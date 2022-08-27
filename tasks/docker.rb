namespace :docker do
  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton-get")
  end
end
