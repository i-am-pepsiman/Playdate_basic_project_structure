import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "assets/sound/global_sfx.lua"
import "screen/common"
import "./UI/message"
import "./UI/message"
import "./UI/choice"
import "screen/explore"
import "screen/title"
import "screen/screen_manager/screen_manager"
import "screen/helper_functions/helpers"
import "screen/menu_functions/menu_functions"
import "screen/cutscene_manager/cutscene_manager"

local pd = playdate
local gfx = playdate.graphics

-- Game screen management

function initGame()
    global.currentScreen = TitleScreen()
    global.currentScreen.onAppear()
end

function playdate.update()
    pd.timer.updateTimers()
    gfx.sprite.update()
    global.currentScreen.update()
end

initGame()
