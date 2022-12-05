class Day04
  def part1(inputs)
    sections(inputs).count do |elf1, elf2|
      contains?(elf1, elf2)
    end
  end

  def example_part1
    2
  end

  def part2(inputs)
    sections(inputs).count do |elf1, elf2|
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
        (start..finish).to_a
      end
    end
  end

  def contains?(a, b)
    (a - b).empty? || (b - a).empty?
  end
end
