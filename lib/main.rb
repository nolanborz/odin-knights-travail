
class Knight

  attr_reader :position
  def initialize(x, y)
    @position = [x, y]
  end
  
  def valid_pos?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end

  def move_to(new_position)
    old_position = @position
    @position = new_position
    yield
    @position = old_position
  end

  def set_position(new_position)
    @position = new_position 
  end

  def possible_moves
    moves = []
    [-2, -1, 1, 2].permutation(2).each do |dx, dy|
      next if dx.abs == dy.abs
      new_x, new_y = @position[0] + dx, @position[1] + dy
      moves << [new_x, new_y] if valid_pos?(new_x, new_y)
    end
    moves
  end
end
class ChessPathFinder
  def initialize(knight)
    @knight = knight
  end
  def find_shortest_path(start, target)
    @knight.set_position(start)
    if start == target
      return [start]
    else
      return bidirectional_search(start, target)
    end
  end

  private

  def bidirectional_search(start, target)
    start_queue = [SearchNode.new(start)]
    target_queue = [SearchNode.new(target)]
    start_visited = {start => start_queue.first}
    target_visited = {target => target_queue.first}
  
    until start_queue.empty? || target_queue.empty?
      puts "Start queue: #{start_queue.map(&:position)}"
      puts "Target queue: #{target_queue.map(&:position)}"
  
      if meeting_point = expand_frontier(start_queue, start_visited, target_visited)
        return reconstruct_path(meeting_point, start_visited, target_visited)
      end
  
      if meeting_point = expand_frontier(target_queue, target_visited, start_visited)
        return reconstruct_path(meeting_point, start_visited, target_visited)
      end
    end
  
    nil  # No path found
  end

  def expand_frontier(queue, own_visited, other_visited)
    current = queue.shift
    puts "Expanding from: #{current.position} (depth: #{current.depth})"
    @knight.set_position(current.position)
    @knight.possible_moves.each do |new_pos|
      puts "  Considering move to: #{new_pos}"
      next if own_visited.key?(new_pos)
      new_node = SearchNode.new(new_pos, current)
      own_visited[new_pos] = new_node
      queue << new_node

      if other_visited.key?(new_pos)
        puts "  Found meeting point at: #{new_pos}"
        debug_path(new_node, other_visited[new_pos])
        return new_node
      end
    end
    nil
  end

  def debug_path(node1, node2)
    path1 = reconstruct_single_path(node1)
    path2 = reconstruct_single_path(node2)
    puts "  Path from start: #{path1.inspect}"
    puts "  Path from target: #{path2.reverse.inspect}"
  end
  def reconstruct_path(meeting_point, start_visited, target_visited)
    # Path from start to meeting point
    start_path = reconstruct_single_path(start_visited[meeting_point.position])

    # Path from target to meeting point
    target_path = reconstruct_single_path(target_visited[meeting_point.position])

    # Combine paths, removing duplicate meeting point
    full_path = start_path + target_path.reverse[1..-1]
    puts "Reconstructed path: #{full_path.inspect}"
    full_path
  end
  def reconstruct_single_path(node)
    path = []
    current = node
    while current
      path.unshift(current.position)
      current = current.parent
    end
    path
  end
end
class SearchNode
  attr_reader :position, :parent, :depth

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @depth = parent ? parent.depth + 1 : 0
  end
  def to_s
    "Node(pos: #{@position}, depth: #{depth})"
  end

  def path
    node = self
    path = []
    while node
      path.unshift(node.position)
      node = node.parent
    end
    path
  end
end

knight = Knight.new(0, 0)
pathfinder = ChessPathFinder.new(knight)
shortest_path = pathfinder.find_shortest_path([3, 3], [6, 0])
puts "Shortest path: #{shortest_path.inspect}"

