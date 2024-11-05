PLAY_CUTSCENE = 'PlayCutscene'

local gfx = playdate.graphics

class(PLAY_CUTSCENE).extends(Screen)

isOnCutscene = false

function PlayCutscene:init(cutsceneId)
    PlayCutscene.super.init(self)
    isOnCutscene = true

    cutscenesData = parseJsonToTable('/assets/data/cutscenes/cutscenes.json')
    currentCutscene = findElementInTableByID(cutscenesData, cutsceneId)

    local cutsceneTransitionTime = 2000 -- Adjust time here

    print("Has cutscene: " .. cutsceneId)
    createTransitionSprite(gfx.kColorBlack)
    startScreenTransition(cutsceneTransitionTime, function ()
        openDialog(currentCutscene.bg_img)
        Message.show({currentCutscene.dialog}, nil, function ()
            
            print("End of cutscene")
            startScreenTransition(cutsceneTransitionTime, function ()
                endDialog(currentExploreScreen.bg_img)
                isOnCutscene = false
            end)
        end)
    end)
end

function PlayCutscene:onAppear() 
end

function PlayCutscene:onDisappear()
end

function PlayCutscene:update()
end