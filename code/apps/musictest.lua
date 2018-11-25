--按键测试app
module(..., package.seeall)

function getName()
    return "声音测试"
end

local id
local function exit()
    uiWin.remove(id)
end

local playlock = false
function load()
    id = uiWin.add({
        onUpdate = function ()
            disp.clear()
            tools.puttext("声音测试：", 0,0)
            tools.puttext("黄键播放mp3", 0,17)
            tools.puttext("红键播放tts", 0,33)
            disp.update()
        end,
        onKey = function (key,value)
            if value == 0 and key == "green" then
                exit()
                return
            elseif value == 0 and key == "red" and not playlock then
                playlock = true
                audio.play(TTS,"TTS","语音测试",nvm.get("vol"),function ()
                    playlock = false
                end)
            elseif value == 0 and key == "yellow" and not playlock then
                playlock = true
                tools.music("poweron.mp3",false,function ()
                    playlock = false
                end)
            end
            uiWin.update()
        end
    })
end
