# frozen_string_literal: true

require 'thor'
require_relative 'application'
require_relative '../teuton-get'

class CLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'

  def version
    puts "#{Application::NAME} (version #{Application::VERSION})"
  end

  map ['cr', '-cr', '--create-repo', 'create-repo'] => 'create_repo'
  desc 'create-repo [SOURCE-DIR]', 'Create repo from SOURCE directory'
  long_desc <<-LONGDESC
  Create index from SOURCE directory.
  LONGDESC
  def create_repo(source_dir)
    TeutonGet.create_repo(source_dir)
  end

  map ['s', '-s', '--search'] => 'search'
  desc 'search FILTER', 'Search Teuton test with FILTER'
  long_desc <<-LONGDESC
  Search Teuton test with FILTER
  LONGDESC
  def search(filter)
    TeutonGet.search(filter)
  end

  map ['d', '-d', '--download'] => '--download'
  desc 'download TESTNAME', 'Download Teuton test'
  long_desc <<-LONGDESC
    Download Teuton test
  LONGDESC
  def download(testname)
    TeutonGet.download(testname)
  end

end
