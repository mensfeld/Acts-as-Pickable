# ActsAsPickable
## Install

    gem install acts_as_pickable

and in your Gemfile:
    
    gem 'acts_as_pickable'

Model declaration:

    class CoolClass < ActiveRecord::Base
        acts_as_pickable :column_name (default - :picked)
    end    

## About

Simple Rails gem allowing ActiveRecord models to be picked (selected).

Requirements

    table.boolean :picked, :default => false

## Example

    Example? Look into spec dir for rspec file :)    

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Maciej Mensfeld. See LICENSE for details.
