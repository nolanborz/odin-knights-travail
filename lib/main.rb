require_relative 'knight-moves'
class Knight
  include KnightMoves
  attr_reader :position
  def initialize(x, y)
    @position = [x, y]
  end
  def print_position
    puts @position
  end
  def fastest_route(x, y)
    puts "Generating the fastest route from #{@position} to [#{x}, #{y}]..."
    puts valid_pos?(x, y)
  end
  
  def valid_pos?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end

  def possible_moves
    moves = []
    original_position = @position.dup

    [:move_up_right, :move_up_left, :move_right_up, :move_right_down, :move_down_right, :move_down_left, :move_left_down, :move_left_up].filter_map do |move|
      send(move)
      new_pos = @position.dup
      @position = original_position.dup
      new_pos if valid_pos?(*new_pos)
    end
  end
end
class ChessPathFinder
  def find_shortest_path(start, target, movement_rules)
  end

  private

  def knight_moves
    [
      [1, 2], [2, 1], [2, -1], [1, -2],
      [-1, -2], [-2, -1], [-2, 1], [-1, 2]
    ]
  end

knight = Knight.new(0, 0)
path_finder = ChessPathFinder.new
shortest_path = path_finder.find_shortest_path(knight.position, [3, 3], method(:knight_moves))
