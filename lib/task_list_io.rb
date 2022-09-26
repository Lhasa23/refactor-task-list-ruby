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

  def print(message)
    return if message.empty?
    @output.puts message
    @output.puts
  end
end