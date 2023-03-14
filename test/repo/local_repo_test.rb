require "test/unit"

require_relative "../../lib/teuton-get/repo/local_info"
require_relative "../../lib/teuton-get/repo/local_repo"
require_relative "../../lib/teuton-get/reader/yaml_reader"
require_relative "../../lib/teuton-get/writer/file_writer"
require_relative "../../lib/teuton-get/writer/null_writer"

class LocalRepoTest < Test::Unit::TestCase
  def setup
    @tmpdir = "var"
    @localinfo = LocalInfo.new(NullWriter.new)
    @localrepo = LocalRepo.new(
      repoindex_writer: FileWriter.new,
      progress_writer: NullWriter.new
    )
    @dirpaths = [
      "test/files/learn-00-empty",
      "test/files/learn-01-target",
      "test/files/learn-02-config"
    ]
  end

  def test_create_repo
    tempfiles = []

    dirpath = @dirpaths[1]
    @localinfo.default_created(dirpath)
    tempfiles << File.join(dirpath, Settings::INFOFILENAME)

    dirpath = @dirpaths[2]
    @localinfo.default_created(dirpath)

    indexfilepath = File.join("test", "files", Settings::INDEXFILENAME)
    assert_equal false, File.exist?(indexfilepath)

    assert_equal true, @localrepo.create(File.join("test", "files"))
    assert_equal true, File.exist?(indexfilepath)
    tempfiles << indexfilepath

    tempfiles.each { |filepath| FileUtils.rm(filepath) }
  end
end
