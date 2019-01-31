import tensorflow as tf
from keras.applications.inception_resnet_v2 import InceptionResNetV2
import os
from skimage.color import rgb2lab, lab2rgb, rgb2gray, gray2rgb
from skimage.transform import resize
from keras.preprocessing.image import img_to_array, load_img
from keras.applications.inception_resnet_v2 import preprocess_input
import numpy as np

class ImagePreprocesser:
    def __init__(self, image_dir, write=False):
        print('start init')
        self.write = write
        if write:
            self.inception = InceptionResNetV2(weights='imagenet', include_top=True)
            self.inception.graph = tf.get_default_graph()
        self.set_dir(image_dir)
        print('init done')
        
    def set_dir(self, image_dir):
        self.image_dir = image_dir
        
    def _bytes_feature(self, value):
        """Returns a bytes_list from a string / byte."""
        return tf.train.Feature(bytes_list=tf.train.BytesList(value=[value]))

    def _float_feature(self, value):
        """Returns a float_list from a float / double."""
        return tf.train.Feature(float_list=tf.train.FloatList(value=[value]))

    def _int64_feature(self,value):
        """Returns an int64_list from a bool / enum / int / uint."""
        return tf.train.Feature(int64_list=tf.train.Int64List(value=[value]))
    
    def _image_example(self, filename):
        image = img_to_array(load_img(self.image_dir + filename))
        image_for_inception = gray2rgb(rgb2gray(image) / 255.0)
        image = resize(image, (224, 224), anti_aliasing=True)
        image_lab = rgb2lab(image / 255.0).astype(np.float32) #float32
        image_gray = rgb2gray(image)         
        image_for_inception = preprocess_input(image_for_inception)
        image_for_inception = image_for_inception.reshape((1,) +  image_for_inception.shape)
        embedding = self.inception.predict(image_for_inception, verbose=True)
        embedding = embedding.astype(np.float32)
        image = image.astype(np.int32)
        # image_shape = np.array(image.shape, dtype=np.uint16)
        image_gray = image_gray.astype(np.uint8) # uint8
        
        feature = {
            #'image_shape': self._bytes_feature(image_shape.tobytes()), #uint16
            'image_gray': self._bytes_feature(image_gray.tobytes()), # uint8
            'image_a_b': self._bytes_feature(image_lab[:, :, 1:].tobytes()), #float32
            'embedding': self._bytes_feature(embedding.tobytes()), #float32
            'label': self._bytes_feature(str.encode(filename)), #uint8
        }
        return tf.train.Example(features=tf.train.Features(feature=feature))
        
    def preprocess_data(self, max_num, batch_size, root):
        if self.write is False:
            return
        cnt = 0
        filenames = os.listdir(self.image_dir)
        for i in range(0, max_num // batch_size):
            with tf.python_io.TFRecordWriter(root + str(i) +'.tfrecords') as writer:
                print('writing' + str(i) + '.tfrecords')
                for j in range(0, batch_size):
                    tf_example = self._image_example(filenames[cnt])
                    writer.write(tf_example.SerializeToString())
                    print('image %s done %d' % (filenames[cnt], cnt))
                    cnt += 1
                    if cnt > max_num:
                        break;
            writer.close()
