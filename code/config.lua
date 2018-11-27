module(...)

--音量，0-7
vol = 1

--软件列表与代码
apps = {
    "keytest","",
    "qrcodetest","",
    "musictest","",
    "showvbatt","",
    "camera","",
    "scan","",
    "test1",[[
    module(..., package.seeall)
    function getName()
        return "测试1"
    end
    function load()
        log.info("load")
    end
    ]],
    "test2",[[
        module(..., package.seeall)
    function getName()
        return "测试2"
    end
    function load()
        log.info("load")
    end
    ]],
    "test3",[[
        module(..., package.seeall)
    function getName()
        return "测试3"
    end
    function load()
        log.info("load")
    end
    ]],
    "test4",[[
        module(..., package.seeall)
    function getName()
        return "测试4"
    end
    function load()
        log.info("load")
    end
    ]],
    "test5",[[
        module(..., package.seeall)
    function getName()
        return "测试5"
    end
    function load()
        log.info("load")
    end
    ]],
}
