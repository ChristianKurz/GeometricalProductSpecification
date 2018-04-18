gauss_lowpass(x, λc)  = exp(-π*((√(log(2)/π)*λc)/x)^2)
gauss_highpass(x, λc) = 1-gauss_lowpass(x, λc)

"""
    separatefeatures(frequencies, rate; filterwavelengths=[2.5, 250, 2500])

Filter frequencies for roughness-, waviness- and form-components. `rate`(points/mm) is needed to convert `filterwavelengths`(μm) to corresponding filter bins.
"""
function separatefeatures(data, rate; filterwavelengths=[2.5, 250, 2500])
    frequencies = dct(data)
    N = rate/2 # maximal spatial frequency (points/mm)
    bins = length(frequencies)
    filterbins = 1 ./ (filterwavelengths*1e-3) / (N/bins)

    weights(b1, b2) = gauss_highpass.(1:bins, b1) .* gauss_lowpass.(1:bins, b2)

    res = Array{Array{Float64, 1}, 1}(length(filterwavelengths))
    for i in 1:length(filterwavelengths)
        b1 = filterbins[i]
        b2 = i == length(filterwavelengths) ? 0 : filterbins[i+1]
        res[i] = frequencies .* weights(b1, b2)
    end
    return res
end