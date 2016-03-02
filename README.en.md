# oled-station

The station for displaying any kind of info  on the screen via MQTT protocol. Inspired by https://github.com/nfriedly/nodemcu-weather-station.

At this moment the device can display  time, weather (temperature humidity pressure and dark sky icon from http://forecast.io), text message, image. Any other type of information to display can be easy added, look at software part of this README.

[![Demo video](http://img.youtube.com/vi/x8hI9_JtbBE/0.jpg)](http://www.youtube.com/watch?v=x8hI9_JtbBE)


## Hardware
* esp8266 with NodeMCU
* OLED screen http://goo.gl/Cxhwoh
* RTC http://goo.gl/zzWak4
* MicroUSB socket for powering http://goo.gl/yqudYL
* Variety small supplies
* Structor http://amperka.ru/collection/structor

![The device itself](https://github.com/pastukhov/oled-station/raw/master/images/0.jpg)
 
![Parts inside](https://github.com/pastukhov/oled-station/raw/master/images/1.jpg)

![Parts 2](https://github.com/pastukhov/oled-station/raw/master/images/2.jpg)



## Software

Device connect to MQTT broker and subscribe to ```oled/events/+```
When a message arrives module will run a handler according to the last part of a topic.

```lua
mqtt:on("message", function(conn, topic, data)
    local start = tmr.now()
    print(topic,node.heap())
            if  topic:match('weather$') then
                dolc('weather',data)
            elseif topic:match('message$') then
                dolc('message',data)
            elseif topic:match('image$') then
                dolc('image',data)
            elseif topic:match('gird$') then
                dolc('gird')
            elseif topic:match('test$') then
                dolc('test',data)
            elseif topic:match('setTime$') then
                dolc('settime',data)
            elseif topic:match('save$') then
                dolc('save',data)
            end

    data = nil
    topic =nil
         
    collectgarbage()
end)
```
Controlled with [Node-RED flows](https://github.com/pastukhov/oled-station/raw/master/node-red_flow.json)
