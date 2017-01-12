BEGIN {
    avail = 4000
    total = 0

    for (i = 1; i < ARGC; i++) {
        total += length(ARGV[i])
    }

    if (total == 0) {
        print("Nothing to repeat") > "/dev/stderr"
        exit 1
    }

    for (i = 1; ; i = i % (ARGC - 1) + 1) {
        if (avail < length(ARGV[i])) {
            break
        }
        printf("%s", ARGV[i])
        avail -= length(ARGV[i])
    }
}
