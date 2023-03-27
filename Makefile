DEUBG = -D_DEBUG

TARGET1 = rtsp_server
TARGET2 = rtsp_pusher
TARGET3 = rtsp_h264_file

OBJS_PATH = objs

CROSS_COMPILE =/opt/atk-dlrv1126-toolchain/usr/bin/arm-linux-gnueabihf-
CXX   = $(CROSS_COMPILE)g++
CC    = $(CROSS_COMPILE)gcc
STRIP = $(CROSS_COMPILE)strip

INC  = -I$(shell pwd)/src/ -I$(shell pwd)/src/net -I$(shell pwd)/src/xop -I$(shell pwd)/src/3rdpart
LIB  =

LD_FLAGS  = -lrt -pthread -lpthread -ldl -lm $(DEBUG)
CXX_FLAGS = -std=c++11

SRC1  = $(notdir $(wildcard ./src/net/*.cpp) $(wildcard ./src/xop/*.cpp))
OBJS1 = $(patsubst %.cpp,$(OBJS_PATH)/%.o,$(SRC1))

LIB_OBJ = libRtsp.a

all: BUILD_DIR $(LIB_OBJ)

BUILD_DIR:
	@-mkdir -p $(OBJS_PATH)

$(OBJS_PATH)/%.o : ./src/net/%.cpp
	$(CXX) -c  $< -o  $@  $(CXX_FLAGS) $(INC)
$(OBJS_PATH)/%.o : ./src/xop/%.cpp
	$(CXX) -c  $< -o  $@  $(CXX_FLAGS) $(INC)

$(LIB_OBJ) : $(OBJS1)
	rm -f $@
	ar cr $@ $(OBJS1)
	rm -f $(OBJS1)

tags:
	ctags -R *

clean:
	rm -f $(OBJS1) $(LIB_OBJ)
