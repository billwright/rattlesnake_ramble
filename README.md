# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.3.1

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
* gender
* minimum_age
* maximum_age

Examples:
  | Under 20 Male | :male   |  0 |  20 |
  | 20-29 Male    | :male   | 20 |  29 |
  | 60+ Female    | :female | 60 | 200 |
  | 50-59 Female  | :female | 50 |  59 |

### Race Placement Package

* name
* num_overall_finishers_to_remove_from_categories (defaults to 3)
* num_masters_finishers_to_remove_from_categories (defaults to 3)
* starting_masters_age (defaults to 40)
* categories

Examples:
  | Rattlesnake Ramble Long Course | 3 | 3 | 40 |
  | Rattlesnake Ramble Kids Course | 0 | 0 | 40 |
  
  
Placement Test:

Given the following results:

|   Name    | Age | Gender | Seconds |
| Joe Smith | 35  |  Male  |   1750  |
| Jim Smith | 41  |  Male  |   2000  |
| Sue Smith | 25  | Female |   2100  |
| Pam Smith | 33  | Female |   2250  |
| Bob Smith | 51  |  Male  |   2500  |
| Sal Smith | 42  |  Male  |   1950  |
| Cal Smith | 21  |  Male  |   1800  |
| Sam Smith | 32  |  Male  |   1900  |

#### Useful Aliases
```bash
alias gs='git status'
alias gp='git push'
alias gpr='git push heroku master'
alias test='rake test'
alias resetdb='rake db:reset'
alias rebuilddb='rake db:schema:load'
alias start='rails server -b $IP -p $PORT'
alias pushToHeroku='git push heroku master'
```

## Updating entries

#### Getting racer emails, unpaid racer emailss

http://www.rattlesnakeramble.org/race_editions/rattlesnake-ramble-trail-race-on-2019-09-14/racer_emails

On this page are three buttons: All, Paid, Unpaid

#### Updating payment and bib number for entrants

http://www.rattlesnakeramble.org/race_entries 

Make sure to find the entry for the correct race editions

#### Updating racer information, like birth date

http://www.rattlesnakeramble.org/racers

#### Exporting racer information to a spreadsheet

http://www.rattlesnakeramble.org/race_editions/rattlesnake-ramble-trail-race-on-2019-09-14/racer_info_csv
