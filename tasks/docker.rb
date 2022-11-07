# NO USED
namespace :docker do
  desc "Build docker image"
  task :build do
    puts "[INFO] Pushing docker..."
    system("docker build docker/teuton-get")
  end

  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton-get")
  end
end
