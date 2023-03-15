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

  map ["d", "-d", "--download", "download", "--pull"] => "pull"
  option :color, type: :boolean
  option :into
  desc "pull TESTID", "Download Teuton test"
  long_desc <<-LONGDESC
  Example: "teutonget pull teuton.en:systems.1/02-opensuse-conf". Download test.
  LONGDESC
  def pull(testid)
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
  option :format, type: :string
  desc "show TESTID|FILTER", "Show info data for Teuton test"
  long_desc <<-LONGDESC
    Example: "teutonget show teuton.en:systems.1/02-opensuse-conf". Show test info.

    Example: "teutonget show foo --format=json". Show test info using JSON format.
  LONGDESC
  def show(test_id)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.show_info(test_id, options)
  end

  map ["--repos"] => "repos"
  option :color, type: :boolean
  option :format, type: :string
  desc "repos", "Show repo list"
  long_desc <<-LONGDESC
    Example: "teutonget repos". Show repo list.

    Example: "teutonget repos --format=json". Show JSON repos list. 
  LONGDESC

  def repos
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.show_repo_list(options)
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
  option :format, type: :string
  desc "search [REPONAME:]FILTER", "Search Teuton test with FILTER"
  long_desc <<-LONGDESC
    Example: "teutonget search opensuse". Search tests filtering by 'opensuse'.

    Example: "teutonget search debian --format=json". Search tests filtering by 'debian' and show JSON format output.
  LONGDESC
  def search(filter)
    TeutonGet::Format.disable if options["color"] == false
    TeutonGet.search(filter, options)
  end

  def respond_to_missing?(method_name, include_private = false)
    # Respond to missing methods name
    super
  end
end
