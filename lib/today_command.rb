# frozen_string_literal: true
require_relative 'command'

class TodayCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    task = tasks.find_task_by_date
    output = ''
    task.each { |item| output += "#{item.task_item_string}\n" }
    io.write(output)
  end
end