--文件功能
--显示初始界面
module(..., package.seeall)
require"uiWin"
require"test1"

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
nvm.set("apps",apps)

--选中的app
local select = 1

sys.timerStart(uiWin.add,1500,
{
    --刷新画面
    onUpdate = function ()
        local apps = nvm.get("apps")
        --本页被选中的在第几个
        local selectNow = select % 4 == 0 and 4 or select % 4

        disp.clear()
        --绘制背景
        disp.drawrect(0,0,160,8,tools.rgb(112,128,144))
        disp.drawrect(0,9,160,38,tools.rgb(105,105,105))
        disp.drawrect(0,39,160,68,tools.rgb(120,120,120))
        disp.drawrect(0,69,160,98,tools.rgb(105,105,105))
        disp.drawrect(0,99,160,128,tools.rgb(120,120,120))

        --被选中的选项高亮
        disp.drawrect(0,9+(selectNow - 1) * 30,160,9+(selectNow - 1) * 30 + 29,tools.rgb(190,190,190))

        --显示app
        local start = (select-1)/4*4
        for i=start*2+1,start + 7,2 do
            local baseY = (i/2 % 4) * 30
            if io.exists("/ldata/"..apps[i]..".png") then
                disp.putimage("/ldata/"..apps[i]..".png",0,baseY + 9)
            else
                disp.drawrect(0,baseY + 9,30,baseY + 38,tools.rgb(0,255,127))
                disp.drawrect(1,baseY + 10,29,baseY + 37,tools.rgb(0,191,255))
                tools.putatext(_G[apps[i]].getName(), 7,baseY + 15)
            end
            tools.puttext(_G[apps[i]].getName(), 40,baseY + 15)
            if i == #apps - 1 then break end
        end

        disp.update()
    end,
    --按键处理
    onKey = function (key,value)
        if value == 1 then return end--不响应按键弹起的事件
        local apps = nvm.get("apps")

        if value == 0 and (key == "up" or key == "left") then
            select = select - 1
        elseif value == 0 and (key == "down" or key == "right") then
            select = select + 1
        end

        if select > #apps / 2 then
            select = 1
        elseif select <= 0 then
            select = #apps / 2
        end
        uiWin.update()
    end
})


