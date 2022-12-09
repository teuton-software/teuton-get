namespace :devel do
  desc "Create launcher"
  task :launcher do
    if File.exist? "/usr/local/bin/teutonget"
      puts "[WARN] Exist file /usr/local/bin/teutonget!"
    end
    puts "[INFO] Creating launcher 'teutonget' into /usr/local/bin"
    system("sudo cp tasks/files/teutonget /usr/local/bin/teutonget")
    system("sudo ln -s /usr/local/bin/teutonget /usr/local/bin/teuton-get")
  end
end
