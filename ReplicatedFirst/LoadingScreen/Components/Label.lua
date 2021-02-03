local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)

local Label = Roact.Component:extend("Label")

function Label:init()
    self.active = true
    self.text, self.updateText = Roact.createBinding("LOADING")
end

function Label:render()
    return Roact.createElement("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.244, 0, 0.114, 0),
        Position = UDim2.new(0.547, 0, 0.629, 0),
        TextScaled = true,
        BackgroundTransparency = 1,
        Font = Enum.Font.TitilliumWeb,
        Text = "LOADING"..self.text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
    })
end

function Label:didMount()
    coroutine.wrap(function()
        while self.active == true do
            self.updateText(".")
            wait(0.25)
            self.updateText("..")
            wait(0.25)
            self.updateText("...")
            wait(1.1)
        end
    end)()
end

function Label:willUnmount()
    self.active = false
end

return Label