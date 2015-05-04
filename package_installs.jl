metadata_packages = [
    "Cairo",
    "Calculus",
    "Clustering",
    "DataArrays",
    "DataFrames",
    "DataFramesMeta",
    "Distributions",
    "Distance",
    "Gadfly",
    "GLM",
    "HypothesisTests",
    "KernelDensity",
    "Lora",
    "MLBase",
    "MultivariateStats",
    "NMF",
    "Optim",
    "PDMats",
    "StatsBase",
    "TimeSeries"]

Pkg.init()
Pkg.update()

for package=metadata_packages
    Pkg.add(package)
end

Pkg.clone("https://github.com/benhamner/MachineLearning.jl")
Pkg.pin("MachineLearning")

Pkg.resolve()

# try imports
using Gadfly
using MachineLearning
