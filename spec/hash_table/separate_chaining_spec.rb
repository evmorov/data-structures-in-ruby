require 'rspec'
require_relative '../../src/hash_table/separate_chaining'

describe SeparateChaining do
  describe '.initialize' do
    it 'has 97 slots if not set explicitly' do
      1000.times { |n| subject[n] = n }
      expect(subject.instance_variable_get(:@slots).size).to eq(97)
    end

    it 'has number of slots that is sent to constructor' do
      sc_hash = SeparateChaining.new(1)
      1000.times { |n| sc_hash[n] = n }
      expect(sc_hash.instance_variable_get(:@slots).size).to eq(1)
    end
  end

  describe '#[] and #[]=' do
    it 'key is String' do
      subject['key'] = 'value'
      expect(subject['key']).to eq('value')
    end

    it 'key is Symbol' do
      subject[:key] = 'value'
      expect(subject[:key]).to eq('value')
    end

    it 'key is any object' do
      obj = Class.new
      subject[obj] = 'value'
      expect(subject[obj]).to eq('value')
    end

    it 'nil if there is no such key' do
      expect(subject['no-key']).to be_nil
    end

    xit 'collision' do
      sc_hash = SeparateChaining.new(1);
      sc_hash[:key1] = 'value1'
      sc_hash[:key2] = 'value2'
      expect(sc_hash[:key1]).to eq('value1')
    end
  end
end
