require_relative 'dice.rb' , 'player.rb' , 'enemy.rb'
# require_relative 'player.rb'
# require_relative 'enemy.rb'

# put in arrays
encounter1 = [
    goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6}, 
    bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6}, 
    kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4}, 
    skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6}
]

# establish stats
player = Player.new(100)

encounter = Enemy1.new(encounter1)
puts encounter