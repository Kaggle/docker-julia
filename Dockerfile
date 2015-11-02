# kaggle/julia dockerfile

FROM ubuntu:14.04

ADD package_installs.jl /tmp/package_installs.jl
ADD userimg.jl          /tmp/userimg.jl

RUN  apt-get install git software-properties-common curl wget libcairo2 libpango1.0-0 -qq -y && \
     add-apt-repository ppa:staticfloat/julia-deps -y && \
     add-apt-repository ppa:staticfloat/juliareleases -y && \
     apt-get update -qq -y && \
     apt-get install libpcre3-dev julia -y && \
     apt-get install build-essential gettext -qq -y && \
     apt-get install hdf5-tools -qq -y && \
     julia /tmp/package_installs.jl
#     cd /tmp && \
#     git clone git://github.com/JuliaLang/julia.git && \
#     cd /tmp/julia && \
#     git checkout release-0.3 && \
#     cd /tmp && \
#     julia julia/contrib/build_sysimg.jl /usr/lib/x86_64-linux-gnu/julia/sys core2 /tmp/userimg.jl --force

RUN  apt-get install -y python3-pip && \
      pip3 install jupyter && \
      cd /usr/local/src && git clone https://github.com/jupyter/nbconvert.git && \
      cd nbconvert && python3 setup.py install && \
      julia -e "Pkg.add(\"IJulia\")" && \
      julia -e "Pkg.update()"

CMD ["julia"]
