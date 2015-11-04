# kaggle/julia dockerfile

FROM ubuntu:14.04

ADD package_installs.jl /tmp/package_installs.jl
ADD userimg.jl          /tmp/userimg.jl

RUN  apt-get install git software-properties-common curl wget libcairo2 libpango1.0-0 -qq -y && \
     add-apt-repository ppa:staticfloat/julia-deps -y && \
     apt-get update -qq -y && \
     apt-get install libpcre3-dev -y && \
     apt-get install build-essential gettext -qq -y && \
     apt-get install hdf5-tools -qq -y && \
     apt-get install -y gfortran

RUN  apt-get install -y python

RUN  apt-get install -y m4 cmake libssl-dev && \
     cd /usr/local/src && git clone https://github.com/JuliaLang/julia.git && \
     cd julia && make && make install
     
RUN  ln -s /usr/local/src/julia/julia /usr/local/bin/julia && julia /tmp/package_installs.jl

RUN   apt-get install -y python-pip python-dev libcurl4-openssl-dev && \
      pip install jupyter pycurl && \
      cd /usr/local/src && git clone https://github.com/jupyter/nbconvert.git && \
      cd nbconvert && python setup.py install && \
      julia -e "Pkg.add(\"IJulia\")" && \
      julia -e "Pkg.build(\"IJulia\")" && \
      julia -e "Pkg.update()" && \
      julia -e "Base.compilecache(\"ZMQ\"); Base.compilecache(\"Nettle\")"

RUN julia -e "Base.compilecache(\"IJulia\")"

RUN mkdir -p /root/.jupyter/kernels && cp -r /root/.local/share/jupyter/kernels/julia-0.5 /root/.jupyter/kernels && touch /root/.jupyter/jupyter_nbconvert_config.py && touch /root/.jupyter/migrated


CMD ["julia"]
