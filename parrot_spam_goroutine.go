package main

import (
    "fmt"
    "os"
)

func check_args() {
    for _, arg := range os.Args[1:] {
        if len(arg) > 0 {
            return
        }
    }

    fmt.Fprintln(os.Stderr, "Nothing to repeat")
    os.Exit(1)
}

func main() {
    check_args()

    c := make(chan string)

    go func() {
        for {
            for _, arg := range os.Args[1:] {
                c <- arg
            }
        }
    }()

    total := 4000

    for {
        parrot := <-c
        total -= len(parrot)
        if total < 0 {
            break
        }

        fmt.Print(parrot)
    }
}
