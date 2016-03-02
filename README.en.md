# oled-station

The station for displaying different info  on the screen via MQTT protocol

[![Demo video](http://img.youtube.com/vi/x8hI9_JtbBE/0.jpg)](http://www.youtube.com/watch?v=x8hI9_JtbBE)


## Hardware parts
* esp8266 with NodeMCU
* OLED screen http://goo.gl/Cxhwoh
* RTC http://goo.gl/zzWak4
* MicroUSB socket for powering http://goo.gl/yqudYL
* Variety small supplies
* Structor http://amperka.ru/collection/structor

## Software

This device can display  time, weather, text message, image. 
Can be easy extended to display any other kind of information:
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
Controlled with  Node-RED flows:
```JSON
[  
   {  
      "id":"95df45c7.e7c0b8",
      "type":"mqtt-broker",
      "z":"",
      "broker":"test.mosquitto.org",
      "port":"8883",
      "clientid":"",
      "usetls":true,
      "verifyservercert":true,
      "compatmode":true,
      "keepalive":"15",
      "cleansession":true,
      "willTopic":"oled/status",
      "willQos":"0",
      "willRetain":"false",
      "willPayload":"{'status':'offline''}",
      "birthTopic":"oled/status",
      "birthQos":"0",
      "birthRetain":"false",
      "birthPayload":"{'status':'online'}"
   },
   {  
      "id":"cd11efde.32ee1",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"init",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":true,
      "x":80,
      "y":26,
      "wires":[  
         [  
            "9584fdfa.6a7b"
         ]
      ]
   },
   {  
      "id":"5902be67.a6fd4",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/weather",
      "qos":"",
      "retain":"true",
      "broker":"95df45c7.e7c0b8",
      "x":534,
      "y":124,
      "wires":[  

      ]
   },
   {  
      "id":"ffd472cf.002b9",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"context.global.forecast",
      "func":"context.global.forecast =  msg.data.currently;\n",
      "outputs":"0",
      "noerr":0,
      "x":317,
      "y":73,
      "wires":[  

      ]
   },
   {  
      "id":"f625d13.f09da3",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Set weather topic",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"10",
      "crontab":"",
      "once":true,
      "x":106,
      "y":121,
      "wires":[  
         [  
            "90f2329b.6f0dd"
         ]
      ]
   },
   {  
      "id":"90f2329b.6f0dd",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"",
      "func":"msg.payload = context.global.forecast||{};\n\nmsg.payload.tst =  Math.round(Date.now()/1000);\n//msg.payload.humidity = Math.round(context.global.forecast.humidity * 100);\nmsg.payload.relHumidity = context.global.forecast.humidity * 100;\nmsg.payload.temperature = Math.round(msg.payload.temperature);\nmsg.payload.pressure = Math.round(msg.payload.pressure);\n\nNumber.prototype.padZero= function(len){\n var s= String(this), c= '0';\n len= len || 2;\n while(s.length < len) s= c + s;\n return s;\n};\n\nreturn msg;",
      "outputs":1,
      "noerr":0,
      "x":284,
      "y":122,
      "wires":[  
         [  
            "5902be67.a6fd4",
            "78372614.87c8d8"
         ]
      ]
   },
   {  
      "id":"78372614.87c8d8",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":false,
      "console":"false",
      "complete":"false",
      "x":520,
      "y":171,
      "wires":[  

      ]
   },
   {  
      "id":"9584fdfa.6a7b",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"context.global.toiso",
      "func":"context.global.toiso = function (text) {\nvar o_code = [];\nvar i_code = \"\";\n\nfor (var I=0; I < text.length; I++){\n    i_code = text.charCodeAt(I);\n    if(1040 <= i_code && i_code <= 1103) {\n        o_code[I] = i_code - 864;\n    }\n    else {\n        o_code[I] = i_code;\n    }\n}\nreturn o_code;\n};\n",
      "outputs":"0",
      "noerr":0,
      "x":270,
      "y":24,
      "wires":[  

      ]
   },
   {  
      "id":"5e96f04b.a1691",
      "type":"forecastio in",
      "z":"87e6275b.406c8",
      "forecastio":"",
      "name":"Weather in Moscow",
      "key":"",
      "lon":"37.3656",
      "lat":"55.4507",
      "date":"",
      "time":"",
      "units":"auto",
      "x":91.5,
      "y":74,
      "wires":[  
         [  
            "ffd472cf.002b9"
         ]
      ]
   },
   {  
      "id":"1302e39.fecfd1c",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/message",
      "qos":"",
      "retain":"false",
      "broker":"95df45c7.e7c0b8",
      "x":548,
      "y":213,
      "wires":[  

      ]
   },
   {  
      "id":"d71972fd.28e69",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":false,
      "console":"false",
      "complete":"payload",
      "x":529,
      "y":264,
      "wires":[  

      ]
   },
   {  
      "id":"431193d8.bcee6c",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"Message fields",
      "func":"\n//var icon = ;\n\n\nmsg.payload = {\n   \"_type\" : \"msg\",\n   \"prio\" : 0,\n   \"title\" : context.global.toiso('Кагдила? Конкурсное сообщение'),\n   \"desc\" : context.global.toiso(\"В первом выпуске нашей новой рубрики Обзор новинок от Амперки мы расскажем вам об одной из самых важных на наш взгляд весенних новинок\"),\n   \"tst\"  : Math.round(Date.now()/1000),\n//   \"icon\" : new Buffer(msg.payload,'ascii')\n\n};\nreturn msg;",
      "outputs":1,
      "noerr":0,
      "x":298,
      "y":209,
      "wires":[  
         [  
            "1302e39.fecfd1c",
            "d71972fd.28e69"
         ]
      ]
   },
   {  
      "id":"647e6e01.9b819",
      "type":"file in",
      "z":"87e6275b.406c8",
      "name":"Icon",
      "filename":"/home/artem/tmp/big/out/ic_3d_rotation_white_48dp.xbm.mono",
      "format":"",
      "x":314,
      "y":307,
      "wires":[  
         [  
            "9d62fc35.629d",
            "f8bb8fb.f07447"
         ]
      ]
   },
   {  
      "id":"30e17aa6.cf1e86",
      "type":"mqtt in",
      "z":"87e6275b.406c8",
      "name":"Profiler",
      "topic":"oled/status",
      "broker":"95df45c7.e7c0b8",
      "x":85,
      "y":1015,
      "wires":[  
         [  

         ]
      ]
   },
   {  
      "id":"2f5b316f.d0a4ce",
      "type":"json",
      "z":"87e6275b.406c8",
      "name":"",
      "x":283,
      "y":1015,
      "wires":[  
         [  
            "29b875cf.d6478a"
         ]
      ]
   },
   {  
      "id":"94ea12c1.6b15f",
      "type":"iot-datasource",
      "z":"87e6275b.406c8",
      "name":"message timings",
      "tstampField":"",
      "dataField":"",
      "disableDiscover":false,
      "x":665,
      "y":1017,
      "wires":[  
         [  

         ]
      ]
   },
   {  
      "id":"8b994478.7466b8",
      "type":"iot-datasource",
      "z":"87e6275b.406c8",
      "name":"weather timings",
      "tstampField":"",
      "dataField":"",
      "disableDiscover":false,
      "x":669,
      "y":982,
      "wires":[  
         [  

         ]
      ]
   },
   {  
      "id":"29b875cf.d6478a",
      "type":"switch",
      "z":"87e6275b.406c8",
      "name":"",
      "property":"payload.data.topic",
      "rules":[  
         {  
            "t":"eq",
            "v":"oled/events/message"
         },
         {  
            "t":"eq",
            "v":"oled/events/weather"
         },
         {  
            "t":"eq",
            "v":"oled/events/image"
         }
      ],
      "checkall":"true",
      "outputs":3,
      "x":489,
      "y":1016,
      "wires":[  
         [  
            "8b994478.7466b8"
         ],
         [  
            "94ea12c1.6b15f"
         ],
         [  
            "aa1b6ba3.55e498"
         ]
      ]
   },
   {  
      "id":"f8bb8fb.f07447",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/image",
      "qos":"",
      "retain":"",
      "broker":"95df45c7.e7c0b8",
      "x":545,
      "y":309,
      "wires":[  

      ]
   },
   {  
      "id":"aa1b6ba3.55e498",
      "type":"iot-datasource",
      "z":"87e6275b.406c8",
      "name":"image timings",
      "tstampField":"",
      "dataField":"",
      "disableDiscover":false,
      "x":662,
      "y":1053,
      "wires":[  
         [  

         ]
      ]
   },
   {  
      "id":"9d62fc35.629d",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":false,
      "console":"false",
      "complete":"false",
      "x":532,
      "y":358,
      "wires":[  

      ]
   },
   {  
      "id":"a01d7a67.5fe288",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Cleanup persistent message",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":559,
      "y":23,
      "wires":[  
         [  
            "5902be67.a6fd4"
         ]
      ]
   },
   {  
      "id":"e5c2b284.1a3d5",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Display image",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":96,
      "y":309,
      "wires":[  
         [  
            "647e6e01.9b819"
         ]
      ]
   },
   {  
      "id":"f168bd30.0e974",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Set message topic",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":113,
      "y":209,
      "wires":[  
         [  
            "431193d8.bcee6c"
         ]
      ]
   },
   {  
      "id":"9682a8fb.697d58",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Set time",
      "topic":"",
      "payload":"",
      "payloadType":"date",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":84,
      "y":390,
      "wires":[  
         [  
            "527e83a5.ad817c"
         ]
      ]
   },
   {  
      "id":"527e83a5.ad817c",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"",
      "func":"// Set date and time to Sunday, January 18th 2015 6:30PM\n// ds3231.setTime(0, 30, 18, 1, 18, 1, 15);\n//setTime(second, minute, hour, day, date, month, year)\nvar date =new Date();\n\nmsg.payload = {\n    second  : date.getSeconds(),\n    minute  : date.getMinutes(),\n    hour    : date.getHours(),\n    day     : date.getDay(),\n    date    : date.getDate(),\n    month   : date.getMonth(),\n    year    : date.getFullYear().toString().substr(2,2)\n};\nreturn msg;",
      "outputs":1,
      "noerr":0,
      "x":299,
      "y":392,
      "wires":[  
         [  
            "f8c2dff.f073d2",
            "cda97da.f32568"
         ]
      ]
   },
   {  
      "id":"f8c2dff.f073d2",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/setTime",
      "qos":"",
      "retain":"",
      "broker":"95df45c7.e7c0b8",
      "x":540,
      "y":400,
      "wires":[  

      ]
   },
   {  
      "id":"cda97da.f32568",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":false,
      "console":"false",
      "complete":"false",
      "x":510,
      "y":460,
      "wires":[  

      ]
   },
   {  
      "id":"25f3025c.da0cfe",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Display time",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":90,
      "y":540,
      "wires":[  
         [  
            "aeda4fc2.5125b"
         ]
      ]
   },
   {  
      "id":"aeda4fc2.5125b",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/printTime",
      "qos":"",
      "retain":"",
      "broker":"95df45c7.e7c0b8",
      "x":525,
      "y":544,
      "wires":[  

      ]
   },
   {  
      "id":"ae0d6848.51f298",
      "type":"inject",
      "z":"87e6275b.406c8",
      "name":"Save l10n",
      "topic":"",
      "payload":"",
      "payloadType":"none",
      "repeat":"",
      "crontab":"",
      "once":false,
      "x":110,
      "y":605,
      "wires":[  
         [  
            "62307e50.9dcf8"
         ]
      ]
   },
   {  
      "id":"62307e50.9dcf8",
      "type":"function",
      "z":"87e6275b.406c8",
      "name":"Will localisation JSON",
      "func":"msg.payload = {};\nvar days    = ['воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'субота'];\nvar months  = ['января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря'];\nvar text    = {\n    temperature : 'Температура',\n    pressure    : 'Давление',\n    humidity    : 'Влажность',\n    loading     : 'Загрузка'\n\n    \n};\ndays.forEach(function(item, i, arr) {\n    arr[i] = context.global.toiso(item);\n});\n\nmonths.forEach(function(item, i, arr) {\n    arr[i] = context.global.toiso(item);\n});\n\n//for (var k in result) {\n//  something(result[k])\n//}\n\nfor (var k in text) {\n    text[k] = context.global.toiso(text[k]);    \n}\n\n\n\nmsg.payload.days    = days;\nmsg.payload.months  = months;\nmsg.payload.text    = text;\nreturn msg;",
      "outputs":1,
      "noerr":0,
      "x":332,
      "y":602,
      "wires":[  
         [  
            "808209a3.7f7df8",
            "dedfeb1c.212018"
         ]
      ]
   },
   {  
      "id":"808209a3.7f7df8",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":true,
      "console":"false",
      "complete":"false",
      "x":591,
      "y":654,
      "wires":[  

      ]
   },
   {  
      "id":"dedfeb1c.212018",
      "type":"mqtt out",
      "z":"87e6275b.406c8",
      "name":"",
      "topic":"oled/events/save",
      "qos":"",
      "retain":"",
      "broker":"95df45c7.e7c0b8",
      "x":589,
      "y":604,
      "wires":[  

      ]
   },
   {  
      "id":"360724f0.c9f8dc",
      "type":"mqtt in",
      "z":"87e6275b.406c8",
      "name":"oled/status",
      "topic":"oled/status/+",
      "broker":"95df45c7.e7c0b8",
      "x":88,
      "y":714,
      "wires":[  
         [  
            "38faab12.c70554"
         ]
      ]
   },
   {  
      "id":"38faab12.c70554",
      "type":"debug",
      "z":"87e6275b.406c8",
      "name":"",
      "active":true,
      "console":"false",
      "complete":"false",
      "x":268,
      "y":714,
      "wires":[  

      ]
   }
]
```


