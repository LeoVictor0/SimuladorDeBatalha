local player1 = require("player.player1")
local player2 = require("player.player2")
local player3 = require("player.player3")
local boss1 = require("boss.boss1")
local boss2 = require("boss.boss2")
local boss3 = require("boss.boss3")
local utils = require("utils")
local player1Actions = require("player.actionsP1")
local player2Actions = require("player.actionsP2")
local player3Actions = require("player.actionsP3")
local boss1Actions = require("boss.actionsB1")
local boss2Actions = require("boss.actionsB2")
local boss3Actions = require("boss.actionsB3")
local players, bosses


 



--habilitar o UTF-8
utils.enableUtf8()

--header 
utils.printHeader()

print (string.format("escolha seu personagem: 1 - %s 2 - %s 3 - %s ",player1.name , player2.name , player3.name ))

-- escolha do personagem
local playerChoice = utils.choicePlayer()  -- Chama a função de escolha

-- Condição de escolha do player
if playerChoice == 1 then 
    players = player1
    player1Actions.build()
    bosses = boss1
    boss1Actions.build()
elseif playerChoice == 2 then
    players = player2
    player2Actions.build()
    bosses = boss2
    boss2Actions.build()
elseif playerChoice == 3 then
    players = player3
    player3Actions.build()
    bosses = boss3
    boss3Actions.build()
end

-- print do cartão do boss escolhido
utils.printBoss(bosses)



-- começar loop de batalha
while true do
    

  -- mostrar ações do jogador
  print()
  print("--------------------------------------------------------------")
  print("O que você deseja fazer em seguida?")
  local validPlayerActions
  local validBossActions
  if playerChoice == 1 then
    validPlayerActions = player1Actions.getValidActions(players, bosses)
    validBossActions = boss1Actions.getValidActions(players,bosses)
elseif playerChoice == 2 then
    validPlayerActions = player2Actions.getValidActions(players, bosses)
    validBossActions = boss2Actions.getValidActions(players, bosses)
elseif playerChoice == 3 then
    validPlayerActions = player3Actions.getValidActions(players, bosses)
    validBossActions = boss3Actions.getValidActions(players, bosses)
end



  for i, action in pairs(validPlayerActions) do
    print(string.format("%d. %s", i, action.description))
  end

  local chosenIndex = utils.ask()
 local chosenAction = validPlayerActions[chosenIndex]
 local isActionValid = chosenAction ~= nil

  -- simular turno do jogador
  if isActionValid then
    chosenAction.execute(players, bosses)
  else
    print("Sua ação é invalida. Você perdeu a vez.")
  end

-- simular turno da criatura
print()
local bossAction = validBossActions[math.random(#validBossActions)]
bossAction.execute(players, bosses)

--ponto de saida : criatura ficou sem vida 
if bosses.health <= 0 then
  print (string.format("%s derrotou %s e alcançou a vitoria.", players.name , bosses.name))
  break
end

--ponto de saida : jogador ficou sem vida
if players.health <= 0 then
  print (string.format("%s derrotou %s e destruiu o mundo.", bosses.name, players.name))
  break
end












end
