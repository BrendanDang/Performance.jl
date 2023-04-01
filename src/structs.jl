export DefaultArray

# This implements an array that returns a "default" value when
# accessed out of bounds. Example:
#     a = DefaultArray([1.0, 2.0], NaN)
#     a[1]   # returns 1.0
#     a[5]   # returns NaN (does not throw a BoundsError)
# However, this is a deliberately "amateurish" implementation
# and it has numerous deficiencies.

# To solve this problem, you'll have to improve the `struct` definition and modify/add constructors
# Hint: every aspect of the struct definition should be improved (not just the fields)
struct DefaultArray{N} <: AbstractArray{Int64,N}
    parentarray::Array{Int64}
    defaultvalue::Int64
end

struct DefaultArrayFloatAlt{N} <: AbstractArray{Union{Nothing,Float32},N}
    parentarray::Array{Union{Nothing,Float32}}
    defaultvalue::Union{Nothing,Float32}
end

struct DefaultArrayFloat{N} <: AbstractArray{Float32,N}
    parentarray::Array{Float32}
    defaultvalue::Float32
end

# Call different constructors based on input types
function DefaultArray(parentarray::Array{Int64}, defaultvalue::Int64)
    bucket = DefaultArray{ndims(parentarray)}(parentarray, defaultvalue)
    return bucket
end

function DefaultArray(parentarray::Array{Float32}, defaultvalue::Nothing)
    bucket = DefaultArrayFloatAlt{ndims(parentarray)}(parentarray, defaultvalue)
    return bucket
end

function DefaultArray(parentarray::Array{Float32}, defaultvalue::Int64)
    dv = promote(parentarray[1],defaultvalue)[2]
    bucket = DefaultArrayFloat{ndims(parentarray)}(parentarray, dv)
    return bucket
end

# Methods for different constructors
Base.getindex(a::DefaultArray{N}, i::Vararg{Int,N}) where N = checkbounds(Bool, a, i...) ? a.parentarray[i...] : a.defaultvalue
Base.size(a::DefaultArray) = size(a.parentarray)
Base.getindex(a::DefaultArrayFloat{N}, i::Vararg{Int,N}) where N = checkbounds(Bool, a, i...) ? a.parentarray[i...] : a.defaultvalue
Base.size(a::DefaultArrayFloat) = size(a.parentarray)
Base.getindex(a::DefaultArrayFloatAlt{N}, i::Vararg{Int,N}) where N = checkbounds(Bool, a, i...) ? a.parentarray[i...] : a.defaultvalue
Base.size(a::DefaultArrayFloatAlt) = size(a.parentarray)