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