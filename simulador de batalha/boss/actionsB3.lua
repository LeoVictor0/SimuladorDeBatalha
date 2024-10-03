local utils = require "utils"
local actions = {}

actions.list = {}


function actions.build()
    actions.list = {}

    -- ataque de espada
    local swordAttack = {
        description = "saca sua espada rapidamente e golpeia o adversario",
        requirement = nil,

        execute = function(player3Data, creature3Data)
            -- definir chance de sucesso
            local sucessChance = player3Data.speed == 0 and 1 or creature3Data.speed / player3Data.speed
            local success = math.random() <= sucessChance

            -- calcular o dano
            local rawDamage = creature3Data.attack - math.random() * player3Data.defense
            -- arredonda o numero para cima
            local damage = math.max(1, math.ceil(rawDamage))
            -- resultado em print
            if success then 
                player3Data.health = player3Data.health - damage

                print (string.format("%s ao piscar de olhos sacou sua espada e causou %d de dano a %s", creature3Data.name, damage , player3Data.name))
                local healthRate = math.floor((player3Data.health / player3Data.maxHealth) * 10)
                print(string.format("%s: %s", player3Data.name, utils.getProgressBar(healthRate)))
            else
                print (string.format("%s errou o golpe",creature3Data.name))
            end
        end
    }
    
   -- dispara em varios lugares ao mesmo tempo
   local flashAttack = {
    description = "da varios cortes ao mesmo tempo",
    requirement = nil,

    execute = function(player3Data, creature3Data)
        
        -- calcular o dano
        local rawDamage = creature3Data.attack - math.random() * player3Data.defense
        -- arredonda o numero para cima
        local damage = math.max(1, math.ceil(rawDamage * 0.3))
        -- resultado em print
        
            player3Data.health = player3Data.health - damage

            print (string.format("%s deu varios golpes rapidos causou %d de dano a %s", creature3Data.name, damage , player3Data.name))
            local healthRate = math.floor((player3Data.health / player3Data.maxHealth) * 10)
            print(string.format("%s: %s", player3Data.name, utils.getProgressBar(healthRate)))
    
    end
}

 -- fica parado
 local waitAction = {
    description = "decide ver o que o jogador vai fazer",
    requirement = nil,

    execute = function(player3Data, creature3Data)
        
        -- resultado em print

            print (string.format("%s decidiu ver a ação do jogador e não fez nada. ", creature3Data.name))
    end
}


    --populate list . colocar a ação no final da lista 
    actions.list[#actions.list+1] = swordAttack
    actions.list[#actions.list+1] = flashAttack
    actions.list[#actions.list+1] = waitAction
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