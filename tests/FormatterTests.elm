module FormatterTests exposing (accessibilityDateFormatterTest, date, dateFormatterTest, dateTimeFormatterTest, footerFormatterTest, timeFormatterTest, titleFormatterTest)

import Date
import DateTimePicker.DateTime as DateTime
import DateTimePicker.Formatter as Formatter
import Expect
import Test exposing (..)


date : DateTime.DateTime
date =
    DateTime.fromParts 2018 Date.Sep 10 13 15


titleFormatterTest : Test
titleFormatterTest =
    test "titleFormatter" <|
        \() ->
            date
                |> Formatter.titleFormatter
                |> Expect.equal "September 2018"


accessibilityDateFormatterTest : Test
accessibilityDateFormatterTest =
    test "accessibilityDateFormatter" <|
        \() ->
            date
                |> Formatter.accessibilityDateFormatter
                |> Expect.equal "10, Monday September 2018"


dateFormatterTest : Test
dateFormatterTest =
    test "dateFormatter" <|
        \() ->
            date
                |> Formatter.dateFormatter
                |> Expect.equal "09/10/2018"


footerFormatterTest : Test
footerFormatterTest =
    test "footerFormatter" <|
        \() ->
            date
                |> Formatter.footerFormatter
                |> Expect.equal "Monday, September 10, 2018"


dateTimeFormatterTest : Test
dateTimeFormatterTest =
    test "dateTimeFormatter" <|
        \() ->
            date
                |> Formatter.dateTimeFormatter
                |> Expect.equal "09/10/2018 01:15 PM"


timeFormatterTest : Test
timeFormatterTest =
    test "timeFormatter" <|
        \() ->
            date
                |> Formatter.timeFormatter
                |> Expect.equal "01:15 PM"
