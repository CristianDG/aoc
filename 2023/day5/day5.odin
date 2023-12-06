package day5

import "core:log"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "dependencies:utils"

when ODIN_DEBUG {
  INPUT :: `seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4`

} else {
  INPUT :: #load("input.txt", string)
}


AlmanacMap :: struct {
  src: int,
  dst: int,
  range: int,
}

part1 :: proc() {
  lines := strings.split_lines(INPUT)
  seeds, _ := utils.parse_int_list(strings.split(lines[0], ": ")[1])


  seed_to_soil := [dynamic]AlmanacMap {}
  soil_to_fertilizer := [dynamic]AlmanacMap {}
  fertilizer_to_water := [dynamic]AlmanacMap {}
  water_to_light := [dynamic]AlmanacMap {}
  light_to_temperature := [dynamic]AlmanacMap {}
  temperature_to_humidity := [dynamic]AlmanacMap {}
  humidity_to_location := [dynamic]AlmanacMap {}

  maps := [?][dynamic]AlmanacMap {
    seed_to_soil,
    soil_to_fertilizer,
    fertilizer_to_water,
    water_to_light,
    light_to_temperature,
    temperature_to_humidity,
    humidity_to_location,
  }

  i := 3
  map_i := 0
  for ; i < len(lines); i += 1 {
    if lines[i] == "" {
      i += 1
      map_i += 1
      continue
    }
    numbers, _ := utils.parse_int_list(lines[i])

    append(&maps[map_i], AlmanacMap { numbers[1], numbers[0], numbers[2] })
  }

  lowest_distance : u64 = 0xffffffffffffffff
  for seed in seeds {
    value := seed
    for m_list in maps {
      for m in m_list {
        range := (value - m.src) + 1
        if value >= m.src && value <= m.src + m.range {
          value = m.dst + range - 1
          break
        }
      }
    }
    lowest_distance = lowest_distance if u64(value) >= lowest_distance else u64(value)
  }
  fmt.println(lowest_distance)

}

main :: proc() {
  part1()

}
