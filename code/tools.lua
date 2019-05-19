require"audio"
require"nvm"
module(..., package.seeall)

--设置优先级相同时的播放策略，1表示停止当前播放，播放新的播放请求
audio.setStrategy(1)

--播放声音
--file 声音文件
--replay 是否循环播放
function music(file,replay,cb)
    log.info("play music",file,replay,nvm.get("vol"))
    audio.play(0,"FILE","/ldata/"..file,nvm.get("vol"),cb,replay)
end

--播放tts
function tts(text)
    log.info("play tts",text,nvm.get("vol"))
    audio.play(0,"TTS",text,nvm.get("vol"))
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


