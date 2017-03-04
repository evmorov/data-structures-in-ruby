require 'rspec'
require_relative '../../src/hash_table/separate_chaining'

describe SeparateChaining do
  describe '#[]' do
    it do
      expect(subject['a']).to eq('a')
    end
  end
end
