# kaggle/julia dockerfile

FROM ubuntu:14.04

ADD package_installs.jl /tmp/package_installs.jl

RUN  apt-get install git software-properties-common curl wget gettext libcairo2 libpango1.0-0 -y && \
     add-apt-repository ppa:staticfloat/julia-deps -y && \
     add-apt-repository ppa:staticfloat/juliareleases -y && \
     apt-get update -qq -y && \
     apt-get install libpcre3-dev julia -y && \
     julia /tmp/package_installs.jl

CMD ["julia"]
