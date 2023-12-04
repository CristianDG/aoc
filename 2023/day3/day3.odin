package day3

import "core:strings"
import "core:strconv"
import "core:unicode"
import "core:log"
import "core:fmt"

INPUT :: #load("input.txt", string)


is_symbol :: proc(lines: []string, x,y: int) -> bool {
  if y < 0 || y > len(lines)-1 { return false }
  if x < 0 || x > len(lines[y])-1 { return false }

  char := rune(lines[y][x])
  return char != '.' && !unicode.is_digit(char)
}

part1 :: proc() {
  total := 0
  lines := strings.split_lines(INPUT) 
  for line, y in lines {
    for x := 0; x < len(line); x+=1 {
      char := rune(line[x])

      if unicode.is_digit(char) {
        start := x
        for ; x < len(line) ; x+=1 {
          if char = rune(line[x]); !unicode.is_digit(char) { break }
        }
        finish := x

        is_part := false
        for box_x in start-1..<finish+1 {
          is_part |= is_symbol(lines, box_x, y-1) || is_symbol(lines, box_x, y+1)
          if is_part {
            break
          }
        }

        is_part |= is_symbol(lines, start-1, y) || is_symbol(lines, finish, y)

        if is_part {
          number, _ := strconv.parse_int(line[start:finish])
          total += number
        }

      }

    }
  }
  fmt.println(total)
}


ASTERISK_MAP := map[[2]int][dynamic]int { }
is_close_to_asterisk :: proc(number: int, x,y : int){
  key := [2]int { x, y }
  if key in ASTERISK_MAP {
    append(&ASTERISK_MAP[key], number)
  }
}

part2 :: proc() {

  lines := strings.split_lines(INPUT) 
  for y := 0; y < len(lines); y += 1 {
    line := lines[y]

    if y == 0 {
      for char, x in line {
        if char == '*' {
          ASTERISK_MAP[{x, y}] = {}
        }
      }
    }
    if y + 1 < len(lines) {
      for char, x in lines[y+1] {
        if char == '*' {
          ASTERISK_MAP[{x, y+1}] = {}
        }
      }
    }

    for x := 0; x < len(line); x+=1 {
      char := rune(line[x])

      if unicode.is_digit(char) {
        start := x
        for ; x < len(line) ; x+=1 {
          if char = rune(line[x]); !unicode.is_digit(char) { break }
        }
        finish := x

        number, _ := strconv.parse_int(line[start:finish])

        for box_x in start-1..<finish+1 {
          is_close_to_asterisk(number, box_x, y-1)
          is_close_to_asterisk(number, box_x, y+1)
        }
        is_close_to_asterisk(number, start-1, y)
        is_close_to_asterisk(number, finish, y)
      }

    }
  }

  total := 0
  for _, val in ASTERISK_MAP {
    if len(val) == 2 {
      total += val[0] * val[1]
    }
  }

  fmt.println(total)

}

main :: proc() {
  part1()
  part2()
}
