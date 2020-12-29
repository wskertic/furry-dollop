FROM gitpod/workspace-full

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
# ENV PATH /opt/conda/bin:$PATH

# USER root
# RUN echo "Set disable_coredump false" >> /etc/sudo.conf

# USER gitpod
RUN sudo apt-get update --fix-missing && \
    sudo apt-get install -y wget bzip2 ca-certificates curl git && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh -O ~/miniconda.sh && \
#     sudo /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     /opt/conda/bin/conda clean -tipsy && \
#     sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

ENV TINI_VERSION=v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN sudo chmod +x /usr/bin/tini

# USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install flake8-black nb_black pre_commit

ENV PIP_USER=false
    
# RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda activate base" >> ~/.bashrc
#     conda config --append channels conda-forge && \
#     conda install flake8-black, nb_black, pre_commit

# ENV CONDARC ~/workspace/furry-dollop/.condarc

ENTRYPOINT [ "/usr/bin/tini", "--"]
CMD [ "/bin/bash" ]
