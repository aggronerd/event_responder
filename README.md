# Event webhook responder

**Author:** Gregory Doran <greg@gregorydoran.co.uk>.

## Requirements

- Ruby 2.2.3
- Bundler

It is suggested to use [RVM](https://rvm.io/).

## Setup

Before running the webserver for testing you need to install the requirements above then you can install the dependencies using bundler.

    bundle install
    
## Running the server

To run the development server run:

    rails s
    
## Running the tests

To test the system run the following:

    rake test
    
## Usage

TODO: explain usage
    
## Storage backend

The development and test environment uses SQLite3 because it is quick to set up. In any production environment