require "tty-prompt"
prompt = TTY::Prompt.new(active_color: :magenta, symbols: {marker: "⬢"})
require 'colorize'
require_relative '../dice.rb'
require_relative '../player.rb'
require_relative '../enemy.rb'
require_relative '../combat.rb'

D4 = [1..4]
D6 = [1..6]
D8 = [1..8]
D10 = [1..10]
D12 = [1..12]
D100 = [1..100]
D20 = [1..20]

describe "roll dice" do
    it 'rolls a value within a specified threshold' do
        expect (Dice.roll(D20)).to eq(1..20)

        # expect {Dice.roll(D20)}.to eq(true)
    end
end