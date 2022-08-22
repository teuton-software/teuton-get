# frozen_string_literal: true

require_relative 'utils'

namespace :install do
  desc 'Check installation'
  task :check do
    Utils.check_tests
  end

  desc 'Create launcher'
  task :launcher do
    Utils.create_launcher
  end
end
