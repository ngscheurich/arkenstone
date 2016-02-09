# Arkenstone

[![Build Status](https://travis-ci.org/ngscheurich/arkenstone.svg?branch=master)](https://travis-ci.org/ngscheurich/arkenstone)
[![Code Climate](https://codeclimate.com/github/ngscheurich/arkenstone/badges/gpa.svg)](https://codeclimate.com/github/ngscheurich/arkenstone)

The Arkenstone is a Ruby on Rails application generator set up to use my
preferred development configuration. It is heavily influenced by thoughtbot’s
Suspenders; I simply prefer to have something that I’ve pruned from infancy
and just totally *get*, you know?

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
