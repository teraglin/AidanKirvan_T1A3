d4 = [1..4]
d6 = [1..6]
d8 = [1..8]
d10 = [1..10]
d12 = [1.. 2]
d100 = [1..100]
d20 = [1..20]

CRITICAL_HIT = 20

def roll(dice)
    result = rand(dice[0])
    return result
end

puts roll(d20)
class dice

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