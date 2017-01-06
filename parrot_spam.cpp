#include <iostream>
#include <string>
#include <vector>

#include <cstdlib>

static const size_t MAX_CHARS = 4000;

int main(int argc, char *argv[])
{
    if (argc < 2) {
        std::cerr << "Nothing to repeat" << std::endl;
        return EXIT_FAILURE;
    }

    std::vector<std::string> items;

    for (int i = 1; i < argc; ++i) {
        items.push_back(argv[i]);
    }

    size_t avail = MAX_CHARS;
    for (size_t i = 0; ; i = (i + 1) % items.size()) {
        if (avail >= items[i].size()) {
            std::cout << items[i];
            avail -= items[i].size();
        } else {
            break;
        }
    }

    return EXIT_SUCCESS;
}
