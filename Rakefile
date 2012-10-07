#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec') do |t|
  t.rspec_opts = '-t ~remote'
end

RSpec::Core::RakeTask.new('spec:remote') do |t|
  t.rspec_opts = '-t remote'
end

task :default => :spec
