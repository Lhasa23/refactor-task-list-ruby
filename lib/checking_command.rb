# frozen_string_literal: true
require_relative 'command'

class CheckingCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, id = @command.split(/ /, 2)
    begin
      task = tasks.find_task_by_id(id)
    rescue
      io.write("Could not find a task with an ID of #{id}.\n")
    end
    if command == 'check'
      task.check!
    else
      task.uncheck!
    end
  end
end