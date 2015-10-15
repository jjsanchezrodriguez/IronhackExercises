class SubtitleBlock
  attr_accessor :id, :time, :text
  def initialize(id, start_time, end_time, text)
    @id = id
    @time = {start: start_time, end: end_time}
    @text = text
  end
end

