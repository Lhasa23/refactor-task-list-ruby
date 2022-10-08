# frozen_string_literal: true
require_relative 'command'

class DeadlineCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, id, date = @command.split(/ /, 3)
    begin
      task = tasks.find_task_by_id(id)
    rescue
      io.write("Could not find a task with an ID of #{id}.\n")
    end

    if date.nil?
      io.write("Cannot recognize exact date.")
    end

    task.deadline!(date)
    io.write("[#{task.status}] #{task.id}: #{task.description} #{task.deadline}")

  end
end