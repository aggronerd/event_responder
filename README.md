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

    rake db:migrate
    rails s
    
## Running the tests

To test the system run the following:

    rake test
    
## Usage

### Logging events

Request data can take the following forms:

    {"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}
    {"Address":"tom@lostmy.name","EmailType":"UserConfirmation","Event":"click","Timestamp":1432820702}
    {"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"open","Timestamp":1432820704}
    
Once you have started the server by running 'rails s' you can start sending data to the server. If you are running development
environment you can point the test script to the server running on port 3000

    ./llirdnam http://localhost:3000/events
    
### Viewing the summarised data

TODO
    
## Notes

- Email address are never stored - we don't need them and they could be considered confidential information adding a potential security risk.
- Timestamps are ignored - they are not required.
    
### Storage backend

The development and test environment uses SQLite3 because it is quick to set up. In any production environment at least
a relational database server would be required. If this was to scale to millions per second a keystore with support
for atomic operations would be more suited such as Redis.

### To-dos

- Remove the Event.created_at - it's not used for anything and just consumes space.