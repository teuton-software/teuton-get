namespace :docker do
  desc "Build docker image"
  task :build do
    puts "[INFO] Building docker image..."
    image = "dvarrui/teuton-get"
    system "docker rmi #{image}"
    system "docker build -t #{image} install/docker/"
  end

  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton-get")
  end
end
