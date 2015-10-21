require 'rspec'
require './PasswordChecker'

RSpec.describe "Password Checker" do

  before :each do
    @check = PasswordChecker.new
  end
  it "password must be longer than 7 chars" do
    expect(@check.check_password("info@ironhack.com", "pass")).to eq(false)
  end

  it "password must contain 1 letter, 1 number and 1  symbol" do
    expect(@check.check_password("info@ironhack.com", "blabla")).to eq(false)
    expect(@check.check_password("info@ironhack.com", "Pass1wor$")).to eq(true)
  end

  it "password must contain 1 uppercase and 1 lowercase letter" do
    expect(@check.check_password("info@ironhack.com", "pass1wor$")).to eq(false)
    expect(@check.check_password("info@ironhack.com", "Pass1wor$")).to eq(true)
  end

  it "password cant contain name or domain of the email" do 
    expect(@check.check_password("info@ironhack.com", "Pass1word&info")).to eq(false)
    expect(@check.check_password("info@ironhack.com", "Pass1word&ironhack")).to eq(false)
    expect(@check.check_password("info@ironhack.com", "infoPass1word&ironhack")).to eq(false)
  end

end
