FROM tensorflow/tensorflow:2.4.2-gpu-jupyter

RUN apt update && apt install -y\
 python-opengl\
 xvfb\
 ffmpeg

RUN pip install --upgrade pip setuptools
RUN pip install\
 keras-rl2\
 gym\
 h5py\
 Pillow\
 gym[atari]\
 gym-notebook-wrapper

RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo c.NotebookApp.open_browser = False >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /mnt
CMD jupyter notebook --allow-root --NotebookApp.token=''
