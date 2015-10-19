require 'pry'
class Lexiconomitron
  def eat_t(input)
    regex = /t|T/
    if !input.match(regex).nil?
      input.gsub!(regex, "")
    else
       input
    end
  end

  def shazam(input)
    words = input.split(" ").map do |word|
      word.reverse
    end
    "#{eat_t(words.first)} #{eat_t(words.last)}"
  end

  def oompa_loompa(input)
    words = input.split(" ").select do |word|
      if word.length <= 3
        eat_t(word)
      end
    end
    words.join(' ')
  end
end
