class Day03
  def part1(inputs)
    inputs
      .split("\n")
      .map(&method(:split_in_half))
      .map(&method(:priorities))
      .sum
  end

  def example_part1
    157
  end

  def part2(inputs)
    inputs
      .split("\n")
      .each_slice(3)
      .map(&method(:priorities))
      .sum
  end

  def example_part2
    70
  end

  private

  def split_in_half(value)
    value.chars.each_slice(value.size / 2).map(&:join)
  end

  def priorities(items)
    item_type = items.map(&:chars).reduce(&:&)[0]

    if upper?(item_type)
      item_type.downcase.bytes[0] - 70
    else
      item_type.bytes[0] - 96
    end
  end

  def upper?(value)
    value == value.upcase
  end
end
