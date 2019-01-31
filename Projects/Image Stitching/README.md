# 图像拼接

> 作者：赵文亮
>
> 班级：自64
>
> 学号：2016011452
>
> github：[https://github.com/thu-jw/ImageStitching](https://github.com/thu-jw/ImageStitching)

## 运行环境

- Windows 10 x64
- MATLAB R2018b
- GUI由MATLAB App designer 编写

## 运行方式

### 打开程序

- 在`app`文件夹下，双击`ImageStitching.mlapp`
- 或者在MATLAB中，切换到`app`目录下，命令行中输入`ImageStitching`

### 图像拼接

- 根据下拉菜单选择数据集
- 点击`图像拼接`开始拼接
- 界面下方显示拼接状态
- 可以选择是否裁剪全景图片

## 目录结构

- src/：源代码
- dataset/：输入图像数据集
  - lab：实验室
  - main_building：主楼
  - 618：科协活动室
- feature/：提取的特征点。程序每次运行时，先尝试从feature中读取，如果读取失败，则重新使用SIFT算法生成特征点保存在feature文件夹中
- results/：图像拼接结果
  - `without_blend.jpg` 为变换后直接拼接（未融合）的结果
  - `with_blend.jpg` 为融合后的拼接结果
  - `after_crop.jpg`为裁剪后的结果
- app/：图形界面文件`ImageStitching.mlapp`
- lib/：vlfeat库函数，用于关键点提取与匹配
- report.pdf：报告