require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
# dice array 
D4 = [1..4]
D6 = [1..6]
D8 = [1..8]
D10 = [1..10]
D12 = [1.. 2]
D100 = [1..100]
D20 = [1..20]

# encounter arrays
encounter1 = [
    goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6}, 
    bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6}, 
    kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4}, 
    skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6}
]

CRITICAL_HIT = 20


# establish stats
player = Player.new(100)

encounter = Enemy1.new(encounter1)
puts encounter

puts :name