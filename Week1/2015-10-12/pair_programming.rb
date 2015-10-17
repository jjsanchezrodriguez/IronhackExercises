require "pry"

class FlashCard
  attr_accessor :question, :answer

  def initialize(question, answer)
  @question = question
    @answer = answer
  end

  def question_and_answer(index = nil)
      if @answer == ""
          return
      end         
      puts " #{index} #{@question}"
      input = ''
      while input != @answer
          input = gets.chomp
      end
      puts @answer
  end
end

def display_cards(cards)
    cards.each_with_index do |card, index|
        card.question_and_answer(index)
    end
end

card0 = FlashCard.new("What does the array.each method do", "Iterates through each element in the array and performs an operation on them")
card01 = FlashCard.new("How much wood could a wood chuck chuck if a wood chuck could chuck wood", "42")
card1 = FlashCard.new("What does the array.each_with_index method do", "Iterates through each element in the array and keeps track of index of the current element")
card2 = FlashCard.new("What does the array.map method do", "Returns an array with operation performed on the original array")
card5 = FlashCard.new("What does the array.select method do", "Returns an array that is a subset of the original array based on the computation in the block.")
card02 = FlashCard.new("What is my favorite food", "Whiskey")
card3 = FlashCard.new("What does the array.reduce method do", "Shortens the array into a single copmuted value")
card03 = FlashCard.new("Why is the sky blue", "Because, science.")

card_list = [card0, card01, card1, card02, card2, card3, card03, card5]


card_list.map do | card |
  card.question += "?"
end

new_card_list = card_list.select { |card| card.question.include?("array") }
new_card_list = new_card_list.shuffle

# card0.question_and_answer(0)

display_cards(new_card_list)





