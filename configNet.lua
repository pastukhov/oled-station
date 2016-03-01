-- Begin network configuration

local netConfig = {}

if file.open('netConfig.json','r') then 
    netConfig = cjson.decode(file.read())
    file.close()
else
    -- wifi.STATION         -- station: join a WiFi network
    -- wifi.AP              -- access point: create a WiFi network
    -- wifi.wifi.STATIONAP  -- both station and access point
    netConfig.mode = wifi.STATION  -- station mode

netConfig.accessPointConfig = {
    ssid    = "ESP-"..node.chipid(),
    pwd     = "ESP-"..node.chipid()    -- WiFi password - at least 8 characters
    
}

netConfig.stationPointConfig = {
    ssid = "WiFi",    -- Name of the WiFi network you want to join
    pwd =  "Password",            -- Password for the WiFi network
    auto    =  1
}
-- Tell the chip to connect to the access point
end
wifi.setmode(netConfig.mode)
print('set (mode='..wifi.getmode()..')')
print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())

wifi.ap.config(netConfig.accessPointConfig)
wifi.sta.config(netConfig.stationPointConfig.ssid,netConfig.stationPointConfig.pwd,netConfig.stationPointConfig.auto)
netConfig = nil
collectgarbage()

-- End network configuration
