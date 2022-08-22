# frozen_string_literal: true

##
# Group general functions used by Rakefile tasks
module Utils
  def self.create_launcher
    if File.exist? '/usr/local/bin/teutonget'
      puts '[WARN] Exist file /usr/local/bin/teutonget!'
      return
    end
    puts '[INFO] Creating launcher into /usr/local/bin'
    system("cp files/teutonget '/usr/local/bin/teutonget'")
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
