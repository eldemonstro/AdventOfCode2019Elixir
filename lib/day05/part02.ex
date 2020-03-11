Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

intcode = IntCode.parse_program(contents)

{:ok, first_op} = Map.fetch(intcode, 0)

inputs = [5]

IntCode.execute(intcode, first_op, 0, inputs)
