open System

let MAX_CHARS = 4000

let cycle(s : seq<'a>) : seq<'a> = seq { while true do yield! s }

[<EntryPoint>]
let main(args : string[]) : int =
    let parrots = Array.filter (not << Seq.isEmpty) args
    if Seq.isEmpty parrots then
        Console.WriteLine "Nothing to repeat"
        exit 1

    let mutable used = 0
    let consuming(p : string) : bool =
        used <- used + p.Length
        used < MAX_CHARS

    parrots |> cycle |> Seq.takeWhile consuming |> Seq.iter Console.Write
    if not Console.IsOutputRedirected then
        Console.WriteLine ()

    0
