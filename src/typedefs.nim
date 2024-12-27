
type
    CalendarItemIdentifier* = enum
        VEVENT    ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.1
        VTODO     ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.2
        VJOURNAL  ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.3
        VFREEBUSY ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.4
        VTIMEZONE ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.5
        VALARM    ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.6.6

    CalendarItem* = object of RootObj
        identifier: CalendarItemIdentifier ## is set via its respective `newItem()` proc

    CalendarEvent* = object of CalendarItem
    CalendarToDo* = object of CalendarItem
    CalendarJournal* = object of CalendarItem
    CalendarFreeBusy* = object of CalendarItem
    CalendarTimezone* = object of CalendarItem
    CalendarAlarm* = object of CalendarItem

    Calendar* = object
        version*: string = "2.0"
        children*: seq[CalendarItem]

proc newCalendarEvent*(): CalendarEvent = CalendarEvent(identifier: VEVENT)
proc newCalendarToDo*(): CalendarToDo = CalendarToDo(identifier: VTODO)
proc newCalendarJournal*(): CalendarJournal = CalendarJournal(identifier: VJOURNAL)
proc newCalendarFreeBusy*(): CalendarFreeBusy = CalendarFreeBusy(identifier: VFREEBUSY)
proc newCalendarTimezone*(): CalendarTimezone = CalendarTimezone(identifier: VTIMEZONE)
proc newCalendarAlarm*(): CalendarAlarm = CalendarAlarm(identifier: VTIMEZONE)
