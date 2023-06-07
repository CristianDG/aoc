
let backpacks: string list =
  Utils.read_file "./inputs/day3-input.txt"

let int_of_item item =
  int_of_char item -
  match item with
  | item when 'A' <= item && item <= 'Z' -> 38
  | item when 'a' <= item && item <= 'z' -> 96
  | _ -> assert false

let find_duped_item_in_backpack backpack : char =
  let len = String.length backpack in
  let first_half = String.sub backpack 0 (len/2) in

  let running = ref true in
  let i = ref (len/2) in
  let c = ref ' ' in
  while !running do
    let ch = String.get backpack !i in
    if String.exists (fun c -> c == ch ) first_half then begin
      c := ch;
      running := false; 
    end else incr i;
  done; !c

let () =
  let part1 =
    backpacks
    |> List.map find_duped_item_in_backpack
    |> List.map int_of_item
    |> List.fold_left (+) 0
  in
  Format.printf "part 1: %d\n" part1

let find_duped_item_in_group backpack_group : char =
  let backpack_group = match backpack_group with (a,b,c) -> a :: b :: c :: [] in
  let sorted_backpacks = List.sort (fun a b -> compare (String.length a) (String.length b)) backpack_group in 
  let b1,b2,b3 = match sorted_backpacks with
    | a::b::c::_ -> (a,b,c)
    | _ -> assert false in

  let res = ref '0' in
  for i = 0 to String.length b1 - 1 do
    let ch = String.get b1 i in
    if String.contains b2 ch
    && String.contains b3 ch
    then begin
      res := ch;
    end else ();
  done; 
  !res

let group backpacks: (string * string * string) list =
  assert (List.length backpacks mod 3 == 0);
  let groups = ref [] in
  for i = 1 to List.length backpacks / 3 do
    let group =
      ( List.nth backpacks ((i*3)-3)
      , List.nth backpacks ((i*3)-2)
      , List.nth backpacks ((i*3)-1)) in
    groups := group :: !groups;
  done; !groups



let () =
  let part2 =
    backpacks
    |> group
    |> List.to_seq
    |> Seq.map find_duped_item_in_group
    |> Seq.map int_of_item
    |> Seq.fold_left (+) 0
  in
  Format.printf "part 2: %d\n" part2

