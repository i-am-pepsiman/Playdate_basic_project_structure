import "pdfxr.lua"

sfx = {
    playTyping = function()
        local num = math.random(1, 3)
        pdfxr.synth.new('assets/sound/fx/type'..num):play()
    end,
    
    playConfirm = function () 
        pdfxr.synth.new('assets/sound/fx/confirm3'):play()
    end,
    
    playCancel = function ()
        pdfxr.synth.new('assets/sound/fx/cancel3'):play()
    end,
    
    playOptionSelect = function ()
        pdfxr.synth.new('assets/sound/fx/option_select1'):play()
    end,
    
    playWalk = function ()
        pdfxr.synth.new('assets/sound/fx/walk1'):play()
    end,
    
    playFinalBlow = function ()
        pdfxr.synth.new('assets/sound/fx/final_blow2'):play()
    end,
    
    playJump = function ()
        pdfxr.synth.new('assets/sound/fx/jump1'):play()
    end,
    
    playLongFall = function ()
        pdfxr.synth.new('assets/sound/fx/long_fall1'):play()
    end
}
