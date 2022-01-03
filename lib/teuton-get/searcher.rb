
class Searcher
  def initialize(args)
    @cache_dirpath = args[:cache_dirpath]
    @repo = args[:repo]
    @dev = args[:writer]
  end

  def refresh
    @dev.writeln '[INFO] Refresh test list'
    @repo.data.keys.sort.each do |key|
      refresh_repo key
    end
  end

  private

  def refresh_repo(reponame)
    return if @repo.data[reponame]['enable'] == false

    @dev.write " => Refresh repo "
    @dev.writeln "#{reponame}", color: :light_blue
    dirpath = File.join(@cache_dirpath, reponame)
    unless Dir.exist? dirpath
      begin
        FileUtils.mkdir_p(dirpath)
      rescue => e
        @dev.write "* Create dir  ERROR => "
        @dev.writeln dirpath, color: :red
        puts e
      end
    end
  end
end
