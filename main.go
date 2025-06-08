package main

import (
	"database/sql"
	"log"

	"github.com/WenhaoCao00/easybank/api"
	db "github.com/WenhaoCao00/easybank/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver      = "postgres"
	dbSource = "postgresql://root:secret@localhost:5432/easy_bank?sslmode=disable"
	serverAddress = "0.0.0.0:7999"
)
func main(){
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)
	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}