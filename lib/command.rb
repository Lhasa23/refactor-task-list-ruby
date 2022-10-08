# frozen_string_literal: true
class Command
  HELP = [
    'Commands:',
    '  show',
    '  add project <project name>',
    '  add task <project name> <task description>',
    '  check <task ID>',
    '  uncheck <task ID>'
  ]

  def initialize(command)
    @command = command
  end

  def run
  end
end
