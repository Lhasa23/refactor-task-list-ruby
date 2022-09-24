# frozen_string_literal: true
require_relative 'tasks'

class TaskList
  QUIT = 'quit'

  def initialize(input, output)
    @input = input
    @output = output

    @tasks = Tasks.new
  end

  def run
    while true
      @output.print('> ')
      @output.flush

      command = @input.readline.strip
      break if command == QUIT

      execute(command)
    end
  end

  private

  def execute(command_line)
    command, rest = command_line.split(/ /, 2)
    case command
    when 'show'
      show
    when 'add'
      add rest
    when 'check'
      @tasks.find_task_by_id(rest).set_check!
    when 'uncheck'
      @tasks.find_task_by_id(rest).set_uncheck!
    when 'help'
      help
    else
      error command
    end
  end

  def show
    @tasks.show(&method(:show_project_task))
  end

  def show_project_task(project_name, project_tasks)
    @output.puts project_name
    project_tasks.each do |task|
      @output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
    end
    @output.puts
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
        @output.printf("Could not find a project with the name \"%s\".\n", project_name)
        @output.puts
      end
    end
  end

  def help
    @output.puts('Commands:')
    @output.puts('  show')
    @output.puts('  add project <project name>')
    @output.puts('  add task <project name> <task description>')
    @output.puts('  check <task ID>')
    @output.puts('  uncheck <task ID>')
    @output.puts()
  end

  def error(command)
    @output.printf("I don't know what the command \"%s\" is.\n", command)
  end
end

if __FILE__ == $0
  TaskList.new($stdin, $stdout).run
end
