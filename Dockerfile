# kaggle/julia dockerfile

FROM ubuntu:14.04

RUN  apt-get install git software-properties-common curl wget gettext libcairo2 libpango1.0-0 -y && \
     add-apt-repository ppa:staticfloat/julia-deps -y && \
     add-apt-repository ppa:staticfloat/julianightlies -y && \
     apt-get update -qq -y && \
     apt-get install libpcre3-dev julia -y && \
     julia -e 'Pkg.init()' && \
     julia -e 'Pkg.clone("https://github.com/dcjones/Showoff.jl"); Pkg.clone("https://github.com/benhamner/MachineLearning.jl"); Pkg.checkout("Gadfly"); Pkg.checkout("MachineLearning"); Pkg.pin("MachineLearning"); Pkg.resolve();'

CMD ["julia"]
