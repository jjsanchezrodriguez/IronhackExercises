require 'pry'

class Calculator

  attr_reader :operators


  def initialize(num1, num2, operation)
    @num1 = num1.to_f
    @num2 = num2.to_f
    @operation = operation
    @operators = {
      "addition" => :+,
      "subtraction" => :-,
      "multiplication" => :*,
      "division" => :/
    }
  end

  def calculate
    @num1.send(@operators[@operation], @num2)
  end
end
