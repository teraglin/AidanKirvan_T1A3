class Enemy
    attr_accessor :mon_name, :health, :armour_class, :damage

    def initialize(enemy_num)
        @mon_name = enemy_num[:name]
        @max_enemy_health = enemy_num[:health]
        @health = @max_enemy_health
        @armour_class = enemy_num[:armour]
        @damage = enemy_num[:damage]
    end

    def enemy_gets_hit(damage)
        @health -= damage
    end

    def heal(healing)
        @health += healing
        if @health > @max_enemy_health
            @health = @max_enemy_health
        end
    end

    def print_enemy_health
        puts "#{self.mon_name} HP: #{@health}/#{@max_enemy_health}"
        puts "#{self.mon_name} AC: #{armour_class}"
    end
end











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


# class Enemy

#     attr_reader :foe_name, :foe_health, :foe_current_health, :foe_ac, :foe_damage

#     def initialize(encounter)
#         @foe_choice = encounter[rand(encounter.length)]
#         @foe_name = @foe_choice[:name]
#         @foe_health = @foe_choice[:health]
#         @foe_current_health = @foe_health
#         @foe_ac = @foe_choice[:armour]
#         @foe_damage = @foe_choice[:damage]
#     end



#     def show_enemy_health()
#         puts "#{@foe_name}: #{@foe_current_health} / #{@foe_health}"
#     end

#     def enemy_damage()
#         score = @foe_damage
#         return score
#     end

#     def enemy_gets_hit(player_damage)
#         @foe_current_health -= player_damage
#     end

#     # def to_s
#     #     puts "#{@foe_name} has health:#{@foe_health}"
#     # end
# end

# # class Special
# #     def multiattack(dice)
        
# #     end
# # end


# # puts monster.initialize(encounter1)

# # goblin
# # - hp
# # - armour
# # - damage dice
# # - special attack
# # bullywug
# # kobald
# # skeleton

# # bugbear
# # dire wolf

# # owlbear
# # wyvern
# # gelatenous cube