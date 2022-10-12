# frozen_string_literal: true
require_relative 'command'

class ViewCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, by, method = @command.split(/ /, 3)

    if method.nil? || method == 'project'
      io.write tasks.show
      return
    end

    if method == 'deadline'
      io.write tasks.show_by_deadline
    end
  end
end