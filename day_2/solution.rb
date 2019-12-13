ADD      = 1
MULTIPLY = 2
HALT     = 99
def prepare(prog, *inputs)
  prog = prog.clone
  prog[1] = inputs[0]
  prog[2] = inputs[1]
  prog
end

def get_prog
  IO
   .read("./input.txt")
   .strip
   .split(',')
   .map(&:to_i)
end

def execute(prog)
  halt = false
  pointer = 0
  while pointer < prog.length && !halt
    opcd = prog[pointer]
    argx = prog[prog[pointer+1]]
    argy = prog[prog[pointer+2]]
    stat = prog[pointer+3]
    if opcd == HALT
      halt = true
    elsif opcd == ADD
      prog[stat] = argx+argy
    elsif opcd == MULTIPLY
      prog[stat] = argx*argy
    end
    pointer += 4
  end
  prog
end

def get_output(prog)
  prog[0]
end

def find_input(inputs, output, prog)
  inputs.each do |pair|
    if prepare(prog, *pair)
              .then { |p| execute(p) }
              .then { |p| get_output(p) } == output
      return pair
    end
  end
end

star1 = get_prog()
                .then { |p| prepare(p, 12, 2) }
                .then { |p| execute(p) }
                .then { |p| get_output(p) }

inputs = Array(0..100).permutation(2)
star2 = get_prog()
                .then { |p| find_input(inputs, 19690720, p) }
                .then { |pair| 100*pair[0]+pair[1] }

puts "star1: #{star1}", "star2: #{star2}"
