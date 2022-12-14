# frozen_string_literal: true
class Command
  HELP = [
    'Commands:',
    '  view [by] <option>',
    '    option: project (default mode)',
    '    option: deadline',
    '  add project <project name>',
    '  add task <project name> <task description>',
    '  check <task ID>',
    '  uncheck <task ID>',
    '  deadline <task ID> <date>',
    '  today',
    '  amend <option> <task ID> <new task ID>',
    '    option: id',
  ]

  def initialize(command)
    @command = command
  end

  def run
  end
end
