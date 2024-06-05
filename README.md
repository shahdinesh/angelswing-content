# Angleswing content
This is development test project for ANGELSWING.

## Features
- User
  - User sign-in
  - User sign-up
- Content
  - Any user can create any number of Contents
  - But Contents must belong to only one User
  - The content can only be updated/deleted if the content belongs to the user.
  - Other can only view the contents.

## Installation
* Install `docker` and `docker compose`.
* Clone the repo `Angelswing Content`
* Navigate to the `Angelswing Content` directory.


## Starting the containers
* run `cp .env.example .env` and update `JWT_SECRET` value
* run `docker compose build`
* run `docker compose up`
* run `docker compose run web rails db:create db:migrate`

## Running the test suite
- Setup database for testing by running: `docker compose --profile test run test rails db:setup`
- Run all the test by running: `docker compose --profile test run test rspec`

## Postman Collection
* [Postman Collection](https://api.postman.com/collections/35384677-9e46f6ba-2a2a-46db-8cca-03348831bdf5?access_key=PMAT-01HZ6HM4R39N7MHKQ5YZZWQ1FH)
