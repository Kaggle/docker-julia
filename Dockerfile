# kaggle/julia dockerfile

FROM julia:0.6.4

ADD package_installs.jl /tmp/package_installs.jl
ADD test_build.jl /tmp/test_build.jl

RUN apt-get update && \
    apt-get install -y build-essential gettext git hdf5-tools libcairo2 libpango1.0-0 python3 python3-dev python3-pip

# Pycall
ENV PYTHON /usr/bin/python3

# Conda
ENV CONDA_JL_VERSION 3

ENV JULIA_PKGDIR /root/.julia/
RUN julia -e "Pkg.init()"
ADD REQUIRE /root/.julia/v0.6/REQUIRE

RUN julia /tmp/package_installs.jl

# IJulia
RUN pip3 install jupyter && \
    julia -e "Pkg.add(\"Nettle\")" && \
    julia -e "Pkg.add(\"IJulia\")" && \
    # Make sure Jupyter won't try to migrate old settings
    mkdir -p /root/.jupyter/kernels && \
    cp -r /root/.local/share/jupyter/kernels/julia-0.6 /root/.jupyter/kernels && \
    touch /root/.jupyter/jupyter_nbconvert_config.py && touch /root/.jupyter/migrated && \
    julia -e "Base.compilecache(\"IJulia\")" && \
    julia -e "Base.compilecache(\"ZMQ\")" && \
    julia -e "Base.compilecache(\"Nettle\")"

# TensorFlow
RUN pip3 install tensorflow && \
    julia -e "Pkg.add(\"TensorFlow\")" && \
    julia -e "Base.compilecache(\"TensorFlow\")"

RUN julia -e "Pkg.status()" && \
    julia /tmp/test_build.jl

RUN julia -e "Base.compilecache(\"BinDeps\")" && \
    julia -e "Base.compilecache(\"Cairo\")" && \
    julia -e "Base.compilecache(\"Calculus\")" && \
    julia -e "Base.compilecache(\"Clustering\")" && \
    julia -e "Base.compilecache(\"Compose\")" && \
    julia -e "Base.compilecache(\"DataArrays\")" && \
    julia -e "Base.compilecache(\"DataFrames\")" && \
    julia -e "Base.compilecache(\"DataFramesMeta\")" && \
    julia -e "Base.compilecache(\"DecisionTree\")" && \
    julia -e "Base.compilecache(\"Distributions\")" && \
    julia -e "Base.compilecache(\"Distances\")" && \
    julia -e "Base.compilecache(\"GLM\")" && \
    julia -e "Base.compilecache(\"HDF5\")" && \
    julia -e "Base.compilecache(\"HypothesisTests\")" && \
    julia -e "Base.compilecache(\"JSON\")" && \
    julia -e "Base.compilecache(\"KernelDensity\")" && \
    julia -e "Base.compilecache(\"Loess\")" && \
    julia -e "Base.compilecache(\"MLBase\")" && \
    julia -e "Base.compilecache(\"MultivariateStats\")" && \
    julia -e "Base.compilecache(\"NMF\")" && \
    julia -e "Base.compilecache(\"Optim\")" && \
    julia -e "Base.compilecache(\"PDMats\")" && \
    julia -e "Base.compilecache(\"RDatasets\")" && \
    julia -e "Base.compilecache(\"SQLite\")" && \
    julia -e "Base.compilecache(\"StatsBase\")" && \
    julia -e "Base.compilecache(\"TextAnalysis\")" && \
    julia -e "Base.compilecache(\"TimeSeries\")" && \
    julia -e "Base.compilecache(\"ZipFile\")" && \
    julia -e "Base.compilecache(\"Gadfly\")" && \
    julia -e "Base.compilecache(\"MLBase\")" && \
    julia -e "Base.compilecache(\"Clustering\")" && \
    julia -e "using IJulia"

CMD ["julia"]
