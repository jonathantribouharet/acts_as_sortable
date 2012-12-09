# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
	s.files = `git ls-files`.split("\n")
	s.name = "acts_as_sortable"
	s.platform = Gem::Platform::RUBY
	s.summary = "A plugin to sort ActiveRecord model."
	s.homepage = "https://github.com/jonathantribouharet/acts_as_sortable"
	s.require_paths = ["lib"]
	s.version = "1.0"
	s.author = "Jonathan TRIBOUHARET"
	s.email = "jonathan.tribouharet@gmail.com"
end
