#include "db.h"
#include <postgresql/libpq-fe.h>


static PGconn* connection;

// Datenbank-Login
// rc: 0 = ok, 1 = error
int db_login(const string& user, const string& password, const string& host, const string& dbname) {
    std::string parameter = "user=" + user + " password=" + password +
                            " hostaddr=" + host + " dbname=" + dbname;

    connection = PQconnectdb(parameter.c_str());
    if (PQstatus(connection) == CONNECTION_BAD) return 1;
    return 0;
}

// Datenbank-Logout
void db_logout() {
    PQfinish(connection);
}

// Transaktionsbefehle
// rc: 0 = ok, 1 = error
int db_begin() {
    PGresult* result;
    int rv = 1;

    result = PQexec(connection, "BEGIN;");
    if (PQresultStatus(result) == PGRES_COMMAND_OK) rv = 0;

    PQclear(result);
    return rv;
}

int db_commit() {
    PGresult* result;
    int rv = 1;

    result = PQexec(connection, "COMMIT;");
    if (PQresultStatus(result) == PGRES_COMMAND_OK) rv = 0;

    PQclear(result);
    return rv;
}

int db_rollback() {
    PGresult* result;
    int rv = 1;

    result = PQexec(connection, "ROLLBACK;");
    if (PQresultStatus(result) == PGRES_COMMAND_OK) rv = 0;

    PQclear(result);
    return rv;
}

// Herstellernummer schon vorhanden?
// rc: 0 = noch nicht da, 1 = schon da, -1 = error
int db_findhnr(const string& hnr) {
    PGresult* result;
    int rv = -1;

    std::string parameter = "SELECT * FROM hersteller WHERE hnr='" + hnr + "';";
    result = PQexec(connection, parameter.c_str());

    if (PQresultStatus(result) == PGRES_TUPLES_OK) {
        rv = PQntuples(result) != 0 ? 1 : 0;
    }

    PQclear(result);
    return rv;
}

// Einfuegen Datensatz
// rc: 0 = ok, 1 = error
int db_insert(const string& hnr, const string& name, const string& plz, const string& ort) {
    PGresult* result;
    int rv = 1;

    std::string parameter = "INSERT INTO hersteller(hnr, name, plz, ort) VALUES('" + hnr +
                            "', '" + name + "', '" + plz + "', '" + ort + "');";

    result = PQexec(connection, parameter.c_str());
    if (PQresultStatus(result) == PGRES_COMMAND_OK) rv = 0;

    PQclear(result);
    return rv;
}

// Loeschen des kompletten Tabelleninhalts
// rc: 0 = ok, 1 = error
int db_delete() {
    PGresult* result;
    int rv = 1;

    std::string parameter = "DELETE FROM hersteller;";

    result = PQexec(connection, parameter.c_str());
    if (PQresultStatus(result) == PGRES_COMMAND_OK) rv = 0;

    PQclear(result);
    return rv;
}
