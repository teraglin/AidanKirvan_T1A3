require "tty-prompt"
prompt = TTY::Prompt.new(active_color: :magenta, symbols: {marker: "⬢"})
require 'colorize'
require_relative 'dice.rb'
require_relative 'player.rb'
require_relative 'enemy.rb'
require_relative 'combat.rb'

run = true



while run
system('clear')

puts "
    dP     dP                           dP                888888ba  dP                   
    88     88                           88                88    `8b 88                   
    88aaaaa88a .d8888b. dP  dP  dP    d8888P .d8888b.    a88aaaa8P' 88 .d8888b. dP    dP 
    88     88  88'  `88 88  88  88      88   88'  `88     88        88 88'  `88 88    88 
    88     88  88.  .88 88.88b.88'      88   88.  .88     88        88 88.  .88 88.  .88 
    dP     dP  `88888P' 8888P Y8P       dP   `88888P'     dP        dP `88888P8 `8888P88 
    ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~~~~.88~
                                                                                 d8888P  
".colorize(:cyan)

puts "Select an option bellow to learn about the game:".colorize(:magenta)
puts " "
puts "use the arrow keys to scroll down for more options".colorize(:color => :white, :background => :magenta)
puts "select an option with the SPACE or ENTER key".colorize(:color => :white, :background => :magenta)

    input = prompt.select(" ") do |menu|
        menu.choice "OVERVIEW"
        menu.choice "SELECTING AN ACTION"
        menu.choice "MAKING AN ATTACK"
        menu.choice "ATTACK TYPES"
        menu.choice "HEALING, BLOCKING AND COOLDOWNS"
        menu.choice "LEARNING ABOUT THE ENEMY"
        menu.choice "MONSTER SPECIAL ATTACKS"
        menu.choice "MAIN MENU"
    end

    system('clear')

    if input == "OVERVIEW"
        print "
        
        OVERVIEW".colorize(:cyan)
        puts "
        --------"

        puts "
        In Fight Monsters or Whatever, you are a warrior and a slave to The
        Arena...
        
        To win you must fight three monsters in a row and survive. Each
        monster is randomly selected, and is harder to kill than the one
        before it.
        Should you fell three monsters... you win.
        Should you fall in battle... you lose.

        Both you and your enemy have a pool of health that is displayed
        at the top of the screen. Defeat for either of you is when your health
        reaches 0.

        Conveniently for you, you are a warrier equiped and skilled with:
        * A sword
        * A self-refilling flask of healing potion
        * And the ability to shield yourself with magic

        I will explain how to use these in the other guides."

        puts "
        This concludes the OVERVIEW".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "SELECTING AN ACTION"
        system('clear')
        print "

        SELECTING AN ACTION".colorize(:cyan)
        puts "
        -------------------"

        puts "
        The game is played in rounds in which you and your eneymy take
        turns attacking each other. Each round starts with your turn where
        you will decide on an ACTION. After your turn is concluded, the enemy
        retaliates. This contunues until you are either victorious or defeated
        (or surrender).

        The actions you can choose from are:
        * ATTACK: Takes you to the attack submenu so you can attck your foe
        with your weapon.
        * HEAL: Drink the healing potion in your flask. The potency of the
        potion varies every time it is drunk.
        * SHIELD: Cast a magical barrier to protect you from harm. You are
        impervious to damage until it is your turn again. (This is particulary
        useful for enemy special attacks)
        * SURRENDER: Forefit and return to the main menu."


        puts "
        This concludes SELECTING AN ACTION".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "MAKING AN ATTACK"
        system('clear')
        print "
        
        MAKING AN ATTACK".colorize(:cyan)
        puts "
        ----------------"

        puts "
        Before going the ATTACK sub-menu, it's important to know what heppens
        when an attack is made.
            
        1) A 20 sided dice is rolled.

        2) The result of the roll is compared to the 'Armour Class' of your
        opponent. If the result is equal to or higher, you hit. Otherwise
        the attack misses.
        
            eg. You rolled a 10 on an attack against a Goblin. The armour
            class of the Goblin is 8. Seeing as the result is higher than the
            Goblin's Armour Class, you hit the Goblin.

        3) If the attack hits. Damage is rolled depending on the player or
        monster's 'Damage Dice'. For you as the player, this is a D6. For
        monsters this can be a D4, D6, D8, D10 or D12.
        The result of the damage roll is subtracted from the opponent's
        health.
        
        If a 'Critical Hit' is rolled (rolling a result of 20 when rolling to
        hit), you would roll two damage die instead of one.
        
        So to summarise the terminology when an attack is made:

        * ROLLING TO HIT: A 20 sided die (a D20) is rolled when an attack is
        made.

        * ARMOUR CLASS: If the result of the ROLL TO HIT is equal to or higher
        than your opponents ARMOUR CLASS, the attack hits. Otherwise it misses.
        
        * ROLLING DAMAGE: If an attack hits, the appropriate dice is rolled
        and the opponent takes the reult as damage.
        For you this is a D6 (a six sided die), for enemy monsters this can be
        a D4, D6, D8, D10 or a D12!
        
        * CRITICAL HITS: If a 20 is rolled on a D20 to hit, this results in a
        CRITICAL HIT. This means that whichever and how many die that are
        rolled for damage are DOUBLED!
        (eg. 1 D6 for damage becomes 2 D6 of damage.)
        
        Remember that these rules apply for both you and your opponent!"

        puts "
        This concludes MAKING AN ATTACK.".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "ATTACK TYPES"
        system('clear')
        print "
        
        ATTACK TYPES".colorize(:cyan)
        puts "
        ------------"
        
        puts "
        When ATTACK is selected from the main menu, a submenu opens. Here you
        can choose THREE different methods of attacking. (If you haven't read
        MAKING AN ATTACK, I suggest you do that first.)

        The three types of attacks are:
        
        * BALANCED: A BALANCED attack results in a standard attack. You roll
        one die to hit and use that result. Your opponent does the same when
        they attack.
        
        * RECKLESS: Being RECKLESS means you'll have the advantage on your
        opponent. When you attack recklessly, two dice are rolled to hit your
        opponent and only the highest reult is used. However, you are attacking
        recklessly so your opponent gains the same advantage. Be sure to use
        caution when using this while a monster is using a special attack.
        Otherwise it's handy for finishing off an opponent who is close to
        death.
        
        * DEFENSIVE: This is similar to attacking recklessly. However fighting
        defensively means your caution makes it both harder to hit your enemy
        and harder for them to hit you. This maneuver means two dice are
        rolled to hit and the lowest value is used. Your opents suffers the
        same effect. This is useful if you are biding your time for your
        shield to recharge or your flask to refill."
        
        puts "
        This concludes ATTACK TYPES".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "HEALING, BLOCKING AND COOLDOWNS"
        system('clear')
        print "
        
        HEALING, BLOCKING AND COOLDOWNS".colorize(:cyan)
        puts "
        -------------------------------"
        
        puts "
        When you are looking to avoid damage or recover health, BLOCK
        and HEAL are available from the action menu.
        
        * BLOCK: You cast a magical barrier around you. When your opponent
        attacks you avoid all damage. Even if your oppent uses a special
        attack.
        
        * HEAL: Two D8 are rolled and the result is added to your current
        health. It cannot heal you past your maximum health."
        
        print "
        When playing the game, your name health and armour is displayed in the
        very top in "
        print "GREEN".colorize(:green)
        print ". "
        print "Underneath that, your enemy's name, health and
        armour is displayed in "
        print "RED".colorize(:red)
        puts "."
        print "
        Underneath those two bars in "
        print "BLUE".colorize(:blue)
        puts ", is the status of your
        FLASK and your SHIELD. When you use the HEAL or BLOCK action you must
        wait a number of turns before you can use your FLASK or SHIELD again.
        This is represented as a number from 1-5 (depending on how many turns
        are left) and will display READY when you can use these actions again."

        puts "
        This concludes HEALING, BLOCKING AND COOLDOWNS".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "LEARNING ABOUT THE ENEMY"
        puts "
        
        LEARNING ABOUT THE ENEMY".colorize(:cyan)
        puts "
        ------------------------"

        puts "
        To win the game you must defeat three monsters, one from three
        different tiers.
        
        * TIER 1: The first monsters you fight can be tough in their own way
        but should not be too hard to dispatch.
        
        * TIER 2: When the first enemy is defeated. A randomly selected monster
        from this tier is brought out. They are generally hit harder and have
        more health and armour. There are only a few monsters in this tier with
        a less common sepcial attack.
        
        * TIER 3: This is the last tier to beat. Any monster from this tier
        will serve as a great challenge to fell. They hit the hardest and are
        the hardest to hit. Additionally they are more likely to have
        terrifying special attacks. Part of beating these foes is knowing their
        special rotations."

        puts "
        This concludes LEARNING ABOUT THE ENEMY".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])
    elsif input == "MONSTER SPECIAL ATTACKS"
        puts "
        
        MONSTER SPECIAL ATTACKS".colorize(:cyan)
        puts "
        -----------------------"

        puts "
        Much like the cooldowns on your FLASK and SHIELD, monsters also have
        cooldowns for their SPECIAL ATTACKs. These cooldown times vary from
        monster to monster, as does the type of special attack they perform.
        
        The three types of special attacks are:
        
        * MULTI ATTACK: This allows the monster to attack three times in a row.
        For each attack they still have to roll to hit, but this can be
        affected by whether you are attack RECKLESSLY or DEFENSIVELY like any
        other attack a monster will make. Additionally, if they score a
        CRITICAL HIT, those count as well in a multi attack.
        
        * RESTRAIN: There are a few monster who can restain you with web or
        paralysis. When you are restrained, you will miss your next action and
        The next attack the monster makes will be as though you attacked
        RECKLESSLY.
        
        * BREATH: The most terrifying of all special attacks. Only TIER 3
        monsters have this ability. A breath attack will always hit (unless
        you are blocking) and will deal large amounts of damage. Additionally,
        if you are attacking RECKLESSLY when a monster uses this, you will take
        double damage. Likewise if you attack DEFENSIVELY, you will take half
        damage."

        puts "
        This concludes MONSTER SPECIAL ATTACKS".colorize(:cyan)
        prompt.keypress("
        Press ENTER or SPACE to return", keys: [:space, :return])

    elsif input == "MAIN MENU"
        load('index.rb')
    end
    system('clear')
end