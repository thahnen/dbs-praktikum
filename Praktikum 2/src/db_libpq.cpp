/*
 * db_libpq.cpp
 *
 *  Created on: 10.05.2019
 *      Author: user
 */

#include "db.h"


// Datenbank-Login
// rc: 0 = ok, 1 = error
int db_login(const string &user, const string &password, const string &host, const string &dbname) {
  return 0;
}

// Datenbank-Logout
void db_logout() {

}

// Transaktionsbefehle
// rc: 0 = ok, 1 = error
int db_begin() {
  return 0;
}
int db_commit() {
  return 0;
}
int db_rollback(){
  return 0;
}

// Herstellernummer schon vorhanden?
// rc: 0 = noch nicht da, 1 = schon da, -1 = error
int db_findhnr(const string &hnr) {
  return 0;
}

// Einfuegen Datensatz
// rc: 0 = ok, 1 = error
int db_insert(const string &hnr, const string &name, const string &plz, const string &ort) {
  return 0;
}

// Loeschen des kompletten Tabelleninhalts
// rc: 0 = ok, 1 = error
int db_delete() {
  return 0;
}
