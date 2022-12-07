class Day06
  def part1(inputs)
    marker_appears_after(inputs.strip)
  end

  def example_part1
    7
  end

  def part2(inputs)
    marker_appears_after(inputs.strip, packet_count: 14)
  end

  def example_part2
    19
  end

  private

  def marker_appears_after(line, packet_count: 4)
    chars = line.chars
    index = 0

    until chars.empty?
      check = chars.take(packet_count)
      return index + packet_count if check.uniq.count == packet_count
      chars.shift
      index += 1
    end
  end
end
