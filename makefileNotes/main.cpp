#include <stdio.h>
#include <opencv2/opencv.hpp>

using namespace cv;

void echo();

int main(){
    echo();
    Mat image = imread("affine.jpg");
    printf("image size = %d x %d\n",image.cols,image.rows);

    printf("Hello NVIDIA.\n");
    return 0;
}