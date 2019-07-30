# README

https://backend.turing.io/module3/projects/sweater_weather

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.4.1p111

* System dependencies
 - UNIX terminal

* Configuration
 - `$bundle`
 - `$bundle exec figaro install`
 - Add your own API keys to `config/application.yml`:
 ```yml
GOOGLE_MAPS_API_KEY: <your google maps API key>
DARK_SKY_API_KEY: <your dark sky API key>
FLICKR_API_KEY: <your flickr API key>
FLICKR_SECRET: <your flickr secret>
YELP_CLIENT_ID: <your yelp client ID>
YELP_API_KEY: <your yelp API key>
 ```

* Database creation
 - `$bundle exec rails db:create`

* Database initialization
 - `$bundle exec rails db:migrate`

* How to run the test suite
 - `$bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)
 - To enable caching in the development environment, run `$rails dev:cache` once

* Deployment instructions
 - `$git push heroku master`
 - Add ENV variables with `$heroku config:set <KEY>=<value>`

* ...
