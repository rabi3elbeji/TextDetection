# set source class path
set (SRC_FILES_PATH "../../src")

# set sources files 
set(SOURCE_FILES
	${SRC_FILES_PATH}/EastOpenCV.cpp
	)

# add excutable
add_executable(TextDetection ${SOURCE_FILES})

