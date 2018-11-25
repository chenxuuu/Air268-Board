--按键测试app
module(..., package.seeall)

function getName()
    return "声音测试"
end

local id
local function exit()
    uiWin.remove(id)
end

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
            elseif value == 0 and key == "red" then
                audio.play(TTS,"TTS","语音测试",nvm.get("vol"))
            elseif value == 0 and key == "yellow" then
                tools.music("poweron.mp3")
            end
            uiWin.update()
        end
    })
end
