# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
- 2.4.0

* System dependencies
- Postgresql, redis

* Configuration

* Database creation

* Database initialization

* How to run the test suite

- bundle exec rake db:test:prepare
- bundle exec rake spec
- SIMPLECOV=true bundle exec rake spec
- bundle exec brakeman --exit-on-warn

` In case of docker, go inside the app container and run same command`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* How to use this application using Docker 

````
docker-compose build 
docker-compose up
````
