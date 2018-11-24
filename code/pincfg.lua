require"pins"
module(..., package.seeall)

function upFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","up")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","up")
    end
end

function downFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","down")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","down")
    end
end

function leftFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","left")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","left")
    end
end

function rightFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","right")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","right")
    end
end

function okFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","ok")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","ok")
    end
end

function yellowFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","yellow")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","yellow")
    end
end

function blueFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","blue")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","blue")
    end
end

function greenFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","green")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","green")
    end
end

function redFnc(msg)
    --上升沿中断
    if msg==cpu.INT_GPIO_POSEDGE then
        sys.publish("KEY_UP","red")
    --下降沿中断
    else
        sys.publish("KEY_DOWN","red")
    end
end

up = pins.setup(pio.P0_29,upFnc)
down = pins.setup(pio.P1_0,downFnc)
left = pins.setup(pio.P0_31,leftFnc)
right = pins.setup(pio.P0_30,rightFnc)
ok = pins.setup(pio.P1_1,okFnc)
yellow = pins.setup(pio.P0_0,yellowFnc)
blue = pins.setup(pio.P0_1,blueFnc)
green = pins.setup(pio.P0_3,greenFnc)
red = pins.setup(pio.P0_2,redFnc)

sys.taskInit(function ()
    pio.pin.setpull(pio.PULLUP,pio.P0_29)
    log.info("key initial","up")
    pio.pin.setpull(pio.PULLUP,pio.P1_0)
    log.info("key initial","down")
    pio.pin.setpull(pio.PULLUP,pio.P0_31)
    log.info("key initial","left")
    pio.pin.setpull(pio.PULLUP,pio.P0_30)
    log.info("key initial","right")
    --等等再初始化gpio，不然会崩溃
    sys.wait(500)
    pio.pin.setpull(pio.PULLUP,pio.P1_1)
    log.info("key initial","ok")
    pio.pin.setpull(pio.PULLUP,pio.P0_0)
    log.info("key initial","yellow")
    pio.pin.setpull(pio.PULLUP,pio.P0_1)
    log.info("key initial","blue")
    pio.pin.setpull(pio.PULLUP,pio.P0_3)
    log.info("key initial","green")
    sys.wait(500)
    pio.pin.setpull(pio.PULLUP,pio.P0_2)
    log.info("key initial","red")
    sys.wait(1000)
    --订阅按键事件
    sys.subscribe("KEY_UP",function (s)
        log.info("key _/^^\\_",s)
    end)
    sys.subscribe("KEY_DOWN",function (s)
        log.info("key --\\__/-",s)
    end)
end)




