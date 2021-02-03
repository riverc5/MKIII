local function CreateMotor(part0, part1, c0)
    local motor = Instance.new("Motor6D")
    motor.Name = part1.Name
    motor.Part0 = part0
    motor.Part1 = part1
    motor.C0 = c0
    motor.Parent = part0
    
    return motor
end

return CreateMotor