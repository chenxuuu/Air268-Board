--按键测试app
module(..., package.seeall)

function getName()
    return "按键测试"
end

local lastdownkey = "无按键"
local lastupkey = "无按键"
local count = 0
local id
local function exit()
    uiWin.remove(id)
end

function load()
    lastdownkey = "无按键"
    lastupkey = "无按键"
    count = 0
    id = uiWin.add({
        onUpdate = function ()
            disp.clear()
            tools.puttext("按键测试，结果会在下方显示", 0,0)
            tools.puttext("上次按下："..lastdownkey, 0,33)
            tools.puttext("上次弹起："..lastupkey, 0,49)
            tools.puttext("按十次退出键退出", 0,80)
            disp.update()
        end,
        onKey = function (key,value)
            if value == 0 then
                lastdownkey = key
                if key == "red" then
                    count = count + 1
                    if count == 10 then
                        exit()
                        return
                    end
                end
            else
                lastupkey = key
            end
            uiWin.update()
        end
    })
end
