local utils = {}
---habilita o UTF-8 no terminal
function utils.enableUtf8()
    os.execute("chcp 65001")
end


---faz o print da simulação
function utils.printHeader()
    print([[
==================================================================================================
           /\                                                                 /\
 _         )( ______________________                   ______________________ )(         _
(_)///////(**)______________________>BATTLE SIMULATOR <______________________(**)\\\\\\\(_)
           )(                                                                 )(
           \/                                                                 \/
==================================================================================================

                      ⚔pegue sua espada e se prepare para a luta!!!⚔
]]) 
end

function utils.getProgressBar(Attribute)
    local FullChar = "⬛"
    local EmptyChar = "⬜"
    local result = ""
    for i = 1, 10, 1 do
        if i <= Attribute then
            result = result .. FullChar
        else 
            result = result .. EmptyChar
            
        end
        
        
    end
    return result
end


function utils.printBoss(creature)
-- calculo da taxa de vida
    local healthRate = math.floor((creature.health / creature.maxHealth) * 10)
--cartão


    print("| " .. creature.name)
    print("|")
    print("|" .. creature.description)
    print("|")
    print("| Atributos:")
    print("|     Vida:        " .. utils.getProgressBar(healthRate))
    print("|     Ataque:      " .. utils.getProgressBar(creature.attack)) 
    print("|     Defesa:      " .. utils.getProgressBar(creature.defense))
    print("|     Velocidade:  " .. utils.getProgressBar(creature.speed))


          
end

-- para definir a escolha do player
function utils.choicePlayer(playerChoice)
    local choice = io.read() 

if choice == "1" then
    return 1
elseif choice == "2" then
    return 2
elseif choice == "3" then
    return 3
else
    print("Escolha inválida. Tente novamente.")
end
    
end

-- pergunta ao usuario por um numero que é retornado pela função 
function utils.ask()
    io.write("> ")
    local answer = io.read("*n")
    return answer
    

end




return utils

