
require_relative 'reader/yaml_reader'

class Filter
  def initialize(args)
    @cache_dirpath = args[:cache_dirpath]
    @repo = args[:repo]
    @dev = args[:writer]
    @reader = args[:reader]
    @database = {}
  end

  def get(input)
    reponame_filter, filter = read_search_input(input)
    results = []
    filename = database_filename

    @database = YamlReader.new.read(database_filename)
    if reponame_filter == 'all'
      @database.keys.each do |reponame|
        results += search_into_repo(reponame, filter)
      end
    else
      results += search_into_repo(reponame_filter, filter)
    end
    results
  end

  private

  def enabled?(reponame)
    @repo.data[reponame]['enable'] == true
  end

  def database_filename()
    File.join(@cache_dirpath, 'database.yaml')
  end

  def read_search_input(input)
    reponame_filter = 'all'
    options = input.split('@')
    if options.size == 1
      reponame_filter = 'all'
      filter = options[0]
    elsif options[0] == ''
        reponame_filter = 'all'
        filter = options[1]
    else
      reponame_filter = options[0]
      filter = options[1]
    end
    [reponame_filter, filter]
  end

  def search_into_repo(reponame, filter)
    results = []
    return results if @database[reponame].nil?

    @database[reponame].each do |testname, data|
      score = evaluate_test(testname: testname,
                            data: data,
                            filter: filter)
      if (score > 0)
        results += [{score: score, reponame: reponame, testname: testname}]
      end
    end
    results
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
end
