class Combat

    def fight_menu
        @fight_input = prompt.select('What would you like to do?') do |menu|
            menu.choice "ATTACK"
            menu.choice "BLOCK"
            menu.choice "HEAL"
            menu.choice "SURRENDER"
        end

        if @fight_input == "ATTACK"
            @fight_choice = prompt.select('What is your plan of attack?') do |menu|
                menu.choice "BALANCED"
                menu.choice "RECKLESS"
                menu.choice "DEFENSIVE"
                menu.choice "BACK"
            end
        elsif @fight_input == "HEAL"
            @fight_input = "HEALING"
        elsif @fight_input == "BLOCK"
            @fight_choice = "BLOCKING"
        end

        if @fight_choice == "BACK"
            Combat.fight_menu
    end
end