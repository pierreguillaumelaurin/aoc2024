# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/2024/day09'

RSpec.describe Year2024::Day09 do
  describe 'Disk' do
    it 'should calculate the correct checksum' do
      disk = Year2024::Day09::Disk.new '2333133121414131402'
      expect(disk.checksum).to eq(1928)
    end

    it 'should consider empty space when calculating checksum' do
      disk = Year2024::Day09::Disk.new '29'
      expect(disk.checksum).to eq(0)
    end

    it 'should calculate the correct checksum with defragmentation' do
      disk = Year2024::Day09::Disk.new '2333133121414131402'
      expect(disk.checksum_with_defragmentation).to eq(2858)
    end
  end
end
