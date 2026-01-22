# README

APP DESCRIPTION:
  
  This is a Ruby on Rails app that lets users save locations and view a 7-day forecast (daily high/low).
  Uses geocode.xyz for geocoding and Open-Meteo for forecasts.

INSTRUCTIONS FOR USE: 
  
  Requires Ruby and Rails installed locally.
  In the terminal, make sure you're in the root of the repo. 
  run:
    
    bundle install
    
  Once done, boot the server up with:
   
    bin/rails server

  Open either of the provided links:
    
    http://127.0.0.1:3000
    http://[::1]:3000

  and enter the location you would like to forcast. 

TESTING:

  This project uses RSpec for testing.
  To run the test suite:
  
    bundle exec rspec
  
  The test suite includes unit tests demonstrating how to stub third-party API calls for both geocoding (geocode.xyz) and weather data (Open-Meteo), ensuring tests do not make real HTTP     requests.

Note: Forecast view shows daily max/min only (no hourly data).
