-- Connect to the WiFi access point.
-- Once the device is connected, you may start the HTTP server.

local joinCounter = 0
local joinMaxAttempts = 5
tmr.alarm(0, 3000, 1, function()
   local ip = wifi.sta.getip()
   if ip == nil and joinCounter < joinMaxAttempts then
      print('Connecting to WiFi Access Point ...')
      joinCounter = joinCounter +1
   else
      if joinCounter == joinMaxAttempts then
         print('Faild to connect to WiFi Access Point.')
         print('Starting wifi access point')
         wifi.setmode(wifi.SOFTAP)
      else
         print('IP: ',ip)
        dolc('station')
      end
      tmr.stop(0)
      joinCounter = nil
      joinMaxAttempts = nil
      collectgarbage()
--      dolc('http-example')
   end

end)

