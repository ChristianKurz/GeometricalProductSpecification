function zeropad(profile::SurfaceProfile, component::Symbol)
    c = profile.component
    bc = profile.λc * profile.resolution
    cut = round(Int, bc/2)
    c = c[cut:end-cut]
end