import std.stdio;

int main(char[][] args) 
{ 
    int avail = 4000;
    int total = 0;

    for (size_t i = 1; i < args.length; i++) {
        total += args[i].length;
    }

    if (total == 0) {
        stderr.writef("Nothing to repeat\n");
        return 1;
    }

    for (size_t i = 1; i < args.length; i = i % (args.length - 1) + 1) {
        if (avail < args[i].length) {
            break;
        }
        writef("%s", args[i]);
        avail -= args[i].length;
    }

    return 0;
}
