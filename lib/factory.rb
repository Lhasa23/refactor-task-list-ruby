# frozen_string_literal: true
require_relative 'add_command'
require_relative 'none_command'
require_relative 'checking_command'
require_relative 'show_command'
require_relative 'help_command'
require_relative 'deadline_command'

def command_factory(input)
  command = input.split(/ /).first
  if command.nil?
    return NoneCommand.new('')
  end

  if command.include? 'check'
    return CheckingCommand.new(input)
  end

  case command
  when 'show'
    return ShowCommand.new(input)
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

