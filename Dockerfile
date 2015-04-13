# kaggle/julia dockerfile

FROM ubuntu:14.04

RUN  apt-get install git software-properties-common curl wget gettext libcairo2 libpango1.0-0 -y && \
     add-apt-repository ppa:staticfloat/julia-deps -y && \
     add-apt-repository ppa:staticfloat/juliareleases -y && \
     apt-get update -qq -y && \
     apt-get install libpcre3-dev julia -y && \
     julia -e 'Pkg.init(); Pkg.update()' && \
     julia -e 'Pkg.add("DataArrays")' && \
     julia -e 'Pkg.add("DataFrames")' && \
     julia -e 'Pkg.clone("https://github.com/dcjones/Showoff.jl")' && \
     julia -e 'Pkg.clone("https://github.com/benhamner/MachineLearning.jl")' && \
     julia -e 'Pkg.checkout("Gadfly")' && \
     julia -e 'Pkg.checkout("MachineLearning")' && \
     julia -e 'Pkg.pin("MachineLearning")' && \
     julia -e 'Pkg.checkout("Optim")' && \
     julia -e 'Pkg.checkout("Calculus")' && \
     julia -e 'Pkg.checkout("DataArrays")' && \
     julia -e 'Pkg.resolve()' && \
     julia -e 'using DataFrames' && \
     julia -e 'using Gadfly' && \
     julia -e 'using MachineLearning'

CMD ["julia"]
