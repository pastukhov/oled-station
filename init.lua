function dolc(fileName, ...)
    if  file.open(fileName .. '.lua') then
        file.close()
        print('Compiling:', fileName .. '.lua')
        local status, err = pcall(function () node.compile(fileName .. '.lua') end)
        if not status then print('Status', ': ',status,' Error: ',err) end
        file.remove(fileName .. '.lua')
    end
    if file.open(fileName ..'.lc') then
        file.close()
        if arg.n > 0 then
            local _, _ = pcall(function () dofile(fileName .. '.lc')(unpack(arg)) end)
        else
            local _, _ = pcall(function () dofile(fileName .. '.lc') end)
        end
    else
        print('Cant find ' .. fileName .. ' to exec')
    end
    collectgarbage()
end

dolc('initDisplay')
dolc('initTime')
dolc('setLocale')
dolc('displaySplash')
dolc('configNetSmart')
dolc('station')


