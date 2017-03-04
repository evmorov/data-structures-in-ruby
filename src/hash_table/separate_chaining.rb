class SeparateChaining
  Node = Struct.new(:key, :value, :next)

  def initialize(slots_count = 97)
    @slots_count = slots_count
    @slots = []
  end

  def []=(key, value)
    slot_index = hash(key)
    node = @slots[slot_index]
    while node
      if node.key == key
        node.key = key
        return
      end
      node = node.next
    end
    @slots[slot_index] = Node.new(key, value, @slots[slot_index])
  end

  def [](key)
    slot_index = hash(key)
    node = @slots[slot_index]
    while node
      return node.value if node.key == key
      node = node.next
    end
    nil
  end

  private

  def hash(key)
    key.hash.abs % @slots_count
  end
end
