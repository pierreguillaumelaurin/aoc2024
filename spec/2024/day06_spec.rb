# frozen_string_literal: true

require 'rspec'
require 'webmock/rspec'
require 'net/http'
require_relative '../../lib/2024/day06'

RSpec.describe Year2024::Day06 do
  describe '.part1' do
    context 'with HTTP input' do
      let(:mock_response) do
        <<~MAP
          ....#.....
          .........#
          ..........
          ..#.......
          .......#..
          ..........
          .#..^.....
          ........#.
          #.........
          ......#...
        MAP
      end
      before do
        stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
          .to_return(status: 200, body: mock_response)
      end
      it 'fetches input via HTTP and returns the correct number of distinct positions' do
        uri = URI('https://adventofcode.com/2024/day/6/input')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.get(uri.path)
        expect(response.body).to eq(mock_response)
        expect(Year2024::Day06.part1(response)).to eq(41)
      end
    end

    context 'with a straight path' do
      let(:mock_response) do
        <<~MAP
          .....
          ..^..
          ....#
          .....
        MAP
      end

      before do
        stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
          .to_return(status: 200, body: mock_response)
      end

      it 'counts positions correctly' do
        uri = URI('https://adventofcode.com/2024/day/6/input')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.get(uri.path)

        expect(Year2024::Day06.part1(response)).to eq(2)
      end
    end
  end

  context 'with a right turn' do
    let(:mock_response) do
      <<~MAP
        ..#..
        ..^..
        ....#
        .....
      MAP
    end

    before do
      stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
        .to_return(status: 200, body: mock_response)
    end

    it 'counts positions correctly' do
      uri = URI('https://adventofcode.com/2024/day/6/input')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path)

      expect(Year2024::Day06.part1(response)).to eq(3)
    end
  end

  context 'with 2 turns' do
    let(:mock_response) do
      <<~MAP
        ..#..
        ..^.#
        ....#
        .....
      MAP
    end

    before do
      stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
        .to_return(status: 200, body: mock_response)
    end

    it 'counts positions correctly' do
      uri = URI('https://adventofcode.com/2024/day/6/input')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path)

      expect(Year2024::Day06.part1(response)).to eq(4)
    end
  end

  context 'with 3 turns' do
    let(:mock_response) do
      <<~MAP
        ..#..
        ..^.#
        ....#
        ...#.
      MAP
    end

    before do
      stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
        .to_return(status: 200, body: mock_response)
    end

    it 'counts positions correctly' do
      uri = URI('https://adventofcode.com/2024/day/6/input')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path)

      expect(Year2024::Day06.part1(response)).to eq(6)
    end
  end

  context 'with 4 turns' do
    let(:mock_response) do
      <<~MAP
        ..#..
        ..^.#
        #...#
        ...#.
      MAP
    end

    before do
      stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
        .to_return(status: 200, body: mock_response)
    end

    it 'counts positions correctly' do
      uri = URI('https://adventofcode.com/2024/day/6/input')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path)

      expect(Year2024::Day06.part1(response)).to eq(7)
    end
  end

  context 'with position overlaps' do
    let(:mock_response) do
      <<~MAP
        ..#....
        ......#
        #.^..#.
        ...#...
        ...#...
        ...#...
      MAP
    end

    before do
      stub_request(:get, 'https://adventofcode.com/2024/day/6/input')
        .to_return(status: 200, body: mock_response)
    end

    it 'counts positions correctly' do
      uri = URI('https://adventofcode.com/2024/day/6/input')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.get(uri.path)

      expect(Year2024::Day06.part1(response)).to eq(7)
    end
  end
end
