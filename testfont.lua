
     -- Hardware SPI CLK  = GPIO14
     -- Hardware SPI MOSI = GPIO13
     -- Hardware SPI MISO = GPIO12 (not used)
     -- CS, D/C, and RES can be assigned freely to available GPIOs
     local cs  = 8 -- GPIO15, pull-down 10k to GND
     local dc  = 3 -- GPIO0
     local res = 0 -- GPIO16

     spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 8, 8)
     disp = u8g.ssd1306_128x64_hw_spi(cs, dc, res)

     disp:firstPage()
     repeat
     until disp:nextPage() == false


local fonts = { 'font_climacons32', 'font_werfProFont_0_8_10', 'font_werfProFont_0_8_7', 'font_werfProFont_0_8_24'}



local counter = 1 

tmr.alarm(0, 1000, 1, function()

print(fonts[counter])


    disp:firstPage()
    repeat
        disp:setFont(u8g[fonts[counter]])
        disp:drawStr(0,32,fonts[counter])
    until disp:nextPage() == false
    counter = counter +1
    if counter == 5 then counter = 1 end
end)
