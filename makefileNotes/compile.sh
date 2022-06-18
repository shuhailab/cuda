#!/bin/bash
# bash compile.sh 执行脚本文件
# undefined reference to : 这一类错误称之为链接错误

# 编译时，运行时

# 查看当前执行程序依赖哪些so
# ldd ./a.out

# 读取执行程序(so,可执行,a文件都属于elf文件)
# 读取elf文件，查看他的信息，看他的run path是多少
# readelf -a ./a.out | grep path

echo "编译开始"
# 编译阶段，汇编阶段
g++ -c main.cpp -o main.o \
    -I/datav/lean/opencv4.5.1/include/opencv4/  \
    # -L/datav/lean/opencv4.5.1/lib               \
    # -lopencv_core -lopencv_imgcodecs            \
    # -Wl,-rpath=/datav/lean/opencv4.5.1/lib
# 上面两行表示配置的路径 最后一行表示引入的文件是哪一个

g++ -c hello.cpp -o hello.o 


echo "编译结束"
echo "链接开始"
# 链接阶段
g++ main.o hello.o -o main.out \
    # -I/datav/lean/opencv4.5.1/include/opencv4/  \
    -L/datav/lean/opencv4.5.1/lib               \
    -lopencv_core -lopencv_imgcodecs            \
    -Wl,-rpath=/datav/lean/opencv4.5.1/lib

echo "链接结束"