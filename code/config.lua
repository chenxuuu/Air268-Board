module(...)

--音量，0-7
vol = 3

--软件列表与代码
apps = {
    "test1",[[]],
    "test2",[[
module(..., package.seeall)

log.info("test2","initial ok")

function getName()
    return "test2"
end

function test2()
    log.info("test2222222222")
end
]],
"test3",[[
    module(..., package.seeall)

    log.info("test3","initial ok")

    function getName()
        return "test3"
    end

    function test3()
        log.info("test33333333333")
    end
    ]],
    "test4",[[
        module(..., package.seeall)

        log.info("test4","initial ok")

        function getName()
            return "test4"
        end

        function test4()
            log.info("test44444444444")
        end
        ]],
        "test5",[[
            module(..., package.seeall)

            log.info("test5","initial ok")

            function getName()
                return "test5"
            end

            function test5()
                log.info("test555555555555")
            end
            ]],
}
