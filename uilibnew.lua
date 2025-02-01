

-- / Locals
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- / Services
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local ContentService = game:GetService("ContentProvider")
local TeleportService = game:GetService("TeleportService")

-- / Tween table & function
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

-- / Dragging
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

coroutine.wrap(function()
    RunService.RenderStepped:Connect(function(v)
        library.fps =  math.round(1/v)
    end)
end)()

function library:RoundNumber(int, float)
    return tonumber(string.format("%." .. (int or 0) .. "f", float))
end
--[[
function library:GetUsername()
    return Player.Name
end
]]
function library:CheckIfLoaded()
    if game:IsLoaded() then
        return true
    else
        return false
    end
end

function library:GetUserId()
    return Player.UserId
end

function library:GetPlaceId()
    return game.PlaceId
end

function library:GetJobId()
    return game.JobId
end

function library:Rejoin()
    TeleportService:TeleportToPlaceInstance(library:GetPlaceId(), library:GetJobId(), library:GetUserId())
end

new(0, 4)
    tabButtonPadding.PaddingRight = UDim.new(0, 4)
    tabButtonPadding.PaddingTop = UDim.new(0, 4)

    containerEdge.Name = "containerEdge"
    containerEdge.Parent = background
    containerEdge.AnchorPoint = Vector2.new(0.5, 0.5)
    containerEdge.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    containerEdge.Position = UDim2.new(0.637000024, 0, 0.536000013, 0)
    containerEdge.Size = UDim2.new(0, 414, 0, 360)

    container.Name = "container"
    container.Parent = containerEdge
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
    local backgroundCorner = Instance.new("UICorner")
    local backgroundStroke = Instance.new("UIStroke")
    local headerText = Instance.new("TextLabel")
    local headerPadding = Instance.new("UIPadding")
    local tabsFrame = Instance.new("ScrollingFrame")



    local barFolder = Instance.new("Folder")
    local bar = Instance.new("Frame")
    local barGradient = Instance.new("UIGradient")
    local barLayout = Instance.new("UIListLayout")
    
    local tabButtonsGradient = Instance.new("UIGradient")
    local tabButtonLayout = Instance.new("UIListLayout")
    local tabButtonPadding = Instance.new("UIPadding")
    local containerEdge = Instance.new("Frame")
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

    backgroundCorner.CornerRadius = UDim.new(0, 20  )
    backgroundCorner.Name = "backgroundCorner"
    backgroundCorner.Parent = background

    backgroundStroke.Name = "backgroundStroke"
    backgroundStroke.Parent = background
    backgroundStroke.Thickness = 1.1
    backgroundStroke.Color = Color3.fromRGB(0, 76, 255)

    headerText.Name = "headerText"
    headerText.Parent = background
    headerText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    headerText.BackgroundTransparency = 1.000
    headerText.Size = UDim2.new(0, 675, 0, 39)
    headerText.Font = Enum.Font.Code
    headerText.Text = title
    headerText.TextColor3 = Color3.fromRGB(129, 129, 129)
    headerText.TextSize = 39.000
    headerText.TextXAlignment = Enum.TextXAlignment.Left
    headerText.RichText = true

    tabsFrame.Name = "tabsFrame"
    tabsFrame.Parent = background
    tabsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    tabsFrame.ClipsDescendants = true
    tabsFrame.Position = UDim2.new(0.013, 0, 0.12, 0)
    tabsFrame.Size = UDim2.new(0, 100, 0, 290)




    --[[
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


    

    tabButtonLayout.Name = "tabButtonLayout"
    tabButtonLayout.Parent = tabButtons
    tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabButtonPadding.Name = "tabButtonPadding"
    tabButtonPadding.Parent = tabButtons
    tabButtonPadding.PaddingBottom = UDim.new(0, 4)
    tabButtonPadding.PaddingLeft = UDim.]]--
    }
    CreateTween("tab_text_colour", 0.16)
    function TabLibrary:Menu()
        title = title or "tab"

        local tabButton = Instance.new("TextButton")
        local tabButtonsGradient = Instance.new("UIGradient")
        local tabButtonStroke = Instance.new("UIStroke")
        local page = Instance.new("ScrollingFrame")
        local pageLayout = Instance.new("UIListLayout")
        local pagePadding = Instance.new("UIPadding")

        tabButton.Name = "tabButton"
        tabButton.Parent = tabsFrame
        tabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        tabButton.BackgroundTransparency = 0.000
        tabButton.ClipsDescendants = true
        tabButton.Position = UDim2.new(-0.0281690136, 0, 0, 0)
        tabButton.Size = UDim2.new(0, 125, 0, 22)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Code
        tabButton.Text = title
        tabButton.TextColor3 = Color3.fromRGB(170, 170, 170)
        tabButton.TextSize = 15.000
        tabButton.RichText = true

        --tabButtonsGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
        --tabButtonsGradient.Rotation = 90
        --tabButtonsGradient.Name = "tabButtonsGradient"
        --tabButtonsGradient.Parent = tabButton

        --tabButtonStroke.Name = "TabButtonStroke"
        --tabButtonStroke.Parent = tabButton
        --tabButtonStroke.Color = Color3.fromRGB(61, 135, 255)
        --tabButtonStroke.Thickness = 1
        --tabButtonStroke.ApplyStrokeMode = Border
        --[[page.Name = "page"
        page.Parent = container
        page.Active = true
        page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        page.BackgroundTransparency = 1.000
        page.BorderSizePixel = 0
        page.Size = UDim2.new(0, 412, 0, 358)
        page.BottomImage = "http://www.roblox.com/asset/?id=3062506202"
        page.MidImage = "http://www.roblox.com/asset/?id=3062506202"
        page.ScrollBarThickness = 1
        page.TopImage = "http://www.roblox.com/asset/?id=3062506202"
        page.ScrollBarImageColor3 = Color3.fromRGB(61, 135, 255)
        page.Visible = false
        
        pageLayout.Name = "pageLayout"
        pageLayout.Parent = page
        pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 4)

        pagePadding.Name = "pagePadding"
        pagePadding.Parent = page
        pagePadding.PaddingBottom = UDim.new(0, 6)
        pagePadding.PaddingLeft = UDim.new(0, 6)
        pagePadding.PaddingRight = UDim.new(0, 6)
        pagePadding.PaddingTop = UDim.new(0, 6)]]--

        if TabLibrary.IsFirst then
            --page.Visible = true
            tabButton.TextColor3 = Color3.fromRGB(61, 135, 255)
            TabLibrary.CurrentTab = title
        end
        
        tabButton.MouseButton1Click:Connect(function()
            TabLibrary.CurrentTab = title
            for i,v in pairs(container:GetChildren()) do 
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            --page.Visible = true

            for i,v in pairs(tabButtons:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenTable["tab_text_colour"], {TextColor3 = Color3.fromRGB(170, 170, 170)}):Play()
                end
            end
            TweenService:Create(tabButton, TweenTable["tab_text_colour"], {TextColor3 = Color3.fromRGB(61, 135, 255)}):Play()
        end)

        --[[local function UpdatePageSize()
            local correction = pageLayout.AbsoluteContentSize
            page.CanvasSize = UDim2.new(0, correction.X+13, 0, correction.Y+13)
        end]]

        --page.ChildAdded:Connect(UpdatePageSize)
        --page.ChildRemoved:Connect(UpdatePageSize)

        TabLibrary.IsFirst = false

        CreateTween("hover", 0.16)
        local Components = {}
        return Components
    end
    function TabLibrary:Remove()
        screen:Destroy()

        return TabLibrary
    end
    --
    function TabLibrary:Text(text)
        text = text or "new text"
        headerLabel.Text = text

        return TabLibrary
    end
    --
    function TabLibrary:UpdateKeybind(new)
        new = new or key
        key = new
        return TabLibrary
    end
    return TabLibrary
end
return library