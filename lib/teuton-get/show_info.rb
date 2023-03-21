# frozen_string_literal: true

require_relative "repo/repo_data"
require_relative "searcher"
require "json/pure"

class ShowInfo
  def initialize
    @repo_data = RepoData.default
  end

  def call(testid, options)
    testinfo = get_testinfo(testid)
    if options["format"] == "json"
      puts testinfo.to_json
    else
      @repo_data.show_testinfo(testinfo)
    end
  end

  private

  def get_testinfo(testid)
    testinfo = @repo_data.get_info(testid)

    if testinfo == {}
      results = Searcher.default.get(testid).results
      if results.size.zero?
        puts "No results!"
        exit 1
      elsif results.size == 1
        testid = results[0][:id]
        testinfo = @repo_data.get_info(testid)
        exit 1 if testinfo == {}
      else
        results.each { |i| puts "* #{i[:id]}" }
        puts "#{results.size} results!"
        exit 1
      end
    end

    testinfo
  end
end
