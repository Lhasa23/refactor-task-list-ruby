class TaskListIO
  def initialize(io)
    @input = io[:input]
    @output = io[:output]
  end

  def prompt
    @output.write('> ')
    @output.flush
  end

  def read
    @input.readline.strip
  end

  def write(message)
    return if message.empty?
    @output.puts message
    @output.puts
  end
end