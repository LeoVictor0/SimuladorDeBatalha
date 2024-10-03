local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- soltar kamehameha
    local kameAttack = {
        description = "solta um kamehameha",
        requirement = nil,

        execute = function(playerData, creatureData)
            -- definir chance de sucesso
            local sucessChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = playerData.attack - math.random() * creatureData.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                creatureData.health = creatureData.health - damage

                print (string.format("você acertou um kamehameha perfeito e deu %d de dano", damage))
                local healthRate = math.floor((creatureData.health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgressBar(healthRate)))
            else
                print("você não tinha ki suficiente")
            end
        end
    }
    
    -- carregar o ki = recuperar vida
    local kiCharge = {
        description = "carrega seu ki ao maximo",
        requirement = function (playerData, creatureData)
            return playerData.kiBase >= 1
        end,
        execute = function (playerData, creatureData)
            -- carrega ki 
            playerData.kiBase = playerData.kiBase - 1
            -- recupera vida
            local regenPoints = 5
            playerData.health = math.min(playerData.maxHealth,playerData.health + regenPoints)
            print("você carregou seu ki e recuperou vida.")
        end
        
    }


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = kameAttack
    actions.list[#actions.list+1] = kiCharge
end
-- retorna uma lista de ações validas
function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions

end

return actions