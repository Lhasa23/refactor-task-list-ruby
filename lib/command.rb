# frozen_string_literal: true

def command_factory(input)
  command = input.split(/ /).first
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
  else
    return NoneCommand.new(input)
  end
end

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

class AddCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, subcommand, project_name, description = @command.split(/ /, 4)
    if subcommand == 'project'
      tasks.add_project(project_name)
      return
    end

    begin
      tasks.add_project_task(project_name, description)
    rescue
      io.write("Could not find a project with the name \"#{project_name}\".\n")
    end
  end
end

class ShowCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write tasks.show
  end
end

class NoneCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write("I don't know what the command \"#{@command}\" is.\n")
  end
end

class CheckingCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, args = @command.split(/ /, 2)
    begin
      task = tasks.find_task_by_id(args)
    rescue
      io.printf("Could not find a task with an ID of #{id}.\n")
    end
    if command == 'check'
      task.check!
    else
      task.uncheck!
    end
  end
end

class HelpCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    io.write Command::HELP.join("\n")
  end
end
