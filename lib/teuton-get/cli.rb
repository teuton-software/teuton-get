# frozen_string_literal: true

require "thor"
require_relative "version"
require_relative "../teuton-get"

class CLI < Thor
  map ["-help", "--help"] => "help"

  map ["-version", "--version"] => "version"
  desc "version", "Show the program version"

  def version
    puts "#{TeutonGet::EXECUTABLE} version #{TeutonGet::VERSION}"
  end

  map ["ci", "-ci", "--create-info", "create-info"] => "create_info"
  option :color, type: :boolean
  desc "create-info DIRPATH", "Create info data for Teuton test"
  long_desc <<-LONGDESC
    Create info data for Teuton test. Example: "teutonget create-info systems.1/02-opensuse-conf"
  LONGDESC

  def create_info(testpath)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.create_info(testpath)
  end

  map ["cr", "-cr", "--create-repo", "create-repo"] => "create_repo"
  option :color, type: :boolean
  desc "create-repo", "Create repo into current directory"
  long_desc <<-LONGDESC
    Create index from SOURCE directory. Example: "teutonget create-repo"
  LONGDESC
  def create_repo
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.create_repo(".")
  end

  map ["d", "-d", "--download", "pull", "--pull"] => "download"
  option :color, type: :boolean
  option :into
  desc "download TESTID", "Download Teuton test"
  long_desc <<-LONGDESC
    Download Teuton test. Example: "teutonget download teuton.en:systems.1/02-opensuse-conf"
  LONGDESC
  def download(testid)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.download(testid, options[:into] || ".")
  end

  map ["--init"] => "init"
  option :color, type: :boolean
  desc "init", "Create ini config file"
  long_desc <<-LONGDESC
    Create inital configuration files. Example: "teutonget init"
  LONGDESC
  def init
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.init
  end

  map ["i", "-i", "--info", "info", "--show"] => "show"
  option :color, type: :boolean
  desc "show TESTID", "Show info data for Teuton test"
  long_desc <<-LONGDESC
    Show info data for Teuton test. Example: "teutonget info teuton.en:systems.1/02-opensuse-conf"
  LONGDESC
  def show(test_id)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.show_info(test_id)
  end

  map ["--repos"] => "repos"
  option :color, type: :boolean
  desc "repos", "Show repo list"
  long_desc <<-LONGDESC
    Show repo list. Example: "teutonget repos"
  LONGDESC

  def repos
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.show_repo_list
  end

  map ["r", "-r", "--refresh", "--update", "update"] => "refresh"
  option :color, type: :boolean
  desc "refresh", "Synchronize list of available tests."
  long_desc <<-LONGDESC
    Synchronize list of tests available. Example: "teutonget refresh"
  LONGDESC
  def refresh
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.refresh
  end

  map ["s", "-s", "--search"] => "search"
  option :color, type: :boolean
  desc "search [REPONAME:]FILTER", "Search Teuton test with FILTER"
  long_desc <<-LONGDESC
    Search Teuton test using FILTER. Example: "teutonget search opensuse"
  LONGDESC
  def search(filter)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.search(filter)
  end

  def respond_to_missing?(method_name, include_private = false)
    # Respond to missing methods name
    super
  end
end
