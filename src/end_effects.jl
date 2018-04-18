"""
`profile` is truncated to eliminate end-effects. This is equivalent to zero-padding described in [DIN EN ISO 16610-28:2017]().
"""
function zeropad(profile::SurfaceProfile, component::Symbol)
    c = profile.component
    bc = profile.λc * profile.resolution
    cut = round(Int, bc/2)
    c = c[cut:end-cut]
end