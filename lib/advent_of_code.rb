# frozen_string_literal: true

require 'optparse'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'

module AdventOfCode
  module CLI
    Dotenv.load
    class << self
      def run(year:, day:)
        validate_input(year, day)

        input = fetch_input(year, day)
        solution_module = load_solution(year, day)

        solve_and_print(solution_module, input)
      end

      def validate_input(year, day)
        raise ArgumentError, "Day must be between 1 and 25, got #{day}" unless (1..25).include?(day)

        raise ArgumentError, 'Invalid year' if year < 2015
      end

      def validate_session_token(session_token)
        return unless session_token.nil? || session_token.empty?

        raise 'Advent of Code session token not found. Set AOC_SESSION_TOKEN in .env file.'
      end

      def validate_response(response)
        case response.code
        when '200'
          response.body.chomp # Remove trailing newline
        when '404'
          raise 'Input not found. Check year, day, and session token.'
        when '400', '403'
          raise 'Authentication failed. Verify your session token.'
        else
          raise "Failed to fetch input. HTTP #{response.code}: #{response.body}"
        end
      end

      def fetch_input(year, day)
        validate_input(year, day)
        session_token = ENV['AOC_SESSION_TOKEN']
        validate_session_token(session_token)

        url = URI("https://adventofcode.com/#{year}/day/#{day}/input")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['Cookie'] = "session=#{session_token}"

        response = http.request(request)

        validate_response response

        response
      end

      def load_solution(year, day)
        # Pad day to ensure two digits
        formatted_day = day.to_s.rjust(2, '0')

        # Construct the potential file path
        solution_file = File.join(year.to_s, "day#{formatted_day}.rb")

        begin
          # Dynamically require the solution file
          require_relative solution_file

          # Construct the module/class name
          solution_module_name = "Year#{year}::Day#{formatted_day}"

          # Attempt to get the constant
          Object.const_get(solution_module_name)
        rescue LoadError
          raise "Solution file not found: #{solution_file}"
        rescue NameError
          raise "Solution module not defined: #{solution_module_name}"
        end
      end

      def solve_and_print(solution_module, input)
        puts '=== Part 1 ==='
        part1_result = solution_module.part1(input)
        puts part1_result

        puts "\n=== Part 2 ==="
        part2_result = solution_module.part2(input)
        puts part2_result
      end
    end
  end
end
