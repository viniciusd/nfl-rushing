![Build status](https://travis-ci.org/viniciusd/nfl-rushing.svg?branch=master)
# nfl-rushing
<p align="center">
  <img src="/.images/screenshot.png" width=780>
</p>

*A quick demo of a React client that reads NFL rushing data from an Elixir back-end*
nfl-rushing back-end is a service that provides a single HTTP endpoint:
```
GET    /api/players   - List players based on query parameters
```
The back-end also serves the static files generated by the client build.

### Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo there is a sample data file [`rushing.json`](/server/priv/rushing.json).

##### Client Features
1. The user is able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
2. The user is able to filter by the player's name
3. The user is able to download the sorted data as a CSV, as well as a filtered subset

##### Server Features
2. The system is able to provide every feature required by the client
2. The system is able to potentially support larger sets of data on the order of 10k records.

## Installing

### 🐳 Using Docker
Plain and simple: Given the entire build process is described in the Dockerfile, all it takes is cloning this repo, building, and running its image

```bash
$ git clone https://github.com/viniciusd/nfl-rushing.git
$ cd nfl-rushing
$ docker build -t nfl-rushing . 
$ docker run nfl-rushing
$ python -m webbrowser "http://localhost:5000"
```

### 📜 Without Docker

Even without Docker, the process isn't quite complicated:
```bash
$ git clone https://github.com/viniciusd/nfl-rushing.git
$ cd nfl-rushing
$ cd client
$ npm build
$ cp build ../server/priv/static
$ cd ../server
$ mix phx.server
$ python -m webbrowser "http://localhost:5000"
```

