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

    it 'no collision' do
      sc_hash = SeparateChaining.new(1)
      3.times { |n| sc_hash["key#{n}"] = "value#{n}" }
      3.times { |n| expect(sc_hash["key#{n}"]).to eq("value#{n}") }
    end

    it 'assign another value with the same key' do
      subject[:key] = 'value'
      subject[:key] = 'another value'
      expect(subject[:key]).to eq('another value')
    end

    it "setting value = nil doesn't take a slot" do
      sc_hash = SeparateChaining.new(1)
      sc_hash[:key] = nil
      expect(sc_hash.instance_variable_get(:@slots).size).to eq(0)
    end

    it 'setting value = nil deletes a pair' do
      sc_hash = SeparateChaining.new(1)
      sc_hash[:key] = 'value'
      sc_hash[:key] = nil
      expect(sc_hash.instance_variable_get(:@slots).first).to be_nil
    end
  end

  describe '#delete' do
    it 'deletes a pair' do
      subject['key'] = 'value'
      subject.delete('key')
      expect(subject['key']).to be_nil
    end

    it 'returns the removed value' do
      subject['key'] = 'value'
      expect(subject.delete('key')).to eq('value')
    end

    it "doesn't change size if there is no such key" do
      subject['key'] = 'value'
      subject.delete('no-key')
      expect(subject.size).to eq(1)
    end

    context 'when there was a collision' do
      subject do
        SeparateChaining.new(1)
      end

      before do
        subject['key1'] = 'value1'
        subject['key2'] = 'value2'
        subject['key3'] = 'value3'
      end

      it 'deletes the first node in a slot' do
        subject.delete('key1')
        expect(subject['key1']).to be_nil
        expect(subject['key2']).to eq('value2')
        expect(subject['key3']).to eq('value3')
      end

      it 'deletes a middle node in a slot' do
        subject.delete('key2')
        expect(subject['key1']).to eq('value1')
        expect(subject['key2']).to be_nil
        expect(subject['key3']).to eq('value3')
      end

      it 'deletes the last node in a slot' do
        subject.delete('key3')
        expect(subject['key1']).to eq('value1')
        expect(subject['key2']).to eq('value2')
        expect(subject['key3']).to be_nil
      end
    end
  end

  describe '#size' do
    it 'when just created size is 0' do
      expect(subject.size).to be_zero
    end

    it 'returns the number of pairs' do
      3.times { |n| subject[n] = n }
      expect(subject.size).to eq(3)
    end
  end

  describe '#empty?' do
    it 'returns true if hash is empty' do
      expect(subject).to be_empty
    end

    it 'returns false if hash is not empty' do
      subject['key'] = 'value'
      expect(subject).to_not be_empty
    end
  end
end
