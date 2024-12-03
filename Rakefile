# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# RSpec tasks
RSpec::Core::RakeTask.new(:spec)

# RuboCop tasks
RuboCop::RakeTask.new

# Default task runs tests and linter
task default: %i[spec rubocop]

namespace :aoc do
  desc 'Run solution for a specific day'
  task :solve, [:year, :day] do |_, args|
    year = args[:year].to_i || Time.now.year
    day = args[:day].to_i

    unless day
      puts 'Please specify a day, e.g., rake aoc:solve[2024,1]'
      exit 1
    end

    require_relative 'lib/advent_of_code'
    AdventOfCode::CLI.run(year: year, day: day)
  end
end
