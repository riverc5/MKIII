-- TODO: Set up TUU Firebase database
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")

local SensitiveData = require(ServerStorage.SensitiveData)

local Firebase = {}

local Key = "?auth="..SensitiveData.APIKeys.Firebase
local URL = SensitiveData.URLs.Firebase

function Firebase:GetAsync(path)
    local url = URL.. tostring(path) ..".json"..Key
    return HttpService:JSONDecode(HttpService:GetAsync(url))
end

function Firebase:SetAsync(path, value)
    local url = URL..tostring(path)..".json"..Key
    local header = {["X-HTTP-Method-Override"]="PUT"}
    local reply = HttpService:PostAsync(url, HttpService:JSONEncode(value),
        Enum.HttpContentType.ApplicationUrlEncoded, false, header
    )
    return HttpService:JSONDecode(reply or "[]")
end

function Firebase:DeleteAsync(path)
    local url = URL..tostring(path)..".json"..Key
    local header = {["X-HTTP-Method-Override"]="DELETE"}
    local reply = HttpService:PostAsync(url, HttpService:JSONEncode("null"),
        Enum.HttpContentType.ApplicationUrlEncoded, false, header
    )
end

return Firebase