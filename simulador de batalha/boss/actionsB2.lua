local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- concentra energia e da um disparo no oponente
    local meteoricAttack = {
        description = "concentra sua energia e da um disparo no oponente",
        requirement = nil,

        execute = function(player2Data, creature2Data)
            -- definir chance de sucesso
            local sucessChance = player2Data.speed == 0 and 1 or creature2Data.speed / player2Data.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = creature2Data.attack - math.random() * player2Data.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                player2Data.health = player2Data.health - damage

                print (string.format("%s usou um poderoso ataque de energia e causou %d de dano a %s", creature2Data.name, damage , player2Data.name))
                local healthRate = math.floor((player2Data.health / player2Data.maxHealth) * 10)
                print(string.format("%s: %s", player2Data.name, utils.getProgressBar(healthRate)))
            else
                print (string.format("%s estava sem energia",creature2Data.name))
            end
        end
    }
    
   -- explode uma grande area
   local collapsingStarAttack = {
    description = "concentra toda sua energia em um ataque só",
    requirement = nil,

    execute = function(player2Data, creature2Data)
        
        -- calcular o dano
        local rawDamage = creature2Data.attack - math.random() * player2Data.defense
        -- arredonda o numero para cima
        local damage = math.max(1, math.ceil(rawDamage * 0.3))
        -- resultado em print
        
            player2Data.health = player2Data.health - damage

            print (string.format("%s se explodiu e causou %d de dano a %s", creature2Data.name, damage , player2Data.name))
            local healthRate = math.floor((player2Data.health / player2Data.maxHealth) * 10)
            print(string.format("%s: %s", player2Data.name, utils.getProgressBar(healthRate)))
    
    end
}

 -- fica parado
 local waitAction = {
    description = "decide ver o que o jogador vai fazer",
    requirement = nil,

    execute = function(player2Data, creature2Data)
        
        -- resultado em print

            print (string.format("%s decidiu ver a ação do jogador e não fez nada. ", creature2Data.name))
    end
}


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = meteoricAttack
    actions.list[#actions.list+1] = collapsingStarAttack
    actions.list[#actions.list+1] = waitAction
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