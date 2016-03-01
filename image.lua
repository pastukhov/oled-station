return function (msg)
--    disp:sleepOn()
    disp:firstPage()
    repeat
        disp:drawXBM(32, 0,64, 64, msg)
    until disp:nextPage() == false
--    disp:sleepOff()
    msg = nil
end
