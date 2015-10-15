class FileHandler
  def initialize(file)
    @file = file
  end

  def read
    @file.readlines.each do |line|
      line.chomp!
    end
  end

  def write(controller)
    file_str = ""
    controller.each do |sub|
      file_str += "#{sub.id}\n#{sub.time}\n#{sub.text}\n"
    end
    IO.write(@file.path, file_str)
  end
end
