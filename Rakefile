# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require_relative "tasks/devel"
require_relative "tasks/docker"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"

task default: %i[test standard]
