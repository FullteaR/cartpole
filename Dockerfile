FROM nvidia/cuda:11.0.3-cudnn8-runtime-ubuntu20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y\
 python-opengl\
 xvfb\
 ffmpeg\
 wget\
 unrar\
 git\
 curl\
 build-essential\
 libreadline-dev\
 libncursesw5-dev\
 libssl-dev\
 libsqlite3-dev\
 libgdbm-dev\
 libbz2-dev\
 liblzma-dev\
 zlib1g-dev\
 uuid-dev\
 libffi-dev\
 libdb-dev

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && cd ~/.pyenv/plugins/python-build && ./install.sh && /usr/local/bin/python-build -v 3.7.4 /usr/local/bin/python && rm -rf ~/.pyenv
ENV PATH $PATH:/usr/local/bin/python/bin


RUN pip install --upgrade pip setuptools
RUN pip install\
 tqdm\
 keras-rl2\
 gym\
 h5py\
 Pillow\
 gym[atari]\
 gym-notebook-wrapper\
 jupyter\
 tensorflow-gpu==2.4.0

RUN wget -O /Roms.rar http://www.atarimania.com/roms/Roms.rar
RUN mkdir /Roms && unrar x /Roms.rar /Roms && python -m atari_py.import_roms /Roms

RUN mkdir -p /root/.jupyter && echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo c.NotebookApp.open_browser = False >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /mnt
CMD jupyter notebook --allow-root --NotebookApp.token=''
