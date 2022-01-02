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

  map ['s', '-s', '--search'] => 'search'
  desc 'search FILTER', 'Search Teuton test with FILTER'
  long_desc <<-LONGDESC
  Search Teuton test with FILTER
  LONGDESC
  def search(filter)
    TeutonGet.search(filter)
  end

  map ['ci', '-ci', '--create-index', 'create-index'] => 'create_index'
  desc 'create-index SOURCE-DIR [TARGET-FILE]', 'Create index from SOURCE directory to TARGET file'
  long_desc <<-LONGDESC
  Create index from SOURCE directory to TARGET file
  LONGDESC
  def create_index(source_dir, target_file)
    Index.create(source_dir, target_file)
  end
end
