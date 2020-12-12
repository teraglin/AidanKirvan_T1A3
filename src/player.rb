class Player
    attr_accessor :health, :armour_class, :damage


    def initialize
        @health = HEALTH_MAX
        @armour_class = 12
        @damage = D6
    end

    def player_gets_hit(damage)
        @health -= damage
    end

    def heal(healing)
        @health += healing
        if @health > HEALTH_MAX
            @health = HEALTH_MAX
        end
    end

    def print_player_health
        puts "PLAYER HP: #{@health}/#{HEALTH_MAX}"
        puts "PLAYER AC: #{armour_class}"
    end
end










# class Player

#     attr_reader :player_healing_value, :player_health, :player_current_health, :player_ac

#     def initialize(health)
#         @player_health = health
#         @player_current_health = health
#         @player_ac = 12
#     end

#     def show_player_health()
#         puts "Player: #{@player_current_health} / #{@player_health}"
#     end

#     def player_damage(dice)
#         score = dice[0]
#         return score
#     end

#     def player_gets_hit(enemy_attack)
#             @player_current_health -= enemy_damage
#     end

#     def player_healed(dice)
#         @healing_value = (dice[] + dice[])
#         @player_current_health += @healing_value
#         if @player_current_health > @player_health
#             @player_current_health = @player_health
#         end
#     end

#     def gain_amour(amount)
#         @armour_class += amount
#     end
# end

# # tim = Player.new(100)
# # tim.gets_hit(d20)