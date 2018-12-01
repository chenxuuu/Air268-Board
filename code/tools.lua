require"audio"
require"nvm"
module(..., package.seeall)

--播放声音
--file 声音文件
--replay 是否循环播放
function music(file,replay,cb)
    audio.stop()
    log.info("play music",file,replay,nvm.get("vol"))
    audio.play(0,"FILE","/ldata/"..file,nvm.get("vol"),cb,replay)
    sys.taskInit(function ()
        local result = sys.waitUntil("AUDIO_PLAY_END",300)
        if result then
            audio.play(0,"FILE","/ldata/"..file,nvm.get("vol"),cb,replay)
        end
    end)
end

--播放tts
function tts(text)
    audio.stop()
    log.info("play tts",text,nvm.get("vol"))
    audio.play(0,"TTS",text,nvm.get("vol"))
    sys.taskInit(function ()
        local result = sys.waitUntil("AUDIO_PLAY_END",300)
        if result then
            sys.wait(200)
            audio.play(0,"TTS",text,nvm.get("vol"))
        end
    end)
end

--放置文字，自动转码
function puttext(s,x,y)
    disp.puttext(common.utf8ToGb2312(s),x,y)
end

--放置第一个字，自动转码
function putatext(s,x,y)
    disp.puttext(common.utf8ToGb2312(s):sub(1,2),x,y)
end

--rgb值转rgb565
function rgb(r,g,b)
    return r/8*2048 + g/4*32 + b/8
end


