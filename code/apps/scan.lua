--按键测试app
module(..., package.seeall)
require"scanCode"

function getName()
    return "扫码测试"
end

local id
local function exit()
    uiWin.remove(id)
end

local mode,result,codeType,codeStr

function load()
    mode = "preview"
    id = uiWin.add({
        onUpdate = function ()
            if mode == "preview" then
                --唤醒系统
                pm.wake("testScanCode")
                --设置扫码回调函数，默认10秒超时
                scanCode.request(function (r,ct,cs)
                    log.info("scan",r,ct,cs)
                    --关闭摄像头预览
                    disp.camerapreviewclose()
                    --关闭摄像头
                    disp.cameraclose()
                    --允许系统休眠
                    pm.sleep("testScanCode")
                    result,codeType,codeStr = r,ct,cs
                    mode = "show"
                    uiWin.update()
                end)
                --打开摄像头
                disp.cameraopen(1,1,0)
                --打开摄像头预览
                disp.camerapreview(0,0,0,0,160,128)
            elseif mode == "show" then
                disp.clear()
                if result then
                    disp.puttext(common.utf8ToGb2312("扫描成功"),0,5)
                    disp.puttext(common.utf8ToGb2312("类型：")..codeType,0,35)
                    log.info("scanCodeCb",codeStr:toHex())
                    disp.puttext(common.utf8ToGb2312("结果：")..codeStr,0,65)
                else
                    disp.puttext(common.utf8ToGb2312("扫描失败"),0,5)
                end
                disp.update()
            end
        end,
        onKey = function (key,value)
            if value == 0 and key == "red" then
                --关闭摄像头预览
                disp.camerapreviewclose()
                --关闭摄像头
                disp.cameraclose()
                --允许系统休眠
                pm.sleep("testTakePhoto")
                exit()
                mode,result,codeType,codeStr = nil,nil,nil,nil--清除变量
                return
            elseif value == 0 and key == "green" then
                if mode == "show" then
                    mode = "preview"
                end
                uiWin.update()
            end
        end
    })
end

