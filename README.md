# ruby_ufc

:warning: :construction: **Under heavy development** :warning: :construction:

[![Build Status](https://travis-ci.org/kiriakosv/ruby_ufc.svg?branch=master)](https://travis-ci.org/kiriakosv/ruby_ufc)
[![Coverage Status](https://coveralls.io/repos/github/kiriakosv/ruby_ufc/badge.svg?branch=master)](https://coveralls.io/github/kiriakosv/ruby_ufc?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/2c5d82e2464d857bd494/maintainability)](https://codeclimate.com/github/kiriakosv/ruby_ufc/maintainability)

A simple Ruby wrapper to communicate with the UFC API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_ufc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_ufc

## Usage

Description and examples of the supported actions are below. Every action returns an Array of Hashes or an empty Array.

```ruby
# Instantantiate
client = RubyUfc::Client.new

client.fighters # Returns an Array of Hashes with all the fighters

client.fighters(first_name: 'Conor') # Returns each fighter whose first name is Conor

client.fighters(first_name: 'SomeWeirdName') # Returns an empty Array

client.fighters(unknown_key: 'A value') # Returns an empty Array
```

Every supported action has the same behaviour as the action above. Currently
supported actions are:
* fighters
* octagon_girls
* events
* news
* media

Since UFC API has no documentation, each of the actions above comes with a
helper action that returns an Array of Symbols with the attributes for that
particular resource. You can use them as follows.

```ruby
client.news_attributes #=> [:article_date, :article_fighter_id, :article_media_id, :author, :created, :external_url, :external_url_text, :featured_news_category, :id, :introduction, :keyword_ids, :last_modified, :published_start_date, :thumbnail, :title, :url_name]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

In order to contribute to this project, follow the guidelines below:
* Fork the project
* Create a feature branch and pull request.
* Make your commits atomic and descriptive. You can find a nice guide for Git
  best practices [here](https://github.com/agis/git-style-guide) .

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
