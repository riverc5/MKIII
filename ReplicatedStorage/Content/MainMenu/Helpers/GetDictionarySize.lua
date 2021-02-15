local function GetDictionarySize(dictionary)
    local counter = 0

    for _, _ in pairs(dictionary) do
        counter += 1
    end

    return counter
end

return GetDictionarySize