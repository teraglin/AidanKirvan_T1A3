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


end


# class Combat
    
#     attr_reader :fight_choice

#     def initialize(prompt)
#         @prompt = prompt
#     end




#     def fight_menu
#         @fight_input = @prompt.select('What would you like to do?') do |menu|
#             menu.choice "ATTACK"
#             menu.choice "BLOCK"
#             menu.choice "HEAL"
#             menu.choice "SURRENDER"
#         end

#         if @fight_input == "ATTACK"

#             @fight_choice = @prompt.select('What is your plan of attack?') do |menu|
#                 menu.choice "BALANCED"
#                 menu.choice "RECKLESS"
#                 menu.choice "DEFENSIVE"
#                 menu.choice "BACK"
#             end

#         elsif @fight_input == "HEAL"
#             @fight_choice = "HEALING"
#         elsif @fight_input == "BLOCK"
#             @fight_choice = "BLOCKING"
#         elsif @fight_input == "SURRENDER"

#         end

#         if @fight_choice == "BACK"
#             system('clear')
#             self.fight_menu
#         end

#     end
# end