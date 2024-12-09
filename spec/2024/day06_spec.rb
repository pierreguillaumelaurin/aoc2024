require 'rspec'

require_relative '../../lib/2024/day06'

RSpec.describe Year2024::Day06 do
  describe '.part1' do
    context 'with the provided example input' do
      let(:input) do
        <<~MAP
          ....#.....
          ....XXXXX#
          ....X...X.
          ..#.X...X.
          ..XXXXX#X.
          ..X.X.X.X.
          .#XXXXXXX.
          .XXXXXXX#.
          #XXXXXXX..
          ......#X..
        MAP
      end

      it 'returns the correct number of distinct positions' do
        expect(Year2024::Day06.part1(input)).to eq(41)
      end
    end

    context 'with additional test cases' do
      it 'handles a simple input' do
        simple_input = <<~MAP
          ^..#
          ....
          ....
        MAP

        expect(Year2024::Day06.part1(simple_input)).to eq(1)
      end
    end
  end
end
