/*
 * options.cpp
 *
 *  Created on: 10.05.2019
 *      Author: user
 */

#include "options.hpp"



Options::Options() {
  _del = 0;
  _u = 0;
  _p = 0;
  _h = 0;
  _d = 0;
  _user.clear();
  _password.clear();
  _databaseHost.clear();
  _databaseName.clear();
  _filename.clear();
}

Options::Options(int argc, char *argv[]) {
  _del = 0;
  _u = 0;
  _p = 0;
  _h = 0;
  _d = 0;

  int i = 0;
  std::string value;
  for(i = 1; i < argc; i++) {
    value = argv[i];

    if(value == "-del") {
      _del = 1;
    }

    else if(value == "-u") {
      _u = 1;
      i++;
      if(i >= argc)
        throw std::invalid_argument("no user");
      _user = argv[i];
    }

    else if(value == "-p") {
      _p = 1;
      i++;
      if(i >= argc)
        throw std::invalid_argument("no password");
      _password = argv[i];
    }

    else if(value == "-h") {
      _h = 1;
      i++;
      if(i >= argc)
        throw std::invalid_argument("no database host");
      _databaseHost = argv[i];
    }

    else if(value == "-d") {
      _d = 1;
      i++;
      if(i >= argc)
        throw std::invalid_argument("no database name");
      _databaseName = argv[i];
    }

    else if(argv[i][0] != '-') {
      _filename = argv[i];
    }

  }

  if(_filename.empty())
    throw std::invalid_argument("no file");
}

bool Options::isSetDelete() {
  return _del;
}

bool Options::isSetUser() {
  return _u;
}

bool Options::isSetPassword() {
  return _p;
}

bool Options::isSetdatabaseHost() {
  return _h;
}

bool Options::isSetdatabaseName() {
  return _d;
}

std::string Options::getUser(){
  return _user;
}

std::string Options::getPassword(){
  return _password;
}

std::string Options::getdatabaseHost(){
  return _databaseHost;
}

std::string Options::getdatabaseName(){
  return _databaseName;
}

std::string Options::getFilname() {
  return _filename;
}
