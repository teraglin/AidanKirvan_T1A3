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

encounter_table_1 = [
    goblin = {name: 'GOBLIN',:health=>8, :armour=>8, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    bullywug = {name: 'BULLYWUG',:health=>8, :armour=>8, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    kobald = {name: 'KOBALD',:health=>8, :armour=>8, :damage=>D4, :special_name=>"multi", :special_cool=>5}, 
    skeleton = {name: 'SKELETON',:health=>10, :armour=>10, :damage=>D6, :special_name=>"multi", :special_cool=>5}
]

enemy_roll_1 = encounter_table_1[rand(encounter_table_1.length)]
monster = Enemy.new(enemy_roll_1, prompt)


describe "pull monster" do
    it 'generates monster' do
        expected_output = 1..6

        expect (Dice.roll(monster.damage)).to output(expected_output).to_stdout
    end
end