require "tty-prompt"
prompt = TTY::Prompt.new(active_color: :magenta, symbols: {marker: "⬢"})
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
    goblin = {name: 'goblin',:health=>15, :armour=>11, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    bullywug = {name: 'bullywug',:health=>15, :armour=>11, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    kobald = {name: 'kobald',:health=>10, :armour=>8, :damage=>D4, :special_name=>"multi", :special_cool=>5}, 
    skeleton = {name: 'skeleton',:health=>15, :armour=>10, :damage=>D6, :special_name=>"multi", :special_cool=>5}
]

enemy_roll_1 = encounter_table_1[rand(encounter_table_1.length)]
enemy_roll_2 = encounter_table_1[rand(encounter_table_1.length)]
enemy_roll_3 = encounter_table_1[rand(encounter_table_1.length)]

CRITICAL_HIT = 20
HEALTH_MAX = 20
FLASK_MAX = 5
SHIELD_MAX = 5
victory_points = 0
run = true

# initiate objects 
dice = Dice.new(prompt)
player = Player.new(prompt)
monster1 = Enemy.new(enemy_roll_1, prompt)
monster2 = Enemy.new(enemy_roll_2, prompt)
monster3 = Enemy.new(enemy_roll_3, prompt)
combat = Interface.new(prompt)

# load first monster 
monster = monster1

system('clear')
PLAYER_NAME = prompt.ask("What is your name?", default: "Nicholas Cage")


# NAME PROMPT HERE 
while run
    # clear terminal 
    system('clear')
    # introduce monster 
    puts "The gate opens and you see a #{monster.mon_name}"
    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

    while run
        system('clear')
        player.flask_cooldown
        player.shield_cooldown

        while run
            player.print_player_health
            monster.print_enemy_health

            

            # SHIELD COUNTER METHOD
            
            # HEAL COUNTER METHOD 
            # puts player.flask
            # puts player.shield

            # class for menu 
            # get value
            menu_input = combat.action_menu

            # flask and shield need to be in player class!!!  
            # MENU CHECKPOINT
            if menu_input == "BLOCK"
                if player.shield > 0
                    system('clear')
                    menu_input = "RETURN"
                    prompt.warn("You need to wait #{player.shield} more turn(s) more turn(s) to cast shield again")
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                else
                    break
                end
            elsif menu_input == "HEAL"
                if player.flask > 0
                    system('clear')
                    menu_input = "RETURN"
                    prompt.warn("You need to wait #{player.flask} for your flask to refill.")
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                else
                    break
                end
            elsif menu_input == "SURRENDER"
                system('clear')
                menu_input = prompt.select('Are you sure you want to surrender? (You will return to the menu and lose your progress)', active_color: :red) do |menu|
                    menu.choice "GET ME OUTTA HERE!!"
                    menu.choice "I WON'T GIVE UP"
                end
                
                if menu_input == "GET ME OUTTA HERE!!"
                    system('clear')
                    puts "You toss down your weapon and raise your hands in defeat..."
                    prompt.error("
        ▄████  ▄▄▄       ███▄ ▄███▓▓█████     ▒█████   ██▒   █▓▓█████  ██▀███  
       ██▒ ▀█▒▒████▄    ▓██▒▀█▀ ██▒▓█   ▀    ▒██▒  ██▒▓██░   █▒▓█   ▀ ▓██ ▒ ██▒
      ▒██░▄▄▄░▒██  ▀█▄  ▓██    ▓██░▒███      ▒██░  ██▒ ▓██  █▒░▒███   ▓██ ░▄█ ▒
      ░▓█  ██▓░██▄▄▄▄██ ▒██    ▒██ ▒▓█  ▄    ▒██   ██░  ▒██ █░░▒▓█  ▄ ▒██▀▀█▄  
      ░▒▓███▀▒ ▓█   ▓██▒▒██▒   ░██▒░▒████▒   ░ ████▓▒░   ▒▀█░  ░▒████▒░██▓ ▒██▒
       ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ░  ░░░ ▒░ ░   ░ ▒░▒░▒░    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░
        ░   ░   ▒   ▒▒ ░░  ░      ░ ░ ░  ░     ░ ▒ ▒░    ░ ░░   ░ ░  ░  ░▒ ░ ▒░
      ░ ░   ░   ░   ▒   ░      ░      ░      ░ ░ ░ ▒       ░░     ░     ░░   ░ 
            ░       ░  ░       ░      ░  ░       ░ ░        ░     ░  ░   ░     
                                                                           ░                   
                      ")
                    prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
                    load(index.rb)
                else
                    menu_input = "RETURN"
                end
            end

            # return from sub-menus
            if menu_input == "RETURN"
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
            player.use_flask
            heal_value = Dice.roll(D8) + Dice.roll(D8)
            player.heal(heal_value)
            player.print_player_health
            monster.print_enemy_health
            puts "you regained #{heal_value} points of health."
        elsif player_to_hit == "blocking"
            player.use_shield
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
            puts "You dealt #{player_damage} points of damage to the #{monster.mon_name}"
        else
            puts "Shoot!!"
            puts "You missed!"
        end

        prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

        # CHECK FOR VICTORY/NEW MONSTER 
        if monster.health <= 0
            system('clear')
            victory_points +=1
            puts "You defeat the #{monster.mon_name}!!"
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

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
            monster.special_timer

            system('clear')
            player.print_player_health
            monster.print_enemy_health
            puts "Now it's the #{monster.mon_name}'s' turn."
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        end
    # elsif statements for how the monster will attack

        #CHECK FOR SPERCIAL ATTACK
        if monster.special_use == 0
            # CHECK IF BLOCKING 
            if menu_input == "BLOCK"
                monster_to_hit = "blocking"
                monster.special_recharge
            else
                monster_to_hit = monster.special_name
                monster.special_recharge
            end
        else
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
        end

        # !!!!!!MAYBE WRAP THE REST BELOW IN IF STATEMENT!!!!!

        # resolve player desicions and attack roles
        system('clear')

        if monster_to_hit == "blocking"
            monster_damage = Dice.roll(monster.damage)
            player.print_player_health
            monster.print_enemy_health
            puts "Your foe can't get through your magical barrier."
        elsif monster_to_hit == CRITICAL_HIT
            # player_damage_score = player.damage
            monster_damage = Dice.roll(monster.damage) + Dice.roll(monster.damage)
            player.player_gets_hit(monster_damage)
            player.print_player_health
            monster.print_enemy_health
            puts "CRITICAL HIT!!"
            puts "You take #{monster_damage} points of damage."
        elsif monster_to_hit.to_i >= player.armour_class
            # player_damage_score = player.damage
            monster_damage = Dice.roll(monster.damage)
            player.player_gets_hit(monster_damage)
            player.print_player_health
            monster.print_enemy_health
            puts monster_to_hit
            puts "OOF!"
            puts "You take #{monster_damage} points of damage."
        elsif monster_to_hit == "multi"
            multi1 = Dice.roll(monster.damage)
            multi2 = Dice.roll(monster.damage)
            multi3 = Dice.roll(monster.damage)

            # FIRST HIT 
            monster_to_hit = (Dice.roll(D20).to_i + 2)
            if monster_to_hit >= player.armour_class
                player.player_gets_hit(multi1)
                player.print_player_health
                monster.print_enemy_health
                puts "OOF!"
                puts "You take #{multi1} points of damage from the fist hit..."
            else
                player.print_player_health
                monster.print_enemy_health
                puts "Phew!"
                puts "The first attack missed you..."
            end

            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
            system('clear')

            # SECOND HIT 
            monster_to_hit = (Dice.roll(D20).to_i + 2)
            if monster_to_hit >= player.armour_class
                player.player_gets_hit(multi2)
                player.print_player_health
                monster.print_enemy_health
                puts "You take #{multi2} points of damage from the second hit..."
            else
                player.print_player_health
                monster.print_enemy_health
                puts "The second attack missed you..."
            end

            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
            system('clear')

            # THIRD HIT 
            monster_to_hit = (Dice.roll(D20).to_i + 2)
            if monster_to_hit >= player.armour_class
                player.player_gets_hit(multi3)
                player.print_player_health
                monster.print_enemy_health
                puts "And finally #{multi3} points of damage from the third hit!"
            else
                player.print_player_health
                monster.print_enemy_health
                puts "The third attack missed you!"
            end
            
        elsif monster_to_hit == "breath"
            player.print_player_health
            monster.print_enemy_health
        elsif monster_to_hit == "web"
            player.print_player_health
            monster.print_enemy_health
        else
            puts "Phew!!"
            puts "The #{monster.mon_name} missed you!"
            puts monster_to_hit
        end

        prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

        if player.health <= 0
            system('clear')
            player.print_player_health
            monster.print_enemy_health
            combat.defeat
        else
            system('clear')
            player.print_player_health
            monster.print_enemy_health
            puts "Now it's your turn!"
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        end
    end
end