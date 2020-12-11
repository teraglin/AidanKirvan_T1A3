require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'combat.rb'
require "tty-prompt"

# dice array 
D4 = [1..4]
D6 = [1..6]
D8 = [1..8]
D10 = [1..10]
D12 = [1.. 2]
D100 = [1..100]
D20 = [1..20]

# encounter arrays
encounter1 = [
    goblin = {name: 'goblin',:health=>20, :armour=>11, :damage=>D6}, 
    bullywug = {name: 'bullywug',:health=>20, :armour=>11, :damage=>D6}, 
    kobald = {name: 'kobald',:health=>15, :armour=>8, :damage=>D4}, 
    skeleton = {name: 'skeleton',:health=>20, :armour=>10, :damage=>D6}
]

CRITICAL_HIT = 20
run = true


# establish stats
player = Player.new(50)
encounter = Enemy1.new(encounter1)
prompt = TTY::Prompt.new
combat = Combat.new


# GAME START

system('clear')

# MAKE A CHOICE
while run = true

    while run = true
        player.show_player_health
        encounter.show_enemy_health

        combat.fight_menu

        if @fight_choice == "BACK"
            system('clear')
        elsif @fight_choice == "BALANCED"
            player_to_hit = Dice.roll(D20)
            break
        elsif @fight_choice == "RECKLESS"
            player_to_hit = Dice.advantage(D20)
        elsif @fight_choice == "DEFENSIVE"
            player_to_hit = Dice.disadvantage(D20)
        elsif @fight_choice == "HEAL"
            player_to_hit = "HEALED"
        elsif @fight_choice == "BLOCK"
            player_to_hit = "BLOCKED"
        elsif @fight_choice == "SURRENDER"
            puts "You toss down your weapon and raise your hands in defeat..."
            prompt.keypress("Press SPACE or ENTER to return to menu", keys: [:space, :return])
            exit
        end
    end

    # SHOW RESULTS
    if player_to_hit == "HEALED"
        player.player_healed(D8)
        player.show_player_health
        encounter.show_enemy_health
        puts "You healed for #{@healing_value}"
    elsif player_to_hit == "BLOCKED"
        puts "You shield yourself with magic."
    elsif player_to_hit == CRITICAL_HIT
        player_damage = player.player_damage(D8) + player.player_damage(D8)
        player.enemy_gets_hit(player_damage)
        player.show_player_health
        encounter.show_enemy_health
        puts "CRITICAL HIT!!"
        puts "You deal #{player_damage} points of damage."
    elsif player_to_hit >= @foe_ac
        player_damage = player.player_damage(D8)
        encounter.enemy_gets_hit(player_damage)
        player.show_player_health
        encounter.show_enemy_health
        puts "You deal #{player_damage} points of damage."
    else
        puts "Shoot! You missed!"
    end

    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

    # CHECK FOR VICTORY 
    if @foe_current_health <= 0
        "Victory!"
        exit
    else
        puts "It's now the monster's turn..."
    end

    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])


    # MONSTER ATTACK
    if @fight_choice == "BALANCED"
        foe_to_hit = Dice.roll(D20)
    elsif @fight_choice == "RECKLESS"
        foe_to_hit = Dice.advantage(D20)
    elsif @fight_choice == "DEFENSIVE"
        foe_to_hit = Dice.disadvantage(D20)
    elsif @fight_choice == "HEAL"
        foe_to_hit = Dice.roll(D20)
    elsif @fight_choice == "BLOCK"
        foe_to_hit = "BLOCKED"
    end
    # MONSTER RESULTS 
    if foe_to_hit == "BLOCKED"
        player.show_player_health
        encounter.show_enemy_health
        puts "Your magic protects you from harm."
    elsif foe_to_hit == CRITICAL_HIT
        foe_damage = encounter.enemy_damage + encounter.enemy_damage
        player.player_gets_hit(foe_damage)
        player.show_player_health
        encounter.show_enemy_health
        puts "CRITICAL HIT!!"
        puts "You take #{foe_damage} points of damage."
    elsif foe_to_hit >= @player_ac
        foe_damage = encounter.enemy_damage
        player.player_gets_hit(foe_damage)
        player.show_player_health
        encounter.show_enemy_health
        puts "You take #{player_damage} points of damage."
    else
        puts "Phew! The #{@foe_name} missed you!"
    end

    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])


    # CHECK FOR LOSS

    if @player_current_health <= 0
        "DEATH!"
        exit
    else
        puts "It's now your turn!"
    end

    prompt.keypress("Press SPACE or ENTER to continue", keys: [:space, :return])

end