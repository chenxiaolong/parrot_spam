function spam(chars, parrots)
    buffer = IOBuffer(maxsize = chars)

    for parrot in Iterators.cycle(parrots)
        chars -= length(parrot)
        if chars < 0
            break
        end

        write(buffer, parrot)
    end

    return String(take!(buffer))
end

parrots = filter(!isempty, ARGS)
if isempty(parrots)
    println("Nothing to repeat")
    exit(1)
end

println(spam(4000, parrots))
