class TaskListIO
  def initialize(io)
    @input = io[:input]
    @output = io[:output]
  end

  def init
    @output.print('> ')
    @output.flush
  end

  def read
    @input.readline.strip
  end

  def print(message = '')
    @output.puts message
    @output.puts
  end
end