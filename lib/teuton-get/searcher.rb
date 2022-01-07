
require_relative 'searcher/result'
require_relative 'application'

class Searcher
  def initialize(args)
    @dev = args[:writer]

    @repodata = args[:repodata]
    filename = @repodata.database_filename

    @reader = args[:reader]
    @database = @reader.read(filename)

    @results = {}
  end

  def get(input)
    reponame_filter, filters = parse_input(input)
    search_inside(reponame_filter, filters)
  end

  def show(result)
    @results.each do |i|
      @dev.writeln "(#{i[:score]}) #{i[:reponame]}@#{i[:testname]}"
    end
  end

  private

  def parse_input(input)
    reponame_filter = :all
    filter = :all
    options = input.split('@')
    if options.size == 1
      reponame_filter = :all
      filter = options[0]
    elsif options[0] == ''
        reponame_filter = :all
        filter = options[1]
    elsif options.size == 2
      reponame_filter = options[0]
      filter = options[1]
    end
    reponame_filter = :all if reponame_filter == 'ALL'
    if filter == 'ALL'
      filters = :all
    else
      filters = filter.split(',')
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
    return if reponame != :all and @database[reponame].nil?

    @database[reponame].each do |testname, data|
      result = Result.new(score: 0,
                          reponame: reponame,
                          testname: testname)
      if (filters == :all)
        add_result(result)
        next
      end
      score = 0
      filters.each do |filter|
        score += evaluate_test(testname: testname,
                               data: data,
                               filter: filter)
        if (score > 0)
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
      if value.class == String
        score += 1 if (value.downcase.include? filter)
      elsif value.class == Date
        score += 1 if (value.to_s.include? filter)
      elsif value.class == Array
        score += 1 if (value.include? filter)
      end
    end
    score += 1 if (testname.include? filter)
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

  def sort_results()
    results = []
    @results.each_pair { |key, value| results += [value.to_h] }

    results.sort_by! do |i|
      [(Application::MAGICNUMBER - i[:score]), i[:id]]
    end
    @results = results
  end
end
