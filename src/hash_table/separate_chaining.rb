class SeparateChaining
  def initialize(slots_count = 97)
    @slots_count = slots_count
    @slots = []
  end

  def []=(key, value)
    @slots[hash(key)] = value
  end

  def [](key)
    @slots[hash(key)]
  end

  private

  def hash(key)
    key.hash.abs % @slots_count
  end
end
