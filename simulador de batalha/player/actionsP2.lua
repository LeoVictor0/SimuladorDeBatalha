local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- soltar um soco sério
    local punchAttack = {
        description = "solta um soco sério",
        requirement = nil,

        execute = function(player2Data, creature2Data)
            -- definir chance de sucesso
            local sucessChance = creature2Data.speed == 0 and 1 or player2Data.speed / creature2Data.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = player2Data.attack - math.random() * creature2Data.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                creature2Data.health = creature2Data.health - damage

                print (string.format("Você deu um soco incrivelmente sério e deu %d de dano", damage))
                local healthRate = math.floor((creature2Data.health / creature2Data.maxHealth) * 10)
                print(string.format("%s: %s", creature2Data.name, utils.getProgressBar(healthRate)))
            else
                print("Você não estava tão serio.")
            end
        end
    }
    
    -- respirar normalmente = recuperar vida
    local Breathe = {
        description = "Respira calmamente",
        requirement = function (player2Data)
            return player2Data.Breath and player2Data.Breath >= 1
        end,
        execute = function (player2Data)
            -- respira 
            player2Data.Breath = player2Data.Breath - 1
            -- recupera vida
            local regenPoints = 5
            player2Data.health = math.min(player2Data.maxHealth,player2Data.health + regenPoints)
            print("você respirou calmamente e recuperou vida.")
        end
        
    }


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = punchAttack
    actions.list[#actions.list+1] = Breathe
end
-- retorna uma lista de ações validas
function actions.getValidActions(player2Data, creature2Data)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(player2Data)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions

end

return actions