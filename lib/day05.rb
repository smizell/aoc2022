class Day05
  def part1(inputs)
    stacks, procedures = parse_inputs(inputs)
    move_crates(stacks, procedures)
    top_crates(stacks)
  end

  def example_part1
    "CMZ"
  end

  def part2(inputs)
    stacks, procedures = parse_inputs(inputs)
    move_crates(stacks, procedures, model: "9001")
    top_crates(stacks)
  end

  def example_part2
    "MCD"
  end

  private

  def parse_inputs(inputs)
    stack_inputs, procedure_inputs = inputs.split("\n\n")
    [parse_stack_inputs(stack_inputs), parse_procedure_inputs(procedure_inputs)]
  end

  def top_crates(stacks)
    stacks.map(&:first).join
  end

  def move_crates(stacks, procedures, model: "9000")
    procedures.each do |num_of_crates, from_col, to_col|
      to_move = stacks[from_col].shift(num_of_crates)
      picked_crates = (model == "9000") ? to_move.reverse : to_move
      stacks[to_col].unshift(*picked_crates)
    end
  end

  def parse_stack_inputs(inputs)
    (rows = inputs.split("\n")).pop

    stacks = []

    rows.map(&:chars).map do |row|
      stacks << (stack = [])

      until row.empty?
        crate = row.shift(3)[1]
        stack << ((crate == " ") ? nil : crate)

        # Remove the padding between columns
        row.shift if row.count > 3
      end
    end

    stacks.transpose.map(&:compact)
  end

  def parse_procedure_inputs(inputs)
    inputs.split("\n").map do |move_inputs|
      move = move_inputs.split(" ").map(&:to_i)

      # We subtract to move to zero-based indexes
      [move[1], move[3] - 1, move[5] - 1]
    end
  end
end
