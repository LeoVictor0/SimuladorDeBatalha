local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- solta uma ki blast
    local kiAttack = {
        description = "solta um poderoso ki blast",
        requirement = nil,

        execute = function(player1Data, creature1Data)
            -- definir chance de sucesso
            local sucessChance = player1Data.speed == 0 and 1 or creature1Data.speed / player1Data.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = creature1Data.attack - math.random() * player1Data.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                player1Data.health = player1Data.health - damage

                print (string.format("%s usou um poderoso ataque de ki e causou %d de dano a %s", creature1Data.name, damage , player1Data.name))
                local healthRate = math.floor((player1Data.health / player1Data.maxHealth) * 10)
                print(string.format("%s: %s", player1Data.name, utils.getProgressBar(healthRate)))
            else
                print (string.format("%s nao tinha ki suficiente para atacar",creature1Data.name))
            end
        end
    }
    
   -- explode uma grande area
   local explodingAttack = {
    description = "explode tudo a sua volta",
    requirement = nil,

    execute = function(player1Data, creature1Data)
        
        -- calcular o dano
        local rawDamage = creature1Data.attack - math.random() * player1Data.defense
        -- arredonda o numero para cima
        local damage = math.max(1, math.ceil(rawDamage * 0.3))
        -- resultado em print
        
            player1Data.health = player1Data.health - damage

            print (string.format("%s se explodiu e causou %d de dano a %s", creature1Data.name, damage , player1Data.name))
            local healthRate = math.floor((player1Data.health / player1Data.maxHealth) * 10)
            print(string.format("%s: %s", player1Data.name, utils.getProgressBar(healthRate)))
    
    end
}

 -- fica parado
 local waitAction = {
    description = "decide ver o que o jogador vai fazer",
    requirement = nil,

    execute = function(player1Data, creature1Data)
        
        -- resultado em print

            print (string.format("%s decidiu ver a ação do jogador e não fez nada. ", creature1Data.name))
    end
}


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = kiAttack
    actions.list[#actions.list+1] = explodingAttack
    actions.list[#actions.list+1] = waitAction
end
-- retorna uma lista de ações validas
function actions.getValidActions(player1Data, creature1Data)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(player1Data)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions

end

return actions