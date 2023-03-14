require_relative "../settings"

class Result
  @@repoindex = Set.new

  attr_accessor :score
  attr_reader :reponame
  attr_reader :testname

  def initialize(args)
    @score = args[:score] || 0
    @reponame = args[:reponame] || "???"
    @testname = args[:testname] || "???"
    @@repoindex << @reponame
  end

  def id
    "#{reponame}#{Settings::SEPARATOR}#{testname}"
  end

  def to_h
    {
      score: @score,
      id: id,
      reponame: @reponame,
      testname: @testname,
      repoindex: repoindex
    }
  end

  def repoindex
    @@repoindex.to_a.index(@reponame)
  end
end
