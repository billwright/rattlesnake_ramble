# README

This is the repository for the Rattlesnake Ramble website, hosted at https://www.rattlesnakeramble.org.

Local setup requires the following:

* Ruby version: 3.1
* Rails version: 6.1
* Postgres

* Database creation
- Install Postgres if you don't have it already:
##### Using Homebrew on MacOS
> `$ brew install postgres`

Follow the instructions for automatically starting postgres when you start your machine.

* Database initialization
> `$ bundle exec rails db:reset`

* How to run the test suite
> `$ bundle exec rspec`

* Deployment instruction

Once your local master is up to date and you have Heroku CLI credentials in place, run the following command:

> `$ git push heroku master`
 
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

#### Useful things

I use [rvm](https://rvm.io/) to manage my ruby versions. 
To install a new version do this:

```shell
rvm install 3.0.4
```

If you need to mess with the database (not recommended, as we prefer admin pages on the site), you can
do so via the Heroku [console](https://dashboard.heroku.com/apps/rattlesnake-ramble?web-console=rattlesnake-ramble).
Once there you can run the Rails Console

```shell
heroku run console
```

Then you can select Active Record models, modify them, and commit them to the database like this:

```ruby
latest = RaceEdition.find_by(:date => '2022-09-10')
latest.date = Date.new(2022, 9, 17)
latest.default_start_time_female = Time.zone.parse('2022-09-17 13:52:00')
latest.save
```

## To see all the routes that this application supports, run:

```bash
rails routes
```

It shows something like this:
```bash
                      Prefix Verb   URI Pattern                                                                              Controller#Action
                        root GET    /                                                                                        pages#home
               welcome_index GET    /welcome/index(.:format)                                                                 welcome#index
                        home GET    /home(.:format)                                                                          pages#home
                       enter GET    /enter(.:format)                                                                         pages#enter
                      thanks GET    /thanks(.:format)                                                                        pages#thanks
                     charity GET    /charity(.:format)                                                                       pages#charity
                race_reports GET    /race_reports(.:format)                                                                  pages#race_reports
            new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
                user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
        destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
                       races GET    /races(.:format)                                                                         races#index
                             POST   /races(.:format)                                                                         races#create
                    new_race GET    /races/new(.:format)                                                                     races#new
                   edit_race GET    /races/:id/edit(.:format)                                                                races#edit
                        race GET    /races/:id(.:format)                                                                     races#show
                             PATCH  /races/:id(.:format)                                                                     races#update
                             PUT    /races/:id(.:format)                                                                     races#update
                             DELETE /races/:id(.:format)                                                                     races#destroy
                      racers GET    /racers(.:format)                                                                        racers#index
                             POST   /racers(.:format)                                                                        racers#create
                   new_racer GET    /racers/new(.:format)                                                                    racers#new
                  edit_racer GET    /racers/:id/edit(.:format)                                                               racers#edit
                       racer GET    /racers/:id(.:format)                                                                    racers#show
                             PATCH  /racers/:id(.:format)                                                                    racers#update
                             PUT    /racers/:id(.:format)                                                                    racers#update
                             DELETE /racers/:id(.:format)                                                                    racers#destroy
          enter_race_edition GET    /race_editions/:id/enter(.:format)                                                       race_editions#enter
   create_entry_race_edition POST   /race_editions/:id/create_entry(.:format)                                                race_editions#create_entry
   racer_emails_race_edition GET    /race_editions/:id/racer_emails(.:format)                                                race_editions#racer_emails
 racer_info_csv_race_edition GET    /race_editions/:id/racer_info_csv(.:format)                                              race_editions#racer_info_csv
   race_entries_race_edition GET    /race_editions/:id/race_entries(.:format)                                                race_editions#race_entries
               race_editions POST   /race_editions(.:format)                                                                 race_editions#create
            new_race_edition GET    /race_editions/new(.:format)                                                             race_editions#new
           edit_race_edition GET    /race_editions/:id/edit(.:format)                                                        race_editions#edit
                race_edition GET    /race_editions/:id(.:format)                                                             race_editions#show
                             PATCH  /race_editions/:id(.:format)                                                             race_editions#update
                             PUT    /race_editions/:id(.:format)                                                             race_editions#update
                             DELETE /race_editions/:id(.:format)                                                             race_editions#destroy
 successful_entry_race_entry GET    /race_entries/:id/successful_entry(.:format)                                             race_entries#successful_entry
cancelled_payment_race_entry GET    /race_entries/:id/cancelled_payment(.:format)                                            race_entries#cancelled_payment
             edit_race_entry GET    /race_entries/:id/edit(.:format)                                                         race_entries#edit
                  race_entry PATCH  /race_entries/:id(.:format)                                                              race_entries#update
                             PUT    /race_entries/:id(.:format)                                                              race_entries#update
                             DELETE /race_entries/:id(.:format)                                                              race_entries#destroy
                    products GET    /products(.:format)                                                                      products#index
                             POST   /products(.:format)                                                                      products#create
                 new_product GET    /products/new(.:format)                                                                  products#new
                edit_product GET    /products/:id/edit(.:format)                                                             products#edit
                     product GET    /products/:id(.:format)                                                                  products#show
                             PATCH  /products/:id(.:format)                                                                  products#update
                             PUT    /products/:id(.:format)                                                                  products#update
                             DELETE /products/:id(.:format)                                                                  products#destroy
          rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
   rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
          rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
   update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
        rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
```

## Creating a new race edition

You create a new race edition, do the following:

1. From the Admin menu, select "Races"
2. Click on the race for which you want to make a new edition
3. Enter the date and default start times for men and women

## Updating entries

#### Getting racer emails, unpaid racer emails

From the Admin menu, select "View Full Course Emails" or "View Kids Course Emails"

On this page are three buttons: All, Paid, Unpaid

#### Updating payment and bib number for entrants

http://www.rattlesnakeramble.org/race_entries 

Make sure to find the entry for the correct race editions

#### Updating racer information, like birth date

http://www.rattlesnakeramble.org/racers

#### Exporting racer information to a spreadsheet

http://www.rattlesnakeramble.org/race_editions/rattlesnake-ramble-trail-race-on-2019-09-14/racer_info_csv

#### Posting race entries to OpenSplitTime.org

1. Set up the event group in OpenSplitTime.org
2. Make a new rake task for the specific year. There are several examples in `lib/tasks/ost/post_entries.rake`
3. Run the rake task, then ensure the race entries appear in OpenSplitTime.org.
