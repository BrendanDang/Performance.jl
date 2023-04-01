export sequence_of_three, alternate_items

function sequence_of_three(start::Union{Int64,Float64})
    if typeof(start) == Int64
        out = Vector{Int64}()
    else
        out = Vector{Float64}()
    end
    println(out, typeof(out))
    push!(out, start, start+1, start+2)
    return out
end

function alternate_items(nrepeats::Integer, item1::Union{Missing,Int64}, item2::Int64)
    if typeof(item1) == Int64 && typeof(item2) == Int64
        out = Vector{Int64}()
    else
        out = Vector{Union{Missing,Int64}}()
    end
    for _ = 1:nrepeats           # _ is often used for a variable you'll not use again
        push!(out, item1, item2)
    end
    return out
end