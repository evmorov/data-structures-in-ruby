class SeparateChaining
  attr_reader :size

  Node = Struct.new(:key, :value, :next)

  def initialize(slots_count = 97)
    @slots_count = slots_count
    @size = 0
    @slots = []
  end

  def []=(key, value)
    node = find_node(key)
    if node
      node.value = value
    else
      @size += 1
      slot_index = find_slot_index(key)
      @slots[slot_index] = Node.new(key, value, @slots[slot_index])
    end
  end

  def [](key)
    find_node(key)&.value
  end

  def delete(key)
    find_node(key) do |node, node_prev|
      @size -= 1
      node_prev ? (node_prev[:next] = node.next) : (@slots[find_slot_index(key)] = node.next)
      node.value
    end
  end

  def empty?
    size.zero?
  end

  private

  def find_node(key, &block)
    slot_index = find_slot_index(key)
    node = @slots[slot_index]
    node_prev = nil
    while node
      return (block ? yield(node, node_prev) : node) if node.key == key
      node_prev = node
      node = node.next
    end
  end

  def find_slot_index(key)
    key.hash.abs % @slots_count
  end
end
