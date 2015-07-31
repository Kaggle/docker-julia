metadata_packages = [
    "BinDeps",
    "Cairo",
    "Calculus",
    "Clustering",
    "DataArrays",
    "DataFrames",
    "DataFramesMeta",
    "Dates",
    "DecisionTree",
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
    "NMF",
    "Optim",
    "PDMats",
    "RDatasets",
    "StatsBase",
    "TimeSeries",
    "ZipFile"]

Pkg.init()
Pkg.update()

for package=metadata_packages
    Pkg.add(package)
end

# need to build XGBoost version for it to work
Pkg.clone("https://github.com/antinucleon/XGBoost.jl.git")
Pkg.build("XGBoost")

Pkg.clone("https://github.com/benhamner/MachineLearning.jl")
Pkg.clone("https://github.com/johnmyleswhite/NearestNeighbors.jl")
Pkg.pin("MachineLearning")

Pkg.resolve()
