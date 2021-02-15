local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local AddTabRef = Rodux.makeActionCreator("AddTabRef", function(ref)
    return ref
end)

return AddTabRef