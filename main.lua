
-- 🔰 LATAM HUB
-- Owner: thiagoelcrack2253
-- Colaborador: CapitanDiego61

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MUSIC_IDS = {
    "107050372571984",
    "17422156627",
    "124635945242634",
    "91612516672369",
    "115554626181206",
    "112818967585525",
    "137572166291311",
    "80282038249456",
    "103188535669930",
}

local old = playerGui:FindFirstChild("LATAM_HUB")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "LATAM_HUB"
gui.ResetOnSpawn = false
gui.DisplayOrder = 10
gui.Parent = playerGui

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function makeButton(parent, text, height)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, height or 38)
    b.BackgroundColor3 = Color3.fromRGB(75, 39, 105)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.TextScaled = true
    b.Font = Enum.Font.GothamMedium
    b.Parent = parent
    round(b, 8)
    return b
end

local function makeLabel(parent, text, height)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, height or 34)
    l.BackgroundTransparency = 1
    l.TextColor3 = Color3.fromRGB(240, 220, 255)
    l.Text = text
    l.TextScaled = true
    l.Font = Enum.Font.Gotham
    l.Parent = parent
    return l
end

-- BOTON FLOTANTE
local toggle = Instance.new("TextButton")
toggle.Name = "LATAM_Toggle"
toggle.Size = UDim2.fromOffset(54, 54)
toggle.Position = UDim2.new(0, 15, 0.5, -27)
toggle.BackgroundColor3 = Color3.fromRGB(115, 55, 175)
toggle.Text = "🔰"
toggle.TextScaled = true
toggle.Parent = gui
round(toggle, 27)

-- MENU PRINCIPAL
local frame = Instance.new("Frame")
frame.Name = "MainMenu"
frame.Size = UDim2.new(0.88, 0, 0.76, 0)
frame.Position = UDim2.new(0.06, 0, 0.12, 0)
frame.BackgroundColor3 = Color3.fromRGB(28, 14, 40)
frame.ClipsDescendants = true
frame.Parent = gui
round(frame, 14)

local sizeLimit = Instance.new("UISizeConstraint")
sizeLimit.MinSize = Vector2.new(280, 320)
sizeLimit.MaxSize = Vector2.new(520, 560)
sizeLimit.Parent = frame

-- FONDO: COLOCA UN ID DE IMAGEN AUTORIZADA
local GENGAR_IMAGE_ID = ""

local bg = Instance.new("ImageLabel")
bg.Name = "GengarBackground"
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.25
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 1
bg.Parent = frame

if GENGAR_IMAGE_ID:match("^%d+$") then
    bg.Image = "rbxassetid://" .. GENGAR_IMAGE_ID
end

local title = makeLabel(frame, "🔰 LATAM HUB", 44)
title.Position = UDim2.fromOffset(8, 4)
title.Size = UDim2.new(1, -54, 0, 44)
title.ZIndex = 2

local close = makeButton(frame, "X", 36)
close.Size = UDim2.fromOffset(36, 36)
close.Position = UDim2.new(1, -42, 0, 7)
close.ZIndex = 3

-- PESTANAS
local tabs = Instance.new("Frame")
tabs.Position = UDim2.fromOffset(8, 52)
tabs.Size = UDim2.new(1, -16, 0, 38)
tabs.BackgroundTransparency = 1
tabs.ZIndex = 2
tabs.Parent = frame

local pages = Instance.new("Frame")
pages.Position = UDim2.fromOffset(8, 96)
pages.Size = UDim2.new(1, -16, 1, -104)
pages.BackgroundTransparency = 1
pages.ZIndex = 2
pages.Parent = frame

local function createPage(name)
    local p = Instance.new("ScrollingFrame")
    p.Name = name
    p.Size = UDim2.fromScale(1, 1)
    p.BackgroundColor3 = Color3.fromRGB(37, 23, 51)
    p.BackgroundTransparency = 0.08
    p.BorderSizePixel = 0
    p.ScrollBarThickness = 5
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.CanvasSize = UDim2.new()
    p.Visible = false
    p.ZIndex = 2
    p.Parent = pages
    round(p, 8)

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = p

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = p
    return p
end

local musicPage = createPage("Music")
local playersPage = createPage("Players")
local trollPage = createPage("Troll")
local creditsPage = createPage("Credits")

local function showPage(selected)
    for _, p in ipairs(pages:GetChildren()) do
        if p:IsA("ScrollingFrame") then
            p.Visible = p == selected
        end
    end
end

local tabData = {
    {"MUSICA", musicPage},
    {"JUGADORES", playersPage},
    {"TROLL", trollPage},
    {"CREDITOS", creditsPage},
}

for i, data in ipairs(tabData) do
    local tab = makeButton(tabs, data[1], 36)
    tab.Size = UDim2.new(0.25, -4, 1, 0)
    tab.Position = UDim2.new((i - 1) * 0.25, 2, 0, 0)
    tab.ZIndex = 3
    tab.Activated:Connect(function()
        showPage(data[2])
    end)
end

-- REPRODUCTOR DE MUSICA
local sound = Instance.new("Sound")
sound.Name = "LATAM_HUB_Music"
sound.Volume = 0.5
sound.Parent = SoundService

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 0, 38)
input.BackgroundColor3 = Color3.fromRGB(54, 36, 70)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Escribe un ID de audio"
input.Text = ""
input.TextScaled = true
input.ClearTextOnFocus = false
input.LayoutOrder = 1
input.Parent = musicPage
round(input, 8)

local status = makeLabel(musicPage, "Introduce un ID de audio", 32)
status.LayoutOrder = 2

local function playMusic(id)
    id = tostring(id):match("^%s*(.-)%s*$")
    if not id:match("^%d+$") then
        status.Text = "ID no valido"
        return
    end

    sound:Stop()
    sound.SoundId = "rbxassetid://" .. id
    status.Text = "Intentando reproducir..."
    sound:Play()
end

local play = makeButton(musicPage, "REPRODUCIR ID")
play.LayoutOrder = 3
play.Activated:Connect(function()
    playMusic(input.Text)
end)

local stop = makeButton(musicPage, "DETENER MUSICA")
stop.LayoutOrder = 4
stop.Activated:Connect(function()
    sound:Stop()
    status.Text = "Musica detenida"
end)

for i, id in ipairs(MUSIC_IDS) do
    local song = makeButton(musicPage, "Audio " .. i .. " | " .. id)
    song.LayoutOrder = i + 4
    song.Activated:Connect(function()
        input.Text = id
        playMusic(id)
    end)
end

sound.Loaded:Connect(function()
    status.Text = "Audio cargado"
end)

-- JUGADORES CONECTADOS
local function refreshPlayers()
    for _, child in ipairs(playersPage:GetChildren()) do
        if child:IsA("TextButton") or child.Name == "PlayerInfo" then
            child:Destroy()
        end
    end

    for _, target in ipairs(Players:GetPlayers()) do
        local b = makeButton(
            playersPage,
            target.DisplayName .. " @" .. target.Name
        )
        b.Activated:Connect(function()
            local previous = playersPage:FindFirstChild("PlayerInfo")
            if previous then previous:Destroy() end
            local info = makeLabel(
                playersPage,
                "Seleccionado: " .. target.Name,
                35
            )
            info.Name = "PlayerInfo"
            info.LayoutOrder = 1000
        end)
    end
end

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)
refreshPlayers()

-- TROLL: INFORMACION
makeLabel(
    trollPage,
    "Herramientas para tu propia experiencia Roblox.",
    55
)
makeLabel(
    trollPage,
    "Las acciones sobre otros jugadores necesitan permisos del juego.",
    65
)

-- CREDITOS
makeLabel(creditsPage, "OWNER", 32)
makeLabel(creditsPage, "thiagoelcrack2253", 36)
makeLabel(creditsPage, "COLABORADOR", 32)
makeLabel(creditsPage, "CapitanDiego61", 36)

-- ABRIR Y CERRAR
close.Activated:Connect(function()
    frame.Visible = false
end)

toggle.Activated:Connect(function()
    frame.Visible = not frame.Visible
end)

showPage(musicPage)
