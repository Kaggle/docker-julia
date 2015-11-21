# kaggle/julia dockerfile

FROM kaggle/juliabuild

ADD package_installs.jl /tmp/package_installs.jl

RUN  cd /usr/local/src/julia && make && make install && \
     ln -s /usr/local/src/julia/julia /usr/local/bin/julia && \
     julia /tmp/package_installs.jl

# Pre-compiling packages within a Julia session doesn't seem to work at the moment.
RUN julia -e "Base.compilecache(\"BinDeps\")" && \
    julia -e "Base.compilecache(\"Cairo\")" && \
    julia -e "Base.compilecache(\"Calculus\")" && \
    julia -e "Base.compilecache(\"Clustering\")" && \
    julia -e "Base.compilecache(\"Compose\")" && \
    julia -e "Base.compilecache(\"DataArrays\")" && \
    julia -e "Base.compilecache(\"DataFrames\")" && \
    julia -e "Base.compilecache(\"DataFramesMeta\")" && \
    julia -e "Base.compilecache(\"Dates\")" && \
    julia -e "Base.compilecache(\"DecisionTree\")" && \
    julia -e "Base.compilecache(\"Distributions\")" && \
    julia -e "Base.compilecache(\"Distances\")" && \
    julia -e "Base.compilecache(\"GLM\")" && \
    julia -e "Base.compilecache(\"HDF5\")" && \
    julia -e "Base.compilecache(\"HypothesisTests\")" && \
    julia -e "Base.compilecache(\"JSON\")" && \
    julia -e "Base.compilecache(\"KernelDensity\")" && \
    julia -e "Base.compilecache(\"Loess\")" && \
    julia -e "Base.compilecache(\"Lora\")" && \
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
    julia -e "Base.compilecache(\"Gadfly\")" 

RUN julia -e "Base.compilecache(\"MachineLearning\")" && \
    julia -e "Base.compilecache(\"Lora\")" && \
    julia -e "Base.compilecache(\"MLBase\")" && \
    julia -e "Base.compilecache(\"Clustering\")"
    

# IJulia
RUN   apt-get update && apt-get install -y python-pip python-dev libcurl4-openssl-dev && \
        pip install jupyter pycurl && \
        cd /usr/local/src && git clone https://github.com/jupyter/nbconvert.git && \
        cd nbconvert && python setup.py install && \
        julia -e "Pkg.add(\"IJulia\")" && \
        julia -e "Pkg.build(\"IJulia\")" && \
# Make sure Jupyter won't try to migrate old settings
        mkdir -p /root/.jupyter/kernels && \
        cp -r /root/.local/share/jupyter/kernels/julia-0.5 /root/.jupyter/kernels && \
        touch /root/.jupyter/jupyter_nbconvert_config.py && touch /root/.jupyter/migrated && \
        julia -e "Base.compilecache(\"IJulia\")" && \
        julia -e "Base.compilecache(\"ZMQ\")" && \
        julia -e "Base.compilecache(\"Nettle\")" && \
        julia -e "using IJulia"

CMD ["julia"]
