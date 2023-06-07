
type gamestate
  = Loss
  | Win
  | Draw

type ppt
  = Pedra
  | Papel
  | Tesoura

let int_of_gamestate state =
  match state with
  | Win -> 6
  | Draw -> 3
  | Loss -> 0

let int_of_ppt ppt =
  match ppt with
  | Pedra -> 1
  | Papel -> 2
  | Tesoura -> 3

let play p1 p2: gamestate =
  match p1, p2 with
  | Pedra, Papel
  | Papel, Tesoura
  | Tesoura, Pedra -> Win
  | p1, p2 when p1 == p2 -> Draw
  | _ -> Loss

let play_strategy p1 p2: int =
  int_of_gamestate (play p1 p2) + int_of_ppt p2

let ppt_of_char c =
  match c with
  | 'A' -> Pedra
  | 'B' -> Papel
  | 'C' -> Tesoura
  | _ -> assert false

let ppt_decode encoded =
  match encoded with
  | 'X' -> 'A'
  | 'Y' -> 'B'
  | 'Z' -> 'C'
  | _ -> assert false




let games: (char * char) list =
  (* ["A Y"; "B X"; "C Z"] *)
  Utils.read_file "./inputs/day2-input.txt"
  |> List.map (fun line -> (String.get line 0, String.get line 2 ))

let () =
  let part1 =
    games
    |> List.map (fun (c1, c2) ->
        let p1 = ppt_of_char c1 in
        let p2 = ppt_decode c2 |> ppt_of_char in
        play_strategy p1 p2)
    |> List.fold_left (+) 0
  in
  Format.printf "part 1: %d\n" part1



let rec choose_move encoded =
  match encoded with
  | 'X' -> losing_move
  | 'Y' -> drawing_move
  | 'Z' -> winning_move
  | _ -> assert false

and winning_move ppt =
  match ppt with
  | Pedra -> Papel
  | Papel -> Tesoura
  | Tesoura -> Pedra

and losing_move ppt =
  match ppt with
  | Papel -> Pedra
  | Tesoura -> Papel
  | Pedra -> Tesoura

and drawing_move ppt = ppt

let () =
  let part2 =
    games
    |> List.map (fun (c1, c2) ->
        let p1 = ppt_of_char c1 in
        let p2 = choose_move c2 p1 in
        int_of_gamestate (play p1 p2) + int_of_ppt p2)
    |> List.fold_left (+) 0
  in
  Format.printf "part 2: %d\n" part2
