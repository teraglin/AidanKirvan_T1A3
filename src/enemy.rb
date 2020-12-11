require_relative 'dice.rb'
# require_relative 'player.rb'


# encounter1 = [
#     goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6, :special=>Special.multiattack}, 
#     bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6, :special=>Special.multiattack}, 
#     kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4, :special=>Special.multiattack}, 
#     skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6, :special=>Special.multiattack}
# ]

encounter1 = [
    goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6}, 
    bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6}, 
    kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4}, 
    skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6}
]

class Enemy1
    def initialize(encounter)
        @encounter = encounter
        @foe_choice = encounter[rand(@encounter.length - 1)]
        @foe_name = @foe_choice[:name]
        @foe_health = @foe_choice[:health]
        @foe_armour = @foe_choice[:armour]
        @foe_damage = @foe_choice[:damage]
        @foe_special = @foe_choice[:special]
    end

    def to_s
        puts "#{@foe_name} has health:#{@foe_health}"
    end
end

# class Special
#     def multiattack(dice)
        
#     end
# end

encounter = Enemy1.new(encounter1)
puts encounter

# puts Enemy1.initialize(encounter1)

# goblin
# - hp
# - armour
# - damage dice
# - special attack
# bullywug
# kobald
# skeleton

# bugbear
# dire wolf

# owlbear
# wyvern
# gelatenous cube