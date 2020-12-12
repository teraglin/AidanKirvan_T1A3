require "tty-prompt"
prompt = TTY::Prompt.new
require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'combat.rb'

# dice array 
D4 = [1..4]
D6 = [1..6]
D8 = [1..8]
D10 = [1..10]
D12 = [1..2]
D100 = [1..100]
D20 = [1..20]

# encounter arrays
encounter_table_1 = [
    goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6}, 
    bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6}, 
    kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4}, 
    skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6}
]

enemy_roll_1 = encounter_table_1[rand(encounter_table_1.length)]
enemy_roll_2 = encounter_table_1[rand(encounter_table_1.length)]
enemy_roll_3 = encounter_table_1[rand(encounter_table_1.length)]

CRITICAL_HIT = 20
HEALTH_MAX = 50
run = true

dice = Dice.new(prompt)
player = Player.new
enemy1 = Enemy.new(enemy_roll_1)
enemy2 = Enemy.new(enemy_roll_2)
enemy3 = Enemy.new(enemy_roll_3)
combat = Interface.new(prompt)

system('clear')

while run
    while run
        player.print_player_health
        enemy1.print_enemy_health

        # class for menu 
        # get value
        menu_input = combat.action_menu

        # are you quitting? -> method? class?
        if menu_input == "SURRENDER"
            system('clear')
            menu_input = prompt.select('Are you sure you want to surrender? (You will return to the menu and lose your progress)') do |menu|
                menu.choice "GET ME OUTTA HERE!!"
                menu.choice "I WON'T GIVE UP"
            end
    
            if menu_input == "GET ME OUTTA HERE!!"
                system('clear')
                puts "You toss down your weapon and raise your hands in defeat..."
                puts "GAME OVER"
                prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
                exit
            else
                menu_input = "BACK"
            end
        end

        # return from sub-menus
        if menu_input == "BACK"
            system('clear')
        else
            break
        end
    end
# determine player input and determine attack rolls
    case menu_input
    when "HEAL"
        player_to_hit = "healing"
    when "BLOCK"
        player_to_hit = "blocking"
    when "BALANCED"
        player_to_hit = Dice.roll(D20)
    when "RECKLESS"
        player_to_hit = Dice.advantage(D20)
    when "DEFENSIVE"
        player_to_hit = Dice.disadvantage(D20)
    end

# resolve player desicions and attack roles
    system('clear')

    if player_to_hit == "healing"
        heal_value = Dice.roll(D8) + Dice.roll(D8)
        player.heal(heal_value)
        player.print_player_health
        enemy1.print_enemy_health
        puts "you healed for #{heal_value}."
    elsif player_to_hit == "blocking"
        player.print_player_health
        enemy1.print_enemy_health
        puts "You shield yourself with magic."
    elsif player_to_hit == CRITICAL_HIT
        player_damage_score = player.damage
        player_damage = Dice.roll(player.damage) + Dice.roll(player.damage)
        enemy1.enemy_gets_hit(player_damage)
        player.print_player_health
        enemy1.print_enemy_health
        puts "CRITICAL HIT!!"
        puts "You dealt #{player_damage} to the #{enemy1.mon_name}"
    elsif player_to_hit >= enemy1.armour_class
        player_damage = Dice.roll(player.damage)
        enemy1.enemy_gets_hit(player_damage)
        player.print_player_health
        enemy1.print_enemy_health
        puts "WHACK!!"
        puts "You dealt #{player_damage} to the #{enemy1.mon_name}"
    else
        puts "Shoot!!"
        puts "You missed!"
    end




# is value back? repeat if so

# check value against case statement
# roll or create value for the process of hitting

# is crit?
# roll player.damage attack value * 2
# else miss

# is monster dead?
# if yes new round


# monster
# 2 straight
# 1 advantage
# 1 disadvantage
# 1 miss

# is player dead?
# if yes defeat

end


# establish stats
# dice = Dice.new(prompt)
# player = Player.new(50)
# encounter = Enemy.new(encounter1)
# combat = Combat.new(prompt)

# # MODULES 
# module Fight_Process
#     def self.player_turn(input)
#         if input == "HEAL"
#             player_to_hit = "nicholas"
#         elsif input == "BLOCK"
#             player_to_hit = "cage"
#         elsif input == "BALANCED"
#             player_to_hit = Dice.roll(D20)
#         elsif combat.fight_choice == "RECKLESS"
#             player_to_hit = Dice.advantage(D20)     
#         elsif combat.fight_choice == "DEFENSIVE"
#             player_to_hit = Dice.disadvantage(D20)
#         end

#         if player_to_hit == "nicholas"
#             heal_value = Dice.roll(D8) + Dice.roll(D8)
#             player.player_current_health += heal_value
#             if Player.player_current_health > Player.player_health
#                 Player.player_current_health = Player.player_health
#             end
#                 Player.show_player_health
#                 encounter.show_enemy_health
#                 puts "You healed #{heal_value} points of health"
#             return "You'll have to wait two turns to use the flask again."        
#         elsif player_to_hit == "cage"
#                 Player.show_player_health
#                 Enemy.show_enemy_health
#                 puts "You use magic to shield yourself from harm."
#             return "You'll have to wait two turns to use the spell again."
#         elsif player_to_hit == CRITICAL_HIT
#             player_turn_damage = Player.player_damage(D8) + Player.player_damage(D8)
#             Enemy.enemy_gets_hit(player_turn_damage)
#                 player.show_player_health
#                 encounter.show_enemy_health
#                 puts "CRITICAL HIT!!"
#             return puts "You deal #{player_turn_damage} points of damage to the #{Enemy.foe_name}"
#         elsif player_to_hit >= Enemy.foe_ac
#             player_turn_damage = Player.player_damage(D8)
#             Enemy.enemy_gets_hit(player_turn_damage)
#                 Player.show_player_health
#                 Enemy.show_enemy_health
#                 puts "WHACK!"
#             return puts "You deal #{player_turn_damage} points of damage to the #{Enemy.foe_name}"
#         else
#                 puts "Shoot!"
#             return puts "You missed"
#         end
#     end
# end




# # GAME START

# system('clear')

# # MAKE A CHOICE
# while run


#     while run
#         # MENU 
#         player.show_player_health
#         encounter.show_enemy_health

#         menu_input = prompt.select('What would you like to do?') do |menu|
#             menu.choice "ATTACK"
#             menu.choice "BLOCK"
#             menu.choice "HEAL"
#             menu.choice "SURRENDER"
#         end

#         if menu_input == "SURRENDER"
#             system('clear')
#             player.show_player_health
#             encounter.show_enemy_health

#             menu_input = prompt.select('Are you sure you want to surrender? (You will return to the menu and lose your progress)') do |menu|
#                 menu.choice "GET ME OUTTA HERE!!"
#                 menu.choice "I WON'T GIVE UP"
#             end
            
#             if menu_input == "GET ME OUTTA HERE!!"
#                 system('clear')
#                 puts "You toss down your weapon and raise your hands in defeat..."
#                 puts "GAME OVER"
#                 prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
#                 exit
#             else
#                 menu_input = "BACK"
#             end
#         end

#         # ATTACK SUB-MENU 
#         if menu_input == "ATTACK"
#             system('clear')

#             player.show_player_health
#             encounter.show_enemy_health

#             menu_input = prompt.select('What is your plan of attack?') do |menu|
#                 menu.choice "BALANCED"
#                 menu.choice "RECKLESS"
#                 menu.choice "DEFENSIVE"
#                 menu.choice "BACK"
#             end
#         end

#         # RETURN TO MENU FROM SUB-MENU 
#         if menu_input == "BACK"
#             system('clear')
#         else
#             break
#         end

#         # if combat.fight_choice == "BALANCED"
#         #     player_to_hit = dice.roll(D20)
#         #     break
#         # elsif combat.fight_choice == "RECKLESS"
#         #     player_to_hit = dice.advantage(D20)
#         #     break
#         # elsif combat.fight_choice == "DEFENSIVE"
#         #     player_to_hit = dice.disadvantage(D20)
#         #     break
#         # elsif combat.fight_choice == "HEAL"
#         #     player_to_hit = "HEALED"
#         #     break
#         # elsif combat.fight_choice == "BLOCK"
#         #     player_to_hit = "BLOCKED"
#         #     break
#         # elsif combat.fight_choice == "SURRENDER"
#         #     puts "You toss down your weapon and raise your hands in defeat..."
#         #     prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
#         #     exit
#         # end
#     end

#     puts Fight_Process.player_turn(menu_input)

#     # SHOW RESULTS
#     if player_to_hit == "HEALED"
#         player.player_healed(D8)
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "You healed for #{player.player_healing_value}"
#     elsif player_to_hit == "BLOCKED"
#         puts "You shield yourself with magic."
#     elsif player_to_hit == CRITICAL_HIT
#         player_damage = player.player_damage(D8) + player.player_damage(D8)
#         player.enemy_gets_hit(player_damage)
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "CRITICAL HIT!!"
#         puts "You deal #{player_damage} points of damage."
#     elsif player_to_hit >= encounter.foe_ac
#         player_damage = player.player_damage(D8)
#         encounter.enemy_gets_hit(player_damage)
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "You deal #{player_damage} points of damage."
#     else
#         puts "Shoot! You missed!"
#     end

#     prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

#     # CHECK FOR VICTORY 
#     if encounter.foe_current_health <= 0
#         "Victory!"
#         exit
#     else
#         puts "It's now the monster's turn..."
#     end

#     prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])


#     # MONSTER ATTACK
#     if combat.fight_menu == "BALANCED"
#         foe_to_hit = Dice.roll(D20)
#     elsif combat.fight_menu == "RECKLESS"
#         foe_to_hit = Dice.advantage(D20)
#     elsif combat.fight_menu == "DEFENSIVE"
#         foe_to_hit = Dice.disadvantage(D20)
#     elsif combat.fight_menu == "HEAL"
#         foe_to_hit = Dice.roll(D20)
#     elsif combat.fight_menu == "BLOCK"
#         foe_to_hit = "BLOCKED"
#     end
#     # MONSTER RESULTS 
#     if foe_to_hit == "BLOCKED"
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "Your magic protects you from harm."
#     elsif foe_to_hit == CRITICAL_HIT
#         foe_damage = encounter.enemy_damage + encounter.enemy_damage
#         player.player_gets_hit(foe_damage)
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "CRITICAL HIT!!"
#         puts "You take #{foe_damage} points of damage."
#     elsif foe_to_hit >= player.player_ac
#         foe_damage = encounter.enemy_damage
#         player.player_gets_hit(foe_damage)
#         player.show_player_health
#         encounter.show_enemy_health
#         puts "You take #{player_damage} points of damage."
#     else
#         puts "Phew! The #{encounter.foe_name} missed you!"
#     end

#     prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])


#     # CHECK FOR LOSS

#     if player.player_current_health <= 0
#         "DEATH!"
#         exit
#     else
#         puts "It's now your turn!"
#     end

#     prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

# end