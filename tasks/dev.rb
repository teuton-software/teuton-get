# frozen_string_literal: true

namespace :dev do
  desc 'Create launcher'
  task :launcher do
    if File.exist? '/usr/local/bin/teutonget'
      puts '[WARN] Exist file /usr/local/bin/teutonget!'
      return
    end
    puts '[INFO] Creating launcher into /usr/local/bin'
    system("cp files/teutonget '/usr/local/bin/teutonget'")
  end
end
