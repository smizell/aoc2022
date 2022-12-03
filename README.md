# Advent of Code 2022

Ruby code for solving Advent of Code puzzles. Let's see how I far I get this year.

## Install

```sh
bundle
```

## Set up a day

```sh
bin/cli next_day <day-number>
```

## Writing the code

Put code in `lib/day<day-number>.rb` after using the next command above.

```ruby
class Day02
  def part1
    # return result
  end

  def part2
    # return result
  end
end
```

Use `#example_part1` and `#example_part2` methods to provide the expected example values.

### Check examples

Put example values in `inputes/day<day-num>/example.txt`.

```sh
bin/cli example <day> <part>
```

### Check solution

Put example values in `inputes/day<day-num>/input.txt`.

```sh
bin/cli solve <day> <part>
```
