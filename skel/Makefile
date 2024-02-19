.PHONY: clean clean-all

SOURCE_FILES+=$(wildcard *.cpp)
OBJECT_FILES=$(patsubst %.cpp, %.o, $(SOURCE_FILES))

CXX=g++
CC=gcc

CXXFLAGS+=-g -std=c++17
LDFLAGS=-lstdc++

TARGET=foobar

all: $(TARGET)

$(TARGET): $(OBJECT_FILES)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $^ -o $@

clean:
	$(RM) $(patsubst %.cid, %.cpp, $(INTERFACES))
	$(RM) $(patsubst %.cid, %.hpp, $(INTERFACES))
	$(RM) $(OBJECT_FILES)

clean-all: clean
	$(RM) $(TARGET)
