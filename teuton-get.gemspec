require 'date'
require_relative 'lib/teuton-get/application'

Gem::Specification.new do |s|
  s.name        = Application::NAME
  s.version     = Application::VERSION
  s.date        = Date.today.strftime("%Y-%m-%d")
  s.summary     = "TeutonGet (Teuton Software)"
  s.description = <<-EOF
    Find and download Teuton Test.
  EOF

  s.extra_rdoc_files = [ 'README.md', 'LICENSE' ] +
                       Dir.glob(File.join('docs','**','*.md'))

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/dvarrui/teuton-get/tree/master'

  s.executables << 'teutonget'
  s.files       = Dir.glob(File.join('lib', '**', '*.*'))

  s.required_ruby_version = '>= 2.5.0'

  s.add_runtime_dependency 'inifile', '~> 3.0'
  s.add_runtime_dependency 'colorize', '~> 0.8.1'
  s.add_runtime_dependency 'terminal-table', '~> 3.0'
  s.add_runtime_dependency 'thor', '~> 1.1'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'
end
