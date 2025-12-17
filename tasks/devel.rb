namespace :devel do
  desc "Create /usr/local/bin/teutonget"
  task :launcher do
    launcherpath = "/usr/local/bin/teutonget"
    if File.exist?(launcherpath)
      warn "File exist! (#{launcherpath})"
      exit 1
    end

    rubypath = `rbenv which ruby`.strip
    commandpath = File.join(Dir.pwd, "teutonget")

    puts "# Created with: 'rake devel:launcher'"
    puts "# - Copy this content into: #{launcherpath}"
    puts "# - Then: chmod +x #{launcherpath}"
    puts "RUBYPATH=#{rubypath}"
    puts "COMMANDPATH=#{commandpath}"
    puts "$RUBYPATH $COMMANDPATH $@"
  end

end
