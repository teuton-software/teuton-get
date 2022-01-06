
class Result
  attr_accessor :score
  attr_reader :reponame
  attr_reader :testname

  def initialize(args)
    @score = args[:score] || 0
    @reponame = args[:reponame] || '???'
    @testname = args[:testname] || '???'
  end

  def id
    "#{reponame}@#{testname}"
  end

  def to_h
    {score: @score, id: id, reponame: @reponame, testname: @testname}
  end
end
