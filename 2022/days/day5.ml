let input_file = Utils.read_file "./inputs/day5-input.txt"

(*

    [P]                 [Q]     [T]
[F] [N]             [P] [L]     [M]
[H] [T] [H]         [M] [H]     [Z]
[M] [C] [P]     [Q] [R] [C]     [J]
[T] [J] [M] [F] [L] [G] [R]     [Q]
[V] [G] [D] [V] [G] [D] [N] [W] [L]
[L] [Q] [S] [B] [H] [B] [M] [L] [D]
[D] [H] [R] [L] [N] [W] [G] [C] [R]
 1   2   3   4   5   6   7   8   9 

move 1 from 7 to 6
move 1 from 8 to 5
move 3 from 7 to 4

*)

module Move = struct
  type t = { qty : int; start : int; finish : int }

  let of_string (str : string) =
    let skip_int s = Seq.drop_while Utils.is_digit s |> Seq.drop 1 in
    let take_int s =
      Seq.take_while Utils.is_digit s |> String.of_seq |> int_of_string
    in
    let part1 = String.to_seq str |> Seq.drop 5 in
    let part2 = skip_int part1 |> Seq.drop 5 in
    let part3 = skip_int part2 |> Seq.drop 3 in
    { qty = take_int part1; start = take_int part2; finish = take_int part3 }

  let to_string move =
    Format.sprintf "move q:%d from s:%d to f:%d" move.qty move.start move.finish
end


(* NOTE: Não consegui ler a entrada então escrevi em código mesmo :+1: *)
let stacks : char Stack.t list =
  [
    Stack.of_seq (List.to_seq [ 'D'; 'L'; 'V'; 'T'; 'M'; 'H'; 'F' ]);
    Stack.of_seq (List.to_seq [ 'H'; 'Q'; 'G'; 'J'; 'C'; 'T'; 'N'; 'P' ]);
    Stack.of_seq (List.to_seq [ 'R'; 'S'; 'D'; 'M'; 'P'; 'H' ]);
    Stack.of_seq (List.to_seq [ 'L'; 'B'; 'V'; 'F' ]);
    Stack.of_seq (List.to_seq [ 'N'; 'H'; 'G'; 'L'; 'Q' ]);
    Stack.of_seq (List.to_seq [ 'W'; 'B'; 'D'; 'G'; 'R'; 'M'; 'P' ]);
    Stack.of_seq (List.to_seq [ 'G'; 'M'; 'N'; 'R'; 'C'; 'H'; 'L'; 'Q' ]);
    Stack.of_seq (List.to_seq [ 'C'; 'L'; 'W' ]);
    Stack.of_seq (List.to_seq [ 'R'; 'D'; 'L'; 'Q'; 'J'; 'Z'; 'M'; 'T' ]);
  ]

let moves : Move.t list =
  List.to_seq input_file
  |> Seq.drop_while (fun x -> String.length x != 0)
  |> Seq.drop 1 |> Seq.map Move.of_string |> List.of_seq

let execute_move (stacks : 'a Stack.t list) (move : Move.t) : unit =
  for _ = 1 to move.qty do
    let crate = Stack.pop (List.nth stacks (move.start - 1)) in
    Stack.push crate (List.nth stacks (move.finish - 1))
  done

let execute_move9000 (stacks : 'a Stack.t list) (move : Move.t) : unit =
  let start = List.nth stacks (move.start - 1) in
  let finish = List.nth stacks (move.finish - 1) in
  Stack.add_seq finish
    (Stack.to_seq start |> Seq.take move.qty |> List.of_seq |> List.rev
   |> List.to_seq);
  for _ = 1 to move.qty do
    let _ = Stack.pop start in
    ()
  done

let () =
  let get_tops (stacks : char Stack.t list) : string =
    List.map (fun s -> Stack.copy s |> Stack.pop) stacks
    |> List.to_seq |> String.of_seq
  in
  let part1 =
    let stacks = List.map Stack.copy stacks in
    List.iter (execute_move stacks) moves;
    get_tops stacks
  in
  let part2 =
    let stacks = List.map Stack.copy stacks in
    List.iter (execute_move9000 stacks) moves;
    get_tops stacks
  in
  Format.printf "part 1: %s\n" part1;
  Format.printf "part 2: %s\n" part2

