/*
 * tokenizer.hpp
 *
 *  Created on: 11.05.2019
 *      Author: user
 */

#ifndef TOKENIZER_HPP_
#define TOKENIZER_HPP_
#include <string>
#include <list>

class Tokenizer {
private:
  std::list<std::string> _tokenList;
public:
  Tokenizer(std::string input = "", std::string delimiter = ";");
  void init(std::string input, std::string delimiter);
  unsigned int getSize();
  std::string getNextToken();
  bool hasMoreTokens();
};


#endif /* TOKENIZER_HPP_ */
