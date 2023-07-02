
let input_stream = Utils.read_file "./inputs/day6-input.txt" |> List.to_seq |> Seq.concat_map String.to_seq

(* NOTE: fazendo de uma forma não otimal mesmo já que aparentemente minha cabeça não consegue conceber algo mais performante *)

(* TODO: encontrar a primeira sequencia de quatro caracteres onde cada caractere é diferente em uma determinada sequencia de items *)

let is_start_of_packet lst =
  match lst with
  | a :: b :: c :: d :: _ ->
      a != b && a != c && a != d && b != c && b != d && c != d
  | _ -> failwith "Sequence with length != 4"


let find_start_of_packet_index seq =
  
  let packet = ref (Seq.drop 4 seq) in
  let packet_start = ref (List.of_seq (Seq.take 4 seq)) in
  let index = ref 4 in

  while not (is_start_of_packet !packet_start) do
    incr index;
    match Seq.uncons !packet with
    | Some (c, rest) -> 
      let () = packet_start := List.append (List.tl !packet_start) [c] in
      let () = packet := rest in ()
    | _ -> failwith "Unreachable"
  done; (!index, !packet)


let is_start_of_message lst =
  let module S = Set.Make(Char) in 
  (Seq.length @@ S.to_seq @@ S.of_list lst) == 14

let find_start_of_message_index seq =
  let message = ref (Seq.drop 14 seq) in
  let packet_start = ref (List.of_seq (Seq.take 14 seq)) in
  let index = ref 14 in

  while not (is_start_of_message !packet_start) do
    incr index;
    match Seq.uncons !message with
    | Some (c, rest) -> 
      let () = packet_start := List.append (List.tl !packet_start) [c] in
      let () = message := rest in ()
    | _ -> failwith "Unreachable"
  done; (!index, !message)



let () =
  let (index, packet) = find_start_of_packet_index input_stream in begin
    Format.printf "part 1: %d\n" index;
    Format.printf "part 2: %d\n" (index + (fst @@ find_start_of_message_index packet));
  end
