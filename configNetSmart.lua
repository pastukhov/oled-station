wifi.setmode(wifi.STATION)
wifi.sta.config("WiFi", "Password")
wifi.sta.autoconnect(1)

function Success()
   tmr.stop(0)
   print("IP: " .. wifi.sta.getip())
   wifi.sta.eventMonStop()   
   wifi.sta.eventMonReg(wifi.STA_GOTIP, "unreg")
--   dolc('station')
end

function Failure()
   print("Unable to connect")
   wifi.sta.eventMonStop()   
   wifi.sta.eventMonReg(wifi.STA_GOTIP, "unreg")
   return 0
end
   
tmr.alarm(0,30000,0, function() Failure() end)
wifi.sta.connect()
wifi.sta.eventMonReg(wifi.STA_GOTIP, function() Success() end)
wifi.sta.eventMonStart()