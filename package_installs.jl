metadata_packages = [
    "Cairo",
    "Calculus",
    "Clustering",
    "DataArrays",
    "DataFrames",
    "DataFramesMeta",
    "Dates",
    "Distributions",
    "Distance",
    "Gadfly",
    "GLM",
    "HDF5",
    "HypothesisTests",
    "JSON",
    "KernelDensity",
    "Lora",
    "MLBase",
    "MultivariateStats",
    "NearestNeighbors",
    "NMF",
    "Optim",
    "PDMats",
    "StatsBase",
    "TimeSeries",
    "ZipFile"]

Pkg.init()
Pkg.update()

for package=metadata_packages
    Pkg.add(package)
end

Pkg.clone("https://github.com/benhamner/MachineLearning.jl")
Pkg.pin("MachineLearning")

Pkg.resolve()
