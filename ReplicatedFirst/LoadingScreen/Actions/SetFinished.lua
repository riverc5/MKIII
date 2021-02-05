local Rodux = require(script.Parent.Parent.Parent.Immediate.Rodux)

local SetFinished = Rodux.makeActionCreator("SetFinished", function(finished)
    return {
        finished = finished,
    }
end)

return SetFinished