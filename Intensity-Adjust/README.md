# 图像亮度调整

> 作者：赵文亮
>
> 班级：自64
>
> 学号：2016011452
>
> github：[https://github.com/thu-jw/Intensity-Adjust](https://github.com/thu-jw/Intensity-Adjust)

## 运行环境

- Windows 10 x64
- MATLAB R2018b
- GUI由MATLAB App designer 编写

## 运行方式

### 打开程序

- 在`app`文件夹下，双击`IntensityAdjust.mlapp`
- 或者在MATLAB中，切换到`app`目录下，命令行中输入`IntensityAdjust`

### 亮度调整

- 根据下拉菜单选择调整算法
- 拖动滑条改变调整参数
- 点击`载入图片`可以改变图片

## 目录结构

- src/：源代码
- dataset/：示例图像
- results/：亮度调整结果
- app/：图形界面文件`IntensityAdjust.mlapp`
- lib/：边缘检测与连通域计数程序，来自之前的作业
- report.pdf：报告
