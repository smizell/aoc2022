class Day04
  def part1(inputs)
    sections(inputs).count(&method(:contains?))
  end

  def example_part1
    2
  end

  def part2(inputs)
    sections(inputs).count(&method(:overlaps?))
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

  def contains?(elves)
    elf1, elf2 = elves
    (elf1 - elf2).empty? || (elf2 - elf1).empty?
  end

  def overlaps?(elves)
    elf1, elf2 = elves
    !(elf1 & elf2).empty?
  end
end
