export getchar, set_homedir, get_homedir

charset = 'a':'z'

getchar(idx) = charset[idx]::Char

global homedir = ["wrong"]::Vector{String}

function set_homedir(path::String)::Vector{String}
    global homedir = [path]
    return homedir
end

get_homedir() = homedir[1]::String