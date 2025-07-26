#include <string>

std::string decrypt(std::string text, int s) {
    std::string result = "";

    for (std::string::size_type i = 0; i < text.length(); i++) {
        if (isupper(text[i]))
            result += char(int(text[i] - s - 65 + 26) % 26 + 65);
        else
            result += char(int(text[i] - s - 97 + 26) % 26 + 97);
    }

    return result;
}

