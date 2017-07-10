# Rails Tutorial sample application

Sample for [*Ruby on rails Tutorial: Learn Web Development with rails*](http://www.railstutorial.org/)

## License

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/) is available jointly under the MIT License and the Beerware License. See [LICENSE.md](LICENSE.md) for details.

## Getting Started

To get started, acquire Ruby 2.4.1, clone the repo, then install the needed gems:

```
$ bundle install
```

Next, migrate the embedded sqlite database:

```
$ rails db:migrate
```

Finally, run the tests to ensure everything is working correctly:

```
$ rails test
```

If the tests pass, you'll be ready to run the app in a local server:

```
$ rails server
```