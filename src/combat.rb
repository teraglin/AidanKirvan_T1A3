class Interface

    def initialize(prompt)
        @prompt = prompt
        @menu_input = "BACK"
    end

    def action_menu
        # menu
        @menu_input = @prompt.select('What would you like to do?') do |menu|
            menu.choice "ATTACK"
            menu.choice "BLOCK"
            menu.choice "HEAL"
            menu.choice "SURRENDER"
        end

        # ATTACK SUB-MENU 
        if @menu_input == "ATTACK"
            system('clear')

            @menu_input = @prompt.select('What is your plan of attack?') do |menu|
                menu.choice "BALANCED"
                menu.choice "RECKLESS"
                menu.choice "DEFENSIVE"
                menu.choice "BACK"
            end
        end

        return @menu_input
    end

    def victory
        system('clear')
        puts "The final foe falls before you!"
        puts "The crowd erupts into cheer!"
        puts "Congratulations! You are victorious!"
        @prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        system('clear')
        puts "You return to your cell and the gate closes."
        @prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        exit
    end

end