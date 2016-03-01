######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU-UPLOADER=python ../nodemcu-uploader/nodemcu-uploader.py --start_baud 115200 --baud 115200
# Serial port
PORT=/dev/ttyUSB0
SPEED=115200

######################################################################
# End of user config
######################################################################
LUA_FILES := $(wildcard *lua) words.json

# Upload all
all: $(LUA_FILES)
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(foreach f, $^, $(f))



# Print usage
usage:
	@echo "make upload FILE:=<file>  to upload a specific file (i.e make upload FILE:=init.lua)"
	@echo "make to upload all"
	@echo $(TEST)

# Upload one files only
upload:
	@$(NODEMCU-UPLOADER) -b $(SPEED) -p $(PORT) upload $(FILE)




