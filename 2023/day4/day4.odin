package day4

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

INPUT :: #load("input.txt", string)

part1 :: proc() {
  total := 0
  for line in strings.split_lines(INPUT) {
    if line == "" { continue }
    game := strings.split(strings.split(line, ": ")[1], " | ")


    winning_numbers_strs := strings.split(game[0], " ")

    winning_numbers := [dynamic]int { }
    for winning_number_str in winning_numbers_strs {
      if winning_number_str == "" { continue }

      number, _ := strconv.parse_int(winning_number_str)
      append(&winning_numbers, number)
    }

    chosen_numbers_strs := strings.split(game[1], " ")
    chosen_numbers := [dynamic]int { }
    for chosen_number_str in chosen_numbers_strs {
      if chosen_number_str == "" { continue }

      number, _ := strconv.parse_int(chosen_number_str)
      append(&chosen_numbers, number)
    }

    points := 1
    for chosen_number in chosen_numbers {
      for winning_number in winning_numbers {
        if chosen_number == winning_number {
          points <<= 1
        }
      }
    }
    points >>= 1

    total += points
  }
  fmt.println(total)
}

part2 :: proc() {
  copies := make([dynamic]int, 0, 199)
  for line, game_idx in strings.split_lines(INPUT) {
    if game_idx == len(copies) { append(&copies, 1) }
    if line == "" { continue }
    game := strings.split(strings.split(line, ": ")[1], " | ")


    winning_numbers_strs := strings.split(game[0], " ")

    winning_numbers := [dynamic]int { }
    for winning_number_str in winning_numbers_strs {
      if winning_number_str == "" { continue }

      number, _ := strconv.parse_int(winning_number_str)
      append(&winning_numbers, number)
    }

    chosen_numbers_strs := strings.split(game[1], " ")
    chosen_numbers := [dynamic]int { }
    for chosen_number_str in chosen_numbers_strs {
      if chosen_number_str == "" { continue }

      number, _ := strconv.parse_int(chosen_number_str)
      append(&chosen_numbers, number)
    }

    point := 0
    for chosen_number in chosen_numbers {
      for winning_number in winning_numbers {
        if chosen_number == winning_number {
          point += 1
          if point + game_idx >= len(copies) {
            append(&copies, 1)
          }
          copies[point + game_idx] += copies[game_idx]
        }
      }
    }
  }

  total := 0
  for num in copies {
    total += num
  }
  fmt.println(total-1)
}

main :: proc() {
  part1()
  part2()
}
