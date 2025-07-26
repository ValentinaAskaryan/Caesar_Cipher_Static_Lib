#include <iostream>
#include "encrypt.hpp"
#include "decrypt.hpp"
#include "unit_test.hpp"

void unit_test() {
	std::string text;
	int shift = 3;

	while(true) {
		std::cout << "Enter a string" << std::endl;
		std::getline(std::cin, text);
		
		if(text == "break") {
			std::cout << "Exiting" << std::endl;
			break;
		}

		std::string encodeStr = encrypt(text, shift);
		std::string decodeStr = decrypt(encodeStr, shift);

		std::cout << "Encoded: " << encodeStr << std::endl;
		std::cout << "Decoded: " << decodeStr << std::endl;


		if(decodeStr == text) std::cout << "Matches!" << std::endl;
		else std::cout << "Doesn't match!" << std::endl;
	}
}
