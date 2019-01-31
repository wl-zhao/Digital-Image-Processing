# 灰度图片上色

> 作者：赵文亮
>
> 学号：2016011452
>
> 邮箱：zhaowl16@mails.tsinghua.edu.cn

## 运行方式

### 训练

- 将训练集（已调整大小）保存在目录`~/imagenet/resized`下，执行`Preprocess.pynb`将数据保存在tfrecords中
- 运行`Colorization.ipynb`开始训练

### 测试

执行`Colorization.ipynb`中

```python
colorizer = Colorizer('colorization_model.h5')
```

及其之后的语句，加载预训练的模型，为灰度图片上色（默认图片路径为`dataset/`）

## 目录结构

- Colorization/
  - ImagePreprocesser.py：数据预处理类
  - Preprocess.ipynb: 预处理程序
  - Colorization.ipynb：主程序
  - colorization_model.h5：训练好的模型
  - Graph2/：tensorboard log文件
- dataset/
  - original/：原始彩色图片
  - gray/：original/中彩色图片转成的灰度图片
  - results/colorized/ ：上色后图片
- report.pdf：实验报告