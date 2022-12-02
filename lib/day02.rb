class Day02
  MOVE_MAP = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }

  RESULT_MAP = {
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win
  }

  def part1(inputs)
    rounds = parse_inputs(inputs).map do |opponent_move_code, my_move_code|
      [MOVE_MAP[my_move_code], MOVE_MAP[opponent_move_code]]
    end

    Game.play_all(rounds).map(&:score).sum
  end

  def part2(inputs)
    rounds = parse_inputs(inputs).map do |opponent_move_code, game_result|
      opponent_move = MOVE_MAP[opponent_move_code]

      my_move =
        case RESULT_MAP[game_result]
        when :win
          Game::WINNING_MOVES.key(opponent_move)
        when :lose
          Game::WINNING_MOVES[opponent_move]
        when :draw
          opponent_move
        end

      [my_move, opponent_move]
    end

    Game.play_all(rounds).map(&:score).sum
  end

  def parse_inputs(inputs)
    inputs.split("\n").map do |round|
      round.split(" ")
    end
  end
end

class Game
  GameResult = Struct.new(:result, :score)

  WINNING_MOVES = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }

  MOVE_POINTS = {
    rock: 1,
    paper: 2,
    scissors: 3
  }

  class << self
    def play_all(rounds)
      rounds.map { |my_move, opponent_move| play(my_move, opponent_move) }
    end

    def play(my_move, opponent_move)
      if (my_move == opponent_move)
        draw(my_move)
      elsif WINNING_MOVES[my_move] == opponent_move
        won(my_move)
      else
        lost(my_move)
      end
    end

    def won(move)
      GameResult.new(:won, MOVE_POINTS[move] + 6)
    end

    def lost(move)
      GameResult.new(:lost, MOVE_POINTS[move])
    end

    def draw(move)
      GameResult.new(:draw, MOVE_POINTS[move] + 3)
    end
  end
end
