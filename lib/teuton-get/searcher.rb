require "json"
require_relative "settings"
require_relative "reader/yaml_reader"
require_relative "repo/repo_data"
require_relative "searcher/search"
require_relative "writer/format"
require_relative "writer/terminal_writer"

class Searcher
  def initialize(args)
    repodata = args[:repodata]
    filename = repodata.database_filename
    reader = args[:reader]
    database = reader.read(filename)

    dev = args[:writer]
    @results = Search.new(database, dev)
  end

  def self.default
    Searcher.new(
      writer: TerminalWriter.new,
      repodata: RepoData.default,
      reader: YamlReader.new
    )
  end

  def get(input)
    reponame_filter, filters = parse_input(input)
    @results.call(reponame_filter, filters)
  end

  def show_results(options)
    if options["output"] == "json"
      @results.show_json
    else
      @results.show_screen
    end
  end

  private

  def parse_input(input)
    reponame_filter = :all
    filter = :all
    options = input.split(Settings::SEPARATOR)
    if options.size == 1
      reponame_filter = :all
      filter = options[0]
    elsif options[0] == ""
      reponame_filter = :all
      filter = options[1]
    elsif options.size == 2
      reponame_filter = options[0]
      filter = options[1]
    end
    reponame_filter = :all if reponame_filter == "ALL"
    filters = if filter == "ALL"
      :all
    else
      filter.split(",")
    end
    [reponame_filter, filters]
  end
end
