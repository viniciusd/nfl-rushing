[![Build Status](https://travis-ci.org/viniciusd/nfl-rushing.svg?branch=master)](https://travis-ci.org/viniciusd/nfl-rushing)
# 🏈 nfl-rushing
> *A quick demo of a React client that reads NFL rushing data from an Elixir back-end*

<p align="center">
  <img src="/.images/screenshot.png" width=780>
</p>

## Background
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

## Routes

In addition to serving the static files generated by the client build, nfl-rushing back-end is a service that provides a single HTTP endpoint

> Data, give me data!

### `GET /api/players`

Lists statistics on the NFL players with regards to their rushing.

Some query parameters are available for filtering, sorting and paginating.

| Query parameter | Type   | Values     |
| --------------- |--------|------------|
| `page_number`   | int    | >= 1       |
| `page_size`     | int    | >= 1       |
| `sort`          | string | Yds/TD/Lng |
| `order`         | string | asc/desc   |
| `csv`           | any    | true       |
```json
{
"_links": {
    "prev": {"href": "http://.../"},
    "self": {"href": "http://.../"},
    "next": {"href": "http://.../"}
},
"data": [
  {
    "Player":"Joe Banyard",
    "Team":"JAX",
    "Pos":"RB",
    "Att":2,
    "Att/G":2,
    "Yds":7,
    "Avg":3.5,
    "Yds/G":7,
    "TD":0,
    "Lng":"7",
    "1st":0,
    "1st%":0,
    "20+":0,
    "40+":0,
    "FUM":0
  },
  {
    "Player":"Shaun Hill",
    "Team":"MIN",
    "Pos":"QB",
    "Att":5,
    "Att/G":1.7,
    "Yds":5,
    "Avg":1,
    "Yds/G":1.7,
    "TD":0,
    "Lng":"9",
    "1st":0,
    "1st%":0,
    "20+":0,
    "40+":0,
    "FUM":0
  }
]
```
```csv
1st,1st%,20+,40+,Att,Att/G,Avg,FUM,Lng,Player,Pos,TD,Team,Yds,Yds/G
0,0,0,0,2,2,3.5,0,7,Joe Banyard,RB,0,JAX,7,7
0,0,0,0,5,1.7,1,0,9,Shaun Hill,QB,0,MIN,5,1.7
```

## Client Features
1. The user is able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
2. The user is able to filter by the player's name
3. The user is able to download the sorted data as a CSV, as well as a filtered subset

## Server Features
2. The system is able to provide every feature required by the client
2. The system is able to potentially support larger sets of data on the order of 10k records.

## Installing and running

### 🐳 Using Docker
Plain and simple: Given the entire build process is described in the Dockerfile, all it takes is cloning this repo, building, and running its image

```bash
$ git clone https://github.com/viniciusd/nfl-rushing.git
$ cd nfl-rushing
$ docker build -t nfl-rushing . 
$ docker run -p 5000:5000 nfl-rushing
$ python -m webbrowser "http://localhost:5000/index.html"
```
Or you can use `docker-compose` instead:
```bash
$ git clone https://github.com/viniciusd/nfl-rushing.git
$ cd nfl-rushing
$ docker-compose up
$ python -m webbrowser "http://localhost:5000/index.html"
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
$ python -m webbrowser "http://localhost:5000/index.html"
```

## Running the tests

That's gonna be even simpler!

Considering you have already cloned this repo...

### ⚛️  Javascript tests
```bash
$ cd client
$ npm test
```

### ⚗️ Elixir tests
```bash
$ cd server
$ mix test
```

## Decisions and assumptions
* I know we could make an entire application using server-side rendering (maybe even trying out [LiveView](https://github.com/phoenixframework/phoenix_live_view)!), but I decided to decouple both front-end and back-end. Having the front-end project on its own makes it possible to deploy its build on a CDN (e.g. [Cloudflare](https://www.cloudflare.com)). Not only that, but it also makes possible to have different people working independently and simultaneously on both parts.
* Dockerizing: There is an intense war about whether to use or not containers on the BEAM. It is a fact, though, that using Docker allows an easier and reproduceable setup. After all, [it is possible to conciliate the BEAM and the current cloud culture](https://www.youtube.com/watch?v=nLApFANtkHs). Elixir 1.9 has also made it easier by [integrating the releases feature into Elixir itself](https://elixir-lang.org/blog/2019/06/24/elixir-v1-9-0-released/)
* With regards to the back-end stack, I picked Elixir as the development language (even though this is the larged project I created with it), and Phoenix as the web framework
* On the other hand, for the front-end, I chose React. It was an excellent opportunity for learning React, given I had never used it before nor I have much experience with front-end development
* The visuals are provided by [Bootstrap](https://getbootstrap.com/), a battle-proved front-end toolkit. With its neat approach of functional CSS, adding simple yet good-looking visuals was a quick task
* Given the static source of data and the small volume (in the order of 10k), I decided to perform every action in memory using the back-end server. For greater volumes of data, I would use PostgreSQL as a database and query it on demand. Even though we are talking about JSON data, PostgreSQL can be very efficient with its JSONB datatype and even index on it -- which would be an asset for sorting
* Taking into account the fact the Erlang/Elixir can effectively serve static files, that's the path I've taken for them even though the client is developed separetely
* Simple pagination was adapoted using only previous and next options. As the pagination standard, I opted for following the [HAL specification](http://stateless.co/hal_specification.html)
* I am currently using a transient GenServer for fetching and parsing the json and sending it to yet another GenServer that keeps the already-parsed structure in memory as its state

### Architecture draft
The high-level architecture can be found in the following box diagram.

```
     +-----------+
     | React App |
     +-----------+
          ||
          \/
------------------------
          /\
          ||
    +-------------+
    | Phoenix App |
    +-------------+
           |
    +-------------+
    |   Players   | *Plain module*
    |   handler   |
    +-------------+
           |
    +-------------+
    |   Data      | *GenServer*
    |   storage   |
    +-------------+
           |
    +-------------+
    |   Data      | *GenServer*
    |   source    |
    +-------------+
```


### TO-DOs
* Consider using [Task.Supervisor](https://hexdocs.pm/elixir/Task.Supervisor.html#start_child/5) for running the one-off process of fetching the json data
* Mocking the back-end response in the front-end and performing funtional tests using the [React Testing Library](https://testing-library.com/docs/react-testing-library/intro)
* Further testing the Longest Rush sorting, given it is a string and may contain a T representing a touchdown
* Add unit tests for the CSV related functions in the back-end
* Asssess using ReasonML with [reason-react](https://reasonml.github.io/reason-react/) for the front-end
* Make sure the data storage, if restarted, can be filled again with the data sourced. That means the data source won't be transient anymore
