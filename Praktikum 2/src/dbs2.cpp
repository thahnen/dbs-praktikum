#include <iostream>
#include <fstream>
#include <string>
#include <list>
#include "options.hpp"
#include "db.h"
#include "tokenizer.hpp"

using namespace std;


enum {
    HNR,
    NAME,
    PLZ,
    ORT
};

void printUsage() {
    cout << "Usage: \n";
    cout << "\t dbimp-ecpg  [options] <infile> \n";
    cout << "\t dbimp-libpq [options] <infile> \n";
    cout << "Options: \n";
    cout << "\t -del delete table contents before import \n";
    cout << "\t -u database user \n";
    cout << "\t -p password \n";
    cout << "\t -h database host \n";
    cout << "\t -d database name \n";
    cout << "For unset options, the usual PostgreSQL environment \n";
    cout << "{PQUSER, PGPASSWORD, PGHOST, PGDATABASE} takes effect" << endl;
}


int main(int argc, char* argv[]) {
    Options input;
    Tokenizer tokens;
    string line;
    string value[4];
    int readCounter = 0, importCounter = 0;
    int i;
    int rv = 0;

	try {
        input = Options(argc, argv);
	} catch (invalid_argument& e) {
        cerr << e.what() << "\n";
        printUsage();
        return -1;
	}

	fstream infile(input.getFilname(), ios::in);
	if (!infile) {
        cerr << "failed to open " << input.getFilname() << "\n";
        return -1;
	}

	rv = db_login(input.getUser(), input.getPassword(), input.getdatabaseHost(), input.getdatabaseName());
	if (rv != 0) {
        cerr << "failed to login \n";
        return -1;
	}

	rv = db_begin();
    if (rv != 0) {
        cerr << "begin failed \n";
        db_logout();
        return -1;
    }

    if (input.isSetDelete()) {
        rv = db_delete();
        if (rv != 0) {
            cerr << "delete failed \n";
            cerr << "starting rollback \n";

            rv = db_rollback();
            if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

            db_logout();
            return -1;
        }
    }

    while (!infile.eof()) {
        try {
            getline(infile, line);
            infile.peek();
        } catch (...) {
            cerr << "error while reading file " << input.getFilname() << "\n";
            cerr << "starting rollback \n";

            rv = db_rollback();
            if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

            db_logout();
            return -1;
        }

        readCounter++;
        tokens.init(line, ";");

        if (tokens.getSize() != 4){
            cerr << "number of columns in " << input.getFilname() << " does not match the number in the table \n";
            cerr << "starting rollback \n";

            rv = db_rollback();
            if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

            db_logout();
            return -1;
        }

        for (i = 0; i < 4; i++) value[i] = tokens.getNextToken();

        rv = db_findhnr(value[HNR]);
        if (rv == 0) {
            rv = db_insert(value[HNR], value[NAME], value[PLZ], value[ORT]);
            if (rv != 0) {
                cerr << "insert failed \n";
                cerr << "could not insert line " << readCounter << " in " + input.getFilname() << "\n";
                cerr << "starting rollback \n";

                rv = db_rollback();
                if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

                db_logout();
                return -1;
            }
            importCounter++;
        } else if (rv == 1) {
            cout << "Entry hnr: " << value[HNR] << " already exists" << endl;
        } else {
            cerr << "find failed \n";
            cerr << "starting rollback \n";

            rv = db_rollback();
            if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

            db_logout();
            return -1;
        }
    }

    rv = db_commit();
    if (rv != 0) {
        cerr << "commit failed \n";
        cerr << "starting rollback \n";

        rv = db_rollback();
        if (rv != 0) cerr << "rollback failed. All Hope is lost \n";

        db_logout();
        return -1;
    }

    cout << "read data sets: \t" << readCounter << "\n";
    cout << "imported data sets: \t" << importCounter << endl;

	db_logout();
	infile.close();
	return 0;
}
