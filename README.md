[![Circle CI](https://circleci.com/gh/mccraveiro/pds-2015.svg?style=svg)](https://circleci.com/gh/mccraveiro/pds-2015) [![Stories in Ready](https://badge.waffle.io/mccraveiro/pds-2015.png?label=ready&title=Ready)](https://waffle.io/mccraveiro/pds-2015)
# README

* **Ruby version required**

  `2.2.1`

* **Installing dependencies**

  You first need bundler installed. To install run `gem install bundler`.

  Then run `bundle install` to install all dependencies.

* **Running the Application**

  Type `rails s` then go to `http://localhost:3000`

* **Database creation**

  Postgres should be running on localhost. A user with createdb permission should be created using `dadosabertos` as username and `password` as password. The following postgres command should do it:
  ```
  create role dadosabertos with createdb login password 'password';
  ```

* **Database initialization**

  Run `rake db:create` to create required databases.
  Also, `rake db:migrate` should be run everytime there is a model update.

* **How to run the test suite**

* **Services (job queues, cache servers, search engines, etc.)**

* **Deployment instructions**
