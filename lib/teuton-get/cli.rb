# frozen_string_literal: true

require "thor"
require_relative "application"
require_relative "version"
require_relative "../teuton-get"

class CLI < Thor
  map ["h", "-h", "--help"] => "help"

  map ["v", "-v", "--version"] => "version"
  desc "version", "Show the program version"

  def version
    puts "#{Version::EXECUTABLE} (version #{Version::VERSION})"
  end

  map ["ci", "-ci", "--create-info"] => "create_info"
  desc "create-info [DIRPATH]", "Create info data for Teuton test"
  long_desc <<-LONGDESC
  Create info data for Teuton test.
  LONGDESC
  def create_info(testpath)
    TeutonGet.create_info(testpath)
  end

  map ["i", "-i", "--info"] => "info"
  desc "info TESTID", "Show info data for Teuton test"
  long_desc <<-LONGDESC
  Show info data for Teuton test.
  LONGDESC
  def info(test_id)
    TeutonGet.show_info(test_id)
  end

  map ["cr", "-cr", "--create-repo"] => "create_repo"
  desc "create-repo [DIRPATH]", "Create repo into DIRPATH directory"
  long_desc <<-LONGDESC
  Create index from SOURCE directory.
  LONGDESC
  def create_repo(source_dir)
    TeutonGet.create_repo(source_dir)
  end

  map ["i", "-i", "--init"] => "init"
  desc "init", "Create ini config file"
  long_desc <<-LONGDESC
    Create ini config file
  LONGDESC
  def init
    TeutonGet.init
  end

  map ["--repos"] => "repos"
  desc "repos", "Show repo list"
  long_desc <<-LONGDESC
    Show repo list.
  LONGDESC
  def repos
    TeutonGet.show_repo_list
  end

  map ["r", "-r", "--refresh"] => "refresh"
  desc "refresh", "Synchronize list of available tests."
  long_desc <<-LONGDESC
    Synchronize list of tests available.
  LONGDESC
  def refresh
    TeutonGet.refresh
  end

  map ["s", "-s", "--search"] => "search"
  desc "search [REPONAME:]FILTER", "Search Teuton test with FILTER"
  long_desc <<-LONGDESC
  Search Teuton test with FILTER.
  LONGDESC
  def search(filter)
    TeutonGet.search(filter)
  end

  map ["d", "-d", "--download"] => "download"
  desc "download TESTID", "Download Teuton test"
  long_desc <<-LONGDESC
    Download Teuton test. Example: "teutonget main@system/opensuse"
  LONGDESC
  def download(testname)
    TeutonGet.download(testname)
  end
end
