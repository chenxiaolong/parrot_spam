#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CHARS 4000

int main(int argc, char *argv[])
{
    char **items = argv + 1;
    int count = argc - 1;
    int *sizes = malloc(count * sizeof(int));
    if (!sizes) {
        fprintf(stderr, "Failed to allocate memory: %s\n",
                strerror(errno));
        return EXIT_FAILURE;
    }

    size_t total = 0;

    for (int i = 0; i < count; ++i) {
        sizes[i] = strlen(items[i]);
        total += sizes[i];
    }

    if (total == 0) {
        fprintf(stderr, "Nothing to repeat\n");
        free(sizes);
        return EXIT_FAILURE;
    }

    int avail = MAX_CHARS;
    for (int i = 0; ; i = (i + 1) % count) {
        if (avail >= sizes[i]) {
            fputs(items[i], stdout);
            avail -= sizes[i];
        } else {
            break;
        }
    }

    free(sizes);
    return EXIT_SUCCESS;
}
