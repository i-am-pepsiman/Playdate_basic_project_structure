EXPLORE_SCREEN = 'ExploreScreen'

class(EXPLORE_SCREEN).extends(Screen)

function openDialog()
    isDialogOpen = true
end

function endDialog()
    isDialogOpen = false
end

-- Screen lifecycle

function ExploreScreen:init()
	ExploreScreen.super.init(self)
end

function ExploreScreen:onAppear()
end

function ExploreScreen:onDisappear()
end

function ExploreScreen:update()
    Message.update()
end

function aButtonPressed()
end

function bButtonPressed()
end
