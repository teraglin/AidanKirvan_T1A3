# require_relative 'dice.rb'
# require_relative 'arena.rb'
# require_relative 'player.rb'
# require_relative 'player.rb'


# encounter1 = [
#     goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6, :special=>Special.multiattack}, 
#     bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6, :special=>Special.multiattack}, 
#     kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4, :special=>Special.multiattack}, 
#     skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6, :special=>Special.multiattack}
# ]


class Enemy1
    def initialize(encounter)
        @foe_choice = encounter[rand(encounter.length)]
        @foe_name = @foe_choice[:name]
        @foe_health = @foe_choice[:health]
        @foe_current_health = @foe_choice[:health]
        @foe_ac = @foe_choice[:armour]
        @foe_damage = @foe_choice[:damage]
        @foe_special = @foe_choice[:special]
    end

    def show_enemy_health()
        puts "#{@foe_name}: #{@foe_current_health} / #{@foe_health}"
    end

    def enemy_damage(dice)
        score = dice[0]
        return score
    end

    def enemy_gets_hit(player_attack)
        if player_attack >= @foe_ac
            @foe_current_health -= @player_damage
        end
    end

    # def to_s
    #     puts "#{@foe_name} has health:#{@foe_health}"
    # end
end

# class Special
#     def multiattack(dice)
        
#     end
# end


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