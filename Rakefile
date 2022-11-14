# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require_relative "tasks/devel"
require_relative "tasks/docker"

desc "Rake help"
task :help do
  system("rake -T")
end

require "standard/rake"

task default: %i[test standard]
