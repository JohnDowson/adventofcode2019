def get_layers(wsize, hsize)
  IO.read('./input.txt').split('').map(&:to_i).each_slice(wsize).each_slice(hsize).map(&:flatten)
end
pp 'Star 1'
# [1] because there's a loose 0 at the end of input for some reason
get_layers(25, 6).sort { |a, b| a.count(0) <=> b.count(0) }[1].then { |l| p l.count(1) * l.count(2) }

pp 'Star 2'
get_layers(25, 6).reject { |el| el.count == 1 }.transpose.map do |pixel|
  case pixel.reject { |l| l == 2 }.first
  when 0
    ' '
  when 1
    '#'
  end
end.each_slice(25).map(&:join).each { |line| p line }
