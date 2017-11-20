metadata_packages = [
    "BinDeps",
    "Bootstrap",
    "Cairo",
    "Calculus",
    "Clustering",
    "CSV",
    "DataArrays",
    "DataFrames",
    "DataFramesMeta",
    "DataStreams",
    "Dates",
    "DecisionTree",
    "Distributions",
    "Distances",
    "Feather",
    "Flux",
    "Gadfly",
    "GLM",
    "GR",
    "HDF5",
    "HypothesisTests",
    "JSON",
    "JLD2",
    "KernelDensity",
    "Klara",
    "Mamba",
    "ManifoldLearning",
    "MLBase",
    "MultivariateStats",
    "NMF",
    "OnlineStats",
    "Optim",
    "Pandas",
    "Plots",
    "PyCall",
    "PyPlot",
    "PDMats",
    "RDatasets",
    "SQLite",
    "StatsBase",
    "TensorFlow",
    "TextAnalysis",
    "TSne",
    "Turing",
    "TimeSeries",
    "Query",
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
Pkg.pin("MachineLearning")

Pkg.resolve()
