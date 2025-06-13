open Array
open List

let spam (chars : int) (parrots : string list) =
    let rec go (chars_left : int) (current_parrots : string list) =
        match current_parrots with
        | []      -> go chars_left parrots
        | p :: ps ->
            let next_chars_left = chars_left - String.length p
            in if next_chars_left <= 0 then () else begin
                print_string p;
                go next_chars_left ps
            end
    in go chars parrots; print_endline ""

let () =
    match Sys.argv |> Array.to_list |> drop 1 |> List.filter (( != ) "") with
    | []      -> invalid_arg "Nothing to repeat"
    | parrots -> spam 4000 parrots
