module DateTimePicker.DateUtils
    exposing
        ( Day
        , MonthType(..)
        , dayToDateTime
        , dayToInt
        , fromMillitaryAmPm
        , fromMillitaryHour
        , generateCalendar
        , padding
        , toMillitary
        )

import Date
import DateTimePicker.DateTime as DateTime
import String


dayToInt : Date.Day -> Date.Day -> Int
dayToInt startOfWeek day =
    let
        base =
            case day of
                Date.Sun ->
                    0

                Date.Mon ->
                    1

                Date.Tue ->
                    2

                Date.Wed ->
                    3

                Date.Thu ->
                    4

                Date.Fri ->
                    5

                Date.Sat ->
                    6
    in
    case startOfWeek of
        Date.Sun ->
            base

        Date.Mon ->
            (base - 1) % 7

        Date.Tue ->
            (base - 2) % 7

        Date.Wed ->
            (base - 3) % 7

        Date.Thu ->
            (base - 4) % 7

        Date.Fri ->
            (base - 5) % 7

        Date.Sat ->
            (base - 6) % 7


calculateNumberOfDaysForPreviousMonth : Int -> Int
calculateNumberOfDaysForPreviousMonth firstDayInInt =
    if firstDayInInt == 0 then
        7
    else
        firstDayInInt


type alias Day =
    { monthType : MonthType
    , day : Int
    }


type MonthType
    = Previous
    | Current
    | Next


dayToDateTime : Int -> Date.Month -> Day -> DateTime.DateTime
dayToDateTime year month day =
    case day.monthType of
        Current ->
            DateTime.fromDate year month day.day

        Previous ->
            let
                previousMonth =
                    DateTime.fromDate year month day.day
                        |> DateTime.addMonths -1
            in
            DateTime.fromDate previousMonth.year previousMonth.month day.day

        Next ->
            let
                nextMonth =
                    DateTime.fromDate year month day.day
                        |> DateTime.addMonths 1
            in
            DateTime.fromDate nextMonth.year nextMonth.month day.day


generateCalendar : Date.Day -> Date.Month -> Int -> List (List Day)
generateCalendar firstDayOfWeek month year =
    let
        firstDateOfMonth =
            DateTime.fromParts year month 1 0 0

        firstDayOfMonth =
            firstDateOfMonth
                |> DateTime.dayOfWeek
                |> dayToInt firstDayOfWeek

        numberOfDaysForPreviousMonth =
            calculateNumberOfDaysForPreviousMonth firstDayOfMonth

        daysInMonth =
            DateTime.daysInMonth firstDateOfMonth.year firstDateOfMonth.month

        firstOfPreviousMonth =
            DateTime.addMonths -1 firstDateOfMonth

        daysInPreviousMonth =
            DateTime.daysInMonth firstOfPreviousMonth.year firstOfPreviousMonth.month

        previousMonth =
            List.range (daysInPreviousMonth - numberOfDaysForPreviousMonth + 1) daysInPreviousMonth
                |> List.map (Day Previous)

        currentMonth =
            List.range 1 daysInMonth
                |> List.map (Day Current)

        nextMonth =
            List.range 1 14
                |> List.map (Day Next)
    in
    previousMonth
        ++ currentMonth
        ++ nextMonth
        |> List.take 42
        |> byWeek


byWeek : List Day -> List (List Day)
byWeek list =
    if List.length list >= 7 then
        List.take 7 list :: byWeek (List.drop 7 list)
    else
        []


padding : String -> String
padding str =
    if String.length str == 0 then
        "00"
    else if String.length str == 1 then
        "0" ++ str
    else
        str


fromMillitaryHour : Int -> Int
fromMillitaryHour hour =
    case hour of
        12 ->
            12

        0 ->
            12

        _ ->
            hour % 12


fromMillitaryAmPm : Int -> String
fromMillitaryAmPm hour =
    case hour of
        12 ->
            "PM"

        0 ->
            "AM"

        _ ->
            if hour >= 12 then
                "PM"
            else
                "AM"


toMillitary : Int -> String -> Int
toMillitary hour amPm =
    case ( hour, amPm ) of
        ( 12, "AM" ) ->
            0

        ( 12, "PM" ) ->
            12

        ( _, "PM" ) ->
            hour + 12

        ( _, _ ) ->
            hour
