
type assignment = (int * int) * (int * int)


let rec assignment_of_string (str: string): assignment =
  match String.split_on_char ',' str with
  | p1 :: p2 :: _ -> (get_section p1, get_section p2)
  | _ -> assert false

(* NOTE: acho que estou complicando demais *)
and get_section str =
  let part1 = ref "" in
  let part2 = ref "" in
  begin
    let wich_part = ref part1 in
    for i = 0 to String.length str - 1 do
      let ch = str.[i] in
      match ch with
      | c when c >= '0' && c <= '9' -> begin 
        !wich_part := ((! !wich_part) ^ Char.escaped c)
      end
      | '-' -> wich_part := part2
      | _ -> assert false
    done;
    (int_of_string !part1, int_of_string !part2)
  end

let print_assignment ( (a1, a2), (b1,b2) as _ass: assignment) : unit =
  Format.printf "%d-%d %d-%d\n" a1 a2 b1 b2

let assignment_list: assignment list =
  Utils.read_file "./inputs/day4-input.txt"
  |> List.map assignment_of_string

let full_overlap ((a1, a2), (b1, b2) : assignment)  : bool =
  (a1 >= b1 && a2 <= b2 ) || (b1 >= a1 && b2 <= a2 )


let partial_overlap ((a1, a2), (b1, b2) : assignment)  : bool =
  (a1 >= b1 && a1 <= b2) || (a2 <= b2 && a2 >= b1) ||
  (b1 >= a1 && b1 <= a2) || (b2 <= a2 && b2 >= a1)


let () =
  let part1 =
    assignment_list
    |> List.to_seq
    |> Seq.map full_overlap
    |> Seq.fold_left (fun acc i -> Bool.to_int i + acc ) 0
  in
  let part2 =
    assignment_list
    |> List.to_seq
    |> Seq.map partial_overlap
    |> Seq.fold_left (fun acc i -> Bool.to_int i + acc ) 0
  in
  Format.printf "part 1: %d\n" part1;
  Format.printf "part 1: %d\n" part2




