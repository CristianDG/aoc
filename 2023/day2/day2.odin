package day2

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"

INPUT :: #load("input.txt", string)

// only 12 red cubes, 13 green cubes, and 14 blue cubes
is_possible_state :: proc(color: string, n: int) -> bool {
  res : bool

  switch color {
  case "red": res = n <= 12
  case "green": res = n <= 13
  case "blue": res = n <= 14
  }

  return res
}

part1 :: proc() {
  total := 0
  outer: for game, idx in strings.split_lines(INPUT) {
    if game == "" { continue }

    game_str := strings.split(game, ": ")
    rounds_str := game_str[1]
    rounds := strings.split(rounds_str, "; ")
    
    for round in rounds {
      cubes_str := strings.split(round, ", ")      
      for cube_str in cubes_str {
        cube := strings.split(cube_str, " ")

        number_str := cube[0]
        color := cube[1]

        number, _ := strconv.parse_int(number_str)

        if !is_possible_state(color, number) {
          continue outer
        }
      }
    }

    total += idx+1
  }
  fmt.println(total)
}

part2 :: proc() {
  total := 0
  for game, idx in strings.split_lines(INPUT) {
    if game == "" { continue }

    game_str := strings.split(game, ": ")
    rounds_str := game_str[1]
    rounds := strings.split(rounds_str, "; ")

    max_values := map[string]int{
      "red" = 0,
      "blue" = 0,
      "green" = 0,
    }

    for round in rounds {
      cubes_str := strings.split(round, ", ")      

      for cube_str in cubes_str {
        cube := strings.split(cube_str, " ")

        number_str := cube[0]
        color := cube[1]

        number, _ := strconv.parse_int(number_str)

        max_values[color] = math.max(max_values[color], number)
      }
    }

    total += max_values["red"] * max_values["blue"] * max_values["green"]
  }
  fmt.println(total)
}

main :: proc() {
  part2()
}
