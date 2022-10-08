# frozen_string_literal: true
require_relative 'command'

class NoneCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write("I don't know what the command \"#{@command}\" is.\n")
  end
end

