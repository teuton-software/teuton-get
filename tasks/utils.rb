# frozen_string_literal: true

##
# Group general functions used by Rakefile tasks
module Utils
  def self.packages
    p = %w[thor colorize]
    p += %w[minitest yard rubocop]
    p
  end

  def self.create_symbolic_link
    if File.exist? '/usr/local/bin/teutonget'
      puts '[WARN] Exist file /usr/local/bin/teutonget!'
      return
    end
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    basedir = File.join(File.dirname(__FILE__), '..')
    system("ln -s #{basedir}/teutonget '/usr/local/bin/teutonget'")
  end

  def self.install_gems(list, options = '')
    fails = filter_uninstalled_gems(list)
    if !fails.empty?
      puts "[INFO] Installing gems (options = #{options})..."
      fails.each do |name|
        system("gem install #{name} #{options}")
      end
    else
      puts '[ OK ] Gems installed'
    end
  end

  def self.filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end

  def self.check_tests
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }
    d = File.join('.', 'tests', '**', '*_test.rb')
    e = Dir.glob(d)
    puts "[FAIL] Some ruby tests are not executed by #{testfile}" unless b.size == e.size
    puts "[INFO] Running #{testfile}"
    system(testfile)
  end
end
