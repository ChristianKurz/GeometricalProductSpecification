export z, t, abbott

include("end_effects.jl")

"""
    Rz(R, λc=250)

Determine roughness of the roughness-profile R. R is truncated to eliminate end-effects. This is equivalent to zero-padding described in [DIN EN ISO 16610-28:2017](references/DIN_EN_ISO_16610-28_2017-04.pdf). Filterwavelength in accordance with [DIN EN ISO 3274:1998](DIN_EN_ISO_3274_1998.pdf) and FMS100-evaluation (Nozzlebody.txt).
"""
function z(profile::SurfaceProfile, component::Symbol, eliminate_end_effect=zeropad)
    c = eliminate_end_effect(profile, component)
    bc = profile.λc * profile.resolution
    maximum(-[-(extrema(c[n+1:n+bc])...) for n ∈ 1:bc:(length(c)-bc)])
end

"""
    Wt(W, λc=250)

Determine roughness of the waviness-profile W. W is truncated to eliminate end-effects. This is equivalent to zero-padding described in [DIN EN ISO 16610-28:2017](references/DIN_EN_ISO_16610-28_2017-04.pdf). Filterwavelength in accordance with [DIN EN ISO 3274:1998](DIN_EN_ISO_3274_1998.pdf) and FMS100-evaluation (Nozzlebody.txt).
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