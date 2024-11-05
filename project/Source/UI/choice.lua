local gfx = playdate.graphics
local snd = playdate.sound
Choice = {}

-- ===== Choice box =====
-- Parameters: title, choices table, number of columns (optional), callback (optional)
-- Example: Choice.show("Examine", {"Door", "Corridor","Window", "Floor", "Ceiling"} , 2, choiceSelected)

class("Choice").extends(gfx.sprite)

local DEFAULT_COLS = 2
local FONT_CHAR_WIDTH = 10
local PADDING_LEFT = 25
local CURSOR_PADDING = 6

-- GLobals
local _enabled = false
local _title
_menuChoiceIndex = 1
_submenuChoiceIndex = 1
local _choices
local _cols = DEFAULT_COLS
local _callback

function drawChoiceBackground()
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 180, 400, 240)
end

function drawMarquee()
    gfx.setColor(gfx.kColorWhite)
	gfx.drawLine(0, 180, 400, 180)
	gfx.drawLine(0, 180, 0, 240)
	gfx.drawLine(399, 180, 399, 240)
	gfx.drawLine(0, 239, 400, 239)
end

function drawTitle(text)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0, 150, 80, 30)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText(text, 5, 155)
end

local function getRowContents(choices, index, cols)
    local firstOfRow = math.floor((index - 1) / cols) * cols + 1
    local row = {}
    for i = firstOfRow, math.min(firstOfRow + cols - 1, #choices) do
        table.insert(row, choices[i])
    end
    return row
end

local function findLongestWord(choices)
    if choices == nil then 
        return 0
    end

    local longestWord = 0
    for i=1, #choices do
        local choiceLength = #choices[i]
        if (choiceLength > longestWord) then
            longestWord = choiceLength
        end
    end

    return longestWord
end

function drawChoices(index, choices)
    local rowTop = getRowContents(choices, index, _cols)
    local rowBottom = getRowContents(choices, index + 2, _cols)
    local longestWord = math.max( findLongestWord(rowTop), findLongestWord(rowBottom))

    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    if rowTop then
        for i = 1, #rowTop do
            gfx.drawText(rowTop[i], PADDING_LEFT + longestWord * ((i -1)) * FONT_CHAR_WIDTH, 190)
        end
    end

    if rowBottom then
        for i = 1, #rowBottom do
            gfx.drawText(rowBottom[i], PADDING_LEFT + longestWord * ((i -1)) * FONT_CHAR_WIDTH, 210)
        end
    end

    return longestWord

end

local function drawCursor(index, cols, longestWord) 
    local i = math.fmod( index - 1, cols )
    local x = CURSOR_PADDING + i * longestWord * FONT_CHAR_WIDTH
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(x, 193, 2, 10)
    gfx.fillRect(x+2, 194, 2, 8)
    gfx.fillRect(x+4, 195, 2, 6)
    gfx.fillRect(x+6, 196, 2, 4)
    gfx.fillRect(x+8, 197, 2, 2)
end

function Choice.show(title, choices, cols, callback)
    _choices = choices
    _title = title

    if (cols) then
        _cols = cols
    end

    if (callback) then
        print(callback)
        _callback = callback
    end

    _enabled = true
end


function Choice.update()
    if (not _enabled) then
        return
    end

    -- Input
    if isSubmenuOpen then
        if playdate.buttonJustPressed("up") then
            if _submenuChoiceIndex > 2 then
                _submenuChoiceIndex -= _cols
            end
        elseif playdate.buttonJustPressed("down") then
            if _submenuChoiceIndex < (#_choices - 1) then
                _submenuChoiceIndex += _cols
            end
        elseif playdate.buttonJustPressed("left") then
            if _submenuChoiceIndex > 1 then
                _submenuChoiceIndex -= 1
            end
        elseif playdate.buttonJustPressed("right") then
            if _submenuChoiceIndex < #_choices then
                _submenuChoiceIndex += 1
            end
        elseif playdate.buttonJustPressed("a") then
            _enabled = false
            if _callback then _callback(_menuChoiceIndex) end
        elseif playdate.buttonJustPressed("b") then
            _enabled = false
        end
    end
    if not isSubmenuOpen then
        if playdate.buttonJustPressed("up") then
            if _menuChoiceIndex > 2 then
                _menuChoiceIndex -= _cols
            end
        elseif playdate.buttonJustPressed("down") then
            if _menuChoiceIndex < (#_choices - 1) then
                _menuChoiceIndex += _cols
            end
        elseif playdate.buttonJustPressed("left") then
            if _menuChoiceIndex > 1 then
                _menuChoiceIndex -= 1
            end
        elseif playdate.buttonJustPressed("right") then
            if _menuChoiceIndex < #_choices then
                _menuChoiceIndex += 1
            end
        elseif playdate.buttonJustPressed("a") then
            _enabled = false
            if _callback then _callback(_menuChoiceIndex) end
        end
    end

    -- Render
    drawChoiceBackground()
    drawMarquee()
    if _title then drawTitle(_title) end

    if isSubmenuOpen then
        local longestWord = drawChoices(_submenuChoiceIndex, _choices)
        drawCursor(_submenuChoiceIndex, _cols, longestWord)
    end
    if not isSubmenuOpen then
        local longestWord = drawChoices(_menuChoiceIndex, _choices)
        drawCursor(_menuChoiceIndex, _cols, longestWord)
    end
    -- drawScrollIndicators(_menuChoiceIndex, choices) // TO DO
end