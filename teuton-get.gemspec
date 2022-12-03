$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

name = "teuton-get"
require "#{name}/version"

Gem::Specification.new do |s|
  s.name = name
  s.version = Version::VERSION
  s.summary = "TeutonGet (Teuton Software)"
  s.description = <<-EOF
    Find and download Teuton Test.
  EOF

  s.extra_rdoc_files = ["README.md", "LICENSE"] \
                       + Dir.glob(File.join("docs", "**", "*.md"))

  s.license = "GPL-3.0"
  s.authors = ["David Vargas Ruiz"]
  s.email = "teuton.software@protonmail.com"
  s.homepage = Version::HOMEPAGE

  s.executables << "teutonget"
  s.executables << "teuton-get"
  s.files = Dir.glob(File.join("lib", "**", "*.*"))

  s.required_ruby_version = ">= 3.0.4"

  s.add_runtime_dependency "inifile", "~> 3.0"
  s.add_runtime_dependency "colorize", "~> 0.8"
  # s.add_runtime_dependency "pastel", "~> 0.8"
  s.add_runtime_dependency "tty-progressbar", "~> 0.18"
  s.add_runtime_dependency "tty-prompt", "~> 0.23"
  s.add_runtime_dependency "tty-table", "~> 0.12"
  s.add_runtime_dependency "thor", "~> 1.2"
end
