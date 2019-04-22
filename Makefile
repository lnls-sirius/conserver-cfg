CMDSEP = ;

PWD = $(shell pwd)

# Prefixes
ETC_PREFIX ?= /etc/conserver

# Scripts
CFG_FOLDER=etc/conserver
CFG_FULL_NAME := $(shell cd $(CFG_FOLDER) && find . -type f)

# Strip off a leading ./
CFGS=$(CFG_FULL_NAME:./%=%)

.PHONY: all clean install uninstall

all:

install:
	$(foreach script,$(CFGS),mkdir -p $(dir ${ETC_PREFIX}/$(script)) $(CMDSEP))
	$(foreach script,$(CFGS),cp --preserve=mode $(CFG_FOLDER)/$(script) ${ETC_PREFIX}/$(script) $(CMDSEP))

uninstall:
	$(foreach script,$(CFGS),rm -f ${ETC_PREFIX}/$(script) $(CMDSEP))

clean:
