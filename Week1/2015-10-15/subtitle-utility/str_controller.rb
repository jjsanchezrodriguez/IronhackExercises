require 'date'

class STRController
  TO_S = 86400
  def initialize(operator, shift, subtitles)
    @operator = operator
    @shift = shift
    @subtitles = subtitles
  end

  def convert_to_date_obj
    @subtitles.each do |sub|
      start = sub.time[:start]
      endtime = sub.time[:end]

      sub.time[:start] = DateTime.parse(start)
      sub.time[:end] = DateTime.parse(endtime)

    end
  end

  def convert_date_obj_to_s
    @subtitles.each do |sub|
      start = sub.time[:start]
      endtime = sub.time[:end]

      sub.time[:start] = start.strftime("%H:%M:%S,%L")
      sub.time[:end] = endtime.strftime("%H:%M:%S,%L")

      sub.time = "#{sub.time[:start]} --> #{sub.time[:end]}"
    end
  end

  def shift
    @subtitles.each do |sub|

      if @operator == "+"
        sub.time[:start] += (@shift / TO_S.to_f)
        sub.time[:end] += (@shift / TO_S.to_f)
      else
        sub.time[:start] -= (@shift / TO_S.to_f)
        sub.time[:end] -= (@shift / TO_S.to_f)
      end

    end
  end

  def censor
    # add censor function
  end

  def typos?
    # add typo function
  end

end
