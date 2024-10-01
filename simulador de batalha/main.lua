local player1 = require("definitions.player1")

local player2 = require("definitions.player2")

local player3 = require("definitions.player3")

local boss1 = require("definitions.boss1")

local boss2 = require("definitions.boss2")

local boss3 = require("definitions.boss3")




--habilitar o UTF-8
os.execute("chcp 65001")

--header 
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

print (string.format("um terrivel inimigo assusta a todos com seu poderoso ki , seu nome é : %s",boss1.name))

