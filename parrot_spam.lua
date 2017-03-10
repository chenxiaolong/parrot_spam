#! /usr/bin/env lua

local parrots = {}
for _, a in ipairs {...} do
    if #a > 0 then table.insert(parrots, a) end
end
if #parrots == 0 then
    io.stderr:write "Nothing to repeat\n"
    os.exit(1)
end

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
