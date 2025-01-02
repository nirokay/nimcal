import std/[
    strutils,
    tables,
    times
]
export
    tables,
    times

import
    properties
export
    properties

# -----------------------------------------------------------------------------
# Declarations:
# -----------------------------------------------------------------------------

type
    CalendarPropertyType* = enum
        propertyString, propertyObject
    CalendarPropertyTable* = OrderedTable[string, CalendarProperty] ## "Property Parameter" -> "Property Parameter Value" (described in https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2)
    CalendarProperty* = object
        case propertyType: CalendarPropertyType:
        of propertyString:
            text*: string
        of propertyObject:
            data*: CalendarPropertyTable

    CalendarItemIdentifier = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.1
        VCALENDAR
        VEVENT
        VTODO
        VJOURNAL
        VFREEBUSY
        VTIMEZONE
        VALARM
        STANDARD
        DAYLIGHT

    CalendarItem* = object
        identifier: CalendarItemIdentifier ## is set via its respective `newItem()` proc
        properties*: CalendarPropertyTable

    Calendar* = object
        version*: string = "2.0"
        identifier*: string = "VCALENDAR"
        children*: seq[CalendarItem]
        properties*: CalendarPropertyTable

    PeriodType = enum
        periodDateToDate, periodDateAndDuration
    Period* = object ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.3.9
        starting*: DateTime
        case periodType: PeriodType:
        of periodDateToDate: ending*: DateTime
        of periodDateAndDuration: duration: Duration


proc newCalendarEvent*(): CalendarItem = CalendarItem(identifier: VEVENT)
proc newCalendarToDo*(): CalendarItem = CalendarItem(identifier: VTODO)
proc newCalendarJournal*(): CalendarItem = CalendarItem(identifier: VJOURNAL)
proc newCalendarFreeBusy*(): CalendarItem = CalendarItem(identifier: VFREEBUSY)
proc newCalendarTimezone*(): CalendarItem = CalendarItem(identifier: VTIMEZONE)
proc newCalendarAlarm*(): CalendarItem = CalendarItem(identifier: VTIMEZONE)
proc newCalendarStandard*(): CalendarItem = CalendarItem(identifier: STANDARD)
proc newCalendarDaylight*(): CalendarItem = CalendarItem(identifier: DAYLIGHT)

proc newCalendarPropertyString*(text: string): CalendarProperty =
    result = CalendarProperty(
        propertyType: propertyString,
        text: text
    )
proc newCalendarPropertyObject*(data: CalendarPropertyTable): CalendarProperty =
    result = CalendarProperty(
        propertyType: propertyObject,
        data: data
    )

proc newCalendarPeriod*(starting, ending: DateTime): Period =
    result = Period(
        periodType: periodDateToDate,
        starting: starting,
        ending: ending
    )
proc newCalendarPeriod*(starting: DateTime, duration: Duration): Period =
    result = Period(
        periodType: periodDateAndDuration,
        starting: starting,
        duration: duration
    )


# -----------------------------------------------------------------------------
# String/Dollar procs:
# -----------------------------------------------------------------------------

proc propertyTextString(property: CalendarProperty): string =
    result = ":"
    # TODO: implementation
proc propertyTextObject(property: CalendarProperty): string =
    result = ";"
    # TODO: implementation
proc propertyText(property: CalendarProperty): string =
    ## Processes text of properties, quotes them if needed
    result = case property.propertyType:
        of propertyString: property.propertyTextString()
        of propertyObject: property.propertyTextObject()

proc `$`*(item: CalendarItem): string =
    result = "BEGIN:" & $item.identifier
    for key, value in item.properties:
        result &= "\n" & key & propertyText(value)
    result &= "\nEND:" & $item.identifier

proc `$`*(calendar: Calendar): string =
    # Header:
    result = @[
        "BEGIN:" & calendar.identifier,
        "VERSION:" & calendar.version
    ].join("\n")

    # Children:
    for child in calendar.children:
        result &= "\n" & $child

    # Closure:
    result &= "\n" & "END:" & calendar.identifier


# -----------------------------------------------------------------------------
# Conversions:
# -----------------------------------------------------------------------------

#! THIS IS WHAT YOU WERE DOING BEFORE YOU LEFT OFF:
#proc newData(property: KeyProperty, propertyType)

proc convertBool(value: bool): string =
    result = ";VALUE=BOOLEAN:"
    result = case value:
        of true: "TRUE"
        of false: "FALSE"

proc convertDate(date: DateTime): string =
    let utc: DateTime = date.utc()
    result = @[
        utc.getDateStr().replace("-", ""),
        "T",
        utc.getClockStr().replace(":", ""),
        "Z"
    ].join("")

proc convertDuration(duration: Duration): string =
    var negative: bool = false
    proc `?`(unit: string, value: int): string =
        if value == 0 and unit != "S": return ""
        if value < 0: negative = true
        result = $value.abs()

    result &= @[
        "P",
        "W" ? duration.inWeeks(),
        "D" ? duration.inDays() mod 7,
        "H" ? duration.inHours() mod 24,
        "M" ? duration.inMinutes() mod 60,
        "S" ? duration.inSeconds() mod 60
    ].join("")
    # Zero-duration correction:
    if result.len() == 1: result &= "0S"
    # Negative duration (https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.3.6):
    if negative: result = "-" & result

proc convertPeriod(period: Period): string =
    result = period.starting.convertDate() & "/"
    case period.periodType:
    of periodDateToDate: result &= period.ending.convertDate()
    of periodDateAndDuration: result &= period.duration.convertDuration()

# -----------------------------------------------------------------------------
# Assignment:
# -----------------------------------------------------------------------------

proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: CalendarProperty) =
    item.properties[$key] = value

proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: string) =
    item[key] = newCalendarPropertyString(value)
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: bool) =
    item[key] = newCalendarPropertyString(value.convertBool())
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: SomeInteger) =
    item[key] = newCalendarPropertyString(value.convertInt())
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: SomeFloat) =
    item[key] = newCalendarPropertyString(value.convertFloat())
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: DateTime) =
    item[key] = newCalendarPropertyString(value.convertDate())
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: Duration) =
    item[key] = newCalendarPropertyString(value.convertDuration())
proc `[]=`*(item: var CalendarItem, key: KeyProperty, value: Period) =
    item[key] = newCalendarPropertyString(value.convertPeriod())
