require 'rspec'
require_relative '../../src/hash_table/separate_chaining'

describe SeparateChaining do
  describe '#[] and #[]=' do
    it 'works if key is String' do
      subject['key'] = 'value'
      expect(subject['key']).to eq('value')
    end

    it 'works if key is Symbol' do
      subject[:key] = 'value'
      expect(subject[:key]).to eq('value')
    end
  end
end
