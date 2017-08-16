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
* editions

### Race Editions

* race (required)
* date (required)
* entry_fee
* entries

### Race Entry

* racer (required)
* race_edition (required)
* time (filled in after finishing race)
* paid? (defaults to false and set to true with confirmation of payment)

### Products

* description (required)
* quantity (required)
* price (required)
* images (optional series of images to show the product)

### Race Categories

* name
* race
* gender
* minimum_age
* maximum_age

### Race Placement Package

* name
* remove
* 

#### Useful Aliases
```bash
alias gs='git status'
alias gp='git push'
alias gpr='git push heroku master'
alias test='rake test'
alias resetdb='rake db:reset'
alias rebuilddb='rake db:schema:load'
alias start='rails server -b $IP -p $PORT'
```


