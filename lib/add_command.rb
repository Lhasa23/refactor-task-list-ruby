# frozen_string_literal: true
require_relative 'command'

class AddCommand < Command
  def initialize(command)
    super
  end

  def run(tasks, io)
    command, subcommand, project_name, description = @command.split(/ /, 4)
    if subcommand == 'project'
      tasks.add_project!(project_name)
      return
    end

    begin
      tasks.add_project_task!(project_name, description)
    rescue
      io.write("Could not find a project with the name \"#{project_name}\".\n")
    end
  end
end
