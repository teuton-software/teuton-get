require "json"
require_relative "result"
require_relative "../settings"
require_relative "../writer/format"

class Search
  def initialize(database, dev)
    @dev = dev
    @database = database
  end

  def call(reponame_filter, filters)
    @results = {}
    @database.keys.each do |reponame|
      if reponame_filter == :all || reponame.include?(reponame_filter)
        search_inside_repo(reponame, filters)
      end
    end
    sort_results
  end

  def show_json
    list = []
    @results.each do |i|
      list << {
        score: i[:score],
        reponame: i[:reponame],
        testname: i[:testname]
      }
    end
    puts list.to_json
  end

  def show_screen
    @results.each do |i|
      @dev.write ("(x%02d) " % i[:score]), color: :white
      reponame = TeutonGet::Format.colorize(i[:reponame], i[:repoindex])
      @dev.writeln "#{reponame}#{Settings::SEPARATOR}#{i[:testname]}"
    end
  end

  private

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

  def add_result(result)
    key = result.id
    if @results[key].nil?
      @results[key] = result
      return
    end
    @results[key].score += result.score
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

  def sort_results
    results = []
    @results.each_pair { |key, value| results += [value.to_h] }

    results.sort_by! do |i|
      [(Settings::MAGICNUMBER - i[:score]), i[:id]]
    end
    @results = results
  end
end
