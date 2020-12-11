# require_relative 'arena.rb'
# require_relative 'player.rb'
# require_relative 'enemy.rb'

class Dice
    def initialize(prompt)
        @prompt = prompt
    end

    def roll(dice)
        result = rand(dice[0])
        return result
    end

    def advantage(dice)
        score1 = dice(0)
        score2 = dice(0)
        if score1 >= score2
            return score1
        else
            return score2
        end
    end

    def disadvantage(dice)
        score1 = dice(0)
        score2 = dice(0)
        if score1 >= score2
            return score2
        else
            return score1
        end
    end

    def critical_hit(dice)
        if dice[0] = CRITICAL_HIT
            return true
        else
            return false
        end
    end
    
end