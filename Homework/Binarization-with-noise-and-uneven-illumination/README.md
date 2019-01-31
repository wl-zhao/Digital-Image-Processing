# 图像二值化分割

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


## 目录结构

- src/：源代码
  - main.m：主程序
  - illumination_adjust.m：照明调整
  - ostu_binarize.m：Ostu方法二值化分割
  - remove_isolated.m：去除孤立区域
  - split_eclipses.m：提取出每一个椭圆区域
  - reconstruct_eclipse.m：对椭圆区域进行重构
    - calc_diff.m：用于计算两组二次曲线系数的距离
  - GIFWriter：用于生成GIF的类
- dataset/：输入图像
- results/：处理结果
  - denoise.jpg：去噪结果
  - estimated_illumination.jpg：估计的光照结果
  - illumination_adjusted.jpg：光照调整后结果
  - binarized.jpg：Ostu方法二值化分割结果
  - removed_isolation.jpg：去除孤立区域
  - eclipses/ 1.jpg~5.jpg：五个椭圆的重构结果
  - final_result.jpg：最终结果
  - reconstruct_eclipse.gif：椭圆重构过程的动图
- report.pdf：报告
- README.md：说明文档
