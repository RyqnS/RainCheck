# RainCheck App

## Goal

Using Application Programming Interfaces (APIs) to grab live data from the internet. Specifically, using openweather API to retrieve weather information to display for the user

## What I created

A Dark-mode enabled weather app that can check the weather for the current location based on the GPS data from the user's iPhone as well as by searching for a city manually. 

## Additional Features

1) Included particle effects and animations to match weather conditions
  - Rain effects for Light rain, or Rainy conditions 
  - Additional Lightning and cloud effects for thunderstorms
  - Snow
  - Fog
  
2) Updated API call to go through and additional Geocoding API: API call now first retrieves coordinates from city location and uses coordinates to retrieve weather
  - This change was made to add another degree of accuracy to tell the user precisely what location's weather their search found, rather than a large region such as "China"
  - The openweather API used in the project also changed to require latitude and longitude inputs to a call, so using a Geocoding API to retrieve latitude and longitude from a city input was necessary

## What I learned

* How to create a dark-mode enabled app.
* How to use vector images as image assets.
* Learn to use the UITextField to get user input. 
* Learn about the delegate pattern.
* Swift protocols and extensions. 
* Swift guard keyword. 
* Swift computed properties.
* Swift closures and completion handlers.
* Learn to use URLSession to network and make HTTP requests.
* Parse JSON with the native Encodable and Decodable protocols. 
* Learn to use Grand Central Dispatch to fetch the main thread.
* Learn to use Core Location to get the current location from the phone GPS. 


>This is a companion project to The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)
