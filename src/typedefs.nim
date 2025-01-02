import std/[
    strutils,
    tables
]
export
    tables


# -----------------------------------------------------------------------------
# Declarations:
# -----------------------------------------------------------------------------

type
    CalendarPropertyType* = enum
        propertyString, propertyObject
    CalendarPropertyTable* = OrderedTable[string, CalendarProperty] ## "Property Parameter" -> "Property Parameter Value" (described in https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2)
    CalendarProperty* = object
        case propertyType*: CalendarPropertyType:
        of propertyString:
            text*: string
        of propertyObject:
            data*: CalendarPropertyTable


    CalendarItemIdentifier* = enum
        VEVENT    ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.1
        VTODO     ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.2
        VJOURNAL  ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.3
        VFREEBUSY ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.4
        VTIMEZONE ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.5
        VALARM    ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.6

    CalendarItem* = object
        identifier: CalendarItemIdentifier ## is set via its respective `newItem()` proc
        properties*: CalendarPropertyTable

    Calendar* = object
        version*: string = "2.0"
        identifier*: string = "VCALENDAR"
        children*: seq[string]
        properties*: CalendarPropertyTable


proc newCalendarEvent*(): CalendarItem = CalendarItem(identifier: VEVENT)
proc newCalendarToDo*(): CalendarItem = CalendarItem(identifier: VTODO)
proc newCalendarJournal*(): CalendarItem = CalendarItem(identifier: VJOURNAL)
proc newCalendarFreeBusy*(): CalendarItem = CalendarItem(identifier: VFREEBUSY)
proc newCalendarTimezone*(): CalendarItem = CalendarItem(identifier: VTIMEZONE)
proc newCalendarAlarm*(): CalendarItem = CalendarItem(identifier: VTIMEZONE)

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
# :
# -----------------------------------------------------------------------------

