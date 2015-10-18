require 'date'

class STRController
  TO_S = 86400
  def initialize(operator, shift, subtitles)
    @operator = operator
    @shift = shift
    @subtitles = subtitles
    @typos = {}
    @profanity = nil
    @censored = []
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

  def censor!
    profanity = ['fuck', 'dick']

    @subtitles.each do |sub|
      text = sub.text.split(" ")

      text.each do |word|

        profanity.each do |pword|
          if word.match(pword).nil? == false
            text[text.index(word)] = "CENSORED"
            text = text.join(' ')
          end
        end

      end
      cblock = SubtitleBlock.new(sub.id, sub.time[:start], sub.time[:end], text )
      @censored << cblock
    end

    str = ""
    @censored.each do |sub|
      str += "#{sub.id}\n"
      str += "#{sub.time[:start].strftime("%H:%M:%S,%L")} --> #{sub.time[:end].strftime("%H:%M:%S,%L")}\n"
      str += "#{sub.text}\n\n"
    end
    IO.write("profanity.txt", str)
  end

  def check_for_typos 
    dictionary = File.open("/usr/share/dict/words", "r").read.split("\n")
    @subtitles.each do |subtitle|
      text = subtitle.text.split(" ")
      typos = text - dictionary 
      typos.each do |typo|
        @typos[typo] = subtitle.time[:start].strftime("%H:%M:%S,%L")
      end
    end

    str = ""
    @typos.each do |k, v|
      str += "#{k}: #{@typos[k]}\n"
    end

    IO.write("typos.txt", str)
  end

end
