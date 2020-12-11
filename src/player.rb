# require_relative 'dice.rb'
# require_relative 'enemy.rb'
# require_relative 'arena.rb'


class Player
    def initialize(health)
        @player_health = health
        @player_current_health = health
        @player_ac = 10
    end

    def show_player_health()
        puts "Player: #{@player_current_health} / #{@player_health}"
    end

    def player_damage(dice)
        score = dice[0]
        return score
    end

    def player_gets_hit(enemy_attack)
            @player_current_health -= enemy_damage
        end
    end

    def player_healed(dice)
        @healing_value = (dice[] + dice[])
        @player_current_health += @healing_value
        if @player_current_health > @player_health
            @player_current_health = @player_health
        end
    end

    def gain_amour(amount)
        @armour_class += amount
    end
end

# tim = Player.new(100)
# tim.gets_hit(d20)