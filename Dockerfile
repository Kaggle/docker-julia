# kaggle/julia dockerfile

FROM kaggle/juliabuild

ADD package_installs.jl /tmp/package_installs.jl

RUN  cd /usr/local/src/julia && make && make install && \
     ln -s /usr/local/src/julia/julia /usr/local/bin/julia && \
     julia /tmp/package_installs.jl

# IJulia
RUN   apt-get install -y python-pip python-dev libcurl4-openssl-dev && \
      pip install jupyter pycurl && \
      cd /usr/local/src && git clone https://github.com/jupyter/nbconvert.git && \
      cd nbconvert && python setup.py install && \
      julia -e "Pkg.add(\"IJulia\")" && \
      julia -e "Pkg.build(\"IJulia\")" && \
      julia -e "Pkg.update()" && \
      julia -e "Base.compilecache(\"ZMQ\"); Base.compilecache(\"Nettle\")"

# Make sure IJulia doesn't need any compilation and that Jupyter won't try to
# migrate old settings
RUN julia -e "Base.compilecache(\"IJulia\")" && \
    mkdir -p /root/.jupyter/kernels && \
    cp -r /root/.local/share/jupyter/kernels/julia-0.5 /root/.jupyter/kernels && \
    touch /root/.jupyter/jupyter_nbconvert_config.py && touch /root/.jupyter/migrated


CMD ["julia"]
