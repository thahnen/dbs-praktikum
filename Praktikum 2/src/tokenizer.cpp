/*
 * tokenizer.cpp
 *
 *  Created on: 11.05.2019
 *      Author: user
 */

#include "tokenizer.hpp"


Tokenizer::Tokenizer(std::string input, std::string delimiter) {
  Tokenizer::init(input, delimiter);
}

void Tokenizer::init(std::string input, std::string delimiter) {
  _tokenList.clear();
  std::string::size_type begin = 0, end = 0;

  while((end = input.find_first_of(delimiter, begin)) != std::string::npos) {
    _tokenList.push_back(input.substr(begin, end - begin));
    begin = end + 1;
  }
  _tokenList.push_back(input.substr(begin, end));
}

unsigned int Tokenizer::getSize() {
  return _tokenList.size();
}

std::string Tokenizer::getNextToken() {
  std::string token;
  token = _tokenList.front();
  _tokenList.pop_front();
  return token;
}

bool Tokenizer::hasMoreTokens() {
  return _tokenList.size() != 0;
}
