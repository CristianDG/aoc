
let is_digit = function '0' .. '9' -> true | _ -> false

let read_file path : string list =
  let ic = open_in path in
  let lines : string list ref = ref [] in
  let running = ref true in
  while !running do
    match In_channel.input_line ic with
    | Some (line) -> lines := List.append !lines [line]
    | None -> running := false;
  done; 
  close_in ic;
  !lines

