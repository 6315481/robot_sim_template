cmake_minimum_required(VERSION 3.16)
project(
  robot_sim_template
  VERSION 0.0.0
  DESCRIPTION "Robot simulation template"
)

include(FetchContent)

if (NOT TARGET fmt)
  FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 0379bf3a5d52d8542aec1874677c9df5ff9ba5f9
  )
  FetchContent_MakeAvailable(fmt)
endif()

if (NOT TARGET eigen3)
  FetchContent_Declare(
    eigen3
    GIT_REPOSITORY https://gitlab.com/libeigen/eigen.git
    GIT_TAG c5189ac656c2bf5eead9bc967282cf084cbaeb64
  )
  FetchContent_MakeAvailable(eigen3)
endif()

if (NOT TARGET glfw)
  unset(GLFW_USE_WAYLAND CACHE)
  set(GLFW_BUILD_WAYLAND ON)
  set(GLFW_BUILD_X11 ON)
  set(GLFW_LIBRARY_TYPE STATIC)
  FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG b35641f4a3c62aa86a0b3c983d163bc0fe36026d
  )
  FetchContent_MakeAvailable(glfw)
endif()

if (NOT TARGET mujoco)
  set(MUJOCO_BUILD_TESTS OFF)
  set(MUJOCO_BUILD_SIMULATE OFF)
  set(MUJOCO_BUILD_EXAMPLES OFF)
  FetchContent_Declare(
    mujoco
    GIT_REPOSITORY https://github.com/google-deepmind/mujoco.git
    GIT_TAG cad8ca6ffd269668c02b526b602b729adf91cdc8
  )
  FetchContent_MakeAvailable(mujoco)
endif()

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/third-party/imgui)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/third-party/glad)

add_executable(main ./src/main.cpp)

target_link_libraries(main PRIVATE mujoco glfw)

target_compile_options(main PRIVATE
-Wall 
-Wextra 
-Wdouble-promotion
-rdynamic
)

install(TARGETS main DESTINATION main COMPONENT main)