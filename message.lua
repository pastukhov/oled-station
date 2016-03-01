return function (data)
    local msg = cjson.decode(data)    
    local string = ""
    local strCoords = {}
    strCoords[1] = {x=32,y=30}
    strCoords[2] = {x=32,y=46}
    strCoords[3] = {x=7, y=60} 
    msg.text = {}
    local icon = ""
    local title = ""
    if msg.icon  ~= nil then
        msg.icon = arr2str(msg.icon) 
    else
        msg.icon = ''
    end
    if msg.title ~= nil then
        msg.title = arr2str(msg.title) 
    else
        msg.title = ''
    end

    if msg.desc ~= nil then
        msg.desc = arr2str(msg.desc)
        for i=1,2,1 do
            msg.text[i] = msg.desc:sub(1,12)
            msg.desc = msg.desc:sub(13)
        end
        msg.text[3] = msg.desc:sub(1,15)
--        disp:sleepOn()
        disp:firstPage()
        repeat
--            dolc('gird')
--            disp:drawXBM(3, 24 , 24, 24, msg.icon)
            disp:setFont(u8g[textFont])
            for strNumber=1,3 do
                disp:drawStr(strCoords[strNumber].x,strCoords[strNumber].y,msg.text[strNumber])
            end
            disp:drawRFrame(0,0,disp:getWidth(),17,5)
            disp:drawRFrame(0,0,disp:getWidth(),disp:getHeight(),5)
            disp:drawStr(4,13,msg.title)
        until disp:nextPage() == false
--        disp:sleepOff()
    end
    
end
