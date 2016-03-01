second, minute, hour, day, date, month, year = ds3231.getTime();

if string.len(minute) == 1 then minute = 0 .. minute end
if string.len(hour) == 1 then hour = 0 .. hour end






    disp:firstPage()
    repeat
        disp:setFont(u8g.font_werfProFont_0_8_25)            
        
        disp:drawStr(26,54,hour ..':'..minute)
        disp:setFont(u8g.font_werfProFont_0_8_7)
        disp:drawStr(14,63,words.days[day+1] .. ' ' .. date .. ' ' .. words.months[month+1])
    
    until disp:nextPage() == false
