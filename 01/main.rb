example = File.read("example.txt")
inputs = File.read("input.txt")

def part1(inputs)
  calorie_sums(inputs).max
end

def part2(inputs)
  calorie_sums(inputs).sort.reverse!.take(3).reduce(&:+)
end

def calorie_sums(inputs)
  inputs.split("\n\n").map do |elf_calories|
    elf_calories.split("\n").map(&:to_i).reduce(&:+)
  end
end
