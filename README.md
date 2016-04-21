# Arkenstone

[![Build Status](https://circleci.com/gh/ngscheurich/arkenstone.svg?&style=shield)](https://circleci.com/gh/ngscheurich/arkenstone)
[![Code Coverage](https://codecov.io/github/ngscheurich/arkenstone/coverage.svg?branch=master)](https://codecov.io/github/ngscheurich/arkenstone?branch=master)

The Arkenstone is a Ruby on Rails application generator set up to use my
preferred development configuration. It is heavily influenced by thoughtbot’s
[Suspenders](https://github.com/thoughtbot/suspenders); I simply prefer to
have something that I’ve pruned from infancy and just totally *get*, you know?

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "arkenstone"
```

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install arkenstone

## Usage

The Arkenstone provides you with the command line application `arkenstone`,
which behaves essentially like `rails new`. To create a Rails app with
The Arkenstone, simply:

	$ arkenstone path/to/app

Check out the `--help` option to see the available configuration options.

---

[(ↄ) Copyleft](http://www.gnu.org/licenses/copyleft.en.html)
Nicholas Gunther Scheurich under the
[GNU General Public License](http://www.gnu.org/licenses/gpl.txt)
