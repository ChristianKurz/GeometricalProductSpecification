module GeometricalProductSpecification

include("gauss_filters.jl")
include("parameters_1d.jl")

import Plots: plot

export SurfaceProfile

struct SurfaceProfile
    data::Array{Float64,1}
    R::Array{Float64,1}
    W::Array{Float64,1}
    F::Array{Float64,1}
    resolution::Float64
    λs::Int
    λc::Int
    λf::Int
    features::Array{Function,1}
    parameters::Dict{String, Float64}
    function SurfaceProfile(data, res, λs, λc, λf, features=[], parameters=Dict())
        components = idct.(separatefeatures(data, 1/res, filterwavelengths=[λs, λc, λf]))
        return new(data, components..., res, λs, λc, λf, features, parameters)
    end
end

function plot(profile::SurfaceProfile)
    p1 = plot(profile.R, label="R")
        plot!(profile.W, label="W")
        plot!(profile.F, label="F")
    return p1
end

end #module GeometricalProductSpecifications