local function syncTime()
        sntp.sync('0.ru.pool.ntp.org',
            function(sec,usec,server)
                print('Synced from',server,'time is', sec, 'seconds')
            end,
            function()
                print('failed!')
            end
        )

end
tmr.alarm(4,1000,tmr.ALARM_AUTO, function() 
    print('Syncing time')
    if wifi.sta.status() == wifi.STA_GOTIP then 
        syncTime()
        tmr.stop(4)
        tmr.alarm(4,3600000,tmr.ALARM_AUTO, function() 
            print('Syncing time')
            syncTime()
        end)
    end
end)






