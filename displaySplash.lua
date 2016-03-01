
local maxX      = disp:getWidth()
local maxY      = disp:getHeight()
local counter   = 32

tmr.alarm(3, 500, tmr.ALARM_AUTO, function()
    second, minute, hour, day, date, month, year = ds3231.getTime();
    if string.len(minute) == 1 then minute = 0 .. minute end
    if string.len(hour) == 1 then hour = 0 .. hour end

    disp:firstPage()
    repeat
        disp:setFont(u8g[iconsFont]) 
        disp:drawStr(0,36,string.char(counter))
        if counter < 59 then
            counter = counter +1
        else
            counter = 32
        end
        disp:setFont(u8g[textFont])
        disp:drawStr(48,20,words.text['loading'])
        disp:setFont(u8g[smallFont])
        disp:drawStr(18,61,words.days[day+1] .. ' ' .. date .. ' ' .. words.months[month+1])

        disp:setFont(u8g[clockFont]) 
        disp:drawStr(26,54,hour ..':'..minute)
        
    until disp:nextPage() == false
end)
