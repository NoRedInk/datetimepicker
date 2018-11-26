module DateTimePicker.Formatter
    exposing
        ( accessibilityDateFormatter
        , dateFormatter
        , dateTimeFormatter
        , footerFormatter
        , timeFormatter
        , titleFormatter
        )

import Date
import DateTimePicker.DateTime as DateTime


titleFormatter : DateTime.DateTime -> String
titleFormatter dateTime =
    fullMonth dateTime.month
        ++ " "
        ++ toString dateTime.year


accessibilityDateFormatter : DateTime.DateTime -> String
accessibilityDateFormatter dateTime =
    toString dateTime.day
        ++ ", "
        ++ fullDayOfWeek dateTime
        ++ " "
        ++ fullMonth dateTime.month
        ++ " "
        ++ toString dateTime.year


dateFormatter : DateTime.DateTime -> String
dateFormatter dateTime =
    padWithZero (DateTime.monthToInt dateTime.month) ++ "/" ++ padWithZero dateTime.day ++ "/" ++ toString dateTime.year


footerFormatter : DateTime.DateTime -> String
footerFormatter dateTime =
    fullDayOfWeek dateTime
        ++ ", "
        ++ fullMonth dateTime.month
        ++ " "
        ++ toString dateTime.day
        ++ ", "
        ++ toString dateTime.year


dateTimeFormatter : DateTime.DateTime -> String
dateTimeFormatter dateTime =
    dateFormatter dateTime ++ " " ++ timeFormatter dateTime


timeFormatter : DateTime.DateTime -> String
timeFormatter dateTime =
    let
        ( hourString, amPm ) =
            if dateTime.hour == 12 then
                ( "12", "PM" )
            else if dateTime.hour == 0 then
                ( "12", "AM" )
            else if dateTime.hour > 12 then
                ( padWithZero (dateTime.hour % 12), "PM" )
            else
                ( padWithZero dateTime.hour, "AM" )
    in
    hourString ++ ":" ++ padWithZero dateTime.minute ++ " " ++ amPm


fullDayOfWeek : DateTime.DateTime -> String
fullDayOfWeek dateTime =
    case DateTime.dayOfWeek dateTime of
        Date.Sun ->
            "Sunday"

        Date.Mon ->
            "Monday"

        Date.Tue ->
            "Tuesday"

        Date.Wed ->
            "Wednesday"

        Date.Thu ->
            "Thursday"

        Date.Fri ->
            "Friday"

        Date.Sat ->
            "Saturday"


fullMonth : Date.Month -> String
fullMonth month =
    case month of
        Date.Jan ->
            "January"

        Date.Feb ->
            "February"

        Date.Mar ->
            "March"

        Date.Apr ->
            "April"

        Date.May ->
            "May"

        Date.Jun ->
            "June"

        Date.Jul ->
            "July"

        Date.Aug ->
            "August"

        Date.Sep ->
            "September"

        Date.Oct ->
            "October"

        Date.Nov ->
            "November"

        Date.Dec ->
            "December"


padWithZero : Int -> String
padWithZero input =
    if input < 10 then
        "0" ++ toString input
    else
        toString input
