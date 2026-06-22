-- LuaShell v4 — + Copy Output button made by claude 🥱🥱

local Players       = game:GetService("Players")
local UIS           = game:GetService("UserInputService")
local TweenService  = game:GetService("TweenService")

local Player = Players.LocalPlayer
repeat task.wait() until Player
local PlayerGui = Player:WaitForChild("PlayerGui")

pcall(function() PlayerGui:FindFirstChild("LuaShell4"):Destroy() end)

local C = {
    BG      = Color3.fromRGB(12, 12, 16),
    SURFACE = Color3.fromRGB(18, 18, 24),
    PANEL   = Color3.fromRGB(24, 24, 32),
    BORDER  = Color3.fromRGB(40, 40, 58),
    ACCENT  = Color3.fromRGB(0,  160, 240),
    GREEN   = Color3.fromRGB(60, 200, 100),
    RED     = Color3.fromRGB(240, 70,  70),
    TEXT    = Color3.fromRGB(205, 210, 225),
    MUTED   = Color3.fromRGB(100, 105, 125),
    WHITE   = Color3.new(1, 1, 1),
}

local W, H   = 340, 292
local TH     = 32
local RADIUS = 7

local function mkCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or RADIUS)
    c.Parent = p
end

local function mkStroke(p, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color        = col   or C.BORDER
    s.Thickness    = thick or 1
    s.Transparency = trans or 0
    s.Parent = p
    return s
end

local function mkFrame(parent, size, pos, bg, props)
    local f = Instance.new("Frame")
    f.Size             = size
    f.Position         = pos or UDim2.new(0,0,0,0)
    f.BackgroundColor3 = bg  or C.PANEL
    f.BorderSizePixel  = 0
    for k,v in pairs(props or {}) do f[k] = v end
    f.Parent = parent
    return f
end

local function mkLabel(parent, text, size, col, font, xAlign)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text           = text
    l.TextSize       = size  or 12
    l.TextColor3     = col   or C.TEXT
    l.Font           = font  or Enum.Font.GothamMedium
    l.TextXAlignment = xAlign or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Size           = UDim2.new(1,0,1,0)
    l.Parent = parent
    return l
end

local function mkButton(parent, text, bg, fg, size, pos)
    local baseBG = bg or C.PANEL
    local f = Instance.new("Frame")
    f.Size             = size or UDim2.new(0,80,0,24)
    f.Position         = pos  or UDim2.new(0,0,0,0)
    f.BackgroundColor3 = baseBG
    f.BorderSizePixel  = 0
    f.Parent = parent
    mkCorner(f, 5)
    mkStroke(f, baseBG:Lerp(C.WHITE, 0.18), 1, 0.25)

    local b = Instance.new("TextButton")
    b.Size                   = UDim2.new(1,0,1,0)
    b.BackgroundTransparency = 1
    b.Text                   = text
    b.TextSize               = 11
    b.Font                   = Enum.Font.GothamBold
    b.TextColor3             = fg or C.TEXT
    b.BorderSizePixel        = 0
    b.AutoButtonColor        = false
    b.Parent = f

    b.MouseEnter:Connect(function()
        TweenService:Create(f, TweenInfo.new(0.1), {
            BackgroundColor3 = baseBG:Lerp(C.WHITE, 0.16)
        }):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(f, TweenInfo.new(0.1), {
            BackgroundColor3 = baseBG
        }):Play()
    end)

    return b, f
end

-- ─────────────────────────────────────────────────────
-- ROOT GUI
-- ─────────────────────────────────────────────────────

local Root = Instance.new("ScreenGui")
Root.Name           = "LuaShell4"
Root.ResetOnSpawn   = false
Root.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Root.DisplayOrder   = 999
Root.Parent         = game:GetService("CoreGui")

-- ─────────────────────────────────────────────────────
-- TOGGLE BUTTON
-- ─────────────────────────────────────────────────────

local ToggleHolder = mkFrame(Root,
    UDim2.new(0,40,0,40),
    UDim2.new(0,14,0.5,-20),
    C.SURFACE
)
mkCorner(ToggleHolder, 10)
local toggleStroke = mkStroke(ToggleHolder, C.ACCENT, 1.3, 0.2)

local tGlow = Instance.new("ImageLabel")
tGlow.BackgroundTransparency = 1
tGlow.Image             = "rbxassetid://5028857084"
tGlow.ImageColor3       = C.ACCENT
tGlow.ImageTransparency = 0.82
tGlow.ScaleType         = Enum.ScaleType.Slice
tGlow.SliceCenter       = Rect.new(24,24,276,276)
tGlow.Size              = UDim2.new(1,20,1,20)
tGlow.Position          = UDim2.new(0,-10,0,-10)
tGlow.ZIndex            = 0
tGlow.Parent            = ToggleHolder

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size                   = UDim2.new(1,0,1,0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text                   = ">_"
ToggleBtn.Font                   = Enum.Font.Code
ToggleBtn.TextSize               = 15
ToggleBtn.TextColor3             = C.ACCENT
ToggleBtn.BorderSizePixel        = 0
ToggleBtn.AutoButtonColor        = false
ToggleBtn.Parent                 = ToggleHolder

do
    local drag, ds, sp = false, nil, nil
    ToggleHolder.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            ds   = Vector2.new(i.Position.X, i.Position.Y)
            sp   = ToggleHolder.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
                  or i.UserInputType == Enum.UserInputType.Touch) then
            local d = Vector2.new(i.Position.X, i.Position.Y) - ds
            ToggleHolder.Position = UDim2.new(
                sp.X.Scale, sp.X.Offset + d.X,
                sp.Y.Scale, sp.Y.Offset + d.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

-- ─────────────────────────────────────────────────────
-- MAIN WINDOW
-- ─────────────────────────────────────────────────────

local Main = mkFrame(Root,
    UDim2.new(0,W,0,H),
    UDim2.new(0.5,-W/2,0.5,-H/2),
    C.BG
)
mkCorner(Main, RADIUS)
mkStroke(Main, C.ACCENT, 1.2, 0.45)
Main.ClipsDescendants = true

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(16,16,22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,14)),
})
grad.Rotation = 120
grad.Parent   = Main

-- Title bar
local TBar = mkFrame(Main, UDim2.new(1,0,0,TH), UDim2.new(0,0,0,0), C.SURFACE)
mkCorner(TBar, RADIUS)
mkFrame(TBar, UDim2.new(1,0,0,RADIUS), UDim2.new(0,0,1,-RADIUS), C.SURFACE, {BorderSizePixel=0})

local pip = mkFrame(TBar, UDim2.new(0,3,0,16), UDim2.new(0,10,0.5,-8), C.ACCENT)
mkCorner(pip, 2)

local titleLbl = mkLabel(TBar, "   LuaShell", 12, C.TEXT, Enum.Font.GothamBold)
titleLbl.Position       = UDim2.new(0,14,0,0)
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn, _ = mkButton(TBar, "X",
    Color3.fromRGB(180,50,50), C.WHITE,
    UDim2.new(0,24,0,24),
    UDim2.new(1,-28,0.5,-12)
)

-- Body
local Body = mkFrame(Main,
    UDim2.new(1,-12,1,-(TH+8)),
    UDim2.new(0,6,0,TH+4),
    C.BG, {BorderSizePixel=0}
)

local bodyLayout = Instance.new("UIListLayout")
bodyLayout.Padding       = UDim.new(0,5)
bodyLayout.FillDirection = Enum.FillDirection.Vertical
bodyLayout.SortOrder     = Enum.SortOrder.LayoutOrder
bodyLayout.Parent        = Body

-- Editor header row
local editorHdrFrame = mkFrame(Body,
    UDim2.new(1,0,0,16), UDim2.new(0,0,0,0),
    C.BG, {LayoutOrder=1, BorderSizePixel=0}
)
local editorHdrLayout = Instance.new("UIListLayout")
editorHdrLayout.FillDirection     = Enum.FillDirection.Horizontal
editorHdrLayout.VerticalAlignment = Enum.VerticalAlignment.Center
editorHdrLayout.SortOrder         = Enum.SortOrder.LayoutOrder
editorHdrLayout.Padding           = UDim.new(0,0)
editorHdrLayout.Parent            = editorHdrFrame

local editorTitleLbl = mkLabel(editorHdrFrame, "SCRIPT", 9, C.MUTED, Enum.Font.GothamBold)
editorTitleLbl.Size           = UDim2.new(1,-88,1,0)
editorTitleLbl.LayoutOrder    = 1
editorTitleLbl.TextXAlignment = Enum.TextXAlignment.Left

local ClearCodeBtn, ClearCodeFrame = mkButton(editorHdrFrame,
    "[ CLR CODE ]",
    Color3.fromRGB(100,50,20), Color3.fromRGB(255,160,80),
    UDim2.new(0,88,0,16)
)
ClearCodeFrame.LayoutOrder = 2

-- Editor frame
local EditorFrame = mkFrame(Body,
    UDim2.new(1,0,0,110), UDim2.new(0,0,0,0),
    C.PANEL, {LayoutOrder=2}
)
mkCorner(EditorFrame, 5)
mkStroke(EditorFrame, C.BORDER, 1, 0)

local EditorScroll = Instance.new("ScrollingFrame")
EditorScroll.Size                   = UDim2.new(1,-2,1,-2)
EditorScroll.Position               = UDim2.new(0,1,0,1)
EditorScroll.BackgroundTransparency = 1
EditorScroll.ScrollBarThickness     = 3
EditorScroll.ScrollBarImageColor3   = C.ACCENT
EditorScroll.BorderSizePixel        = 0
EditorScroll.CanvasSize             = UDim2.new(0,0,0,0)
EditorScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
EditorScroll.Parent                 = EditorFrame

local CodeBox = Instance.new("TextBox")
CodeBox.Size               = UDim2.new(1,-8,1,0)
CodeBox.Position           = UDim2.new(0,6,0,2)
CodeBox.BackgroundTransparency = 1
CodeBox.Text               = '-- Paste your script here\nprint("Hello from LuaShell!")'
CodeBox.PlaceholderText    = "-- Paste script here..."
CodeBox.PlaceholderColor3  = C.MUTED
CodeBox.TextColor3         = Color3.fromRGB(160,215,160)
CodeBox.TextSize           = 11
CodeBox.Font               = Enum.Font.Code
CodeBox.MultiLine          = true
CodeBox.ClearTextOnFocus   = false
CodeBox.TextXAlignment     = Enum.TextXAlignment.Left
CodeBox.TextYAlignment     = Enum.TextYAlignment.Top
CodeBox.TextWrapped        = false
CodeBox.AutomaticSize      = Enum.AutomaticSize.Y
CodeBox.Parent             = EditorScroll

-- ── RUN ROW (Run + Copy Err) ──

local BtnRow = mkFrame(Body, UDim2.new(1,0,0,26),
    UDim2.new(0,0,0,0), C.BG, {LayoutOrder=3, BorderSizePixel=0})

local bLayout = Instance.new("UIListLayout")
bLayout.Padding       = UDim.new(0,5)
bLayout.FillDirection = Enum.FillDirection.Horizontal
bLayout.SortOrder     = Enum.SortOrder.LayoutOrder
bLayout.Parent        = BtnRow

local RunBtn, _ = mkButton(BtnRow, "[ RUN ]",
    Color3.fromRGB(30,120,60), C.WHITE, UDim2.new(0,76,1,0))
RunBtn.Parent.LayoutOrder = 1

local CopyErrBtn, _ = mkButton(BtnRow, "[ CPY ERR ]",
    C.PANEL, C.MUTED, UDim2.new(0,88,1,0))
CopyErrBtn.Parent.LayoutOrder = 2

-- ── OUTPUT HEADER ROW  (label | CPY OUT | CLR OUT) ──

local outHdrFrame = mkFrame(Body,
    UDim2.new(1,0,0,16), UDim2.new(0,0,0,0),
    C.BG, {LayoutOrder=4, BorderSizePixel=0}
)

local outHdrLayout = Instance.new("UIListLayout")
outHdrLayout.FillDirection     = Enum.FillDirection.Horizontal
outHdrLayout.VerticalAlignment = Enum.VerticalAlignment.Center
outHdrLayout.SortOrder         = Enum.SortOrder.LayoutOrder
outHdrLayout.Padding           = UDim.new(0,4)
outHdrLayout.Parent            = outHdrFrame

local outTitleLbl = mkLabel(outHdrFrame, "OUTPUT", 9, C.MUTED, Enum.Font.GothamBold)
outTitleLbl.Size           = UDim2.new(1,-178,1,0)   -- fills remaining space
outTitleLbl.LayoutOrder    = 1
outTitleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- ✦ NEW: Copy Output button
local CopyOutBtn, CopyOutFrame = mkButton(outHdrFrame,
    "[ CPY OUT ]",
    Color3.fromRGB(20,70,110), C.ACCENT,
    UDim2.new(0,86,0,16)
)
CopyOutFrame.LayoutOrder = 2

local ClearOutBtn, ClearOutFrame = mkButton(outHdrFrame,
    "[ CLR OUT ]",
    C.PANEL, C.MUTED,
    UDim2.new(0,80,0,16)
)
ClearOutFrame.LayoutOrder = 3

-- Output scroll
local OutFrame = mkFrame(Body,
    UDim2.new(1,0,0,82), UDim2.new(0,0,0,0),
    Color3.fromRGB(8,8,11), {LayoutOrder=5}
)
mkCorner(OutFrame, 5)
mkStroke(OutFrame, C.BORDER, 1, 0.2)

local OutScroll = Instance.new("ScrollingFrame")
OutScroll.Size                   = UDim2.new(1,-4,1,-4)
OutScroll.Position               = UDim2.new(0,2,0,2)
OutScroll.BackgroundTransparency = 1
OutScroll.ScrollBarThickness     = 3
OutScroll.ScrollBarImageColor3   = C.ACCENT
OutScroll.BorderSizePixel        = 0
OutScroll.CanvasSize             = UDim2.new(0,0,0,0)
OutScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
OutScroll.Parent                 = OutFrame

local outListLayout = Instance.new("UIListLayout")
outListLayout.Padding   = UDim.new(0,1)
outListLayout.SortOrder = Enum.SortOrder.LayoutOrder
outListLayout.Parent    = OutScroll

local outPad = Instance.new("UIPadding")
outPad.PaddingLeft  = UDim.new(0,5)
outPad.PaddingTop   = UDim.new(0,3)
outPad.PaddingRight = UDim.new(0,4)
outPad.Parent       = OutScroll

-- ─────────────────────────────────────────────────────
-- OUTPUT SYSTEM
-- ─────────────────────────────────────────────────────

local lineIdx    = 0
local lastError  = ""
local outputLines = {}   -- ✦ track every line of text for copy

local function addLine(msg, col)
    lineIdx += 1
    local str = tostring(msg)
    table.insert(outputLines, str)   -- store for copy

    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text           = str
    l.TextColor3     = col or C.TEXT
    l.TextSize       = 11
    l.Font           = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Top
    l.TextWrapped    = true
    l.AutomaticSize  = Enum.AutomaticSize.Y
    l.Size           = UDim2.new(1,-4,0,0)
    l.LayoutOrder    = lineIdx
    l.Parent         = OutScroll
    task.defer(function()
        OutScroll.CanvasPosition = Vector2.new(
            0, math.max(0, OutScroll.AbsoluteCanvasSize.Y - OutScroll.AbsoluteSize.Y)
        )
    end)
end

local _print = print
local function capPrint(...)
    local t = {}
    for i = 1, select("#",...) do t[i] = tostring(select(i,...)) end
    local s = table.concat(t, "  ")
    _print(s)
    addLine(">> " .. s, Color3.fromRGB(170,215,170))
end

-- ─────────────────────────────────────────────────────
-- VISIBILITY / TOGGLE
-- ─────────────────────────────────────────────────────

local visible   = false
local OPEN_POS  = UDim2.new(0.5,-W/2,0.5,-H/2)
local CLOSE_POS = UDim2.new(0.5,-W/2,0.5,0)

local function syncToggle()
    if visible then
        ToggleBtn.Text       = "[-]"
        ToggleBtn.TextColor3 = C.ACCENT
        TweenService:Create(toggleStroke, TweenInfo.new(0.15), {Color=C.ACCENT}):Play()
        TweenService:Create(tGlow,        TweenInfo.new(0.15), {ImageColor3=C.ACCENT}):Play()
    else
        ToggleBtn.Text       = ">_"
        ToggleBtn.TextColor3 = C.RED
        TweenService:Create(toggleStroke, TweenInfo.new(0.15), {Color=C.RED}):Play()
        TweenService:Create(tGlow,        TweenInfo.new(0.15), {ImageColor3=C.RED}):Play()
    end
end

local function setVisible(v)
    visible = v
    syncToggle()
    if v then
        Main.Visible  = true
        Main.Size     = UDim2.new(0,W,0,0)
        Main.Position = CLOSE_POS
        TweenService:Create(Main,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0,W,0,H), Position = OPEN_POS
            }):Play()
    else
        TweenService:Create(Main,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0,W,0,0), Position = CLOSE_POS
            }):Play()
        task.delay(0.16, function() Main.Visible = false end)
    end
end

-- ─────────────────────────────────────────────────────
-- BUTTON WIRING
-- ─────────────────────────────────────────────────────

local toggleClickTime = 0
ToggleBtn.MouseButton1Click:Connect(function()
    if tick() - toggleClickTime < 0.15 then return end
    toggleClickTime = tick()
    TweenService:Create(ToggleHolder, TweenInfo.new(0.08), {Size=UDim2.new(0,46,0,46)}):Play()
    task.delay(0.08, function()
        TweenService:Create(ToggleHolder,
            TweenInfo.new(0.1,Enum.EasingStyle.Back), {Size=UDim2.new(0,40,0,40)}):Play()
    end)
    setVisible(not visible)
end)

CloseBtn.MouseButton1Click:Connect(function()
    setVisible(false)
end)

ClearCodeBtn.MouseButton1Click:Connect(function()
    CodeBox.Text = ""
    addLine("[INFO] Script editor cleared.", C.MUTED)
end)

RunBtn.MouseButton1Click:Connect(function()
    local src = CodeBox.Text
    if src == "" then addLine("[INFO] Nothing to run.", C.MUTED) return end

    local env = setmetatable({ print = capPrint }, {
        __index = getfenv and getfenv(0) or _G
    })
    local fn, compErr = loadstring(src)
    if not fn then
        lastError = tostring(compErr)
        addLine("[COMPILE] " .. lastError, C.RED)
        return
    end
    pcall(setfenv, fn, env)
    local ok, runErr = pcall(fn)
    if not ok then
        lastError = tostring(runErr)
        addLine("[ERROR]   " .. lastError, C.RED)
    else
        addLine("[DONE]", C.ACCENT)
    end
end)

CopyErrBtn.MouseButton1Click:Connect(function()
    if lastError == "" then addLine("[INFO] No error recorded.", C.MUTED) return end
    local ok = pcall(function()
        if setclipboard then setclipboard(lastError)
        elseif Clipboard and Clipboard.set then Clipboard.set(lastError)
        else error("x") end
    end)
    addLine(ok and "[INFO] Error copied." or "[INFO] setclipboard unavailable.", C.MUTED)
end)

-- ✦ Copy Output — joins all output lines and copies to clipboard
CopyOutBtn.MouseButton1Click:Connect(function()
    if #outputLines == 0 then
        addLine("[INFO] Output is empty.", C.MUTED)
        return
    end
    local blob = table.concat(outputLines, "\n")
    local ok = pcall(function()
        if setclipboard then setclipboard(blob)
        elseif Clipboard and Clipboard.set then Clipboard.set(blob)
        else error("x") end
    end)
    addLine(ok and "[INFO] Output copied (" .. #outputLines .. " lines)."
               or "[INFO] setclipboard unavailable.", C.MUTED)
end)

ClearOutBtn.MouseButton1Click:Connect(function()
    for _, c in ipairs(OutScroll:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    lineIdx     = 0
    lastError   = ""
    outputLines = {}
end)

-- ─────────────────────────────────────────────────────
-- MAIN WINDOW DRAG
-- ─────────────────────────────────────────────────────

do
    local drag, ds, sp = false, nil, nil
    TBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            ds   = Vector2.new(i.Position.X, i.Position.Y)
            sp   = Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
                  or i.UserInputType == Enum.UserInputType.Touch) then
            local d = Vector2.new(i.Position.X, i.Position.Y) - ds
            Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X,
                                      sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

-- ─────────────────────────────────────────────────────
-- INIT
-- ─────────────────────────────────────────────────────

Main.Visible = false
syncToggle()
setVisible(true)

addLine("LuaShell ready.", C.MUTED)
addLine("[ CPY OUT ] copies all output lines to clipboard.", C.MUTED)
