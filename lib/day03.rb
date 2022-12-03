require "set"

class Day03
  def part1(inputs)
    rucksacks = inputs.split("\n").map do |line|
      [line[0, line.size / 2], line[line.size / 2..]]
    end

    priorities = rucksacks.map do |compartment1, compartment2|
      compartment1_set = compartment1.chars.to_set
      compartment2_set = compartment2.chars.to_set
      item_type = compartment1_set.intersection(compartment2_set).to_a[0]

      if upper?(item_type)
        item_type.downcase.bytes[0] - 70
      else
        item_type.bytes[0] - 96
      end
    end

    priorities.sum
  end

  def example_part1
    157
  end

  def upper?(value)
    value == value.upcase
  end

  def part2
  end
end
