# frozen_string_literal: true
require_relative 'task'

class Tasks
  def initialize
    @tasks = {}
  end

  def show
    show_arr = []
    @tasks.each do |project_name, project_tasks|
      show_arr << project_tasks.reduce([project_name]) { |result, task| result << "  [#{task.status}] #{task.id}: #{task.description}" }.join("\n")
    end
    show_arr.join("\n\n")
  end

  def add_project(name)
    @tasks[name] = []
  end

  def add_project_task(project_name, description)
    project_tasks = @tasks[project_name]
    if project_tasks.nil?
      raise 'Project tasks not existed'
    end
    @tasks[project_name] << Task.new(next_id, description, false)
  end

  def find_task_by_id(id_string)
    id = id_string.to_i
    task = @tasks.collect { |project_name, project_tasks|
      project_tasks.find { |t| t.id == id }
    }.reject(&:nil?).first

    if task.nil?
      @output.printf("Could not find a task with an ID of %d.\n", id)
      return
    end

    task
  end

  private

  def next_id
    @last_id ||= 0
    @last_id += 1
  end
end
