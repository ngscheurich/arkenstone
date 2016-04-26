# The Arkenstone

[![Build Status](https://circleci.com/gh/ngscheurich/arkenstone.svg?&style=shield)](https://circleci.com/gh/ngscheurich/arkenstone)
[![Code Coverage](https://codecov.io/github/ngscheurich/arkenstone/coverage.svg?branch=master)](https://codecov.io/github/ngscheurich/arkenstone?branch=master)

The Arkenstone is a Ruby on Rails development environment generator. Its
goal is to provide an easy way to spin up a new Vagrant box provisioned
for Rails development.

<iframe src="//giphy.com/embed/HfB1VJRaL5Ctq" width="100%" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/sparkle-hexagon-gem-HfB1VJRaL5Ctq">via GIPHY</a></p>

## Installation

    $ gem install arkenstone

## Usage

The Arkenstone provides you with the command line application `arkenstone`.
To create a new Arkenstone environment:

    $ arkenstone new path/to/app

Check out the `arkenstone help new` option to see the available
configuration options.

Once, you’ve generated your new environment, `cd` over to `path/to/app`
and run:

    $ vagrant up

Now go grab a cup of coffee or a glass of Scotch—this part might take a
while. The Arkenstone is busy building a new Vagrant box and doing some
initial work for you like:

- Installing system software depencies
- Building and installing Ruby
- Installing and setting up PostgreSQL
- Generating a new Rails app with [Suspenders](https://github.com/thoughtbot/suspenders)

When your new environment is complete, SSH into it with `vagrant ssh`,
`cd` to the /vagrant directory and fire up the Rails server with:

    $ bin/rails server -b 0.0.0.0
    
You should now be able to visit your Rails app on your host machine at
[http://localhost:3001](http://localhost:3001). Voilà!

---

[(ↄ) Copyleft](http://www.gnu.org/licenses/copyleft.en.html)
Nicholas Gunther Scheurich under the
[GNU General Public License](http://www.gnu.org/licenses/gpl.txt)
