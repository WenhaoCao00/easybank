# easybank Service

The service that we’re going to build is a easy bank. It will provide APIs for the frontend to do following things:

1. Create and manage bank accounts, which are composed of owner’s name, balance, and currency.
2. Record all balance changes to each of the account. So every time some money is added to or subtracted from the account, an account entry record will be created.
3. Perform a money transfer between 2 accounts. This should happen within a transaction, so that either both accounts’ balance are updated successfully or none of them are.

## Setup local development

### Install tools

- [Docker desktop](https://www.docker.com/products/docker-desktop)
- [TablePlus](https://tableplus.com/)
- [Golang](https://golang.org/)
- [Homebrew](https://brew.sh/)
- [Migrate](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate)

  ```bash
  brew install golang-migrate
  ```

- [Sqlc](https://github.com/kyleconroy/sqlc#installation)

  ```bash
  brew install golang-migrate
  ```

### Setup infrastructure

- Start postgres container:

  ```bash
  make postgres
  ```

- Create easy_bank database:

  ```bash
  make createdb
  ```

- Run db migration up all versions:

  ```bash
  make migrateup
  ```

- Run db migration up 1 version:

  ```bash
  make migrateup1
  ```

- Run db migration down all versions:

  ```bash
  make migratedown
  ```

- Run db migration down 1 version:

  ```bash
  make migratedown1
  ```

### Documentation

- Generate DB documentation:

  ```bash
  make db_docs
  ```

- Access the DB documentation at [this address](https://dbdocs.io/WenhaoCao00/easy_bank). Password: `secret`

### How to generate code

- Generate schema SQL file with DBML:

  ```bash
  make db_schema
  ```

- Generate SQL CRUD with sqlc:

  ```bash
  make sqlc
  ```

- Generate DB mock with gomock:

  ```bash
  make mock
  ```

- Create a new db migration:

  ```bash
  migrate create -ext sql -dir db/migration -seq <migration_name>
  ```

### How to run

- Run server:

  ```bash
  make server
  ```

- Run test:

  ```bash
  make test
  ```

## Running the program in Docker

```bash
docker compose up
```
