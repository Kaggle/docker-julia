# kaggle/julia dockerfile

FROM debian:jessie

ENV JULIA_PATH /usr/local/julia

RUN  apt-get update -qq -y && \
     apt-get install git software-properties-common curl wget gettext libcairo2 libpango1.0-0 -y && \
     curl -sSL https://status.julialang.org/download/linux-x86_64 | tar -xz -C $JULIA_PATH --strip-components 1 && \
     julia -e 'Pkg.init()' && \
     julia -e 'Pkg.clone("https://github.com/dcjones/Showoff.jl"); Pkg.clone("https://github.com/benhamner/MachineLearning.jl"); Pkg.checkout("Gadfly"); Pkg.checkout("MachineLearning"); Pkg.pin("MachineLearning"); Pkg.resolve();'

CMD ["julia"]
