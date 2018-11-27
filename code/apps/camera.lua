--按键测试app
module(..., package.seeall)

function getName()
    return "摄像头测试"
end

local id
local function exit()
    uiWin.remove(id)
end

local mode

function load()
    mode = "preview"
    id = uiWin.add({
        onUpdate = function ()
            if mode == "preview" then
                --唤醒系统
                pm.wake("testTakePhoto")
                --打开摄像头
                disp.cameraopen(1)
                disp.camerapreview(0,0,0,0,160,128)
            elseif mode == "show" then
                disp.clear()
                disp.putimage("/testCamera.jpg",0,0)
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
                mode = nil--清除变量
                return
            elseif value == 0 and key == "green" then
                if mode == "preview" then
                    --设置照片的宽和高像素并且开始拍照
                    --此处设置的宽和高和预览时的保持一致
                    disp.cameracapture(160,128)
                    --设置照片保存路径
                    disp.camerasavephoto("/testCamera.jpg")
                    log.info("testCamera.takePhoto fileSize",io.fileSize("/testCamera.jpg"))
                    --关闭摄像头预览
                    disp.camerapreviewclose()
                    --关闭摄像头
                    disp.cameraclose()
                    --允许系统休眠
                    pm.sleep("testTakePhoto")
                    mode = "show"
                elseif mode == "show" then
                    mode = "preview"
                end
                uiWin.update()
            end
        end
    })
end

