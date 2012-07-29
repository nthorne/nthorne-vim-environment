.PHONY: clean clean-all

SOURCE_FILES+=$(wildcard *.cpp)
OBJECT_FILES=$(patsubst %.cpp, %.o, $(SOURCE_FILES))

CXX=CC
CC=cc

CXXFLAGS+=-g -library=stlport4_dbg
LDFLAGS=-library=stlport4_dbg

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
