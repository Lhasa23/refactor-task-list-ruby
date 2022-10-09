# frozen_string_literal: true
require_relative 'add_command'
require_relative 'none_command'
require_relative 'checking_command'
require_relative 'show_command'
require_relative 'today_command'
require_relative 'help_command'
require_relative 'deadline_command'

class CommandFactory
  def initialize(io, tasks)
    @io = io
    @tasks = tasks
  end

  def listen
    while true
      @io.prompt

      terminal = create(@io.read)
      break unless terminal

      terminal.run(@tasks, @io)
    end
  end

  private

  def create(input)
    command = input.split(/ /).first

    return false if command == 'quit'

    if command.nil?
      return NoneCommand.new('')
    end

    if command.include? 'check'
      return CheckingCommand.new(input)
    end

    case command
    when 'show'
      return ShowCommand.new(input)
    when 'today'
      return TodayCommand.new(input)
    when 'add'
      return AddCommand.new(input)
    when 'help'
      return HelpCommand.new(input)
    when 'deadline'
      return DeadlineCommand.new(input)
    else
      return NoneCommand.new(input)
    end
  end

end
