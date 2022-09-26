# frozen_string_literal: true
require_relative 'tasks'
require_relative 'task_list_io'

class TaskList
  QUIT = 'quit'
  HELP = [
    'Commands:',
    '  show',
    '  add project <project name>',
    '  add task <project name> <task description>',
    '  check <task ID>',
    '  uncheck <task ID>'
  ]

  def initialize(input = $stdin, output = $stdout)
    @io = TaskListIO.new(input: input, output: output)
    @tasks = Tasks.new
  end

  def run
    while true
      @io.init

      command = @io.read
      break if command == QUIT

      execute(command)
    end
  end

  private

  def execute(command_line)
    command, args = command_line.split(/ /, 2)
    case command
    when 'show'
      show
    when 'add'
      add args
    when 'check'
      check(args)
    when 'uncheck'
      uncheck(args)
    when 'help'
      help
    else
      error command
    end
  end

  def uncheck(args)
    @tasks.find_task_by_id(args).uncheck!
  end

  def check(args)
    @tasks.find_task_by_id(args).check!
  end

  def show
    @tasks.show(&method(:show_project_task))
  end

  def show_project_task(project_name, project_tasks)
    @io.print project_tasks.reduce([project_name]) { |result, task| result << "  [#{task.status}] #{task.id}: #{task.description}" }.join("\n")
  end

  def add(command_line)
    subcommand, rest = command_line.split(/ /, 2)
    if subcommand == 'project'
      @tasks.add_project(rest)
    elsif subcommand == 'task'
      project_name, description = rest.split(/ /, 2)
      begin
        @tasks.add_project_task(project_name, description)
      rescue
        @io.print("Could not find a project with the name \"#{project_name}\".\n")
      end
    end
  end

  def help
    @io.print HELP.join("\n")
  end

  def error(command)
    @io.print("I don't know what the command \"#{command}\" is.\n")
  end
end

if __FILE__ == $0
  TaskList.new.run
end
