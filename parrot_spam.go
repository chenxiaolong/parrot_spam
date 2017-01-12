package main

import (
    "fmt"
    "os"
)

func main() {
	avail := 4000
	total := 0

	for i := 1; i < len(os.Args); i++ {
		total += len(os.Args[i])
	}

	if total == 0 {
        fmt.Fprintln(os.Stderr, "Nothing to repeat")
		os.Exit(1)
	}

	for i := 1; ; i = i % (len(os.Args) - 1) + 1 {
		if avail < len(os.Args[i]) {
			break
		}
		fmt.Print(os.Args[i])
		avail -= len(os.Args[i])
	}
}
