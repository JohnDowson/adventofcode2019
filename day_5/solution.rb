class IntcodeComputer
  @@executors {
    add: ->(argx, argy, stat, prog) { prog[stat] = argx+argy }
  }
  @@opcodes = {
    1 => :add,
    2 => :mul,
    3 => :inp,
    4 => :out,
    99 => :hlt
  }
  @@modes = {
    0 => :pos,
    1 => :imm
  }
  def self.parse_instruction(instruction)
    pp instruction
    opcode = instruction.digits.first(2)
    opcode = (instruction + 100).digits.first(2) if opcode == 0
    modes = instruction.digits[2..].map { |d| @@modes[d] }
    modes = [:pos, :pos, :pos] if modes.nil?
    while modes.count < 3
      modes << :pos
    end
    opcode = @@opcodes[opcode.reverse.join.to_i]
    { opcd: opcode, mode: modes }
  end
end

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
    instruction = IntcodeComputer.parse_instruction(prog[pointer])
    opcd = instruction[:opcd]
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

