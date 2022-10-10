# frozen_string_literal: true
require_relative 'command'

class AmendCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, subcommand, id, new_msg = @command.split(/ /, 4)
    if subcommand == 'id'
      if new_msg.match?(/\W/)
        io.write("Can't use special characters!")
        return
      end

      task = tasks.find_task_by_id(id)

      usable = tasks.find_task_by_id(new_msg).nil?
      if usable
        task.amend_id(new_msg)
        io.write("[#{task.status}] #{task.id}: #{task.description}")
      else
        io.write("Can't use exist id!")
      end
      return
    end
  end
end
