module GeometricalProductSpecification

include("gauss_filters.jl")
include("parameters_1d.jl")

import Plots: plot

export SurfaceProfile

struct SurfaceProfile
    data::Array{Float64,1}
    resolution::Float64
    filterwavelengths::Vector{Float64}
    components::Array{Array{Float64,1},1}
    features::Array{Function,1}
    parameters::Dict{String, Float64}
    function SurfaceProfile(data, res, filterwavelengths=[2.5, 250.0, 2500.0],
                            features=[], parameters=Dict())
        components = idct.(separatefeatures(data, 1/res, filterwavelengths))
        return new(data, res, filterwavelengths, components, features, parameters)
    end
end

function plot(profile::SurfaceProfile)
    p1 = plot(profile.R, label="R")
        plot!(profile.W, label="W")
        plot!(profile.F, label="F")
    return p1
end

end #module GeometricalProductSpecifications