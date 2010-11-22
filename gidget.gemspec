# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gidget}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Forrest Robertson"]
  s.date = %q{2010-11-21}
  s.description = %q{Gidget is a minimalist blog engine designed to run on Heroku with a Git-based workflow.}
  s.email = %q{forrest@hasmanytrees.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "lib/gidget.rb",
    "lib/gidget/ext.rb",
    "lib/gidget/post.rb",
    "lib/gidget/post_index.rb",
    "lib/gidget/server.rb"
  ]
  s.homepage = %q{http://github.com/hasmanytrees/gidget}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{The smallest taco-loving blog engine in the world!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<haml>, [">= 3.0.24"])
      s.add_runtime_dependency(%q<rdiscount>, [">= 1.6.5"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 1.1.0"])
      s.add_dependency(%q<haml>, [">= 3.0.24"])
      s.add_dependency(%q<rdiscount>, [">= 1.6.5"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 1.1.0"])
    s.add_dependency(%q<haml>, [">= 3.0.24"])
    s.add_dependency(%q<rdiscount>, [">= 1.6.5"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

