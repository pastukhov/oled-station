return function (data)
    local msg = cjson.decode(data)
    local weather = {
        ["clear-day"] = 73,
        ["clear-night"] = 78,
        ["partly-cloudy-day"] = 34,
        ["partly-cloudy-night"] = 35,
        ["cloudy"] = 33,
        ["rain"] = 36,
        ["sleet"] = 48,
        ["snow"] = 57,
        ["wind"] = 66,
        ["fog"] = 60
    }
--    msg.date.month  = arr2str(msg.date.month)  
--    msg.date.wDay   = arr2str(msg.date.wDay)  
--    msg.temperature = round(msg.temperature,1)
--    msg.pressure    = round(msg.pressure,0)
    second, minute, hour, day, date, month, year = ds3231.getTime();
    if string.len(minute) == 1 then minute = 0 .. minute end
    if string.len(hour) == 1 then hour = 0 .. hour end

--    disp:sleepOn()
    disp:firstPage()
    repeat
--        dolc('gird')
        disp:setFont(u8g[iconsFont]) 
        disp:drawStr(0,36,string.char(weather[msg.icon]))

        
        disp:setFont(u8g[smallFont])
        disp:drawStr(38,10,words.text['temperature'])
        disp:drawStr(38,20,words.text['humidity'])
        disp:drawStr(38,30,words.text['pressure'])
        
        disp:setFont(u8g[textFont])
        disp:drawStr(100,10,msg.temperature  .. "C")
        disp:drawStr(100,20,msg.relHumidity .. "%")
        disp:drawStr(100,30,msg.pressure)

        disp:setFont(u8g[clockFont]) 
        disp:drawStr(26,54,hour ..':'..minute)

        disp:setFont(u8g[smallFont])
        disp:drawStr(18,61,words.days[day+1] .. ' ' .. date .. ' ' .. words.months[month+1])
        
     until disp:nextPage() == false
--     disp:sleepOff()

end
