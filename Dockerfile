# kaggle/julia dockerfile

FROM julia:1.1.0

ADD package_installs.jl /tmp/package_installs.jl
ADD test_build.jl /tmp/test_build.jl

RUN apt-get update && \
  apt-get install -y build-essential gettext git hdf5-tools libcairo2 libpango1.0-0 python3 python3-dev python3-pip

# Pycall
ENV PYTHON /usr/bin/python3

# Conda
ENV CONDA_JL_VERSION 3

ENV JULIA_PKGDIR /root/.julia/

RUN julia /tmp/package_installs.jl

# IJulia
RUN pip3 install jupyter && \
  julia -e "using Pkg;Pkg.add(\"IJulia\")" && \
  # Make sure Jupyter won't try to migrate old settings
  mkdir -p /root/.jupyter/kernels && \
  cp -r /root/.local/share/jupyter/kernels/julia-1.1 /root/.jupyter/kernels && \
  touch /root/.jupyter/jupyter_nbconvert_config.py && touch /root/.jupyter/migrated

# TensorFlow
RUN pip3 install tensorflow && \
  julia -e "using Pkg;Pkg.add(\"TensorFlow\")"

RUN julia -e "using Pkg;Pkg.status()"

RUN julia /tmp/test_build.jl

RUN julia -e "Base.compilecache(Base.identify_package(\"BinDeps\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Cairo\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Calculus\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Clustering\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Compose\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"DataFrames\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"DataFramesMeta\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"DecisionTree\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Distributions\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Distances\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Gadfly\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"GLM\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"HDF5\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"HypothesisTests\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"IJulia\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"JSON\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"KernelDensity\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Loess\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"MLBase\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"MultivariateStats\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"NMF\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Optim\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"PDMats\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"RDatasets\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"SQLite\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"StatsBase\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"TensorFlow\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"TextAnalysis\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"TimeSeries\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"Turing\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"ZipFile\"))" && \
  julia -e "Base.compilecache(Base.identify_package(\"ZMQ\"))" && \
  julia -e "using IJulia"

CMD ["julia"]
