#include <iostream>
#include <string>
#include <vector>

#include <cstdlib>

static const size_t MAX_CHARS = 4000;

int main(int argc, char *argv[])
{
    std::vector<std::string> items;
    size_t total = 0;

    for (int i = 1; i < argc; ++i) {
        items.push_back(argv[i]);
        total += items.back().size();
    }

    if (total == 0) {
        std::cerr << "Nothing to repeat" << std::endl;
        return EXIT_FAILURE;
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
