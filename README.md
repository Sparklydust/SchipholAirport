# SchipholAirport



## by Roland LARIOTTE
## contact: roland.lariotte@gmail.com



Time Spent:  
- around 76 hours

Resources mostly used: 
- [Stackoverflow](https://stackoverflow.com)
- [Ray Wenderlich's books](https://www.raywenderlich.com)
- [Hacking With Swift content](https://www.hackingwithswift.com)
- [iOS Unit Testing by example](https://pragprog.com/titles/jrlegios/ios-unit-testing-by-example)
- [Delete a storyboard](https://medium.com/better-programming/creating-ios-apps-without-storyboards-42a63c50756f)
- [Create a cell programmatically](https://medium.com/@kemalekren/swift-create-custom-tableview-cell-with-programmatically-in-ios-835d3880513d)
- [Sort an array by location](https://stackoverflow.com/questions/35199363/sort-array-by-calculated-distance-in-swift)




## iOS Development Assignment


### Introduction

Impala Studios is an app development company. We’re always looking for new ideas to 
capture more of the market, or create markets ourselves. We currently have 2 flight-related 
app titles, The Flight Tracker (iOS, Android), and Flight Board (iOS).


### Prompt

You have been asked by Impala Studios's stakeholders to make an app for them that gives 
information about different airports that can be reached on a given day from Schiphol Airport.
Schiphol has provided us with the following 3 data files:

- Airlines: ​https://flightassets.datasavannah.com/test/airlines.json
- Airports: ​https://flightassets.datasavannah.com/test/airports.json
- Flights: ​https://flightassets.datasavannah.com/test/flights.json

The stakeholders want a multi-tab iOS application. On the first tab they would like to see a 
map that shows all the airports. When a user then taps on one of the airports the app will 
navigate to the airport details screen.

The airport details screen should display the following:

- The specifications of this airport. (id, latitude, longitude, name, city and countryId).
- The nearest airport and its distance.

On the second tab they would like to see a list of airports that could be reached directly from 
Schiphol Airport that day, sorted by the distance from Schiphol Airport, ascending.

On the third tab they would like to see a list of airlines that are flying from Schiphol Airport that 
day, sorted by the total distance of all flights from Schiphol Airport of that airline that day, ascending.

Please keep structure, readability, maintainability and efficiency in mind while making the app.


### Rules

- Log the time working you spent working on this test.
- The app needs to run on iOS 11 and above.
- The UI has to be built programmatically. Storyboards are not permitted.
- Searching on the internet is allowed and found code snippets can be used. Please add comments to sources used.

Bonus points
- Add unit tests
- Highlight the two airports on the map that are the furthest away from each other
- A fourth tab with settings where you can change the distance unit from kilometers to
miles.
- Dark / light mode support
- Support localization and add a second language to the app.
- UI tests
- Use asynchronous web requests to retrieve the 3 JSON files.
