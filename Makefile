CXX = em++
CC = emcc 

CXXFLAGS =  -O3 -std=c++17 -I ../ANTLR-cmake-Emscripten-starter/tools/antlr/cpp_runtime/runtime/src
HEADERS = myVisitor.h
SOURCES = $(wildcard *.cpp)
OBJECTS = $(SOURCES:%.cpp=%.o)

EMFLAGS =  -O3 -s NO_EXIT_RUNTIME=1 -s USE_GLFW=3 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s "EXPORTED_RUNTIME_METHODS=['ccall','cwrap']" -s "EXPORTED_FUNCTIONS=['_malloc', '_free', _run_script]" -s ALLOW_MEMORY_GROWTH -s ENVIRONMENT='web' -s MODULARIZE=1 -s "EXPORT_NAME='createModule'"
all: main.wasm

clean: 
	rm *.o 
	rm main.wasm
	rm main.js

main.wasm: $(OBJECTS) $(HEADERS)
	$(CC) $(EMFLAGS) -o main.js $(OBJECTS) libantlr4-runtime.a

%.o: $(HEADERS) %.cpp 
	$(CXX) $(CXXFLAGS) -c $*.cpp

.PHONY: clean all