star1 = ARGV[0].split('-').map(&:to_i).then { |n| (n[0]..n[1]) }.to_a.map { |i| i.to_s.split('').map(&:to_i) }.reject { |n| n.each_cons(2).any? { |c| c[0] > c[1] } }.reject { |n| !n.each_cons(2).any? { |c| c[0] == c[1] }}
pp star1.map(&:join).map(&:to_i).count
star2 = star1.reject { |n| n.each_cons(3).any? { |c| c.uniq.count < 2 } }
pp star2.map(&:join).map(&:to_i).count
# pp star1
# pp star2
