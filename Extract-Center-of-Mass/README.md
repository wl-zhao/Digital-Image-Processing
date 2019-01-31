# 质心提取

> 作者：赵文亮
>
> 班级：自64
>
> 学号：2016011452
>

## 运行环境

- Windows 10 x64
- MATLAB R2018b

## 运行方式

### 打开程序

- 运行src目录下的`main.m`文件


- 在`results`目录下会输出提取结果和提取过程

## 目录结构

- src/：源代码
  - main.m：主程序
  - GIFWriter：用于生成GIF的类
- dataset/：输入图像
- results/：处理结果

  - process/：处理过程截图
    - H.jpg, S.jpg：转换到HSV空间后的H、S分量
    - H_mask.jpg, S_mask.jpg：色调和饱和度蒙版
    - BW.jpg：二值化提取后结果
    - dilate.jpg：膨胀填充缝隙结果
    - refine.jpg：优化的二值化提取结果
    - seperate.jpg：两荔枝分离结果
    - eroded.jpg：腐蚀提取质心
    - coor.jpg：质心坐标标注结果
    - process.jpg：处理过程汇总
  - coordinate.txt：以文本格式保存的质心坐标
  - result.jpg：将质心坐标标注在原图上的结果
  - lizhi.gif：展示整个处理过程的动图

- report.pdf：报告
- README.md：说明文档
