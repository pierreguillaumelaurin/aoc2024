#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'advent_of_code'

# Parse command-line arguments
year = Time.now.year
day = nil

# Simple argument parsing
case ARGV[0]
when /^\d+$/
  day = ARGV[0].to_i
when '--year'
  year = ARGV[1].to_i
  day = ARGV[2].to_i if ARGV[2]
else
  puts 'Usage: aoc <day>'
  puts '       aoc --year <year> <day>'
  exit 1
end

# Run the solution
AdventOfCode::CLI.run(year: year, day: day)
