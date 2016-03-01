return function (data)
local msg = cjson.decode(data)
print(cjson.encode(msg.days))
local words = {days = {},months = {},text ={}}
for key,value in pairs(msg.days) do
    words.days[key] = arr2str(value)
end
for key,value in pairs(msg.months) do
    words.months[key] = arr2str(value)
end

for key,value in pairs(msg.text) do
    words.text[key] = arr2str(value)
end



file.open('words.json','w')
file.write(cjson.encode(words))
file.close()
end
