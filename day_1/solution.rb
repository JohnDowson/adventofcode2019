def find_fuel_requirement(mass)
  r = mass/3-2
  if r <= 0
    return 0
  else
    return r+find_fuel_requirement(r)
  end
end
print IO
        .read('./input.txt')
        .split
        .map(&:to_i)
        .map { |m| find_fuel_requirement(m) }
        .reduce(:+)
