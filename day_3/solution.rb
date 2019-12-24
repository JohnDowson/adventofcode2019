require 'set'
class Point < Array
  def initialize(x, y)
    super [x, y]
  end
  def x
    self[0]
  end
  def y
    self[1]
  end
  def +(other)
    Point.new(x + other.x, y + other.y)
  end
  def -(other)
    Point.new(x - other.x, y - other.y)
  end
  def <=>(other)
    ((x-other.x).abs + (y-other.y).abs)
  end
  def to_s
    "Point #{x}, #{y}"
  end
end

def parse_node(string)
  {direction: string[0].to_sym, distance: string[1..].to_i}
end
def add_node_to_path(path, node)
  prev_node = path[-1]
  case node[:direction]
  when :L
    (prev_node.x-node[:distance]..prev_node.x).to_a.reverse.each do |x|
      path << Point.new(x, prev_node.y)
    end
  when :U
    (prev_node.y..prev_node.y+node[:distance]).to_a.each do |y|
      path << Point.new(prev_node.x, y)
    end
  when :R
    (prev_node.x..prev_node.x+node[:distance]).to_a.each do |x|
      path << Point.new(x, prev_node.y)
    end
  when :D
    (prev_node.y-node[:distance]..prev_node.y).to_a.reverse.each do |y|
      path << Point.new(prev_node.x, y)
    end
  end
end
def connect_points(n1, n2)
  path = []
  dx = (n1.x - n2.x).abs
  dy = (n1.y - n2.y).abs
  add = nil
  if dx != 0
    ()
    dx -= 1
  elsif dy != 0
    
    dy -= 1
  end
  path
end
def get_wires
  IO.read("./input.txt").split.map { |w| w.split(',') }
end

wires = get_wires.map { |w| w.map { |n| parse_node(n) } }
paths = []
wires.each do |w|
  paths.append([Point.new(0, 0)])
        w.each_with_object(paths.last) do |n, p|
             add_node_to_path(p, n)
  end
end
intersetctions = paths[0].to_set.intersection(paths[1].to_set)
distances = []
p0 = Point.new(0, 0)
intersetctions.each_with_object(distances){ |p, d| d << { dist: (p0 <=> p), point: p } }
distances.sort! { |a, b| a[:dist] <=> b[:dist] }
pp distances[1]
length = []
paths.each do |w|
  length << []
  i = 0
  for p in w do
    length.last << i+1 if intersetctions.include? p
    i += 1
  end
end
shortest = length[1].zip(length[0]).map(&:sum).sort[0..4]
pp shortest
