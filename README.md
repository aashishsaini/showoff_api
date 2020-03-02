# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  * 2.5.7

* System dependencies
    * install docker

* Configuration

* Database creation
    * postgresql

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
    #### Development
    ``` 
    * install docker
    * run cmd `docker-compose build`
    * setup `env variables in docker.env`
    * run cmd `docker-compose up -d`
    * run cmd `docker-compose run web bash`
    * run cmd `rake db:create`
    * run cmd `rake db:migrate`
    * run cmd `exit`
    ```
    #### Production
    ``` 
    * setup `env variables in credentials.yml.enc`
    * run cmd `git push heroku master`
    ```
