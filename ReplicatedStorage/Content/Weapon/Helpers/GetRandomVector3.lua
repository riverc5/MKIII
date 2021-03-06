local DEFAULT_THETA = 100

local function GetRandomVector3(min, max, thetaArg)
    local theta = thetaArg or DEFAULT_THETA

    local x = math.random(min.X * theta, max.X * theta) / theta
    local y = math.random(min.Y * theta, max.Y * theta) / theta
    local z = math.random(min.Z * theta, max.Z * theta) / theta

    return Vector3.new(x, y, z)
end

return GetRandomVector3