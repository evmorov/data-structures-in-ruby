class SeparateChaining
  def []=(key, value)
    @st ||= []
    @st[hash(key)] = value
  end

  def [](key)
    @st[hash(key)]
  end

  private

  def hash(key)
    key.hash % 100
  end
end
