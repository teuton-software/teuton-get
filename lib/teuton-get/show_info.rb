require_relative "repo/repo_data"
require_relative "searcher"
require "json/pure"

class ShowInfo
  def self.call(test_id, options)
    repo_data = RepoData.default
    testinfo = repo_data.get_info(test_id)

    if testinfo == {}
      results = Searcher.default.get(test_id).results
      if results.size.zero?
        puts "No results!"
        exit 1
      elsif results.size == 1
        test_id = results[0][:id]
        testinfo = repo_data.get_info(test_id)
        exit 1 if testinfo == {}
      else
        results.each { |i| puts "* #{i[:id]}" }
        puts "#{results.size} results!"
        exit 1
      end
    end

    if options["format"] == "json"
      puts testinfo.to_json
    else
      repo_data.show_testinfo(testinfo)
    end
  end
end
