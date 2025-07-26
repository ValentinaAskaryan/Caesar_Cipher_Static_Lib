SRC_DIR := src
INC_DIR := inc
OBJ_DIR := obj
BIN_DIR := bin
LIB_DIR := lib


CXX := g++
CXXFLAGS := -Wall -Wextra -std=c++17 -MMD -MP -I$(INC_DIR)

# Output executable name and path
EXECUTABLE := $(BIN_DIR)/CaesarCipher
SO := $(LIB_DIR)/libCaesarCipher.so
DYNAMIC_EXEC := $(BIN_DIR)/CaesarCipherDynamic

SOURCE_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SOURCE_FILES))
LIB_OBJS := $(filter-out $(OBJ_DIR)/main.o, $(OBJ_FILES))
DEP_FILES := $(OBJ_FILES:.o=.d)

all : $(EXECUTABLE) $(SO) $(DYNAMIC_EXEC)

$(EXECUTABLE) : $(OBJ_FILES)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(OBJ_FILES) -o $(EXECUTABLE)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -fPIC -c $< -o $@

$(SO) : $(LIB_OBJS)
	@mkdir -p $(LIB_DIR)
	$(CXX) -shared -o $(SO) $(LIB_OBJS)

$(DYNAMIC_EXEC) : $(SRC_DIR)/main.cpp $(SO)
	@mkdir -p $(LIB_DIR)
	$(CXX) $(CXXFLAGS) $< -L$(LIB_DIR) -lCaesarCipher -Wl,-rpath=$(LIB_DIR) -I$(INC_DIR) -o $(DYNAMIC_EXEC)

clean :
	rm -rf $(OBJ_DIR) $(BIN_DIR) $(SO) $(LIB_DIR)

-include $(DEP_FILES)
