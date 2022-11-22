# frozen_string_literal: true

require "thor"
require_relative "application"
require_relative "version"
require_relative "../teuton-get"

class CLI < Thor
  map ["-help", "--help"] => "help"

  map ["-version", "--version"] => "version"
  desc "version", "Show the program version"

  def version
    puts "#{Version::EXECUTABLE} (version #{Version::VERSION})"
  end

  map ["ci", "-ci", "--create-info", "create-info"] => "create_info"
  desc "create-info [DIRPATH]", "Create info data for Teuton test"
  long_desc <<-LONGDESC
    Create info data for Teuton test. Example: "teutonget create-info systems.1/02-opensuse-conf"
  LONGDESC

  def create_info(testpath)
    TeutonGet.create_info(testpath)
  end

  map ["cr", "-cr", "--create-repo", "create-repo"] => "create_repo"
  desc "create-repo", "Create repo into current directory"
  long_desc <<-LONGDESC
    Create index from SOURCE directory. Example: "teutonget create-repo"
  LONGDESC
  def create_repo
    TeutonGet.create_repo(".")
  end

  map ["--init"] => "init"
  desc "init", "Create ini config file"
  long_desc <<-LONGDESC
    Create ini config file. Example: "teutonget init"
  LONGDESC
  def init
    TeutonGet.init
  end

  map ["i", "-i", "--info"] => "info"
  desc "info TESTID", "Show info data for Teuton test"
  long_desc <<-LONGDESC
    Show info data for Teuton test. Example: "teutonget info teuton.en:systems.1/02-opensuse-conf"
  LONGDESC

  def info(test_id)
    TeutonGet.show_info(test_id)
  end

  map ["--repos"] => "repos"
  desc "repos", "Show repo list"
  long_desc <<-LONGDESC
    Show repo list. Example: "teutonget repos"
  LONGDESC

  def repos
    TeutonGet.show_repo_list
  end

  map ["r", "-r", "--refresh"] => "refresh"
  desc "refresh", "Synchronize list of available tests."
  long_desc <<-LONGDESC
    Synchronize list of tests available. Example: "teutonget refresh"
  LONGDESC
  def refresh
    TeutonGet.refresh
  end

  map ["s", "-s", "--search"] => "search"
  desc "search [REPONAME:]FILTER", "Search Teuton test with FILTER"
  long_desc <<-LONGDESC
    Search Teuton test using FILTER. Example: "teutonget search opensuse"
  LONGDESC
  def search(filter)
    TeutonGet.search(filter)
  end

  map ["d", "-d", "--download", "clone", "--clone"] => "download"
  # option :dirname # FIXME
  desc "download TESTID", "Download Teuton test"
  long_desc <<-LONGDESC
    Download Teuton test. Example: "teutonget download teuton.en:systems.1/02-opensuse-conf"
  LONGDESC
  def download(testname)
    puts options unless options.empty?
    TeutonGet.download(testname, options)
  end
end
