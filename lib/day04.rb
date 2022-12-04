require "set"

class Day04
  def part1(inputs)
    sections(inputs).count do |elves|
      elf1, elf2 = elves
      (contains?(elf1, elf2) || contains?(elf2, elf1))
    end
  end

  def example_part1
    2
  end

  def part2(inputs)
    sections(inputs).count do |section|
      elf1, elf2 = section.map do |elf|
        (elf[0]..elf[1]).to_a
      end

      !(elf1 & elf2).empty?
    end
  end

  def example_part2
    4
  end

  private

  def sections(inputs)
    inputs.split("\n").map do |line|
      line.split(",").map do |elf_ranges|
        start, finish = elf_ranges.split("-").map(&:to_i)
        [start, finish]
      end
    end
  end

  def contains?(a, b)
    a[0] >= b[0] && a[1] <= b[1]
  end
end
