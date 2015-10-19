require 'rspec'
require './pp-lexiconomitron'

RSpec.describe "Lexiconomitron tests" do

  before :each do
    @lexi = Lexiconomitron.new
  end 

    it "removes every letter t from the input" do
      expect(@lexi.eat_t("great scott")).to eq("grea sco")
      expect(@lexi.eat_t("greaT scoTT")).to eq("grea sco")
    end

    it "shazam should reverse words and remove first and last" do
      expect(@lexi.shazam("This is a boring test")).to eq("sih se")
    end

    it "should take only words with length of 3 or less" do
      expect(@lexi.oompa_loompa("if you wanna be my lover")).to eq("if you be my")
      expect(@lexi.oompa_loompa("too")).to eq("oo")
    end

end
