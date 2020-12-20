# require 'colorize'

class Player
    attr_accessor :health, :armour_class, :damage, :flask, :shield

    def initialize(prompt)
        @prompt = prompt
        @health = HEALTH_MAX
        @armour_class = 12
        @damage = D6
        @flask = 0
        @shield = 0
    end

    def use_flask
        @flask += FLASK_MAX
    end

    def flask_cooldown
        if @flask > 0
            @flask -= 1
        end
    end

    def use_shield
        @shield += SHIELD_MAX
    end

    def shield_cooldown
        if @shield > 0
            @shield -= 1
        end
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
        @prompt.ok("#{PLAYER_NAME} =] [{HEALTH: #{@health}/#{HEALTH_MAX}}] [{ARMOUR: #{armour_class}}]")
    end

    def print_player_tools
        if @flask == 0
            print "FLASK: READY".colorize(:blue)
            print " | "
        else
            print "FLASK: #{@flask}".colorize(:blue)
            print " | "
        end

        if @shield == 0
            puts "SHIELD: READY".colorize(:blue)
            puts " =" * 20
            puts " "
        else
            puts "SHIELD: #{@shield}".colorize(:blue)
            puts " =" * 20
            puts " "
        end
    end
end