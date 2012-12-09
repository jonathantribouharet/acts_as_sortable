ActsAsSortable
======================

A plugin to sort ActiveRecord model.

Installation
------------

Include the gem in your Gemfile:

    gem 'acts_as_sortable', :git => 'https://github.com/jonathantribouharet/acts_as_sortable'


Usage
-----

In your migrations:
	
	class CreateUsers < ActiveRecord::Migration
		def self.up
			create_table :users do |t|
				t.position
			end
		end
	end
	

Minimal configuration in your model:
	
	class User < ActiveRecord::Base
		acts_as_sortable
	end

Custom configuration in your model:
	
	class User < ActiveRecord::Base
		acts_as_sortable do |config|
			config.acts_as_sortable_scope = :category_id
		end
	end

* `acts_as_sortable_scope` is the scope for sort, by default it's nil.

Each instance have two methods :
	
	`position_up!` to upper element in order
	`position_down!` to lower element in order	
