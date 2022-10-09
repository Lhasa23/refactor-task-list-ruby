# frozen_string_literal: true
require_relative 'tasks'
require_relative 'task_list_io'
require_relative 'factory'

class TaskList
  QUIT = 'quit'

  def initialize(input = $stdin, output = $stdout)
    @terminal = CommandFactory.new(TaskListIO.new(input: input, output: output), Tasks.new)
  end

  def run
    @terminal.listen
  end
end

if __FILE__ == $0
  TaskList.new.run
end
