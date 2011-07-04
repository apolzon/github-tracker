#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

GithubTracker::Application.load_tasks

task :default => :spec
require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end
