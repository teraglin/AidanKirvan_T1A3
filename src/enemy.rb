class Enemy
    attr_accessor :mon_name, :health, :armour_class, :damage

    def initialize(enemy_num, prompt)
        @mon_name = enemy_num[:name]
        @prompt = prompt
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
        @prompt.error("#{mon_name} =] [{HP: #{@health}/#{@max_enemy_health}}] [{AC: #{armour_class}}]")
        puts " =" * 20
        puts " "
    end
end