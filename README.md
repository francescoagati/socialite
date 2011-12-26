# Authentication with Socialite

A [Rails 3.1](http://rubyonrails.org/) engine that provides support for linking
multiple authorization accounts per resource (ex. linking social networks
to a single user account). Currently it supports any authentication strategy
that is available for the [OmniAuth](http://github.com/intridea/omniauth)
project.

## Development

We are currently working on an initial release of Socialite. Once we
have a solid suite of tests in place, we will release an official 0.1.0
version to the public.

## Resources

* [Documentation](http://rdoc.info/github/jsmestad/socialite/master/frames)
* [Travis CI Project](http://travis-ci.org/#!/jsmestad/socialite)
* [Issue Tracker](https://github.com/jsmestad/socialite/issues)
* [Gem Releases](https://rubygems.org/gems/socialite)
* [Staging Testbed](http://socialite-gem.herokuapp.com)
* [Facebook Testbed](https://www.facebook.com/apps/application.php?id=281326728563029)

## Installation

To use Socialite in a Rails 3.1 application:

* Require it in the Gemfile: `gem 'socialite'`
* Install it by running `bundle`.
* Import migrations into the parent project with `rake
  socialite:install:migrations`

## History

This project began as a fork of [Tim Riley](http://openmonkey.com)'s
great Omnisocial plugin. The motivation for this fork is that I required
multiple authorizations for each account (linking support) and wanted a
proper Rails 3.1 Engine.

## Socialite Contributers

* [Justin Smestad](http://github.com/jsmestad)
* [Bobby Wilson](http://github.com/bobbyw)

## Copyright & License

Socialite is Copyright (c) 2011-2012 Justin Smestad. All Rights are Reserved. Code is
distributed under the Apache 2.0 License. See LICENSE file for more information.
