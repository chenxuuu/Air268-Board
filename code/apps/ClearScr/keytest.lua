
module(..., package.seeall)

function getName()
return "按键测试"
end

function test1()
uiWin.add({
onUpdate = function ()
disp.clear()
tools.puttext("按键测试，结果会在下方显示", 0,0)
disp.update()
end,
onKey = function (key,value)
uiWin.update()
end
})
end
