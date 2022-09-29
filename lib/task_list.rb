# frozen_string_literal: true
require_relative 'tasks'
require_relative 'task_list_io'
require_relative 'command'

class TaskList
  QUIT = 'quit'

  def initialize(input = $stdin, output = $stdout)
    @io = TaskListIO.new(input: input, output: output)
    @tasks = Tasks.new
  end

  def run
    while true
      @io.prompt

      command = @io.read
      break if command == QUIT

      execute(command)
    end
  end

  private

  def execute(command_line)
    command_factory(command_line).run(@tasks, @io)
  end
end

if __FILE__ == $0
  TaskList.new.run
end
