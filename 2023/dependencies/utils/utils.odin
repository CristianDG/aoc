package utils

import "core:strconv"
import "core:strings"

parse_int_list :: proc(s: string) -> ([]int, bool) {

  res := [dynamic]int { }
  for item in strings.split(s, " ") {
    if item == "" { continue }
    num, ok := strconv.parse_int(item)
    if !ok { return nil, false }

    append(&res, num)
  }

  return res[:], true
}
