class Day01
  def part1(inputs)
    calorie_sums(inputs).max
  end

  def part2(inputs)
    calorie_sums(inputs).sort.reverse!.take(3).sum
  end

  def calorie_sums(inputs)
    inputs.split("\n\n").map do |elf_calories|
      elf_calories.split("\n").map(&:to_i).sum
    end
  end
end
