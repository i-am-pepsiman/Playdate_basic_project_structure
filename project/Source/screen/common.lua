local pd = playdate
local gfx = pd.graphics

function fillTable(tableToFill, content)
    local keys = {}
    for key in pairs(content) do
        table.insert(keys, key)
    end
    table.sort(keys)
    
    for _, key in ipairs(keys) do
        table.insert(tableToFill, content[key])
    end
    print('Filled table results are: ' .. json.encodePretty(tableToFill))
end

function clearScreen(color) -- use gfx.kColorBlack or gfx.kColorWhite
	gfx.setColor(color)
    gfx.fillRect(0, 0, 400, 240)
end

function drawBackground(path, color)
	gfx.setBackgroundColor(color)

	local backgroundImage = gfx.image.new(path)
	local backgroundSprite = gfx.sprite.new(backgroundImage)	
	backgroundSprite:moveTo(200, 120)
	backgroundSprite:add()

	return backgroundSprite
end

function setBgImg(imgName)
    local path = '/assets/img/bg/' .. imgName
    print("Using bgPath: ", path)
    drawBackground(path, gfx.kColorBlack)
end

function createTransitionSprite(color)
	local filledRect = gfx.image.new(400, 240, color)
	local transitionSprite = gfx.sprite.new(filledRect)
	transitionSprite:moveTo(200, 120)
	transitionSprite:add()
	return transitionSprite
end

function wipeTransition(startValue, endValue, time, color)
	local transitionSprite = createTransitionSprite(color)
	transitionSprite:setClipRect(0, 0, startValue, 240)

	-- local transitionTime = time -- Less lengthier now for testing purposes
	local transitionTimer = pd.timer.new(time, startValue, endValue, pd.easingFunctions.inOutCubic)
	transitionTimer.updateCallback = function(timer)
		transitionSprite:setClipRect(0, 0, timer.value, 240)
	end
	return transitionTimer
end

function startScreenTransition(time, callback)
    local transitionTimer = wipeTransition(0, 400, time, gfx.kColorBlack)
    transitionTimer.timerEndedCallback = function()
        callback()
        transitionTimer = wipeTransition(400, 0, time, gfx.kColorBlack)
    end
end
