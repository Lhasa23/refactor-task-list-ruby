# frozen_string_literal: true
require_relative 'command'

class ShowCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write tasks.show
  end
end