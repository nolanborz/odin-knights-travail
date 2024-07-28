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
    if x < 0 || y < 0 || x >= 8 || y >= 8
      false
    else
      true
    end
  end

  def possible_moves
    moves = []
    original_position = @position.dup

    [:move_up_right, :move_up_left, :move_right_up, :move_right_down, :move_down_right, :move_down_left, :move_left_down, :move_left_up].each do |move|
      send(move)
      moves << @position.dup
      @position = original_position.dup
     end
     moves.select {|pos| valid_pos?(pos[0], pos[1])}
  end
end

horse = Knight.new(0, 0)
horse.print_position
end_positions = horse.possible_moves
puts end_positions.inspect
