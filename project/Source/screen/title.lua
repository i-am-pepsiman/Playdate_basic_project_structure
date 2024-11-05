TITLE_SCREEN = 'TitleScreen'

class(TITLE_SCREEN).extends(Screen)

-- Screen lifecycle

function TitleScreen:init()
    TitleScreen.super.init(self)
end

function TitleScreen:onAppear()
end

function TitleScreen:onDisappear()
end

function TitleScreen:update()
    if playdate.buttonJustReleased('a') or playdate.buttonJustReleased('b') then
        global.onChangeScreen(EXPLORE_SCREEN, 1)
    end
end
