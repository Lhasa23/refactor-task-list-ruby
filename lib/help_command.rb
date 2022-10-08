# frozen_string_literal: true
require_relative 'command'

class HelpCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write Command::HELP.join("\n")
  end
end