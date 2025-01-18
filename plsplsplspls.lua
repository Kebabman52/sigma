local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kebabman52/sigma/refs/heads/main/uilib.lua"))()

library.rank = "developer"
library.loginuser = "Owner"

local Notif = library:InitNotifications()

for i = 10, 0, -1 do
    task.wait(0.05)
    local LoadingXSX = Notif:Notify("Loading Exclusive... DM exclusivecm ON BUG", 4, "newwww")
end
library.title = "Exclusive"

local Init = library:Init()

local aimtab = Init:NewTab("Aimbot")
local vistab = Init:NewTab("Visuals")
local wortab = Init:NewTab("World")

local highlightEnabled = false
local highlightInstances = {}

local chamsTransparency = 0
local chamsFillColor = Color3.fromRGB(255, 0, 0)
local outlineTransparency = 1
local outlineColor = Color3.fromRGB(255, 255, 255)

local function addHighlight(character)
    if not character then return end
    if not highlightInstances[character] then
        local highlight = Instance.new("Highlight")
        highlight.Parent = character
        highlightInstances[character] = highlight
    end
    local highlight = highlightInstances[character]
    highlight.FillColor = chamsFillColor
    highlight.OutlineColor = outlineColor
    highlight.FillTransparency = chamsTransparency
    highlight.OutlineTransparency = outlineTransparency
end

local function removeHighlight(character)
    local highlight = highlightInstances[character]
    if highlight then
        highlight:Destroy()
        highlightInstances[character] = nil
    end
end

local function updateHighlights()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            if highlightEnabled then
                addHighlight(player.Character)
            else
                removeHighlight(player.Character)
            end
        end
    end
end

local chamsss = vistab:NewToggle("Chams", false, function(value)
    highlightEnabled = value
    updateHighlights()
end)
--WORLD TYPE SHIT
local blur = Instance.new("BlurEffect")
local blurToggle = wortab:NewToggle("Enable Blur", false, function(value)
    blur.Enabled = value
    if value then
        blur.Parent = game.Lighting
    else
        blur.Parent = nil
    end
end)

local blurSizeSlider = wortab:NewSlider("Blur Size", "", true, "/", {min = 0, max = 30, default = 5}, function(value)
    blur.Size = value
end)
blur.Size = 5
blur.Parent = nil



local atmos = Instance.new("Atmosphere")
local atmosToggle = wortab:NewToggle("Enable CUstom Atmos", false, function(value)
    if value then
        atmos.Parent = game.Lighting
    end
end)

local atmosDensitySlider = wortab:NewSlider("aaaa Size", "", true, "/", {min = 0, max = 100, default = 39}, function(value)
    finalvalue = value / 100
    atmos.Density = value
end)
atmos.Density = 0
atmos.Density = 39
atmos.Parent = nil
--WORLD TYPE SHIT END
local aaaaaaaaaaa = vistab:NewSeperator()
local fillTransSlider = vistab:NewSlider("Chams Transparency", "", true, "/", {min = 0, max = 100, default = 0}, function(value)
    chamsTransparency = value / 100
    if highlightEnabled then
        updateHighlights()
    end
end)
local aaaaaaaaaaa = vistab:NewSeperator()
local fillRedSlider = vistab:NewSlider("Chams Color Red", "", true, "/", {min = 0, max = 255, default = 255}, function(value)
    chamsFillColor = Color3.fromRGB(value, chamsFillColor.G * 255, chamsFillColor.B * 255)
    if highlightEnabled then
        updateHighlights()
    end
end)

local fillGreenSlider = vistab:NewSlider("Chams Color Green", "", true, "/", {min = 0, max = 255, default = 0}, function(value)
    chamsFillColor = Color3.fromRGB(chamsFillColor.R * 255, value, chamsFillColor.B * 255)
    if highlightEnabled then
        updateHighlights()
    end
end)

local fillBlueSlider = vistab:NewSlider("Chams Color Blue", "", true, "/", {min = 0, max = 255, default = 0}, function(value)
    chamsFillColor = Color3.fromRGB(chamsFillColor.R * 255, chamsFillColor.G * 255, value)
    if highlightEnabled then
        updateHighlights()
    end
end)
local aaaaaaaaaaa = vistab:NewSeperator()
local outlineTransSlider = vistab:NewSlider("Outline Transparency", "", true, "/", {min = 0, max = 100, default = 100}, function(value)
    outlineTransparency = value / 100
    if highlightEnabled then
        updateHighlights()
    end
end)
local aaaaaaaaaaa = vistab:NewSeperator()
local outlineRedSlider = vistab:NewSlider("Outline Color Red", "", true, "/", {min = 0, max = 255, default = 255}, function(value)
    outlineColor = Color3.fromRGB(value, outlineColor.G * 255, outlineColor.B * 255)
    if highlightEnabled then
        updateHighlights()
    end
end)

local outlineGreenSlider = vistab:NewSlider("Outline Color Green", "", true, "/", {min = 0, max = 255, default = 255}, function(value)
    outlineColor = Color3.fromRGB(outlineColor.R * 255, value, outlineColor.B * 255)
    if highlightEnabled then
        updateHighlights()
    end
end)

local outlineBlueSlider = vistab:NewSlider("Outline Color Blue", "", true, "/", {min = 0, max = 255, default = 255}, function(value)
    outlineColor = Color3.fromRGB(outlineColor.R * 255, outlineColor.G * 255, value)
    if highlightEnabled then
        updateHighlights()
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if highlightEnabled then
            addHighlight(character)
        end
    end)

    if player.Character then
        if highlightEnabled then
            addHighlight(player.Character)
        end
    end
end)

for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        if highlightEnabled then
            addHighlight(player.Character)
        end
    end

    player.CharacterAdded:Connect(function(character)
        if highlightEnabled then
            addHighlight(character)
        end
    end)
end
