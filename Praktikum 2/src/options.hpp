#ifndef OPTIONS_HPP_
#define OPTIONS_HPP_
#include <string>
#include <stdexcept>


class Options {
private:
    bool _del;
    bool _u;
    bool _p;
    bool _h;
    bool _d;
    std::string _user;
    std::string _password;
    std::string _databaseHost;
    std::string _databaseName;
    std::string _filename;

public:
    Options();
    Options(int argc, char* argv[]);
    bool isSetDelete();
    bool isSetUser();
    bool isSetPassword();
    bool isSetdatabaseHost();
    bool isSetdatabaseName();
    std::string getUser();
    std::string getPassword();
    std::string getdatabaseHost();
    std::string getdatabaseName();
    std::string getFilname();
};


#endif /* OPTIONS_HPP_ */
