use v6;

# The first version of this role/grammar was made in 2011 using Mathematica and ENBF.
# See this file:
#   https://github.com/antononcube/ConversationalAgents/blob/master/Packages/WL/EBNFGrammarToRakuPerl6.m

use DSL::Shared::Roles::English::TimeIntervalSpeechParts;

role DSL::Shared::Roles::English::TimeIntervalSpec
        does DSL::Shared::Roles::English::TimeIntervalSpeechParts {
  rule time-interval-spec { <week-of-year> || <month-of-year> || <time-interval-in-units-spec> || <time-interval-from-to-spec> || <time-interval-into-spec> || <time-interval-every-spec> || <number-of-time-units> }

  rule time-unit  { <hour-time-spec-word>  | <day-time-spec-word>  | <week-time-spec-word>  | <month-time-spec-word>  | <year-time-spec-word>  | <lifetime-time-spec-word> }

  rule time-units { <hours-time-spec-word> | <days-time-spec-word> | <weeks-time-spec-word> | <months-time-spec-word> | <years-time-spec-word> | <lifetimes-time-spec-word> }

  rule number-of-time-units { <few-time-units> || <multi-time-units> || <one-time-unit> }
  rule few-time-units { <.a-determiner>? <few-time-spec-word> <time-units> }
  rule multi-time-units { <time-spec-number> <time-units> }
  rule one-time-unit { [ <.a-determiner> | <one-time-spec-word> ]? <time-unit> }

  rule named-time-intervals { <day-name-relative> | <time-interval-relative> | <month-name> }

  rule time-interval-relative {
    <.the-determiner>? [ <next-time-spec-word> | <last-time-spec-word> | <past-time-spec-word> ] <number-of-time-units> |
    <number-of-time-units> <ago-time-spec-word> |
    <before-time-spec-word> <number-of-time-units>
  }
  rule time-interval-from-to-spec {
    <.between-time-spec-word> <from=.time-spec> <.and-conjunction> <to=.time-spec> |
    <.from-preposition> <from=.time-spec> <.to-preposition> <to=.time-spec> }

  rule time-interval-into-spec {
    [ <.in-preposition> | <.during-time-spec-word> ]? <named-time-intervals> }

  rule time-interval-every-spec {
    [ <.each-determiner> <time-unit> | <.every-determiner> <number-of-time-units> ] }

  rule time-interval-in-units-spec {
    [ <.between-time-spec-word> | <.within-time-spec-word>] <time-spec-number> <.and-conjunction> <number-of-time-units> }

  rule time-spec { <right-now> | <day-name> | <week-of-year> | <week-number> | <month-of-year> | <month-name> | <holiday-name> | <hour-spec> | <holiday-offset> }
  rule right-now { <now-time-spec-word> | <right-time-spec-word> <now-time-spec-word> | <just-time-spec-word> <now-time-spec-word> }
  rule day-name-relative { <today-time-spec-word> | <yesterday-time-spec-word> | <tomorrow-time-spec-word> | <.the-determiner> <day-time-spec-word> <before-time-spec-word> <yesterday-time-spec-word> }
  rule day-name-long { <monday-time-spec-word> | <tuesday-time-spec-word> | <wednesday-time-spec-word> | <thursday-time-spec-word> | <friday-time-spec-word> | <saturday-time-spec-word> | <sunday-time-spec-word> }
  rule day-name-long-plurals { <mondays-time-spec-word> | <tuesdays-time-spec-word> | <wednesdays-time-spec-word> | <thursdays-time-spec-word> | <fridays-time-spec-word> | <saturdays-time-spec-word> | <sundays-time-spec-word> }
  rule day-name-abbr { <mon-time-spec-word> | <tue-time-spec-word> | <wed-time-spec-word> | <thu-time-spec-word> | <fri-time-spec-word> | <sat-time-spec-word> | <sun-time-spec-word> }
  rule day-name { <day-name-long> | <day-name-abbr> | <day-name-long-plurals> }
  rule week-number { <.week-time-spec-word> <week-number-range> }
  rule week-of-year { <.the-determiner>? [ <.week-time-spec-word> <week-number-range> | <week-number-range> <.week-time-spec-word> ] [ <.of-preposition> | <.from-preposition> ] <year-spec> }
  rule month-name-long { <january-time-spec-word> | <february-time-spec-word> | <march-time-spec-word> | <april-time-spec-word> | <may-time-spec-word> | <june-time-spec-word> | <july-time-spec-word> | <august-time-spec-word> | <september-time-spec-word> | <october-time-spec-word> | <november-time-spec-word> | <december-time-spec-word> }
  rule month-name-abbr { <jan-time-spec-word> | <feb-time-spec-word> | <mar-time-spec-word> | <apr-time-spec-word> | <may-time-spec-word> | <jun-time-spec-word> | <jul-time-spec-word> | <aug-time-spec-word> | <sep-time-spec-word> | <oct-time-spec-word> | <nov-time-spec-word> | <dec-time-spec-word> }
  rule month-name { <month-name-long> | <month-name-abbr> }
  rule month-of-year { <month-name> <.of-preposition>? <year-spec>? }
  rule year-spec { <.year-time-spec-word>? <year-number-range> }
  rule holiday-name {
    <christmas-time-spec-word> |
    <lincoln-time-spec-word> <day-time-spec-word> |
    <memorial-time-spec-word> <day-time-spec-word> |
    <mother-time-spec-word> <day-time-spec-word> |
    <new-time-spec-word> <year-time-spec-word> |
    <ramadan-time-spec-word> |
    <thanksgiving-time-spec-word> }
  rule holiday-offset {<number-of-time-units> [ <before-time-spec-word> | <after-time-spec-word> ] <holiday-name>}
  rule hour-spec { [ <integer-value> | <numeric-word-form> ] [ <am-time-spec-word> | <pm-time-spec-word> ]? }
  rule full-date-spec {[ <time-spec-number> <month-name> | <month-name> <time-spec-number> ] <time-spec-number> [ <time-spec-number> [ <am-time-spec-word> | <pm-time-spec-word> ] ]?}

  token week-number-range { (\d+) <?{ 1 <= $0.Str.Num <= 52 }> | <numeric-word-form> }
  token year-number-range { (\d+) <?{ 1900 <= $0.Str.Num <= 2100 }> | <numeric-word-form> }
  token time-spec-number { <integer-value> | <numeric-word-form> }
}