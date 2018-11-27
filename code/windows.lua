--文件功能
--显示初始界面
module(..., package.seeall)
require"uiWin"
require"pm"

require"keytest"
require"qrcodetest"
require"musictest"
require"showvbatt"
require"camera"

--开机画面
disp.putimage("/ldata/poweron.png")
disp.update()
tools.music("poweron.mp3")

--加载各个app
local apps = nvm.get("apps")
for i=1,#apps,2 do
    if apps[i+1]:len() > 0 then
        if io.writeFile("/lua/"..apps[i]..".lua",apps[i+1]) then
            apps[i+1] = ""
            require(apps[i])
        else
            log.error("windows","write file error!"..apps[i]..".lua")
        end
    end
end
--nvm.set("apps",apps)

--选中的app
local select = 1

local function selectOne(c)
    local appsNow = nvm.get("apps")
    select = select + c
    if select > #appsNow / 2 then
        select = 1
    elseif select <= 0 then
        select = #appsNow / 2
    end
end

local function selectPage(c)
    local appsNow = nvm.get("apps")
    select = select + c
    if select > #appsNow / 2 then
        select = #appsNow / 2
    elseif select <= 0 then
        select = 1
    end
end

sys.timerStart(uiWin.add,1500,
{
    --刷新画面
    onUpdate = function ()
        local apps = nvm.get("apps")
        --本页被选中的在第几个
        local selectNow = select % 4 == 0 and 4 or select % 4

        disp.clear()
        --绘制背景
        disp.drawrect(0,0,159,7,tools.rgb(112,128,144))
        --绘制进度条
        disp.drawrect(0,0,16*(select*20/#apps)-1,7,tools.rgb(0,255,255))
        --绘制列表
        disp.drawrect(0,8,159,37,tools.rgb(105,105,105))
        disp.drawrect(0,38,159,67,tools.rgb(120,120,120))
        disp.drawrect(0,68,159,97,tools.rgb(105,105,105))
        disp.drawrect(0,98,159,127,tools.rgb(120,120,120))

        --被选中的选项高亮
        disp.drawrect(0,8+(selectNow - 1) * 30,159,(selectNow - 1) * 30 + 37,tools.rgb(190,190,190))

        --显示app
        local start = (select-1)/4*4
        for i=start*2+1,start*2+8,2 do
            local baseY = (i/2 % 4) * 30
            if io.exists("/ldata/"..apps[i]..".png") then
                disp.putimage("/ldata/"..apps[i]..".png",0,baseY + 8)
            else
                disp.putimage("/ldata/default.png",0,baseY + 8)
            end
            tools.puttext(_G[apps[i]].getName(), 40,baseY + 15)
            if i == #apps - 1 then break end
        end

        disp.update()
    end,
    --按键处理
    onKey = function (key,value)
        if value == 1 then return end--不响应按键弹起的事件

        if value == 0 and key == "up"then
            selectOne(-1)
        elseif value == 0 and key == "left"then
            selectPage(-4)
        elseif value == 0 and key == "down" then
            selectOne(1)
        elseif value == 0 and key == "right"then
            selectPage(4)
        elseif value == 0 and (key == "ok" or key == "green") then
            _G[apps[select*2-1]].load()
            return
        end

        uiWin.update()
    end
})


