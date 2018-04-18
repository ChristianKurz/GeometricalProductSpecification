export z, t, abbott

include("end_effects.jl")

"""
    Rz(R, λc=250)

Determine roughness of profile-component `component`. Filterwavelength in accordance with [DIN EN ISO 3274:1998](DIN_EN_ISO_3274_1998.pdf).
"""
function z(profile::SurfaceProfile, component::Symbol, eliminate_end_effect=zeropad)
    c = eliminate_end_effect(profile, component)
    bc = profile.λc * profile.resolution
    maximum(-[-(extrema(c[n+1:n+bc])...) for n ∈ 1:bc:(length(c)-bc)])
end

"""
    Wt(W, λc=250)

Determine waviness of the waviness-profile W. Filterwavelength in accordance with [DIN EN ISO 3274:1998](DIN_EN_ISO_3274_1998.pdf).
"""
function t(profile::SurfaceProfile, component::Symbol, eliminate_end_effect=zeropad)
    c = eliminate_end_effect(profile, component)
    maximum(c) - minimum(c)
end

"""
    abbott(surf)

Calculate an [Abbott-Firestone-Curve](https://en.wikipedia.org/wiki/Abbott-Firestone_curve) for the line scan given in `surf`.
"""
abbott(surf) = [quantile(surf, i) for i ∈ 1:-0.01:0]