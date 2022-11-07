# NO USED
namespace :docker do
  desc "Build docker image"
  task :build do
    puts "[INFO] Building docker image..."
    DOCKER_IMAGE = "dvarrui/teuton-get"
    system "docker rmi #{DOCKER_IMAGE}"
    system "docker build -t #{DOCKER_IMAGE} install/docker/"
  end

  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton-get")
  end
end
