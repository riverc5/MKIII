local function GetDictionarySize(dictionary)
    local counter = 0

    for _, v in pairs(dictionary) do
        counter += 1
    end

    return counter
end

return GetDictionarySize