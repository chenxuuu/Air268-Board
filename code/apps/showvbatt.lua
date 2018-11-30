--按键测试app
module(..., package.seeall)

function getName()
    return "电池信息"
end

local id
local function exit()
    uiWin.remove(id)
end

function load()
    id = uiWin.add({
        onUpdate = function ()
            disp.clear()
            tools.puttext("电池信息：", 0,0)
            tools.puttext(misc.getVbatt().."mV，"..(pincfg.charge() == 0 and "充电中" or "未在充电"), 0,17)
            tools.puttext("按绿色键刷新", 0,33)
            disp.update()
        end,
        onKey = function (key,value)
            if value == 0 and key == "red" then
                exit()
                return
            elseif value == 0 and key == "green" then
                uiWin.update()
            end
        end
    })
end

