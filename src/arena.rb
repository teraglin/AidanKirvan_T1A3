require "tty-prompt"
prompt = TTY::Prompt.new(active_color: :magenta, symbols: {marker: "⬢"})
require 'colorize'
require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'combat.rb'

# dice array 
D4 = [1..4]
D6 = [1..6]
D8 = [1..8]
D10 = [1..10]
D12 = [1..12]
D100 = [1..100]
D20 = [1..20]

# encounter arrays
encounter_table_1 = [
    goblin = {name: 'GOBLIN',:health=>8, :armour=>8, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    bullywug = {name: 'BULLYWUG',:health=>8, :armour=>8, :damage=>D6, :special_name=>"multi", :special_cool=>5}, 
    kobald = {name: 'KOBALD',:health=>8, :armour=>8, :damage=>D4, :special_name=>"multi", :special_cool=>5}, 
    skeleton = {name: 'SKELETON',:health=>10, :armour=>10, :damage=>D6, :special_name=>"multi", :special_cool=>5}
]

encounter_table_2 = [
    owlbear = {name: 'OWLBEAR',:health=>15, :armour=>10, :damage=>D8, :special_name=>"multi", :special_cool=>5}, 
    giant_spider = {name: 'GIANT SPIDER',:health=>10, :armour=>10, :damage=>D6, :special_name=>"restrain", :special_cool=>5}, 
    nothic = {name: 'NOTHIC',:health=>10, :armour=>11, :damage=>D8, :special_name=>"multi", :special_cool=>5}, 
    minotaur = {name: 'MINOTAUR',:health=>15, :armour=>12, :damage=>D12, :special_name=>"multi", :special_cool=>5}
]

encounter_table_3 = [
    bassalisk = {name: 'BASSALISK',:health=>20, :armour=>12, :damage=>D10, :special_name=>"restrain", :special_cool=>5}, 
    giant = {name: 'GIANT',:health=>25, :armour=>10, :damage=>D12, :special_name=>"multi", :special_cool=>3}, 
    dragon = {name: 'DRAGON',:health=>20, :armour=>12, :damage=>D12, :special_name=>"breath", :special_cool=>5}, 
    wyvern = {name: 'WYVERN',:health=>15, :armour=>10, :damage=>D10, :special_name=>"breath", :special_cool=>3}
]

enemy_roll_1 = encounter_table_1[rand(encounter_table_1.length)]
enemy_roll_2 = encounter_table_2[rand(encounter_table_1.length)]
enemy_roll_3 = encounter_table_3[rand(encounter_table_1.length)]

CRITICAL_HIT = 20
HEALTH_MAX = 50
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

# METHODS

# UNIVERSAL METHODS 
def print_new_screen(player, monster)
    system('clear')
    player.print_player_health
    monster.print_enemy_health
    player.print_player_tools
end

# PLAYER METHODS 
def print_player_roll_hit(player, monster, player_to_hit)
    print "#{PLAYER_NAME}'s ROLL: ".colorize(:yellow)
    print "#{player_to_hit}".colorize(:green)
    print " | #{monster.mon_name}'s ARMOUR: ".colorize(:yellow)
    puts "#{monster.armour_class}".colorize(:blue)
    puts " "
end

def print_player_roll_miss(player, monster, player_to_hit)
    print "#{PLAYER_NAME}'s ROLL: ".colorize(:yellow)
    print "#{player_to_hit}".colorize(:red)
    print " | #{monster.mon_name}'s ARMOUR: ".colorize(:yellow)
    puts "#{monster.armour_class}".colorize(:blue)
    puts " "
end

def name_validation(name)

    if name.size > 12
        return false
    elsif name.count("0-9") > 0
        return false
    else
        return true
    end
end

# MONSTER METHODS 
def print_monster_roll_hit(player, monster, monster_to_hit)
    print "#{monster.mon_name}'s ROLL: ".colorize(:yellow)
    print "#{monster_to_hit}".colorize(:green)
    print " | #{PLAYER_NAME}'s ARMOUR: ".colorize(:yellow)
    puts "#{player.armour_class}".colorize(:blue)
    puts " "
end

def print_monster_roll_miss(player, monster, monster_to_hit)
    print "#{monster.mon_name}'s ROLL: ".colorize(:yellow)
    print "#{monster_to_hit}".colorize(:red)
    print " | #{PLAYER_NAME}'s ARMOUR: ".colorize(:yellow)
    puts "#{player.armour_class}".colorize(:blue)
    puts " "
end

while run
    system('clear')
    puts "What is your name?".colorize(:green)
    name_input = gets.chomp.to_s

    if name_input == ""
        PLAYER_NAME = "NICK CAGE"
        break
    elsif
        if name_validation(name_input) == false
            prompt.error("INVALID INPUT")
            prompt.error("Your name must be:")

            print "-"
            print " LESS ".colorize(:red)
            puts "than 13 characters"

            print "-"
            print " CONTAIN ".colorize(:red)
            puts "only alphabetical characters"
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        else
            PLAYER_NAME = name_input.upcase
            break
        end
    end
end
# NAME PROMPT HERE 
while run
    # clear terminal 
    system('clear')
    # introduce monster 
    puts "The gate opens and you see a #{monster.mon_name}"
    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

    # TURN START 
    while run
        player.flask_cooldown
        player.shield_cooldown

        # USER MAKES SELECTION
        while run
            print_new_screen(player, monster)

            menu_input = combat.action_menu

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
                menu_input = prompt.select('Are you sure you want to surrender? (You will return to the menu and lose your progress)') do |menu|
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
                    load('index.rb')
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

        # DETERMINE PLAYER OUTCOME BASED ON USER INPUT
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

        # RESOLVE PLAYER OUTCOME BASED ON USER INPUT
        if player_to_hit == "healing"
            player.use_flask
            heal_value = Dice.roll(D8) + Dice.roll(D8)
            player.heal(heal_value)

            print_new_screen(player, monster)

            puts "you regained #{heal_value} points of health."
        elsif player_to_hit == "blocking"
            player.use_shield

            print_new_screen(player, monster)

            puts "You shield yourself with magic."
        elsif player_to_hit == CRITICAL_HIT
            player_damage_score = player.damage
            player_damage = Dice.roll(player.damage) + Dice.roll(player.damage)
            monster.enemy_gets_hit(player_damage)

            print_new_screen(player, monster)

            print_player_roll_hit(player, monster, player_to_hit)

            puts "CRITICAL HIT!!"
            puts "You dealt #{player_damage} to the #{monster.mon_name}"
        elsif player_to_hit >= monster.armour_class
            player_damage = Dice.roll(player.damage)
            monster.enemy_gets_hit(player_damage)

            print_new_screen(player, monster)

            print_player_roll_hit(player, monster, player_to_hit)

            puts "WHACK!!"
            puts "You dealt #{player_damage} points of damage to the #{monster.mon_name}"
        else
            print_new_screen(player, monster)

            print_player_roll_miss(player, monster, player_to_hit)

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

            # RELOAD NEW MONSTER
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

            print_new_screen(player, monster)

            puts "Now it's the #{monster.mon_name}'s' turn."
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        end

        #CHECK FOR SPERCIAL ATTACK
        if monster.special_use == 0
            # CHECK IF BLOCKING 
            if menu_input == "BLOCK"
                monster_to_hit = "blocking"
                monster.special_recharge
            else
                monster_to_hit = menu_input.to_s + monster.special_name.to_s
                monster.special_recharge
            end
        else
            # DETERMINE ENEMY OUTCOME BASED ON USER INPUT
            case menu_input
            when "HEAL"
                monster_to_hit = Dice.roll(D20).to_i
            when "BLOCK"
                monster_to_hit = "blocking"
            when "BALANCED"
                monster_to_hit = Dice.roll(D20).to_i
            when "RECKLESS"
                monster_to_hit = Dice.advantage(D20).to_i
            when "DEFENSIVE"
                monster_to_hit = Dice.disadvantage(D20).to_i
            end
        end

        # !!!!!!MAYBE WRAP THE REST BELOW IN IF STATEMENT!!!!!

        # RESOLVE ENEMY OUTCOME BASED ON USER INPUT
        while run
            if monster_to_hit.is_a?(Integer)
                if monster_to_hit.to_i == CRITICAL_HIT

                    monster_damage = Dice.roll(monster.damage) + Dice.roll(monster.damage)
                    player.player_gets_hit(monster_damage)

                    print_new_screen(player, monster)

                    print_monster_roll_hit(player, monster, monster_to_hit)

                    puts "CRITICAL HIT!!"
                    puts "You take #{monster_damage} points of damage."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit.to_i >= player.armour_class

                    monster_damage = Dice.roll(monster.damage)
                    player.player_gets_hit(monster_damage)

                    print_new_screen(player, monster)

                    print_monster_roll_hit(player, monster, monster_to_hit)

                    puts "OOF!"
                    puts "You take #{monster_damage} points of damage."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit.to_i < player.armour_class
                    print_new_screen(player, monster)

                    print_monster_roll_miss(player, monster, monster_to_hit)

                    puts "Phew!"
                    puts "The #{monster.mon_name}'s attack missed you."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                end

            else

                if monster_to_hit == "blocking"
                    print_new_screen(player, monster)
    
                    puts "Your foe can't get through your magical barrier."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit == "BALANCEDmulti" || monster_to_hit == "HEALmulti"
                    multi1 = Dice.roll(monster.damage)
                    multi2 = Dice.roll(monster.damage)
                    multi3 = Dice.roll(monster.damage)
    
                    multi_hash = {"first"=>multi1, "second"=>multi2, "third"=>multi3}

                    multi_hash.each do |turn, damage|
                    monster_to_hit = (Dice.roll(D20).to_i)
                    if monster_to_hit.to_i == CRITICAL_HIT
                        total_damage = damage + Dice.roll(monster.damage)
                        player.player_gets_hit(total_damage)

                        print_new_screen(player, monster)

                        print_monster_roll_hit(player, monster, monster_to_hit)

                        puts "CRITICAL HIT!!"
                        puts "You take #{total_damage} points of damage from the #{turn} hit."
                        prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        elsif monster_to_hit >= player.armour_class
                            player.player_gets_hit(damage)
    
                            print_new_screen(player, monster)
    
                            print_monster_roll_hit(player, monster, monster_to_hit)
    
                            puts "OOF!"
                            puts "You take #{damage} points of damage from the #{turn} hit."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        else
                            print_new_screen(player, monster)
    
                            print_monster_roll_miss(player, monster, monster_to_hit)
    
                            puts "Phew!"
                            puts "The #{turn} attack missed you."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        end
                    end
                    break
                elsif monster_to_hit == "RECKLESSmulti"
                    multi1 = Dice.roll(monster.damage)
                    multi2 = Dice.roll(monster.damage)
                    multi3 = Dice.roll(monster.damage)
    
                    multi_hash = {"first"=>multi1, "second"=>multi2, "third"=>multi3}
                    
                    multi_hash.each do |turn, damage|
                        monster_to_hit = (Dice.advantage(D20).to_i)
                        if monster_to_hit.to_i == CRITICAL_HIT
                            total_damage = damage + Dice.roll(monster.damage)
                            player.player_gets_hit(total_damage)
    
                            print_new_screen(player, monster)
    
                            print_monster_roll_hit(player, monster, monster_to_hit)

                            puts "CRITICAL HIT!!"
                            puts "You take #{total_damage} points of damage from the #{turn} hit."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        elsif monster_to_hit >= player.armour_class
                            player.player_gets_hit(damage)
    
                            print_new_screen(player, monster)
    
                            print_monster_roll_hit(player, monster, monster_to_hit)
    
                            puts "OOF!"
                            puts "You take #{damage} points of damage from the #{turn} hit."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        else
                            print_new_screen(player, monster)
    
                            print_monster_roll_miss(player, monster, monster_to_hit)
    
                            puts "Phew!"
                            puts "The #{turn} attack missed you."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        end
                    end
                    break
                elsif monster_to_hit == "DEFENSIVEmulti"
                    multi1 = Dice.roll(monster.damage)
                    multi2 = Dice.roll(monster.damage)
                    multi3 = Dice.roll(monster.damage)
    
                    multi_hash = {"first"=>multi1, "second"=>multi2, "third"=>multi3}
    
                    multi_hash.each do |turn, damage|
                        monster_to_hit = (Dice.disadvantage(D20).to_i)
                        if monster_to_hit.to_i == CRITICAL_HIT
                            total_damage = damage + Dice.roll(monster.damage)
                            player.player_gets_hit(total_damage)
    
                            print_new_screen(player, monster)
    
                            print_monster_roll_hit(player, monster, monster_to_hit)

                            puts "CRITICAL HIT!!"
                            puts "You take #{total_damage} points of damage from the #{turn} hit."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        elsif monster_to_hit >= player.armour_class
                            player.player_gets_hit(damage)
    
                            print_new_screen(player, monster)
    
                            print_monster_roll_hit(player, monster, monster_to_hit)
    
                            puts "OOF!"
                            puts "You take #{damage} points of damage from the #{turn} hit."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        else
                            print_new_screen(player, monster)
    
                            print_monster_roll_miss(player, monster, monster_to_hit)
    
                            puts "Phew!"
                            puts "The #{turn} attack missed you."
                            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                        end
                    end
                    break
                elsif monster_to_hit == "BALANCEDbreath" || monster_to_hit == "HEALbreath"
                    monster_damage = (
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6)
                    )
    
                    print_new_screen(player, monster)
                    puts "The #{monster.mon_name} exhales a torrent of fire!"
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    player.player_gets_hit(monster_damage)
    
                    print_new_screen(player, monster)
                    puts "You take #{monster_damage} points of damage."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit == "RECKLESSbreath"
                    monster_damage = (
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6) 
                    )
    
                    monster_damage += monster_damage
    
                    print_new_screen(player, monster)
                    puts "The #{monster.mon_name} exhales a torrent of fire!"
                    print "You'll take "
                    print "double damage ".colorize(:red)
                    print "due to fighting "
                    print "recklessly".colorize(:red)
                    puts "."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    player.player_gets_hit(monster_damage)
    
                    print_new_screen(player, monster)
                    puts "You take #{monster_damage} points of damage."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit == "DEFENSIVEbreath"
                    monster_damage = (
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6) +
                        Dice.roll(D6) 
                    )
    
                    monster_damage = monster_damage / 2
    
                    print_new_screen(player, monster)
                    puts "The #{monster.mon_name} exhales a torrent of fire!"
                    print "You'll take "
                    print "half damage ".colorize(:blue)
                    print "due to fighting "
                    print "defensively".colorize(:blue)
                    puts "."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    player.player_gets_hit(monster_damage)
    
                    print_new_screen(player, monster)
                    puts "You take #{monster_damage} points of damage."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
                    break
                elsif monster_to_hit.include? "restrain"
                    print_new_screen(player, monster)
    
                    puts "The monster has you restrained!!"
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    print_new_screen(player, monster)
                    puts "Now it's your turn!"
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    player.flask_cooldown
                    player.shield_cooldown
                    monster.special_timer
                    print_new_screen(player, monster)
                    puts "You are restained!"
                    puts "You can't do anything this turn ..."
                    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
    
                    monster_to_hit = Dice.advantage(D20).to_i
                end

            end
            
        end

        # CHECK FOR PLAYER DEFEAT
        if player.health <= 0
            print_new_screen(player, monster)

            combat.defeat
        else
            print_new_screen(player, monster)
            puts "Now it's your turn!"
            prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])
        end
    end
end