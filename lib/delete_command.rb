# frozen_string_literal: true
require_relative 'command'

class DeleteCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, id = @command.split(/ /, 2)
    begin
      tasks.delete_task_by_id(id)
    rescue
      io.write("Could not find a task with an ID of #{id}.\n")
    end

  end
end