#! /usr/bin/env lua

local parrots = {...}

for _, p in ipairs(parrots) do
    if #p > 0 then goto ok end
end
io.stderr:write "Nothing to repeat\n"
os.exit(1)
::ok::

local function spam(ps, lim)
    return coroutine.wrap(function()
        local total = 0

        while true do
            for _, p in ipairs(ps) do
                total = total + #p
                if total > lim then return end

                coroutine.yield(p)
            end
        end
    end)
end

for p in spam(parrots, 4000) do
    io.write(p)
end
if os.execute "[ -t 1 ]" then print() end
