metadata_packages = [
    "Calculus",
    "DataArrays",
    "DataFrames",
    "Gadfly",
    "Optim",
    "StatsBase"]

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
