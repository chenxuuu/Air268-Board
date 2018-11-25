--按键测试app
module(..., package.seeall)

function getName()
    return "二维码显示测试"
end

local id
local function exit()
    uiWin.remove(id)
end

function load()
    id = uiWin.add({
        onUpdate = function ()
            disp.clear()
            tools.puttext("二维码测试：", 0,0)
            local width, data = qrencode.encode("imei:"..misc.getImei())
            disp.putqrcode(data, width, 100, 37, 30)
            disp.update()
        end,
        onKey = function (key,value)
            if value == 0 and key == "green" then
                exit()
                return
            end
            uiWin.update()
        end
    })
end

