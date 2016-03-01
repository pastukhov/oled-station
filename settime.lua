return function (data)
    local msg = cjson.decode(data)
    print('Setting to',msg.second, msg.minute, msg.hour, msg.day, msg.date, msg.month, msg.year)
    ds3231.setTime(msg.second, msg.minute, msg.hour, msg.day, msg.date, msg.month, msg.year)
end
