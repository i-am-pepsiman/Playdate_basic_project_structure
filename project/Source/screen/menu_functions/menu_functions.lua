--[[ Variables ]]
local gfx = playdate.graphics

--[[ Functions ]]
function drawMenu(choiceBoxTitle, menuTable)
    --[[ if #MENU_TEXTS < 1 then
        fillTable(MENU_TEXTS, menuTable)
    end ]]

    Choice.show(choiceBoxTitle, MENU_TEXTS)
end

function drawSubMenu(choiceBoxTitle, submenuTable)
    --[[ if #SUBMENU_TEXTS < 1 then
    end ]]

    Choice.show(choiceBoxTitle, SUBMENU_TEXTS)
end

--[[ function clearMenu()
    isMenuOpen = false
end ]]

--[[ function clearSubMenu()
    isSubmenuOpen = false
end ]]


function updateInput()
    if playdate.buttonJustPressed("a") then
        aButtonPressed()
    end

    if playdate.buttonJustPressed("b") then
        bButtonPressed()
    end
end
