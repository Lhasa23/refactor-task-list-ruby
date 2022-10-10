# frozen_string_literal: true
require 'date'

class Task
  attr_reader :id, :description, :task_item_string
  attr_accessor :done

  def initialize(id, description, done)
    @id = id
    @description = description
    @done = done
    @deadline = Date.new(9999, 1, 1)
  end

  def deadline
    @deadline.strftime("%Y-%m-%d")
  end

  def check!
    @done = true
  end

  def uncheck!
    @done = false
  end

  def deadline!(date)
    @deadline = Date.parse(date)
  end

  def amend_id!(new_id)
    @id = new_id
  end

  def task_item_string
    "[#{status}] #{@id}: #{@description}"
  end

  private

  def status
    done ? 'x' : ' '
  end
end
