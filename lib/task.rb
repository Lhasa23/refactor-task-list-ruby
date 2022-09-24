# frozen_string_literal: true

class Task
  attr_reader :id, :description
  attr_accessor :done

  def initialize(id, description, done)
    @id = id
    @description = description
    @done = done
  end

  def done?
    done
  end

  def set_check!
    @done = true
  end

  def set_uncheck!
    @done = false
  end
end
