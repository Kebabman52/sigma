-- [LOCALS]
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- [Services]
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local ContentService = game:GetService("ContentProvider")
local TeleportService = game:GetService("TeleportService")
-- [Tween table & function]
local TweenTable = {
    Default = {
        TweenInfo.new(0.17, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
    }
}
local CreateTween = function(name, speed, style, direction, loop, reverse, delay)
    name = name
    speed = speed or 0.17
    style = style or Enum.EasingStyle.Sine
    direction = direction or Enum.EasingDirection.InOut
    loop = loop or 0
    reverse = reverse or false
    delay = delay or 0

    TweenTable[name] = TweenInfo.new(speed, style, direction, loop, reverse, delay)
end

-- [Dragging]
local drag = function(obj, latency)
    obj = obj
    latency = latency or 0.06

    toggled = nil
    input = nil
    start = nil

    function updateInput(input)
        local Delta = input.Position - start
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(obj, TweenInfo.new(latency), {Position = Position}):Play()
    end

    obj.InputBegan:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1) then
            toggled = true
            start = inp.Position
            startPos = obj.Position
            inp.Changed:Connect(function()
                if (inp.UserInputState == Enum.UserInputState.End) then
                    toggled = false
                end
            end)
        end
    end)

    obj.InputChanged:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseMovement) then
            input = inp
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if (inp == input and toggled) then
            updateInput(inp)
        end
    end)
end
local library = {
    version = "0.2",
    title = title or "Exclusive " .. tostring(math.random(1,366)),
    fps = 0,
    rank = "private"
}

new(0, 4)
    tabButtonPadding.PaddingRight = UDim.new(0, 4)
    tabButtonPadding.PaddingTop = UDim.new(0, 4)

    container.Name = "container"
    container.Parent = background
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.Size = UDim2.new(0, 410, 0, 356)

    containerGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    containerGradient.Rotation = 90
    containerGradient.Name = "containerGradient"
    containerGradient.Parent = container

    local TabLibrary = {
        IsFirst = true,
        CurrentTab = ""
function library:Menu(key)
    for _,v in next, CoreGuiService:GetChildren() do
        if v.Name == "screen" then
            v:Destroy()
        end
    end

    local title = library.title
    key = key or Enum.KeyCode.Insert or library.key

    local screen = Instance.new("ScreenGui")
    local background = Instance.new("Frame")
    local backgroundGradient = Instance.new("UIGradient")
    local headerLabel = Instance.new("TextLabel")
    local headerPadding = Instance.new("UIPadding")
    local barFolder = Instance.new("Folder")
    local bar = Instance.new("Frame")
    local barGradient = Instance.new("UIGradient")
    local barLayout = Instance.new("UIListLayout")
    local tabButtons = Instance.new("Frame")
    local tabButtonsGradient = Instance.new("UIGradient")
    local tabButtonLayout = Instance.new("UIListLayout")
    local tabButtonPadding = Instance.new("UIPadding")
    local container = Instance.new("Frame")
    local containerGradient = Instance.new("UIGradient")

    screen.Name = "screen"
    screen.Parent = CoreGuiService
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling


    drag(background, 0.04)
    local CanChangeVisibility = true
    UserInputService.InputBegan:Connect(function(input)
        if CanChangeVisibility and input.KeyCode == key then
            background.Visible = not background.Visible
        end
    end)

    background.Name = "background"
    background.Parent = screen
    background.AnchorPoint = Vector2.new(0.5, 0.5)
    background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    background.Position = UDim2.new(0.5, 0, 0.5, 0)
    background.Size = UDim2.new(0, 590, 0, 402)
    background.ClipsDescendants = true

    backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    backgroundGradient.Rotation = 90
    backgroundGradient.Name = "backgroundGradient"
    backgroundGradient.Parent = background

    headerLabel.Name = "headerLabel"
    headerLabel.Parent = background
    headerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.BackgroundTransparency = 1.000
    headerLabel.Size = UDim2.new(0, 592, 0, 38)
    headerLabel.Font = Enum.Font.Code
    headerLabel.Text = title
    headerLabel.TextColor3 = Color3.fromRGB(198, 198, 198)
    headerLabel.TextSize = 16.000
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.RichText = true

    headerPadding.Name = "headerPadding"
    headerPadding.Parent = headerLabel
    headerPadding.PaddingBottom = UDim.new(0, 6)
    headerPadding.PaddingLeft = UDim.new(0, 12)
    headerPadding.PaddingRight = UDim.new(0, 6)
    headerPadding.PaddingTop = UDim.new(0, 6)

    barFolder.Name = "barFolder"
    barFolder.Parent = background

    bar.Name = "bar"
    bar.Parent = barFolder
    bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bar.BackgroundTransparency = 0.200
    bar.Size = UDim2.new(0, 592, 0, 1)
    bar.BorderSizePixel = 0
    
    barGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(61, 135, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(128, 94, 208))}
    barGradient.Rotation = 0
    barGradient.Name = "barGradient"
    barGradient.Parent = bar

    barLayout.Name = "barLayout"
    barLayout.Parent = barFolder
    barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    barLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabButtons.Name = "tabButtons"
    tabButtons.Parent = background
    tabButtons.AnchorPoint = Vector2.new(0.5, 0.5)
    tabButtons.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    tabButtons.ClipsDescendants = true
    tabButtons.Position = UDim2.new(0.5, 0, 0.5, 0)
    tabButtons.Size = UDim2.new(0, 148, 0, 356)

    tabButtonsGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    tabButtonsGradient.Rotation = 90
    tabButtonsGradient.Name = "tabButtonsGradient"
    tabButtonsGradient.Parent = tabButtons

    tabButtonLayout.Name = "tabButtonLayout"
    tabButtonLayout.Parent = tabButtons
    tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabButtonPadding.Name = "tabButtonPadding"
    tabButtonPadding.Parent = tabButtons
    tabButtonPadding.PaddingBottom = UDim.new(0, 4)
    tabButtonPadding.PaddingLeft = UDim.
    }
    CreateTween("tab_text_colour", 0.16)
    return TabLibrary
end
return library