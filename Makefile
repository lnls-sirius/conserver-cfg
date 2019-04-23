CMDSEP = ;

PWD = $(shell pwd)

# Prefixes
ETC_PREFIX ?= /etc/conserver
LOCAL_ETC_SUFFIX = etc/conserver

# Server Scripts
SERVER_CFG_FOLDER_PREFIX = server
SERVER_CFG_FOLDER = ${SERVER_CFG_FOLDER_PREFIX}/${LOCAL_ETC_SUFFIX}
SERVER_CFG_FULL_NAME := $(shell cd $(SERVER_CFG_FOLDER) && find . -type f)

# Strip off a leading ./
SERVER_CFGS=$(SERVER_CFG_FULL_NAME:./%=%)

# Server Scripts
CLIENT_CFG_FOLDER_PREFIX = client
CLIENT_CFG_FOLDER = ${CLIENT_CFG_FOLDER_PREFIX}/${LOCAL_ETC_SUFFIX}
CLIENT_CFG_FULL_NAME := $(shell cd $(CLIENT_CFG_FOLDER) && find . -type f)

# Strip off a leading ./
CLIENT_CFGS=$(CLIENT_CFG_FULL_NAME:./%=%)

.PHONY: all clean server_install server_uninstall \
		client_install client_uninstall

all:

server_install:
	$(foreach script,$(SERVER_CFGS),mkdir -p $(dir ${ETC_PREFIX}/$(script)) $(CMDSEP))
	$(foreach script,$(SERVER_CFGS),cp --preserve=mode $(SERVER_CFG_FOLDER)/$(script) ${ETC_PREFIX}/$(script) $(CMDSEP))

server_uninstall:
	$(foreach script,$(SERVER_CFGS),rm -f ${ETC_PREFIX}/$(script) $(CMDSEP))

client_install:
	$(foreach script,$(CLIENT_CFGS),mkdir -p $(dir ${ETC_PREFIX}/$(script)) $(CMDSEP))
	$(foreach script,$(CLIENT_CFGS),cp --preserve=mode $(CLIENT_CFG_FOLDER)/$(script) ${ETC_PREFIX}/$(script) $(CMDSEP))

client_uninstall:
	$(foreach script,$(CLIENT_CFGS),rm -f ${ETC_PREFIX}/$(script) $(CMDSEP))

clean:
