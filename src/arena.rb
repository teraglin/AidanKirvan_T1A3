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
victory_points = 0
run = true

# initiate objects 
dice = Dice.new(prompt)
player = Player.new
monster1 = Enemy.new(enemy_roll_1)
monster2 = Enemy.new(enemy_roll_2)
monster3 = Enemy.new(enemy_roll_3)
combat = Interface.new(prompt)

# load first monster 
monster = monster1




# NAME PROMPT HERE 
while run
    # clear terminal 
    system('clear')

    # introduce monster 
    puts "The gate opens and you see a #{monster.mon_name}"

    prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])

    while run
        system('clear')

        while run
            player.print_player_health
            monster.print_enemy_health

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
            monster.print_enemy_health
            puts "you healed for #{heal_value}."
        elsif player_to_hit == "blocking"
            player.print_player_health
            monster.print_enemy_health
            puts "You shield yourself with magic."
        elsif player_to_hit == CRITICAL_HIT
            player_damage_score = player.damage
            player_damage = Dice.roll(player.damage) + Dice.roll(player.damage)
            monster.enemy_gets_hit(player_damage)
            player.print_player_health
            monster.print_enemy_health
            puts "CRITICAL HIT!!"
            puts "You dealt #{player_damage} to the #{monster.mon_name}"
        elsif player_to_hit >= monster.armour_class
            player_damage = Dice.roll(player.damage)
            monster.enemy_gets_hit(player_damage)
            player.print_player_health
            monster.print_enemy_health
            puts "WHACK!!"
            puts "You dealt #{player_damage} to the #{monster.mon_name}"
        else
            puts "Shoot!!"
            puts "You missed!"
        end

        prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])

        # CHECK FOR VICTORY/NEW MONSTER 
        if monster.health <= 0
            system('clear')
            victory_points +=1
            puts "You defeat the #{monster.mon_name}!!"
            prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])

            # CHOOSE ITEM clas.method? 

            # reload new monster 
            case victory_points
            when 3
                combat.victory
            when 2
                monster = monster3
            when 1
                monster = monster2
            end

            break
        else
            system('clear')
            player.print_player_health
            monster.print_enemy_health
            puts "Now it's the #{monster.mon_name}'s' turn."
            prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
        end
        
        case menu_input
        when "HEAL"
            monster_to_hit = Dice.roll(D20)
        when "BLOCK"
            monster_to_hit = "blocking"
        when "BALANCED"
            monster_to_hit = Dice.roll(D20)
        when "RECKLESS"
            monster_to_hit = Dice.advantage(D20)
        when "DEFENSIVE"
            monster_to_hit = Dice.disadvantage(D20)
        end

        # resolve player desicions and attack roles
        system('clear')

        
        if monster_to_hit == "blocking"
            monster_damage = Dice.roll(monster.damage)
            player.print_player_health
            monster.print_enemy_health
            puts "Your foe can't get through your magical barrier."
            puts "You avoid #{monster_damage} points of damage."
        elsif monster_to_hit == CRITICAL_HIT
            # player_damage_score = player.damage
            monster_damage = Dice.roll(monster.damage) + Dice.roll(monster.damage)
            player.player_gets_hit(monster_damage)
            player.print_player_health
            monster.print_enemy_health
            puts "CRITICAL HIT!!"
            puts "You take #{monster_damage} points of damage."
        elsif monster_to_hit >= player.armour_class
            # player_damage_score = player.damage
            monster_damage = Dice.roll(monster.damage)
            player.player_gets_hit(monster_damage)
            player.print_player_health
            monster.print_enemy_health
            puts "OOF!"
            puts "You take #{monster_damage} points of damage."
        else
            puts "Phew!!"
            puts "The #{monster.mon_name} missed you!"
        end

        prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])

        system('clear')
        player.print_player_health
        monster.print_enemy_health
        puts "Now it's your turn!"
        prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
    end
end