# -----------------------------------------------------------------------------
# Defined in registries:
# (https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3)
# -----------------------------------------------------------------------------

type
    CalendarProperty* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.2
        CALSCALE
        METHOD
        PRODID
        VERSION
        ATTACH
        CATEGORIES
        CLASS
        COMMENT
        DESCRIPTION
        GEO
        LOCATION
        PERCENT_COMPLETE = "PERCENT-COMPLETE"
        PRIORITY
        RESOURCES
        STATUS
        SUMMARY
        COMPLETED
        DTEND
        DUE
        DTSTART
        DURATION
        FREEBUSY
        TRANSP
        TZID
        TZNAME
        TZOFFSETFROM
        TZOFFSETTO
        TZURL
        ATTENDEE
        CONTACT
        ORGANIZER
        RECURRENCE_ID = "RECURRENCE-ID"
        RELATED_TO = "RELATED-TO"
        URL
        UID
        EXDATE
        EXRULE
        RDATE
        RRULE
        ACTION
        REPEAT
        TRIGGER
        CREATED
        DTSTAMP
        LAST_MODIFIED = "LAST-MODIFIED"
        SEQUENCE
        REQUEST_STATUS = "REQUEST-STATUS"

    CalendarPropertyParameter* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.3
        ALTREP ## Alternate Text Representation [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.1]
        CN ## Common Name [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.2]
        CUTYPE ## Calendar User Type [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.3]
        DELEGATED_FROM = "DELEGATED-FROM" ## Delegators [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.4]
        DELEGATED_TO = "DELEGATED-TO" ## Delegatees [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.5]
        DIR ## Directory Entry Reference [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.6]
        ENCODING ## Inline Encoding [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.7]
        FMTTYPE ## Format Type [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.8]
        FBTYPE ## Free/Busy Time Type ## [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.9]
        LANGUAGE ## Language [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.10]
        MEMBER ## Group or List Membership [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.11]
        PARTSTAT ## Participation Status [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.12]
        RANGE ## Recurrence Identifier Range [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.13]
        RELATED ## Alarm Trigger Relationship [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.14]
        RELTYPE ## Relationship Type [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.15]
        ROLE ## Participation Role [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.16]
        RSVP ## RSVP Expectation [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.17]
        SENT_BY = "SENT-BY" ## Sent By [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.18]
        TZID ## Time Zone Identifier [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.19]
        VALUE ## Value Data Types [Reference: https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.20]

    CalendarDataType* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.4
        BINARY
        BOOLEAN
        CAL_ADDRESS = "CAL-ADDRESS"
        DATE
        DATE_TIME = "DATE-TIME"
        DURATION
        FLOAT
        INTEGER
        PERIOD
        RECUR
        TEXT
        TIME
        URI
        UTC_OFFSET = "UTC-OFFSET"

    CalendarUserType* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.5
        INDIVIDUAL
        GROUP
        RESOURCE
        ROOM
        UNKNOWN

    CalendarFreeBusyTimeType* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.6
        FREE
        BUSY
        BUSY_UNAVAILABLE = "BUSY-UNAVAILABLE"
        BUSY_TENTATIVE = "BUSY-TENTATIVE"

    CalendarParticipationStatus* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.7
        NEEDS_ACTION = "NEEDS-ACTION"
        ACCEPTED
        DECLINED
        TENTATIVE
        DELEGATED
        COMPLETED
        IN_PROCESS = "IN-PROCESS"

    CalendarRelationshipType* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.8
        CHILD
        PARENT
        SIBLING

    CalendarParticipationRole* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.9
        CHAIR # what??
        REQ_PARTICIPANT = "REQ-PARTICIPANT"
        OPT_PARTICIPANT = "OPT-PARTICIPANT"
        NON_PARTICIPANT = "NON-PARTICIPANT"

    CalendarAction* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.10
        AUDIO
        DISPLAY
        EMAIL
        PROCEDURE

    CalendarClassification* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-8.3.11
        PUBLIC
        PRIVATE
        CONFIDENTIAL

# -----------------------------------------------------------------------------
# Not defined in registries:
# -----------------------------------------------------------------------------

type
    CalendarInlineEncodingType* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.7
        EIGHT_BIT = "8BIT"
        BASE64

    CalendarAlarmTriggerRelationship* = enum ## https://datatracker.ietf.org/doc/html/rfc5545.html#section-3.2.14
        START
        END






type KeyProperty* = string|CalendarProperty



#[
    CalendarFrequency* = enum
        SECONDLY, MINUTELY, HOURLY, DAILY WEEKLY, MONTHLY, YEARLY
]#