Pkg.update()

# install from /root/.julia/v0.6/REQUIRE
Pkg.resolve()

# need to build XGBoost version for it to work
Pkg.clone("https://github.com/dmlc/XGBoost.jl.git")
Pkg.build("XGBoost")

Pkg.clone("https://github.com/Allardvm/LightGBM.jl.git")
ENV["LIGHTGBM_PATH"] = "../LightGBM"

Pkg.resolve()
