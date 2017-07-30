# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.3.1
* 
* Rails version: 5.1.2

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instruction
 
## Models

### Racers

* first_name (required)
* last_name (required)
* email (required)
* birth_date (required)
* gender (required)
* city
* state
 
### Races

* name (required)
* description
* location

### Race Editions

* race (required)
* date (required)

### Race Entry

* racer
* race_edition
* time

### Products

* description
* quantity

### Race Categories

* name
* race
* 


