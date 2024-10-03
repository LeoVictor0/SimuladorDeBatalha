local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- invocar sombras
    local ariseAttack = {
        description = "invoca exercito de sombras",
        requirement = nil,

        execute = function(player3Data, creature3Data)
            -- definir chance de sucesso
            local sucessChance = creature3Data.speed == 0 and 1 or player3Data.speed / creature3Data.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = player3Data.attack - math.random() * creature3Data.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                creature3Data.health = creature3Data.health - damage

                print (string.format("Você invocou todo seu exercito e deu %d de dano.", damage))
                local healthRate = math.floor((creature3Data.health / creature3Data.maxHealth) * 10)
                print(string.format("%s: %s", creature3Data.name, utils.getProgressBar(healthRate)))
            else
                print("Suas sombras não apareceram.")
            end
        end
    }
    
    -- manaRegen = recuperar vida
    local manaRegen = {
        description = "Recupera mana.",
        requirement = function (player3Data)
            return player3Data.mana and player3Data.mana >= 1
        end,
        execute = function (player3Data)
            -- usa mana 
            player3Data.mana = player3Data.mana - 1
            -- recupera vida
            local regenPoints = 5
            player3Data.health = math.min(player3Data.maxHealth,player3Data.health + regenPoints)
            print("você recuperou sua mana.")
        end
        
    }


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = ariseAttack
    actions.list[#actions.list+1] = manaRegen
end
-- retorna uma lista de ações validas
function actions.getValidActions(player3Data, creature3Data)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(player3Data)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions

end

return actions