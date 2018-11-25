--按键测试app
module(..., package.seeall)

function getName()
    return "按键测试"
end

local lastdownkey = "无按键"
local lastupkey = "无按键"
function load()
    uiWin.add({
        onUpdate = function ()
            disp.clear()
            tools.puttext("按键测试，结果会在下方显示，退出需重启", 0,0)
            tools.puttext("上次按下："..lastdownkey, 0,33)
            tools.puttext("上次弹起："..lastupkey, 0,49)
            disp.update()
        end,
        onKey = function (key,value)
            if value == 0 then
                lastdownkey = key
            else
                lastupkey = key
            end
            uiWin.update()
        end
    })
end
