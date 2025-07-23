cmake_minimum_required(VERSION 3.10)

project(KORTEX)

# ✅ Standard C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 📁 Inclus tous les headers utiles
include_directories(src)

# 🧩 GLOB = détecte tous les fichiers .cpp
file(GLOB SOURCES "src/*.cpp")

# 🧠 Exécutable principal
add_executable(kortex_terminal ${SOURCES})

# 🚀 Lien avec Boost.Process si utilisé dans menu.cpp
find_package(Boost REQUIRED COMPONENTS process)
target_link_libraries(kortex_terminal Boost::process)
