# frozen_string_literal: true
require_relative 'command'

class AmendCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, subcommand, id, new_msg = @command.split(/ /, 4)
    if subcommand == 'id'
      return io.write("Can't use special characters!") if new_msg.match?(/\W/)

      task = tasks.find_task_by_id(id)

      usable = tasks.find_task_by_id(new_msg).nil?
      return io.write("Can't use exist id!") unless usable

      task.amend_id!(new_msg)
      io.write(task.task_item_string)
      return
    end
    io.write("I don't know what the option \"#{subcommand}\" is.")
  end
end
