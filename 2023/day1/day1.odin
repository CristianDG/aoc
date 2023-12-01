package day1

import "core:fmt"
import str "core:strings"
import "core:strconv"
import "core:unicode/utf8"
import "core:unicode"
import "core:slice"

FILE :: #load("./input.txt", string)
DEBUG :: false

part1 :: proc() {
  total := 0
  for line in str.split_lines(FILE) {
    number_runes := [dynamic]rune{}
    for c in line {
      if unicode.is_digit(c) {
        append(&number_runes, c)
      }
    }
    if len(number_runes) == 0 { continue }
    number_str := utf8.runes_to_string({number_runes[0], number_runes[len(number_runes)-1]})
    value, _ := strconv.parse_int(number_str)
    when DEBUG {
      if len(number_runes) == 1 {
        fmt.println('\n',line, number_runes, value)
      }
    }
    total += value
  }
  fmt.println(total)
}

/*
one
two
three
four
five
six
seven
eight
nine

s.contains(line, "one")
s.contains(line, "two")
s.contains(line, "three")
s.contains(line, "four")
s.contains(line, "five")
s.contains(line, "six")
s.contains(line, "seven")
s.contains(line, "eight")
s.contains(line, "nine")

s.contains(line, "1")
s.contains(line, "2")
s.contains(line, "3")
s.contains(line, "4")
s.contains(line, "5")
s.contains(line, "6")
s.contains(line, "7")
s.contains(line, "8")
s.contains(line, "9")

*/

Match :: struct {
  digit: int,
  start_idx: u8
}

/*
  slight change of the ybtre's `line_contains` function
*/
match_digit_in_line :: proc(s, substr: string, digit: int) -> [dynamic]Match {

  result := make([dynamic]Match)

  if str.contains(s, substr) {
    temp := s
    count :=  str.count(temp, substr)

    for i := 0; i < count; i += 1 {
      new_match : Match
      new_match.digit = digit
      idx, width := str.index_multi(temp, {substr})
      new_match.start_idx = u8(idx)

      append(&result, new_match)

      temp, _ = str.replace(temp, substr, " ", 1)
    }
  }

  return result
}

MATCH_TABLE : []struct{ s: string, value: int } : {
  { "zero", 0},
  { "one", 1},
  { "two", 2},
  { "three", 3 },
  { "four", 4},
  { "five", 5},
  { "six", 6},
  { "seven", 7 },
  { "eight", 8},
  { "nine", 9},
  { "0", 0},
  { "1", 1},
  { "2", 2},
  { "3", 3},
  { "4", 4},
  { "5", 5},
  { "6", 6},
  { "7", 7},
  { "8", 8},
  { "9", 9},
}

part2 :: proc() {
  total := 0
  for line in str.split_lines(FILE) {
    if line == "" { continue }

    line_digits := [dynamic]Match {}
    for item in MATCH_TABLE {
      append(&line_digits, ..match_digit_in_line(line, item.s, item.value)[:])
    }

    slice.sort_by(line_digits[:], proc(l,r : Match) -> bool {
      return l.start_idx < r.start_idx
    })
    when DEBUG {
      if len(line_digits) == 1 {
        fmt.println('\n',line, line_digits, (line_digits[0].digit * 10) + line_digits[len(line_digits) - 1].digit)
      }
    }
    
    total += (line_digits[0].digit * 10) + line_digits[len(line_digits) - 1].digit
  }
  fmt.println(total)

}

main :: proc() {
  part1()
  part2()
}

