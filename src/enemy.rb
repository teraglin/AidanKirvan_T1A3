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