DB_URL=postgresql://root:secret@localhost:5432/easy_bank?sslmode=disable
postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

mysql:
	docker run --name mysql8 -p 3306:3306  -e MYSQL_ROOT_PASSWORD=secret -d mysql:8

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root easy_bank

dropdb:
	docker exec -it postgres12 dropdb easy_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1
	
db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/WenhaoCao00/easybank/db/sqlc Store

proto:
	rm -f pb/*.go
	find proto -name "*.proto" | xargs protoc \
	    --proto_path=proto \
	    --go_out=pb --go_opt=paths=source_relative \
	    --go-grpc_out=pb --go-grpc_opt=paths=source_relative

evans:
	evans --host localhost --port 8999 -r repl

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 db_docs db_schema sqlc test server mock proto evans