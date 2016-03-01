words  = {}

if file.open('words.json','r')then 
    words = cjson.decode(file.read())
    file.close()
else
  words = { days = 
            {'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'},
        months  = {'January','February','March','April','May','June','July','August','September','October','November','December'},
        text    = {
            temperature = 'Temperature',
            pressure    = 'Pressure',
            humidity    = 'Humidity',
            loading     = 'Loading'}
    }
        
end
