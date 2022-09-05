require_relative "application"
require_relative "format"
require_relative "reader/yaml_reader"
require_relative "repo/repo_data"
require_relative "searcher/result"
require_relative "writer/terminal_writer"

class Searcher
  def initialize(args)
    @dev = args[:writer]

    @repodata = args[:repodata]
    filename = @repodata.database_filename

    @reader = args[:reader]
    @database = @reader.read(filename)

    @results = {}
  end

  def self.new_by_default
    Searcher.new(
      writer: TerminalWriter.new,
      repodata: RepoData.new_by_default,
      reader: YamlReader.new
    )
  end

  def get(input)
    reponame_filter, filters = parse_input(input)
    search_inside(reponame_filter, filters)
  end

  def show_result
    @results.each do |i|
      @dev.write "(x#{i[:score]}) ", color: :white
      reponame = TeutonGet::Format.colorize(i[:reponame], i[:repoindex])
      @dev.writeln "#{reponame}#{Application::SEPARATOR}#{i[:testname]}"
    end
  end

  private

  def parse_input(input)
    reponame_filter = :all
    filter = :all
    options = input.split(Application::SEPARATOR)
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

  def search_inside(reponame_filter, filters)
    @results = {}
    if reponame_filter == :all
      @database.keys.each { |reponame| search_inside_repo(reponame, filters) }
    else
      @database.keys.each do |reponame|
        search_inside_repo(reponame, filters) if reponame.include? reponame_filter
      end
    end
    sort_results
  end

  def search_inside_repo(reponame, filters)
    return if reponame != :all && @database[reponame].nil?

    @database[reponame].each do |testname, data|
      result = Result.new(
        score: 0,
        reponame: reponame,
        testname: testname
      )
      if filters == :all
        add_result(result)
        next
      end
      score = 0
      filters.each do |filter|
        score += evaluate_test(
          testname: testname,
          data: data,
          filter: filter
        )
        if score > 0
          result.score = score
          add_result result
        end
      end
    end
  end

  def evaluate_test(args)
    testname = args[:testname]
    data = args[:data]
    filter = args[:filter]

    score = 0
    data.each_pair do |key, value|
      if value.instance_of? String
        score += 1 if value.downcase.include? filter
      elsif value.instance_of? Date
        score += 1 if value.to_s.include? filter
      elsif value.instance_of? Array
        score += 1 if value.include? filter
      end
    end
    score += 1 if testname.include? filter
    score
  end

  def add_result(result)
    key = result.id
    if @results[key].nil?
      @results[key] = result
      return
    end
    @results[key].score += result.score
  end

  def sort_results
    results = []
    @results.each_pair { |key, value| results += [value.to_h] }

    results.sort_by! do |i|
      [(Application::MAGICNUMBER - i[:score]), i[:id]]
    end
    @results = results
  end
end
