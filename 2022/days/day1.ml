
let calories =
  Utils.read_file "./inputs/day1-input.txt"
  |> List.map int_of_string_opt

let calories_per_elf =
  List.fold_left
    (fun acc item ->
      match (item, acc) with
       | Some cal, current::rest -> current + cal :: rest
       | _ -> 0 :: acc)
    [] calories

let part1 = List.fold_left max min_int calories_per_elf

let part2 =
  let sorted_list = List.sort (fun x y -> compare x y * -1) calories_per_elf in
  match sorted_list with
  | item1::item2::item3::_ -> (item1+item2+item3)
  | _ -> assert false

let () =
  Format.printf "part 1: %d\n" part1;
  Format.printf "part 2: %d\n" part2;

