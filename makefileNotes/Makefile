# a : b 
# 	c

# a -> 生成项
# b -> 依赖项
# c -> 生成指令，执行条件是 b比a要新


# src/main.cpp
# objs/main.o
# 查找所有的cpp文件，需要关注的，编译的文件

#cmd option 
cpp_srcs := $(shell find src -name "*.cpp")
#patsubst = path sub string 路径的子字符串替换 $(patsubst 匹配的模式，替换后的模式，数组)
# makefile至尊一种数据类型，就是字符串数组
# 字符串等于只有一个元素的字符串数组
# 语法：定义一个字符串
# a := abc (+=,=)
# a += bcd
# 定义一个数组
# a := abc def 空格隔开就是数组
cpp_objs := $(patsubst %.cpp,%.o,$(cpp_srcs))

# subst sub string 子字符串替换， $(subst 旧字符串，新字符串，数组)
cpp_objs := $(subst src/,objs/,$(cpp_objs))

# 查找所有的cu文件，需要关注的，编译的文件
cu_srcs := $(shell find src -name "*.cu")
cu_objs := $(patsubst %.cu,%.cuo,$(cu_srcs))
cu_objs := $(subst src/,objs/,$(cu_objs))

# 依赖项路径，里面存放cuda,opencv等库文件
lean := /datav/
#定义长度为3的数组
include_path := src \
	$(lean)/opencv4.5.1/include/opencv4 \
	/usr/local/cuda/include

# /usr/local/opencv4/include/opencv4/opencv2 -> include <opencv.hpp>
# /usr/local/opencv4/include/opencv4	     -> include <opencv2/opencv.hpp>

#定义长度为2的数组
library_path := /datav/lean/opencv4.5.1/lib \
	/usr/local/cuda/lib64

link_library := opencv_core opencv_imgproc opencv_imgcodecs \
	cuda curand cublas cudart \
	stdc++ dl
# link_library := soname
# 在library_path中找：libsoname.so

# 运行时路径
# $(function option)
# a := $(variable)

# $(foreach var,array,新内容)
# array := a b c
# new_array := $(foreach var,array,w$(var))
#			:= wa wb wc

# 运行时路径
run_path		:= $(foreach item,$(library_path),-Wl,-rpath=$(item))
# run_path := -Wl,-rpath=/datav/lean/opencv4.5.1/lib -Wl,-rpath=/usr/local/cuda/lib64

include_path	:= $(foreach item,$(include_path),-I$(item))
# include_path := -I$(lean)/opencv4.5.1/include/opencv4 -I/usr/local/cuda/include

library_path	:= $(foreach item,$(library_path),-L$(item))
# library_path := -L/datav/lean/opencv4.5.1/lib -L/usr/local/cuda/lib64

link_library	:= $(foreach item,$(link_library),-l$(item))
# link_library := -lopencv_core -lopencv_imgproc -lopencv_imgcodecs -lcuda -lcublas -lcudart -lstdc++ -ldl

#指定编译选项和链接选项
cpp_compile_option	:= -std=c++11 -fPIC -m64 -g -fopenmp -w -O0
link_option			:= -pthread -fopenmp
cpp_compile_option += $(include_path)
link_option		   += $(library_path) $(link_library) $(run_path)


# 正式的编译环节
# .o文件，依赖.cpp生成
# $(cpp_objs) : $(cpp_srcs)
# 多对多，有歧义(hello.o main.o : hello.cpp main.cpp)应该使用通配符写法
# $< 依赖项-第一个
# $@ 生成项
# $^ 依赖项-所有
objs/%.o : src/%.cpp
	@echo Compile $<
	@mkdir -p $(dir $@)
	@g++ -c $< -o $@ $(cpp_compile_option)

# 这里是一对多，一个依赖多个是没有问题的
# a : b
# 	c
# c执行的条件是b比a新，说明b更新了
# a和b得是文件
# a如果不存在，他会一直都执行c
# b如果不存在，会报错
# objs/hello.o objs/main.o
workspace/pro : $(cpp_objs)
	@echo Link $@
	@mkdir -p $(dir $@)
	@g++ $^ -o $@ $(link_option)

pro : workspace/pro

run : pro
	@cd workspace && ./pro

clean :
	@rm -rf objs workspace/pro

debug :
	@echo $(a)

# @echo $(run_path)
# @echo $(link_library)

# @echo $(cpp_srcs)
# @echo $(cpp_objs)

# @echo $(cu_srcs)
# @echo $(cu_objs)

.PHONY : clean run debug pro
