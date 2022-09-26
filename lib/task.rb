# frozen_string_literal: true

class Task
  attr_reader :id, :description
  attr_accessor :done

  def initialize(id, description, done)
    @id = id
    @description = description
    @done = done
  end

  def status
    done ? 'x' : ' '
  end

  def check!
    @done = true
  end

  def uncheck!
    @done = false
  end
end
