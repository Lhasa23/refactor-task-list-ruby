# frozen_string_literal: true
require_relative 'task'

class Tasks
  def initialize
    @tasks = {}
    @task_set = []
  end

  def show(tasks = @tasks)
    show_arr = []
    tasks.each do |sub_name, sub_tasks|
      show_arr << sub_tasks.reduce([sub_name]) { |result, task| result << "  #{task.task_item_string}" }.join("\n")
    end
    show_arr.join("\n\n")
  end

  def show_by_deadline
    new_tasks_group = {}
    @task_set.sort { |a, b| a.deadline <=> b.deadline }.each do |task|
      new_tasks_group[task.deadline] = (new_tasks_group[task.deadline] || []) << task
    end

    show(new_tasks_group)
  end

  def add_project!(name)
    @tasks[name] = []
  end

  def add_task!(project_name, description)
    project_tasks = @tasks[project_name]
    if project_tasks.nil?
      raise 'Project tasks not existed'
    end

    task = Task.new(next_id, description, false, project_name)
    @tasks[project_name] << task
    @task_set << task
  end

  def find_task_by_id(id_string)
    id = id_string.to_i
    @task_set.select { |v| v.id == id }.first
  end

  def find_task_by_date(date = Date.today.strftime("%Y-%m-%d"))
    @task_set.select { |t| t.deadline == date }
  end

  def delete_task_by_id(id_string)
    task = find_task_by_id(id_string)
    @tasks[task.project].delete task
    @task_set.delete task
  end

  private

  def next_id
    @last_id ||= 0
    @last_id += 1
  end
end
