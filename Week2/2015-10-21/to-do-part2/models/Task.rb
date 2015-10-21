class Task
  attr_reader :content, :id, :complete, :created_at, :updated_at
  @@curent_id = 1
  def initialize(content)
    @content = content
    @id = @@curent_id
    @@curent_id += 1
    @complete = false
    @created_at = Time.now
    @updated_at = Time.now
  end

  def complete!
    @complete = true
  end

  def completed?
    @complete
  end

  def make_incomplete!
    @complete = false
  end

  def update_content!(new)
    @content = new
  end
end
