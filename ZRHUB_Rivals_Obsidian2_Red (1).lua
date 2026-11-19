if game.GameId ~= 6035872082 and game.PlaceId ~= 17625359962 then return end
loadstring([[
    function LPH_NO_VIRTUALIZE(f) return f end
    function LPH_JIT_MAX(f) return f end
    function LPH_JIT(f) return f end
    function LPH_ENCFUNC(f) return f end
]])();

eli_inext = function(t, i)
    i = i + 1;
    local v = t[i];
    if v ~= nil then return i, v end;
end;
eli_ipairs = function(t) return eli_inext, t, 0 end;
eli_pairs = function(t) return next, t, nil end;
if not cloneref then cloneref = function(ref) return ref end end

do
    if hookfunction and newcclosure and getcallingscript then
        pcall(function()
            local Old1 = nil; Old1 = hookfunction(setmetatable, newcclosure(function(Table, MetaTable)
                if type(MetaTable) == "table" and rawget(MetaTable, "__mode") == "kv" then
                    local Caller = getcallingscript();
                    if Caller and Caller.Name == "MiscellaneousController" then
                        return Old1(Table, { });
                    end;
                end;

                return Old1(Table, MetaTable);
            end));
        end);

        pcall(function()
            local Ol2 = nil; Ol2 = hookfunction(rawlen, newcclosure(function(Table)
                if type(Table) == "table" then
                    local Caller = getcallingscript();
                    if Caller and Caller.Name == "MiscellaneousController" then
                        return 3;
                    end;
                end;

                return Ol2(Table);
            end));
        end);
    end;
end;
print("-");
task.wait(6);

pcall(function()
    if not (hookfunction and newcclosure and getrenv) then return end;
    local oldtable; oldtable = hookfunction(getrenv().setmetatable, newcclosure(function(Table, Metatable)
        if Metatable and typeof(Metatable) == "table" and rawget(Metatable, "__mode") == "kv" then
            local trace = debug.traceback();
            if trace:find("MiscellaneousController") then
                return oldtable({1, 2, 3}, {});
            end;
        end;
        return oldtable(Table, Metatable);
    end));
end);

coroutine.wrap(function()
    pcall(function()
        local acWords = {"anticheat", "ac", "detection", "ban", "kick", "security", "moderation"};
        local function disableScript(obj)
            obj.Disabled = true;
        end;
        local function checkScript(obj)
            if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                local n = string.lower(obj.Name);
                for _, ac in eli_ipairs(acWords) do
                    if string.find(n, ac, 1, true) then
                        pcall(disableScript, obj);
                        break;
                    end;
                end;
            end;
        end;
        local function blockScript(obj)
            pcall(checkScript, obj);
        end;

        pcall(function()
            game.DescendantAdded:Connect(blockScript);
        end);

        pcall(function()
            local descendants = game:GetDescendants();
            for index = 1, #descendants do
                blockScript(descendants[index]);
                if index % 4000 == 0 then
                    task.wait();
                end;
            end;
        end);
    end);

    pcall(function()
        local networkClient = game:GetService("NetworkClient");
        if networkClient then
            networkClient.ChildAdded:Connect(function(child)
                pcall(function()
                    local ok, n = pcall(function() return child.Name:lower() end);
                    if ok and n then
                        if n:find("anticheat") or n:find("detection") then
                            pcall(function() child:Destroy() end);
                        end;
                    end;
                end);
            end);
        end;
    end);
end)();

pcall(function()
    local fake = Instance.new("RemoteEvent");
    fake.Name = "ClientAlert";
    fake.Parent = LocalPlayer;
end);

task.spawn(function()
    pcall(LPH_NO_VIRTUALIZE(function()
        if type(getgc) ~= "function" then return end;
        local rf = game:GetService("ReplicatedFirst");
        local ls3 = rf:WaitForChild("LocalScript3", 10);

        local gc = getgc(false);
        for index = 1, #gc do
            local f = gc[index];
            if type(f) == "function" and (type(islclosure) ~= "function" or islclosure(f)) then
                local ok, e = pcall(getfenv, f);
                if ok and type(e) == "table" then
                    local ok2, scr = pcall(function() return rawget(e, "script") end);
                    if ok2 and scr and typeof(scr) == "Instance" then
                        local ok3, scrStr = pcall(tostring, scr);

                        if ok3 and (scr == ls3 or (type(scrStr) == "string" and scrStr:find("LoadingScreen"))) then
                            local ok4, cs = pcall(debug.getconstants, f);
                            if ok4 and type(cs) == "table" then
                                for _, k in eli_ipairs(cs) do
                                    if type(k) == "string" and (k:find("TakeTheL") or k:find("ban") or k:find("kick")) then
                                        pcall(function()
                                            hookfunction(f, function() end);
                                        end);
                                        break;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            if index % 1500 == 0 then
                task.wait();
            end;
        end;
    end));
end);

local antidetect = true;
local detecteds = {
    ["localscript3"] = true,
    ["miscellaneouscontroller"] = true
};
local callerVerdicts = setmetatable({}, { __mode = "k" });
local original;
pcall(function()
    if not (hookmetamethod and newcclosure and getcallingscript) then return end;
    original = hookmetamethod(game, "__index", newcclosure(LPH_NO_VIRTUALIZE(function(self, key)
        if antidetect and (key == "Name" or key == "Text") then
            local caller = getcallingscript();
            if caller then
                local blocked = callerVerdicts[caller];
                if blocked == nil then
                    local ok, result = pcall(function()
                        return detecteds[string.lower(original(caller, "Name"))] == true;
                    end);
                    blocked = ok and result or false;
                    callerVerdicts[caller] = blocked;
                end;
                if blocked then
                    return "";
                end;
            end;
        end;
        return original(self, key);
    end)));
end);
getgenv().ZRHUB_set_antidetect = function(v)
    antidetect = v and true or false;
end;

repeat task.wait() until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen");

getgenv().silent_load = false;

local Library, ThemeManager, SaveManager;
do
local FourLib = (function()

local InputService = game:GetService('UserInputService');
local TextService = game:GetService('TextService');
local HttpService = game:GetService('HttpService');
local CoreGui = cloneref(game:GetService('CoreGui'));
local Teams = game:GetService('Teams');
local Players = game:GetService('Players');
local RunService = game:GetService('RunService');
local TweenService = game:GetService('TweenService');
local SoundService = game:GetService('SoundService');
local RenderStepped = RunService.RenderStepped;
local LocalPlayer = Players.LocalPlayer;
local Mouse = cloneref(LocalPlayer:GetMouse());

local function IsPrimaryPress(Input)
    return Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch;
end;

local function IsPressActive(Input)
    if Input.UserInputType == Enum.UserInputType.Touch then
        return Input.UserInputState ~= Enum.UserInputState.End
            and Input.UserInputState ~= Enum.UserInputState.Cancel;
    end;
    return InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
end;

local function GetPointerPosition(Input)
    if Input and Input.UserInputType == Enum.UserInputType.Touch then
        return Vector2.new(Input.Position.X, Input.Position.Y);
    end;
    return Vector2.new(Mouse.X, Mouse.Y);
end;

local IsTouchDevice = InputService.TouchEnabled and not InputService.MouseEnabled;

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);

local ScreenGui = Instance.new('ScreenGui');
ProtectGui(ScreenGui);

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
ScreenGui.Parent = CoreGui;

local Toggles = {};
local Options = {};

getgenv().Toggles = Toggles;
getgenv().Options = Options;

local BaseGroupbox;

local ENUM_UI_FONT_ENTRIES = {
    { 'Legacy', 'Legacy' },
    { 'Arial', 'Arial' },
    { 'Arial Bold', 'ArialBold' },
    { 'Arimo', 'Arimo' },
    { 'Arimo Bold', 'ArimoBold' },
    { 'Gotham', 'Gotham' },
    { 'Gotham Medium', 'GothamMedium' },
    { 'Gotham Bold', 'GothamBold' },
    { 'Gotham Black', 'GothamBlack' },
    { 'Roboto', 'Roboto' },
    { 'Roboto Mono', 'RobotoMono' },
    { 'Roboto Condensed', 'RobotoCondensed' },
    { 'Source Sans', 'SourceSans' },
    { 'Source Sans Bold', 'SourceSansBold' },
    { 'Source Sans Semibold', 'SourceSansSemibold' },
    { 'Source Sans Light', 'SourceSansLight' },
    { 'Source Sans Italic', 'SourceSansItalic' },
    { 'Ubuntu', 'Ubuntu' },
    { 'Bangers', 'Bangers' },
    { 'Arcade', 'Arcade' },
    { 'Code', 'Code' },
    { 'Creepster', 'Creepster' },
    { 'Builder Sans', 'BuilderSans' },
    { 'Builder Sans Medium', 'BuilderSansMedium' },
    { 'Builder Sans Bold', 'BuilderSansBold' },
    { 'Builder Sans ExtraBold', 'BuilderSansExtraBold' },
    { 'SciFi', 'SciFi' },
    { 'Highway', 'Highway' },
    { 'Cartoon', 'Cartoon' },
    { 'Fantasy', 'Fantasy' },
    { 'Fondamento', 'Fondamento' },
    { 'Garamond', 'Garamond' },
    { 'Bodoni', 'Bodoni' },
    { 'Merriweather', 'Merriweather' },
    { 'Oswald', 'Oswald' },
    { 'Patrick Hand', 'PatrickHand' },
    { 'Permanent Marker', 'PermanentMarker' },
    { 'Special Elite', 'SpecialElite' },
    { 'Titillium Web', 'TitilliumWeb' },
    { 'Nunito', 'Nunito' },
    { 'Jura', 'Jura' },
    { 'Michroma', 'Michroma' },
    { 'Antique', 'Antique' },
    { 'Amatic SC', 'AmaticSC' },
    { 'Denk One', 'DenkOne' },
    { 'Josefin Sans', 'JosefinSans' },
    { 'Kalam', 'Kalam' },
    { 'Luckiest Guy', 'LuckiestGuy' },
    { 'Sarpanch', 'Sarpanch' },
};

local ENUM_UI_FONTS = {};
for _, entry in ENUM_UI_FONT_ENTRIES do
    local displayName, enumName = entry[1], entry[2];
    if not ENUM_UI_FONTS[displayName] then
        local ok, enumFont = pcall(function()
            return Enum.Font[enumName];
        end);
        if ok and enumFont then
            ENUM_UI_FONTS[displayName] = enumFont;
        end;
    end;
end;

local CUSTOM_UI_FONTS = {
    ['ProggyTiny'] = {
        Ttf = 'ProggyTiny.ttf',
        Url = 'https://github.com/ocornut/imgui/raw/master/misc/fonts/ProggyTiny.ttf',
    },
    ['ProggyClean'] = {
        Ttf = 'ProggyClean.ttf',
        Url = 'https://github.com/ocornut/imgui/raw/master/misc/fonts/ProggyClean.ttf',
    },
    ['XP Tahoma'] = {
        Ttf = 'XP Tahoma.ttf',
        Url = 'https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/TAHOMA-8PT-BOLD-WINDOWS-XP.TTF',
    },
    ['Smallest Pixel'] = {
        Ttf = 'smallest_pixel-7.ttf',
        Url = 'https://raw.githubusercontent.com/sametexe001/luas/main/smallest_pixel-7.ttf',
    },
    ['Tahoma'] = {
        FontFile = 'Tahoma.font',
        AltFontFiles = { 'ZRHUB/Tahoma.font', 'library/Tahoma.font', 'Tahoma.ttf', 'library/Tahoma.ttf' },
    },
};

local function tryFontFromAsset(path)
    if not isfile or not isfile(path) then
        return nil;
    end;

    local okAsset, assetPath = pcall(getcustomasset, path);
    if not okAsset or not assetPath then
        return nil;
    end;

    local okFont, face = pcall(Font.new, assetPath, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    if okFont and face then
        return face;
    end;

    return nil;
end;

local function registerDownloadedFont(name, entry)
    if not (writefile and isfile and getcustomasset and game.HttpGet) then
        return nil;
    end;

    local ok, face = pcall(function()
        local ttfName = entry.Ttf;
        if not isfile(ttfName) then
            writefile(ttfName, game:HttpGet(entry.Url));
        end;

        local fontFile = name .. '.font';
        if isfile(fontFile) then
            delfile(fontFile);
        end;

        local info = {
            name = name,
            faces = {
                {
                    name = 'Normal',
                    weight = 400,
                    style = 'Normal',
                    assetId = getcustomasset(ttfName),
                },
            },
        };

        writefile(fontFile, HttpService:JSONEncode(info));
        return Font.new(getcustomasset(fontFile), Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    end);

    if ok and face then
        return face;
    end;

    return nil;
end;

local function loadCustomFontFace(name, entry)
    if entry.FontFile or entry.AltFontFiles then
        local paths = { entry.FontFile };
        if entry.AltFontFiles then
            for _, path in entry.AltFontFiles do
                table.insert(paths, path);
            end;
        end;

        for _, path in paths do
            local face = tryFontFromAsset(path);
            if face then
                return face;
            end;
        end;
    end;

    if entry.Ttf and entry.Url then
        return registerDownloadedFont(name, entry);
    end;

    return nil;
end;

local function resolveEnumFontFace(enumFont)
    local ok, face = pcall(Font.fromEnum, enumFont);
    if ok and face then
        return face, enumFont;
    end;

    return nil, enumFont;
end;

local DefaultUIFont = 'Builder Sans ExtraBold';
local InitialFontFace, InitialEnumFont = resolveEnumFontFace(Enum.Font.BuilderSansExtraBold);
if not InitialFontFace then
    InitialFontFace = loadCustomFontFace('XP Tahoma', CUSTOM_UI_FONTS['XP Tahoma'])
        or select(1, resolveEnumFontFace(Enum.Font.Code));
    InitialEnumFont = Enum.Font.Code;
end;

local Library = {
    Registry = {};
    RegistryMap = {};

    HudRegistry = {};

    FontColor = Color3.fromHex("e0d4d6");
    MainColor = Color3.fromHex("121212");
    BackgroundColor = Color3.fromHex("0a0a0a");
    AccentColor = Color3.fromHex("001EFF");
    OutlineColor = Color3.new(0, 0, 0);
    SelectedTabColor = Color3.fromHex("0a0a0a");
    GradientColor = Color3.fromHex("ffffff");
    ShadowColor = Color3.new(0, 0, 0);
    ShadowSize = 0;
    ShadowOffset = 0;
    RiskColor = Color3.fromRGB(255, 50, 50),

    Black = Color3.new(0, 0, 0);
    Font = InitialEnumFont or Enum.Font.BuilderSansExtraBold;
    FontFace = InitialFontFace;
    CurrentUIFont = DefaultUIFont;
    FontCache = {};
    EnumUIFonts = ENUM_UI_FONTS;
    CustomUIFonts = CUSTOM_UI_FONTS;

    OverlayGlowEnabled = false;
    OverlayGlowColor = Color3.fromHex('001EFF');

    OpenedFrames = {};
    DependencyBoxes = {};
    Overlays = {};
    EnemyPlayers = {};
    AllCloseOverlays = false;
    MenuOpen = true;
    NotificationSpot = 'Top Right';
    NotificationAnimation = 'Slide Right to Left';
    ToggleSoundEnabled = true;
    NotificationSoundEnabled = true;
    SliderSoundEnabled = true;
    ToggleSoundVolume = 1;
    ToggleSoundSpeed = 1;
    NotificationSoundVolume = 1;
    NotificationSoundSpeed = 1;
    SliderSoundVolume = 1;
    SliderSoundSpeed = 1;
    MobileOverlayScale = 0.55;
    MobilePickerScale = 0.6;
    ZIndexBase = nil;
    OverlayZIndexBase = nil;
    GradientLabels = {};
    AccentTitleLabels = {};
    PopupZIndexCache = setmetatable({}, { __mode = 'k' });

    Signals = {};
    ScreenGui = ScreenGui;
};

local RainbowStep = 0;
local Hue = 0;
local RainbowAccum = 0;

table.insert(Library.Signals, RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(Delta)
    RainbowAccum += Delta;
    if RainbowAccum < 0.05 then
        return
    end;

    Hue = Hue + (RainbowAccum * 0.15);
    RainbowAccum = 0;

    if Hue > 1 then
        Hue = 0;
    end;

    Library.CurrentRainbowHue = Hue;
    Library.CurrentRainbowColor = Color3.fromHSV(Hue, 0.8, 1);
end)));

local function GetPlayersString()
    local PlayerList = Players:GetPlayers();

    for i = 1, #PlayerList do
        PlayerList[i] = PlayerList[i].Name;
    end;

    table.sort(PlayerList, function(str1, str2) return str1 < str2 end);

    return PlayerList;
end;

local function GetTeamsString()
    local TeamList = Teams:GetTeams();

    for i = 1, #TeamList do
        TeamList[i] = TeamList[i].Name;
    end;

    table.sort(TeamList, function(str1, str2) return str1 < str2 end);

    return TeamList;
end;

function Library:SafeCallback(f, ...)
    if (not f) then
        return;
    end;

    if not Library.NotifyOnError then
        return f(...);
    end;

    local success, event = pcall(f, ...);

    if not success then
        local _, i = event:find(":%d+: ");

        if not i then
            return Library:Notify(event);
        end;

        return Library:Notify(event:sub(i + 1), 3);
    end;
end;

Library.UDim2OffsetToString = function(udim2)
    return string.format('%d, %d', udim2.X.Offset, udim2.Y.Offset);
end;
Library.StringToUDim2Offset = function(str)
    local x, y = str:match('([^,]+),%s*([^,]+)');

    return UDim2.fromOffset(tonumber(x), tonumber(y));
end;

function Library:AttemptSave()
    if Library.SaveManager then
        Library.SaveManager:Save();
    end;
end;

function Library:Create(Class, Properties)
    local _Instance = Class;

    if type(Class) == 'string' then
        _Instance = Instance.new(Class);
    end;

    if Properties and type(Properties.ZIndex) == 'number' and Library.OverlayZIndexBase and Properties.ZIndex < 100 then
        Properties.ZIndex = Library.OverlayZIndexBase + Properties.ZIndex;
    end;

    for Property, Value in next, Properties do
        _Instance[Property] = Value;
    end;

    if Library.FontFace and (_Instance:IsA('TextLabel') or _Instance:IsA('TextButton') or _Instance:IsA('TextBox')) then
        if not Properties or not Properties.FontFace then
            pcall(function()
                _Instance.FontFace = Library.FontFace;
            end);
        end;
    elseif (_Instance:IsA('TextLabel') or _Instance:IsA('TextButton') or _Instance:IsA('TextBox')) and (not Properties or not Properties.Font) then
        _Instance.Font = Library.Font;
    end;

    return _Instance;
end;

function Library:ApplyTextStroke(Inst)
    Inst.TextStrokeTransparency = 1;

    Library:Create('UIStroke', {
        Color = Color3.new(0, 0, 0);
        Thickness = 1;
        LineJoinMode = Enum.LineJoinMode.Miter;
        Parent = Inst;
    });
end;

function Library:CreateLabel(Properties, IsHud)
    local _Instance = Library:Create('TextLabel', {
        BackgroundTransparency = 1;
        Font = Library.Font;
        Text = '';
        TextColor3 = Library.FontColor;
        TextSize = 13;
        TextStrokeTransparency = 0;
    });

    Library:ApplyTextStroke(_Instance);

    Library:AddToRegistry(_Instance, {
        TextColor3 = 'FontColor';
    }, IsHud);

    return Library:Create(_Instance, Properties);
end;

function Library:MakeDraggable(Instance, Cutoff)
    Instance.Active = true;
    local CutoffHeight = Cutoff or 40;

    local Dragging = false;
    local DragInput = nil;
    local DragPreview = nil;
    local DragStart = nil;
    local StartPos = nil;

    Instance.InputBegan:Connect(function(Input)
        if not IsPrimaryPress(Input) then return end;

        if Dragging then return end;

        local Pointer = GetPointerPosition(Input);

        if (Pointer.Y - Instance.AbsolutePosition.Y) > CutoffHeight then return end;

        if DragPreview then
            DragPreview:Destroy();
            DragPreview = nil;
        end;

        Dragging = true;
        DragInput = Input;
        DragStart = Pointer;
        StartPos = Instance.Position;

        DragPreview = Library:Create("Frame", {
            BackgroundColor3 = Library.AccentColor,
            BackgroundTransparency = 0.75,
            BorderColor3 = Library.AccentColor,
            BorderSizePixel = 5,
            Position = StartPos,
            Size = Instance.Size,
            AnchorPoint = Instance.AnchorPoint,
            ZIndex = 9999,
            Parent = Library.ScreenGui,
        });
    end);

    InputService.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(Input)
        if not Dragging or not DragPreview then return end;

        if Input == DragInput or (Input.UserInputType == Enum.UserInputType.MouseMovement and DragInput.UserInputType == Enum.UserInputType.MouseButton1) then
            local Current = GetPointerPosition(Input);
            local Delta = Current - DragStart;

            DragPreview.Position = UDim2.new(
                StartPos.X.Scale,
                StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale,
                StartPos.Y.Offset + Delta.Y
            );
        end;
    end));

    InputService.InputEnded:Connect(function(Input)
        if not Dragging or not DragPreview then return end;

        if Input == DragInput or (Input.UserInputType == Enum.UserInputType.MouseButton1 and DragInput.UserInputType == Enum.UserInputType.MouseButton1) then
            Dragging = false;
            DragInput = nil;

            Instance.Position = DragPreview.Position;

            DragPreview:Destroy();
            DragPreview = nil;
        end;
    end);
end;

function Library:AddToolTip(InfoStr, HoverInstance)
    local X, Y = Library:GetTextBounds(InfoStr, Library.Font, 14);
    local Tooltip = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor,
        BorderColor3 = Library.OutlineColor,

        Size = UDim2.fromOffset(X + 5, Y + 4),
        ZIndex = 100,
        Parent = Library.ScreenGui,

        Visible = false,
    });

    local Label = Library:CreateLabel({
        Position = UDim2.fromOffset(3, 1),
        Size = UDim2.fromOffset(X, Y);
        TextSize = 14;
        Text = InfoStr,
        TextColor3 = Library.FontColor,
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = Tooltip.ZIndex + 1,

        Parent = Tooltip;
    });

    Library:AddToRegistry(Tooltip, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    Library:AddToRegistry(Label, {
        TextColor3 = 'FontColor',
    });

    local IsHovering = false;

    HoverInstance.MouseEnter:Connect(function()
        if Library:MouseIsOverOpenedFrame() then
            return
        end;

        IsHovering = true;

        Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12);
        Tooltip.Visible = true;

        while IsHovering do
            RunService.Heartbeat:Wait();
            Tooltip.Position = UDim2.fromOffset(Mouse.X + 15, Mouse.Y + 12);
        end;
    end);

    HoverInstance.MouseLeave:Connect(function()
        IsHovering = false;
        Tooltip.Visible = false;
    end);
end;

function Library:OnHighlight(HighlightInstance, Instance, Properties, PropertiesDefault)
    local activeTweens = {};

    HighlightInstance.MouseEnter:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, Properties do
            local targetValue = Library[ColorIdx] or ColorIdx;
            if typeof(targetValue) == "Color3" then
                if activeTweens[Property] then activeTweens[Property]:Cancel() end;
                local tween = TweenService:Create(Instance, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    [Property] = targetValue
                });
                activeTweens[Property] = tween;
                tween:Play();
            else
                Instance[Property] = targetValue;
            end;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end);

    HighlightInstance.MouseLeave:Connect(function()
        local Reg = Library.RegistryMap[Instance];

        for Property, ColorIdx in next, PropertiesDefault do
            local targetValue = Library[ColorIdx] or ColorIdx;
            if typeof(targetValue) == "Color3" then
                if activeTweens[Property] then activeTweens[Property]:Cancel() end;
                local tween = TweenService:Create(Instance, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    [Property] = targetValue
                });
                activeTweens[Property] = tween;
                tween:Play();
            else
                Instance[Property] = targetValue;
            end;

            if Reg and Reg.Properties[Property] then
                Reg.Properties[Property] = ColorIdx;
            end;
        end;
    end);
end;

function Library:MouseIsOverOpenedFrame()
    for Frame, _ in next, Library.OpenedFrames do
        local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

        if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
            and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

            return true;
        end;
    end;
end;

function Library:IsMouseOverFrame(Frame)
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
        and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

        return true;
    end;
end;

function Library:UpdateDependencyBoxes()
    for _, Depbox in next, Library.DependencyBoxes do
        Depbox:Update();
    end;
end;

function Library:MapValue(Value, MinA, MaxA, MinB, MaxB)
    return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
end;

function Library:GetTextBounds(Text, Font, Size, Resolution)
    function RemoveTags(str)
        str = str:gsub('<br%s*/>', '\n');

        return (str:gsub('<[^<>]->', ''));
    end;

    local CleanText = RemoveTags(Text);
    local Bounds = TextService:GetTextSize(CleanText, Size, Font, Resolution or Vector2.new(1920, 1080));

    return Bounds.X, Bounds.Y;
end;

function Library:ScanCustomUIFonts()
    local found = {};

    local function scanDir(prefix)
        if not listfiles then
            return
        end;

        local ok, files = pcall(listfiles, prefix);
        if not ok or not files then
            return
        end;

        for _, path in files do
            local lower = string.lower(path);
            if lower:sub(-5) == '.font' or lower:sub(-4) == '.ttf' then
                local name = path:match('([^/\\]+)%.%w+$');
                if name and not ENUM_UI_FONTS[name] and not CUSTOM_UI_FONTS[name] then
                    found[name] = path;
                end;
            end;
        end;
    end;

    scanDir('');
    scanDir('library');

    return found;
end;

function Library:GetUIFontNames()
    local names = {};
    local seen = {};

    local function add(name)
        if name and not seen[name] then
            seen[name] = true;
            table.insert(names, name);
        end;
    end;

    for name in CUSTOM_UI_FONTS do
        add(name);
    end;

    for name in ENUM_UI_FONTS do
        add(name);
    end;

    for name in self:ScanCustomUIFonts() do
        add(name);
    end;

    table.sort(names, function(a, b)
        local aCustom = CUSTOM_UI_FONTS[a] ~= nil;
        local bCustom = CUSTOM_UI_FONTS[b] ~= nil;
        if aCustom ~= bCustom then
            return aCustom;
        end;
        return a < b;
    end);

    return names;
end;

function Library:LoadUIFont(name)
    if self.FontCache[name] then
        return self.FontCache[name].FontFace, self.FontCache[name].Font;
    end;

    local customEntry = CUSTOM_UI_FONTS[name];
    if customEntry then
        local face = loadCustomFontFace(name, customEntry);
        if face then
            self.FontCache[name] = { FontFace = face, Font = Enum.Font.Code };
            return face, Enum.Font.Code;
        end;
    end;

    local enumFont = ENUM_UI_FONTS[name];
    if enumFont then
        local face = select(1, resolveEnumFontFace(enumFont));
        self.FontCache[name] = { FontFace = face, Font = enumFont };
        return face, enumFont;
    end;

    local scanned = self:ScanCustomUIFonts();
    local path = scanned[name];
    if path then
        local face = tryFontFromAsset(path);

        if not face and string.lower(path):sub(-4) == '.ttf' and writefile and isfile and getcustomasset then
            local fontFile = name .. '.font';
            if not isfile(fontFile) then
                local info = {
                    name = name,
                    faces = {
                        {
                            name = 'Normal',
                            weight = 400,
                            style = 'Normal',
                            assetId = getcustomasset(path),
                        },
                    },
                };
                writefile(fontFile, HttpService:JSONEncode(info));
            end;
            face = tryFontFromAsset(fontFile);
        end;

        if face then
            self.FontCache[name] = { FontFace = face, Font = Enum.Font.Code };
            return face, Enum.Font.Code;
        end;
    end;

    return self:LoadUIFont(DefaultUIFont);
end;

function Library:ApplyFontToAll()
    for _, inst in ScreenGui:GetDescendants() do
        if inst:IsA('TextLabel') or inst:IsA('TextButton') or inst:IsA('TextBox') then
            if self.FontFace then
                pcall(function()
                    inst.FontFace = self.FontFace;
                end);
            else
                inst.Font = self.Font;
            end;
        end;
    end;

    if self.LastWatermarkText then
        self:SetWatermark(self.LastWatermarkText);
    end;

    self:UpdateKeybindOverlaySize();
    self:UpdateWindowTabLayout();
end;

function Library:UpdateWindowTabLayout()
    if Library.MainWindow and Library.MainWindow.UpdateTabLayout then
        Library.MainWindow:UpdateTabLayout();
    end;
end;

function Library:SetUIFont(name)
    if not name or name == '' then
        return
    end;

    local face, enumFont = self:LoadUIFont(name);
    self.FontFace = face;
    self.Font = enumFont or Enum.Font.Code;
    self.CurrentUIFont = name;
    self:ApplyFontToAll();
end;

function Library:GetDarkerColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V / 1.5);
end;

function Library:GetLighterColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S * 0.8, math.min(V * 1.2, 1));
end;

Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
Library.AccentColorLight = Library:GetLighterColor(Library.AccentColor);

function Library:AddToRegistry(Instance, Properties, IsHud)
    local Idx = #Library.Registry + 1;
    local Data = {
        Instance = Instance;
        Properties = Properties;
        Idx = Idx;
    };

    table.insert(Library.Registry, Data);
    Library.RegistryMap[Instance] = Data;

    if IsHud then
        table.insert(Library.HudRegistry, Data);
    end;
end;

function Library:RemoveFromRegistry(Instance)
    local Data = Library.RegistryMap[Instance];

    if Data then
        for Idx = #Library.Registry, 1, -1 do
            if Library.Registry[Idx] == Data then
                table.remove(Library.Registry, Idx);
            end;
        end;

        for Idx = #Library.HudRegistry, 1, -1 do
            if Library.HudRegistry[Idx] == Data then
                table.remove(Library.HudRegistry, Idx);
            end;
        end;

        Library.RegistryMap[Instance] = nil;
    end;
end;

function Library:IsGuiShown(GuiObject)
    if not GuiObject or not GuiObject:IsA('GuiObject') then
        return true;
    end;

    local current = GuiObject;
    while current and current ~= ScreenGui do
        if current:IsA('GuiObject') and not current.Visible then
            return false;
        end;
        current = current.Parent;
    end;

    return true;
end;

function Library:RefreshThemedControls()
    if Toggles then
        for _, toggle in Toggles do
            if toggle.UpdateColors then
                toggle:UpdateColors();
            elseif toggle.Display then
                toggle:Display();
            end;
        end;
    end;

    if Options then
        for _, option in Options do
            if option.Type == 'Slider' and option.UpdateColors then
                option:UpdateColors();
            elseif option.Type == 'Dropdown' and option.Display then
                option:Display();
            end;
        end;
    end;
end;

function Library:UpdateColorsUsingRegistry()
    Library.ThemeUpdating = true;

    for Idx, Object in next, Library.Registry do
        if Object.Instance and Object.Instance.Parent then
            for Property, ColorIdx in next, Object.Properties do
                if type(ColorIdx) == 'string' then
                    Object.Instance[Property] = Library[ColorIdx];
                elseif type(ColorIdx) == 'function' then
                    Object.Instance[Property] = ColorIdx();
                end;
            end;
        end;
    end;

    if Library.UpdateTitle then
        Library.UpdateTitle();
    end;

    Library:UpdateShadows();
    Library:UpdateScrollBars();

    if Library.LastWatermarkText and Library.WatermarkText then
        Library:SetAccentTitle(Library.WatermarkText, Library.LastWatermarkText, Library.WatermarkAccentPart or '.lol');
    end;

    for _, overlay in next, Library.Overlays do
        if overlay.UpdateTitle then
            overlay.UpdateTitle();
        end;
    end;

    Library:UpdateAllGradientTexts();
    Library:UpdateAllAccentTitles();
    Library:UpdateFooter();
    Library:RefreshThemedControls();
    Library:UpdateOverlayGlows();
    Library.ThemeUpdating = false;
end;

function Library:CreateOverlayGlowLayers(Parent, ZIndex)
    local Layers = {};
    local Thickness = 8;
    local InnerTransparency = 0.42;
    local CornerSpan = Thickness * 2;

    local Holder = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = false;
        Size = UDim2.fromScale(1, 1);
        Position = UDim2.fromScale(0, 0);
        Visible = Library.OverlayGlowEnabled;
        ZIndex = math.max((ZIndex or 1) - 2, 0);
        Parent = Parent;
    });

    table.insert(Layers, Holder);

    local function OutwardFade(FromEdge)
        local Inner = InnerTransparency;

        if FromEdge then
            return NumberSequence.new({
                NumberSequenceKeypoint.new(0, Inner);
                NumberSequenceKeypoint.new(0.3, 0.58);
                NumberSequenceKeypoint.new(0.65, 0.78);
                NumberSequenceKeypoint.new(1, 1);
            });
        end;

        return NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1);
            NumberSequenceKeypoint.new(0.35, 0.78);
            NumberSequenceKeypoint.new(0.7, 0.58);
            NumberSequenceKeypoint.new(1, Inner);
        });
    end;

    local function AddEdge(Size, Position, GradientRotation, FromEdge)
        local Edge = Library:Create('Frame', {
            BackgroundColor3 = Library.OverlayGlowColor;
            BorderSizePixel = 0;
            Position = Position;
            Size = Size;
            ZIndex = Holder.ZIndex;
            Parent = Holder;
        });

        Library:Create('UIGradient', {
            Rotation = GradientRotation;
            Color = ColorSequence.new(Library.OverlayGlowColor);
            Transparency = OutwardFade(FromEdge);
            Parent = Edge;
        });

        Library:AddToRegistry(Edge, {
            BackgroundColor3 = 'OverlayGlowColor';
        }, true);

        table.insert(Layers, Edge);
    end;

    local function AddQuarterCorner(ClipAnchor, ClipPosition, CircleAnchor, GradientRotation)
        local Clip = Library:Create('Frame', {
            AnchorPoint = ClipAnchor;
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            ClipsDescendants = true;
            Position = ClipPosition;
            Size = UDim2.fromOffset(Thickness, Thickness);
            ZIndex = Holder.ZIndex;
            Parent = Holder;
        });

        local OffsetX = CircleAnchor.X == 1 and Thickness or -Thickness;
        local OffsetY = CircleAnchor.Y == 1 and Thickness or -Thickness;

        local Circle = Library:Create('Frame', {
            AnchorPoint = CircleAnchor;
            BackgroundColor3 = Library.OverlayGlowColor;
            BorderSizePixel = 0;
            Position = UDim2.new(CircleAnchor.X, OffsetX, CircleAnchor.Y, OffsetY);
            Size = UDim2.fromOffset(CornerSpan, CornerSpan);
            ZIndex = Holder.ZIndex;
            Parent = Clip;
        });

        Library:Create('UICorner', {
            CornerRadius = UDim.new(1, 0);
            Parent = Circle;
        });

        Library:Create('UIGradient', {
            Rotation = GradientRotation;
            Color = ColorSequence.new(Library.OverlayGlowColor);
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, InnerTransparency);
                NumberSequenceKeypoint.new(0.35, 0.55);
                NumberSequenceKeypoint.new(0.65, 0.78);
                NumberSequenceKeypoint.new(1, 1);
            });
            Parent = Circle;
        });

        Library:AddToRegistry(Circle, {
            BackgroundColor3 = 'OverlayGlowColor';
        }, true);

        table.insert(Layers, Clip);
        table.insert(Layers, Circle);
    end;

    AddEdge(UDim2.new(1, 0, 0, Thickness), UDim2.new(0, 0, 0, -Thickness), 270, true);
    AddEdge(UDim2.new(1, 0, 0, Thickness), UDim2.new(0, 0, 1, 0), 270, false);
    AddEdge(UDim2.new(0, Thickness, 1, 0), UDim2.new(0, -Thickness, 0, 0), 0, false);
    AddEdge(UDim2.new(0, Thickness, 1, 0), UDim2.new(1, 0, 0, 0), 0, true);

    AddQuarterCorner(Vector2.new(1, 1), UDim2.new(0, 0, 0, 0), Vector2.new(1, 1), 225);
    AddQuarterCorner(Vector2.new(0, 1), UDim2.new(1, 0, 0, 0), Vector2.new(0, 1), 315);
    AddQuarterCorner(Vector2.new(1, 0), UDim2.new(0, 0, 1, 0), Vector2.new(1, 0), 135);
    AddQuarterCorner(Vector2.new(0, 0), UDim2.new(1, 0, 1, 0), Vector2.new(0, 0), 45);

    return Layers;
end;

function Library:UpdateOverlayGlow(Overlay)
    if not Overlay or not Overlay.GlowLayers then
        return
    end;

    local Visible;
    if Overlay == Library.MainWindow then
        Visible = Library.OverlayGlowEnabled
            and Overlay.Outer
            and Overlay.Outer.Visible;
    else
        Visible = Overlay.Visible ~= false and Library.OverlayGlowEnabled;
    end;

    local GlowColor = Library.OverlayGlowColor;
    local ColorSequenceValue = ColorSequence.new(GlowColor);

    for _, Layer in Overlay.GlowLayers do
        Layer.Visible = Visible;

        if Layer:IsA('Frame') then
            local Gradient = Layer:FindFirstChildOfClass('UIGradient');
            if Gradient then
                Layer.BackgroundColor3 = GlowColor;
                Gradient.Color = ColorSequenceValue;
            end;
        end;
    end;
end;

function Library:UpdateOverlayGlows()
    for _, Overlay in Library.Overlays do
        Library:UpdateOverlayGlow(Overlay);
    end;

    if Library.MainWindow then
        Library:UpdateOverlayGlow(Library.MainWindow);
    end;
end;

function Library:SetOverlayGlowEnabled(Enabled)
    Library.OverlayGlowEnabled = not not Enabled;
    Library:UpdateOverlayGlows();
end;

function Library:SetOverlayGlowColor(Color)
    Library.OverlayGlowColor = Color;
    Library:UpdateOverlayGlows();
end;

function Library:GetGradientSequence()
    local White = Color3.new(1, 1, 1);
    local Accent = Library.AccentColor;

    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, White),
        ColorSequenceKeypoint.new(0.35, White:Lerp(Accent, 0.4)),
        ColorSequenceKeypoint.new(0.65, White:Lerp(Accent, 0.75)),
        ColorSequenceKeypoint.new(1, Accent),
    });
end;

function Library:RegisterGradientLabel(Label)
    for _, existing in next, Library.GradientLabels do
        if existing == Label then
            return
        end;
    end;
    table.insert(Library.GradientLabels, Label);
end;

function Library:SetGradientText(Label, Text)
    if not Label then return end;

    for idx = #Library.AccentTitleLabels, 1, -1 do
        if Library.AccentTitleLabels[idx].Label == Label then
            table.remove(Library.AccentTitleLabels, idx);
        end;
    end;

    Label.RichText = false;
    Label.Text = Text or '';
    Label.TextColor3 = Color3.new(1, 1, 1);

    local gradient = Label:FindFirstChild('ZRHUBTextGradient');
    if not gradient then
        gradient = Library:Create('UIGradient', {
            Name = 'ZRHUBTextGradient';
            Parent = Label;
        });
        Library:RegisterGradientLabel(Label);
    end;

    gradient.Color = Library:GetGradientSequence();
    gradient.Rotation = 0;
end;

function Library:UpdateAllGradientTexts()
    local sequence = Library:GetGradientSequence();

    for idx = #Library.GradientLabels, 1, -1 do
        local label = Library.GradientLabels[idx];
        if not label or not label.Parent then
            table.remove(Library.GradientLabels, idx);
        else
            local gradient = label:FindFirstChild('ZRHUBTextGradient');
            if gradient then
                gradient.Color = sequence;
            end;
        end;
    end;
end;

function Library:FormatAccentTitle(Title, AccentPart)
    Title = Title or '';
    AccentPart = AccentPart or '';

    if AccentPart == '' or not string.find(Title, AccentPart, 1, true) then
        return Title;
    end;

    local startIndex = string.find(Title, AccentPart, 1, true);
    local before = string.sub(Title, 1, startIndex - 1);
    local after = string.sub(Title, startIndex + #AccentPart);
    local accentHex = Library.AccentColor:ToHex();

    return string.format(
        '<font color="#ffffff">%s</font><font color="#%s">%s</font><font color="#ffffff">%s</font>',
        before,
        accentHex,
        AccentPart,
        after
    );
end;

function Library:RegisterAccentTitleLabel(Label, Title, AccentPart)
    for _, entry in next, Library.AccentTitleLabels do
        if entry.Label == Label then
            entry.Title = Title;
            entry.AccentPart = AccentPart;
            return
        end;
    end;

    table.insert(Library.AccentTitleLabels, {
        Label = Label;
        Title = Title;
        AccentPart = AccentPart;
    });
end;

function Library:SetAccentTitle(Label, Title, AccentPart)
    if not Label then
        return
    end;

    Title = Title or '';
    AccentPart = AccentPart or '';

    local gradient = Label:FindFirstChild('ZRHUBTextGradient');
    if gradient then
        gradient:Destroy();
    end;

    for idx = #Library.GradientLabels, 1, -1 do
        if Library.GradientLabels[idx] == Label then
            table.remove(Library.GradientLabels, idx);
        end;
    end;

    Label.RichText = true;
    Label.TextColor3 = Color3.new(1, 1, 1);
    Label.Text = Library:FormatAccentTitle(Title, AccentPart);
    Library:RegisterAccentTitleLabel(Label, Title, AccentPart);
end;

function Library:UpdateAllAccentTitles()
    for idx = #Library.AccentTitleLabels, 1, -1 do
        local entry = Library.AccentTitleLabels[idx];
        if not entry.Label or not entry.Label.Parent then
            table.remove(Library.AccentTitleLabels, idx);
        else
            entry.Label.RichText = true;
            entry.Label.Text = Library:FormatAccentTitle(entry.Title, entry.AccentPart);
        end;
    end;
end;

function Library:ApplyPopupZIndex(Root, OriginZIndex)
    if not Root then
        return Library:GetPopupZIndex(0);
    end;

    local base = Library:GetPopupZIndex(0);
    OriginZIndex = OriginZIndex or Root.ZIndex or 15;

    local cache = Library.PopupZIndexCache[Root];
    if not cache then
        cache = {
            OriginZ = OriginZIndex;
            OriginalZ = {};
        };
        Library.PopupZIndexCache[Root] = cache;
    else
        cache.OriginZ = OriginZIndex;
    end;

    local delta = base - cache.OriginZ;

    local function Apply(instance)
        if not instance:IsA('GuiObject') then
            return
        end;

        if cache.OriginalZ[instance] == nil then
            cache.OriginalZ[instance] = instance.ZIndex;
        end;

        instance.ZIndex = cache.OriginalZ[instance] + delta;
    end;

    Apply(Root);

    for _, descendant in Root:GetDescendants() do
        Apply(descendant);
    end;

    return base;
end;

function Library:CreateTabBottomGlow(Parent, Options)
    Options = Options or {};

    local GlowHeight = Options.GlowHeight or 18;
    local LineHeight = Options.LineHeight or 2;
    local ZIndex = Options.ZIndex or 1;

    local TabGlow = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0, 1);
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 1, 0);
        Size = UDim2.new(1, 0, 0, GlowHeight);
        Visible = false;
        ZIndex = ZIndex;
        Parent = Parent;
    });

    Library:AddToRegistry(TabGlow, {
        BackgroundColor3 = 'AccentColor';
    });

    Library:Create('UIGradient', {
        Rotation = 90;
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.38);
            NumberSequenceKeypoint.new(0.3, 0.62);
            NumberSequenceKeypoint.new(0.65, 0.86);
            NumberSequenceKeypoint.new(1, 1);
        });
        Parent = TabGlow;
    });

    local TabLine = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0, 1);
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 1, 0);
        Size = UDim2.new(1, 0, 0, LineHeight);
        Visible = false;
        ZIndex = ZIndex + 2;
        Parent = Parent;
    });

    Library:AddToRegistry(TabLine, {
        BackgroundColor3 = 'AccentColor';
    });

    return TabGlow, TabLine;
end;

function Library:SetTabGlowVisible(TabGlow, TabLine, Visible)
    if TabGlow then
        TabGlow.Visible = Visible;
    end;

    if TabLine then
        TabLine.Visible = Visible;
    end;
end;

function Library:ApplyWindowShadow() end;

function Library:LinkWindowShadow() end;

function Library:LinkWindowShadow() end;

function Library:UpdateMenuBlur()
    local lighting = game:GetService('Lighting');
    local blur = lighting:FindFirstChild('ZRHUBMenuBlur');
    local enabled = Toggles and Toggles.MenuBlurToggle and Toggles.MenuBlurToggle.Value;
    local shouldBlur = enabled and Library.MenuOpen;

    if shouldBlur then
        if not blur then
            blur = Instance.new('BlurEffect');
            blur.Name = 'ZRHUBMenuBlur';
            blur.Size = 12;
            blur.Parent = lighting;
        end;
    elseif blur then
        blur:Destroy();
    end;
end;

function Library:UpdateFooter()
    if not Library.FooterLeft or not Library.FooterRight then
        return
    end;

    local username = Library.AnonymousMode and 'anonymous' or LocalPlayer.Name;
    local placeName = Library.PlaceName or 'Baseplate';
    local greyHex = '828282';
    local accentHex = Library.AccentColor:ToHex();

    Library.FooterLeft.RichText = true;
    Library.FooterLeft.TextTransparency = 0;
    Library.FooterLeft.Text = string.format(
        '<font color="#%s">welcome back, </font><font color="#%s">%s</font>',
        greyHex,
        accentHex,
        username
    );

    Library.FooterRight.RichText = true;
    Library.FooterRight.TextTransparency = 0;
    Library.FooterRight.Text = string.format(
        '<font color="#%s">[ </font><font color="#%s">%s</font><font color="#%s"> ]</font>',
        greyHex,
        accentHex,
        placeName,
        greyHex
    );
end;

function Library:GetKeybindRowZBase()
    if Library.KeybindOverlay and Library.KeybindOverlay.Outer then
        return Library.KeybindOverlay.Outer.ZIndex + 12;
    end;

    return 225;
end;

function Library:GetPopupZIndex(Offset)
    Offset = Offset or 0;
    local Z = 250 + Offset;

    if Library.KeybindOverlay and Library.KeybindOverlay.ZIndexBase then
        Z = math.max(Z, Library.KeybindOverlay.ZIndexBase + 50 + Offset);
    end;

    for _, Overlay in Library.Overlays do
        if Overlay and Overlay.ZIndexBase then
            Z = math.max(Z, Overlay.ZIndexBase + 50 + Offset);
        end;
    end;

    return Z;
end;

function Library:SyncKeybindRowsZIndex()
    if not Library.KeybindContainer then
        return
    end;

    local base = Library:GetKeybindRowZBase();

    for _, row in Library.KeybindContainer:GetChildren() do
        if row:IsA('Frame') then
            row.ZIndex = base;

            for _, child in row:GetChildren() do
                if child:IsA('TextLabel') then
                    child.ZIndex = base + 3;
                    child.TextTransparency = 0;
                elseif child:IsA('Frame') then
                    child.ZIndex = base + 3;

                    local valueLabel = child:FindFirstChildWhichIsA('TextLabel');
                    if valueLabel then
                        valueLabel.ZIndex = base + 5;
                        valueLabel.TextTransparency = 0;
                        valueLabel.TextColor3 = Color3.new(1, 1, 1);
                    end;
                end;
            end;
        end;
    end;

    Library.KeybindContainer.ZIndex = base;
end;

function Library:UpdateKeybindOverlaySize()
    if not Library.KeybindContainer or Library._UpdatingKeybindOverlaySize then
        return
    end;

    Library._UpdatingKeybindOverlaySize = true;

    Library:SyncKeybindRowsZIndex();

    local rowHeight = 0;
    local maxWidth = 170;
    local activeCount = 0;

    for _, row in Library.KeybindContainer:GetChildren() do
        if row:IsA('Frame') and row.Visible then
            activeCount += 1;
            rowHeight += 24;
            local nameLabel = row:FindFirstChildWhichIsA('TextLabel');
            local keyBox = row:FindFirstChildWhichIsA('Frame');
            if nameLabel and keyBox then
                local valueLabel = keyBox:FindFirstChildWhichIsA('TextLabel');
                local keyText = valueLabel and valueLabel.Text or '';
                local rowWidth = Library:GetTextBounds(nameLabel.Text, Library.Font, 13)
                    + Library:GetTextBounds(keyText, Library.Font, 12)
                    + 28;
                maxWidth = math.max(maxWidth, rowWidth);
            end;
        end;
    end;

    local compact = activeCount == 0;
    Library.KeybindOverlayCompact = compact;

    if compact then
        rowHeight = 0;
    else
        rowHeight = math.max(rowHeight, 22);
    end;

    local contentHeight = compact and 0 or math.max(rowHeight + 8, 22);

    Library.KeybindContainer.Size = UDim2.new(1, -12, 0, rowHeight);

    if Library.KeybindOverlay and Library.KeybindOverlay.Outer then
        local overlay = Library.KeybindOverlay;
        local overlayWidth = math.max(maxWidth + 24, 196);
        local targetSize;

        if overlay.ContentOuter then
            overlay.ContentOuter.Visible = not compact;
            overlay.ContentOuter.Size = UDim2.new(1, -12, 0, contentHeight);
        end;

        if overlay.ContentInner then
            overlay.ContentInner.Size = UDim2.new(1, -2, 1, -2);
        end;

        if overlay.Container then
            overlay.Container.Visible = false;
        end;

        if compact then
            targetSize = UDim2.fromOffset(overlayWidth, 32);
        else
            targetSize = UDim2.fromOffset(overlayWidth, 26 + contentHeight + 6);
        end;

        if Library.KeybindOverlayTween then
            Library.KeybindOverlayTween:Cancel();
        end;

        Library.KeybindOverlayTween = TweenService:Create(overlay.Outer, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = targetSize,
        });
        Library.KeybindOverlayTween:Play();
    end;

    Library._UpdatingKeybindOverlaySize = false;
end;

function Library:GetUIScaleFactor(Instance)
    local current = Instance;
    while current and current ~= ScreenGui do
        local scale = current:FindFirstChildOfClass('UIScale');
        if scale then
            return scale.Scale;
        end;
        current = current.Parent;
    end;
    return 1;
end;

function Library:UpdateShadows() end;

function Library:UpdateScrollBars()
    for _, desc in ScreenGui:GetDescendants() do
        if desc:IsA('ScrollingFrame') then
            desc.ScrollBarImageColor3 = Library.AccentColor;
        end;
    end;
end;

function Library:SetAllCloseEnabled(Enabled)
    Library.AllCloseOverlays = not not Enabled;
    if Library.AllCloseOverlays then
        Library:SyncOverlaysWithMenu(Library.MenuOpen);
    end;
end;

function Library:SyncOverlaysWithMenu(MenuVisible)
    for _, overlay in Library.Overlays do
        if overlay.SetVisible then
            if MenuVisible then
                if Library.AllCloseOverlays then
                    overlay:SetVisible(true);
                end;
            else
                overlay:SetVisible(false);
            end;
        elseif overlay.Outer then
            if MenuVisible then
                if Library.AllCloseOverlays then
                    overlay.Outer.Visible = true;
                    overlay.Visible = true;
                end;
            else
                overlay.Outer.Visible = false;
                overlay.Visible = false;
            end;
        end;
    end;
end;

function Library:BindHoldButton(Button, StepCallback)
    if not Button or not StepCallback then return end;

    local holding = false;

    local function stop()
        holding = false;
        Library:StopSliderSound();
    end;

    Button.MouseButton1Down:Connect(function()
        holding = true;
        StepCallback();
        task.spawn(function()
            task.wait(0.35);
            while holding and Button.Parent do
                StepCallback();
                task.wait(0.06);
            end;
        end);
    end);

    Button.MouseButton1Up:Connect(stop);
    Button.MouseLeave:Connect(stop);
end;

function Library:CreateOverlayWindow(Config)
    Config = Config or {};

    local Title = Config.Title or 'Overlay';
    local Size = typeof(Config.Size) == 'UDim2' and Config.Size or UDim2.fromOffset(260, 300);
    local Position = typeof(Config.Position) == 'UDim2' and Config.Position or UDim2.fromOffset(100, 100);
    local ZIndex = Config.ZIndex or 150;
    local Visible = Config.Visible == true;
    local AccentPart = Config.AccentPart;
    local ZIndexBase = ZIndex + 10;
    local PreviousOverlayBase = Library.OverlayZIndexBase;

    Library.OverlayZIndexBase = ZIndexBase;

    local Overlay = {
        Visible = Visible;
        Tabs = {};
        Groupboxes = {};
        ZIndexBase = ZIndexBase;
    };

    local Outer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = false;
        Position = Position;
        Size = Size;
        Visible = Visible;
        ZIndex = ZIndex;
        Parent = ScreenGui;
    });

    local OverlayScaleFactor = 1;
    if IsTouchDevice then
        OverlayScaleFactor = Library.MobileOverlayScale or 0.55;
        Library:Create('UIScale', {
            Scale = OverlayScaleFactor;
            Parent = Outer;
        });

        task.delay(0.1, function()
            if not Outer.Parent then
                return
            end;

            local screen = ScreenGui.AbsoluteSize;
            if screen.X <= 0 or screen.Y <= 0 then
                return
            end;

            local maxX = math.max(screen.X - Outer.AbsoluteSize.X, 0);
            local maxY = math.max(screen.Y - Outer.AbsoluteSize.Y, 0);
            local x = math.clamp(Outer.Position.X.Offset, 0, maxX);
            local y = math.clamp(Outer.Position.Y.Offset, 0, maxY);

            if x ~= Outer.Position.X.Offset or y ~= Outer.Position.Y.Offset then
                Outer.Position = UDim2.fromOffset(x, y);
            end;
        end);
    end;

    Overlay.GlowLayers = nil;

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderSizePixel = 0;
        ClipsDescendants = false;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = ZIndex + 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, { BackgroundColor3 = 'MainColor' });

    Overlay.GlowLayers = Library:CreateOverlayGlowLayers(Inner, ZIndex);

    local TopAccent = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = ZIndex + 5;
        Parent = Inner;
    });

    Library:AddToRegistry(TopAccent, { BackgroundColor3 = 'AccentColor' });

    local TitleLabel = Library:CreateLabel({
        Position = UDim2.new(0, 8, 0, 4);
        Size = UDim2.new(1, -16, 0, 20);
        TextSize = 14;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = ZIndex + 2;
        Parent = Inner;
    });

    local function UpdateOverlayTitle()
        if AccentPart and AccentPart ~= '' then
            Library:SetAccentTitle(TitleLabel, Title, AccentPart);
        else
            Library:SetGradientText(TitleLabel, Title);
        end;
    end;

    local ContentOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        ClipsDescendants = true;
        Position = UDim2.new(0, 6, 0, 26);
        Size = UDim2.new(1, -12, 0, 0);
        ZIndex = ZIndex + 1;
        Parent = Inner;
    });

    Library:AddToRegistry(ContentOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local ContentInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 1, 0, 1);
        Size = UDim2.new(1, -2, 1, -2);
        ZIndex = ZIndex + 2;
        Parent = ContentOuter;
    });

    Library:AddToRegistry(ContentInner, { BackgroundColor3 = 'BackgroundColor' });

    local Container = Library:Create('ScrollingFrame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = true;
        Position = UDim2.new(0, 4, 0, 4);
        Size = UDim2.new(1, -8, 1, -8);
        CanvasSize = UDim2.new(0, 0, 0, 0);
        ScrollBarThickness = 3;
        ScrollBarImageColor3 = Library.AccentColor;
        BottomImage = '';
        TopImage = '';
        ZIndex = ZIndex + 3;
        Parent = ContentInner;
    });

    Library:AddToRegistry(Container, {
        ScrollBarImageColor3 = 'AccentColor';
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 6);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = Container;
    });

    Container:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        if Overlay.Resize then
            Overlay:Resize();
        end;
    end);

    function Overlay:Resize()
        local listLayout = Container:FindFirstChildOfClass('UIListLayout');
        if not listLayout then
            return
        end;

        local contentH = math.ceil(listLayout.AbsoluteContentSize.Y / OverlayScaleFactor);
        if contentH <= 0 then
            return
        end;

        local chromeTop = 26;
        local chromeBottom = 6;
        local containerPadding = 8;
        local width = Outer.Size.X.Offset;

        Container.Size = UDim2.new(1, -8, 0, contentH);
        Container.CanvasSize = UDim2.fromOffset(0, contentH);
        ContentOuter.Size = UDim2.new(1, -12, 0, contentH + containerPadding);

        local height = chromeTop + contentH + containerPadding + chromeBottom;
        Outer.Size = UDim2.fromOffset(width, math.max(height, 56));
    end;

    Library:MakeDraggable(Outer, 28);

    function Overlay:SetVisible(Bool)
        Overlay.Visible = not not Bool;
        Outer.Visible = Overlay.Visible;
        Library:UpdateOverlayGlow(Overlay);
    end;

    function Overlay:Show()
        Overlay:SetVisible(true);
    end;

    function Overlay:Hide()
        Overlay:SetVisible(false);
    end;

    function Overlay:Toggle()
        Overlay:SetVisible(not Overlay.Visible);
    end;

    function Overlay:SetTitle(NewTitle, NewAccentPart)
        Title = NewTitle or Title;
        AccentPart = NewAccentPart or AccentPart;
        UpdateOverlayTitle();
    end;

    function Overlay:AddGroupbox(Info)
        local Groupbox = {};
        local boxName = Info.Name or 'Section';

        local BoxOuter = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, -4, 0, 0);
            ZIndex = ZIndex + 4;
            Parent = Container;
        });

        Library:AddToRegistry(BoxOuter, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        local BoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, -2, 1, -2);
            Position = UDim2.new(0, 1, 0, 1);
            ZIndex = ZIndex + 5;
            Parent = BoxOuter;
        });

        Library:AddToRegistry(BoxInner, { BackgroundColor3 = 'BackgroundColor' });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 1);
            ZIndex = ZIndex + 6;
            Parent = BoxInner;
        });

        Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor' });

        Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 16);
            Position = UDim2.new(0, 4, 0, 2);
            TextSize = 13;
            Text = boxName;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = ZIndex + 6;
            Parent = BoxInner;
        });

        local GroupContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 6, 0, 18);
            Size = UDim2.new(1, -10, 0, 0);
            ZIndex = ZIndex + 5;
            Parent = BoxInner;
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = GroupContainer;
        });

        local GroupListLayout = GroupContainer:FindFirstChildOfClass('UIListLayout');
        if GroupListLayout then
            GroupListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Groupbox:Resize();
            end);
        end;

        function Groupbox:Resize()
            local listLayout = GroupContainer:FindFirstChildOfClass('UIListLayout');
            local SizeY = listLayout and math.ceil(listLayout.AbsoluteContentSize.Y / OverlayScaleFactor) or 0;
            GroupContainer.Size = UDim2.new(1, -10, 0, SizeY);
            BoxOuter.Size = UDim2.new(1, -4, 0, 18 + SizeY + 4);
            task.defer(function()
                if Overlay.Resize then
                    Overlay:Resize();
                end;
            end);
        end;

        Groupbox.Container = GroupContainer;
        Groupbox.ContentBaseZIndex = ZIndex + 10;
        setmetatable(Groupbox, BaseGroupbox);
        Groupbox:AddBlank(3);
        Groupbox:Resize();

        Overlay.Groupboxes[boxName] = Groupbox;
        return Groupbox;
    end;

    Overlay.Outer = Outer;
    Overlay.Inner = Inner;
    Overlay.Container = Container;
    Overlay.ContentOuter = ContentOuter;
    Overlay.ContentInner = ContentInner;
    Overlay.TitleLabel = TitleLabel;
    Overlay.UpdateTitle = UpdateOverlayTitle;
    UpdateOverlayTitle();

    table.insert(Library.Overlays, Overlay);
    task.defer(function()
        Overlay:Resize();
    end);

    Library.OverlayZIndexBase = PreviousOverlayBase;

    return Overlay;
end;

function Library:CreateOverlayOpener(Items, ParentContainer, Groupbox)
    local Opener = {};
    local ContentZ = (Groupbox and Groupbox.ContentBaseZIndex or 10);

    local List = Library:Create('Frame', {
        BackgroundTransparency = 1;
        AutomaticSize = Enum.AutomaticSize.Y;
        Size = UDim2.new(1, 0, 0, 0);
        ZIndex = ContentZ + 6;
        Parent = ParentContainer;
    });

    local OpenerLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = List;
    });

    for _, item in next, Items do
        local Row = Library:Create('TextButton', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            AutoButtonColor = false;
            Size = UDim2.new(1, -4, 0, 22);
            Text = '';
            ZIndex = ContentZ + 7;
            Parent = List;
        });

        Library:AddToRegistry(Row, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local displayText = item.Text or item.Name or 'Open';

        local RowLabel = Library:CreateLabel({
            Size = UDim2.new(1, -8, 1, 0);
            Position = UDim2.new(0, 6, 0, 0);
            Text = displayText;
            TextSize = 13;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = ContentZ + 8;
            Parent = Row;
        });

        Library:SetGradientText(RowLabel, displayText);

        Library:OnHighlight(Row, Row,
            { BackgroundColor3 = 'SelectedTabColor', BorderColor3 = 'AccentColor' },
            { BackgroundColor3 = 'MainColor', BorderColor3 = 'OutlineColor' }
        );

        Row.MouseButton1Click:Connect(function()
            if item.Overlay and item.Overlay.Toggle then
                item.Overlay:Toggle();
            elseif type(item.Callback) == 'function' then
                Library:SafeCallback(item.Callback);
            end;
        end);
    end;

    Opener.Frame = List;

    if Groupbox and Groupbox.Resize then
        Groupbox:Resize();
        OpenerLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Groupbox:Resize();
        end);
        task.defer(function()
            Groupbox:Resize();
        end);
    end;

    return Opener;
end;

function Library:CreatePlayerListOverlay(Config)
    Config = Config or {};
    local Overlay = Library:CreateOverlayWindow({
        Title = 'Player List';
        AccentPart = 'List';
        Size = UDim2.fromOffset(320, 392);
        Position = Config.Position or UDim2.fromOffset(40, 80);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 160;
    });

    local Groupbox = Overlay:AddGroupbox({ Name = 'Players' });
    local PZ = Overlay.ZIndexBase + 15;

    Groupbox:AddInput('PlayerListSearch', {
        Text = 'Search';
        NoLabel = true;
        Default = '';
        Placeholder = 'Search...';
        Finished = false;
        ClearOnFocus = false;
    });

    local ListHolder = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, -4, 0, 220);
        ClipsDescendants = true;
        ZIndex = PZ;
        Parent = Groupbox.Container;
    });

    Library:AddToRegistry(ListHolder, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local PlayerScroll = Library:Create('ScrollingFrame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = true;
        Size = UDim2.new(1, 0, 1, 0);
        CanvasSize = UDim2.new(0, 0, 0, 0);
        ScrollBarThickness = 3;
        ScrollBarImageColor3 = Library.AccentColor;
        BottomImage = '';
        TopImage = '';
        ZIndex = PZ + 1;
        Parent = ListHolder;
    });

    Library:AddToRegistry(PlayerScroll, {
        ScrollBarImageColor3 = 'AccentColor';
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, 4);
        SortOrder = Enum.SortOrder.LayoutOrder;
        HorizontalAlignment = Enum.HorizontalAlignment.Center;
        Parent = PlayerScroll;
    });

    local SelectedPanel = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, -4, 0, 82);
        ClipsDescendants = true;
        ZIndex = PZ;
        Parent = Groupbox.Container;
    });

    Library:AddToRegistry(SelectedPanel, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local Avatar = Library:Create('ImageLabel', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        Position = UDim2.new(0, 8, 0, 6);
        Size = UDim2.fromOffset(64, 64);
        ZIndex = PZ + 1;
        Parent = SelectedPanel;
    });

    Library:AddToRegistry(Avatar, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local TeleportBtn = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 80, 0, 6);
        Size = UDim2.fromOffset(88, 28);
        Text = 'Teleport';
        TextColor3 = Library.FontColor;
        TextSize = 13;
        AutoButtonColor = false;
        ZIndex = PZ + 1;
        Parent = SelectedPanel;
    });

    Library:AddToRegistry(TeleportBtn, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
        TextColor3 = 'FontColor';
    });

    local SpectateBtn = Library:Create('TextButton', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 80, 0, 38);
        Size = UDim2.fromOffset(88, 28);
        Text = 'Spectate';
        TextColor3 = Library.FontColor;
        TextSize = 13;
        AutoButtonColor = false;
        ZIndex = PZ + 1;
        Parent = SelectedPanel;
    });

    Library:AddToRegistry(SpectateBtn, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
        TextColor3 = 'FontColor';
    });

    local SelectedName = Library:CreateLabel({
        Position = UDim2.new(0, 176, 0, 6);
        Size = UDim2.new(1, -182, 0, 16);
        Text = 'No player selected';
        TextSize = 13;
        TextTruncate = Enum.TextTruncate.AtEnd;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = PZ + 2;
        Parent = SelectedPanel;
    });

    Groupbox:AddDropdown('PlayerListStatus', {
        Values = { 'Enemy', 'Friendly', 'Neutral' };
        Default = 1;
    });

    if Options.PlayerListStatus and Options.PlayerListStatus.Outer then
        local StatusOuter = Options.PlayerListStatus.Outer;
        StatusOuter.Parent = SelectedPanel;
        StatusOuter.Position = UDim2.new(0, 176, 0, 28);
        StatusOuter.Size = UDim2.new(1, -182, 0, 20);
        StatusOuter.ZIndex = PZ + 2;
    end;

    Groupbox:Resize();

    local selectedPlayer;
    local playerButtons = {};
    local enemyPlayers = {};
    local clientGrey = Color3.fromRGB(140, 140, 140);
    local enemyRed = Color3.fromRGB(255, 80, 80);
    local statusUpdating = false;

    local function SelectPlayer(player)
        selectedPlayer = player;
        if player then
            SelectedName.Text = player.Name;
            if enemyPlayers[player] then
                SelectedName.TextColor3 = enemyRed;
            elseif player == LocalPlayer then
                SelectedName.TextColor3 = clientGrey;
            else
                SelectedName.TextColor3 = Library.FontColor;
            end;

            if Options.PlayerListStatus then
                local status = enemyPlayers[player] and 'Enemy' or 'Friendly';
                if Options.PlayerListStatus.Value ~= status then
                    statusUpdating = true;
                    Options.PlayerListStatus:SetValue(status);
                    statusUpdating = false;
                end;
            end;

            local ok, thumb = pcall(function()
                return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
            end);
            Avatar.Image = ok and thumb or '';
        else
            SelectedName.Text = 'No player selected';
            SelectedName.TextColor3 = Library.FontColor;
            Avatar.Image = '';
        end;
    end;

    local refreshPending = false;

    local function RefreshPlayers()
        if refreshPending then
            return
        end;

        refreshPending = true;
        task.defer(function()
            refreshPending = false;
            if not PlayerScroll.Parent then
                return
            end;

            for _, btn in playerButtons do
                btn:Destroy();
            end;
            table.clear(playerButtons);

            local filter = string.lower(Options.PlayerListSearch and Options.PlayerListSearch.Value or '');
            local layoutOrder = 0;

            for _, player in Players:GetPlayers() do
                local isLocal = player == LocalPlayer;
                local displayName = isLocal and (player.Name .. ' (Client)') or player.Name;
                if filter == '' or string.find(string.lower(displayName), filter, 1, true) then
                    layoutOrder += 1;
                    local isEnemy = enemyPlayers[player];
                    local Btn = Library:Create('TextButton', {
                        BackgroundTransparency = 1;
                        Size = UDim2.new(1, -8, 0, 22);
                        Text = displayName;
                        TextColor3 = isEnemy and enemyRed or (isLocal and clientGrey or (player == selectedPlayer and Library.AccentColor or Library.FontColor));
                        TextSize = 13;
                        Font = Library.Font;
                        TextXAlignment = Enum.TextXAlignment.Center;
                        LayoutOrder = layoutOrder;
                        AutoButtonColor = false;
                        ZIndex = PZ + 3;
                        Parent = PlayerScroll;
                    });

                    Btn.MouseButton1Click:Connect(function()
                        SelectPlayer(player);
                        RefreshPlayers();
                    end);

                    playerButtons[#playerButtons + 1] = Btn;
                end;
            end;

            PlayerScroll.CanvasSize = UDim2.fromOffset(0, math.max(layoutOrder * 26, 26));
            Groupbox:Resize();
        end);
    end;

    if Options.PlayerListSearch then
        Options.PlayerListSearch:OnChanged(RefreshPlayers);
    end;

    if Options.PlayerListStatus then
        Options.PlayerListStatus:OnChanged(function()
            if statusUpdating then
                return
            end;

            if selectedPlayer then
                enemyPlayers[selectedPlayer] = Options.PlayerListStatus.Value == 'Enemy';
                if enemyPlayers[selectedPlayer] then
                    SelectedName.TextColor3 = enemyRed;
                elseif selectedPlayer == LocalPlayer then
                    SelectedName.TextColor3 = clientGrey;
                else
                    SelectedName.TextColor3 = Library.FontColor;
                end;
                RefreshPlayers();
            end;
        end);
    end;

    Players.PlayerAdded:Connect(RefreshPlayers);
    Players.PlayerRemoving:Connect(function(player)
        enemyPlayers[player] = nil;
        if selectedPlayer == player then
            SelectPlayer(nil);
        end;
        RefreshPlayers();
    end);

    TeleportBtn.MouseButton1Click:Connect(function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild('HumanoidRootPart') then
            local char = LocalPlayer.Character;
            if char and char:FindFirstChild('HumanoidRootPart') then
                char.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame;
            end;
        end;
    end);

    local spectating;
    local savedMinZoom, savedMaxZoom, savedCameraMode;

    local function StopSpectating()
        if not spectating then
            return
        end;

        spectating = nil;
        SpectateBtn.Text = 'Spectate';

        if savedMinZoom ~= nil then
            LocalPlayer.CameraMinZoomDistance = savedMinZoom;
            LocalPlayer.CameraMaxZoomDistance = savedMaxZoom;
            LocalPlayer.CameraMode = savedCameraMode;
            savedMinZoom, savedMaxZoom, savedCameraMode = nil, nil, nil;
        end;

        local camera = workspace.CurrentCamera;
        if camera then
            local char = LocalPlayer.Character;
            local hum = char and char:FindFirstChildOfClass('Humanoid');
            if hum then
                camera.CameraSubject = hum;
            end;
            camera.CameraType = Enum.CameraType.Custom;
        end;
    end;

    Library:GiveSignal(RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
        if not spectating then
            return
        end;

        if not spectating.Parent then
            StopSpectating();
            return
        end;

        local targetCharacter = spectating.Character;
        local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildOfClass('Humanoid');
        local camera = workspace.CurrentCamera;
        if not targetHumanoid or not camera then
            return
        end;

        if camera.CameraSubject ~= targetHumanoid then
            camera.CameraSubject = targetHumanoid;
        end;
        if camera.CameraType ~= Enum.CameraType.Custom then
            camera.CameraType = Enum.CameraType.Custom;
        end;
    end)));

    SpectateBtn.MouseButton1Click:Connect(function()
        if spectating then
            StopSpectating();
            return
        end;

        if not selectedPlayer or selectedPlayer == LocalPlayer then
            return
        end;

        local targetCharacter = selectedPlayer.Character;
        local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildOfClass('Humanoid');
        if not targetHumanoid then
            return
        end;

        savedMinZoom = LocalPlayer.CameraMinZoomDistance;
        savedMaxZoom = LocalPlayer.CameraMaxZoomDistance;
        savedCameraMode = LocalPlayer.CameraMode;

        LocalPlayer.CameraMode = Enum.CameraMode.Classic;
        LocalPlayer.CameraMinZoomDistance = 0.5;
        LocalPlayer.CameraMaxZoomDistance = 128;

        spectating = selectedPlayer;
        SpectateBtn.Text = 'Unspectate';

        local camera = workspace.CurrentCamera;
        if camera then
            camera.CameraSubject = targetHumanoid;
            camera.CameraType = Enum.CameraType.Custom;
        end;
    end);

    RefreshPlayers();
    task.defer(function()
        Groupbox:Resize();
        Overlay:Resize();
    end);
    Overlay.RefreshPlayers = RefreshPlayers;
    Overlay.SelectPlayer = SelectPlayer;
    Library.EnemyPlayers = enemyPlayers;
    Overlay.EnemyPlayers = enemyPlayers;
    return Overlay;
end;

function Library:CreateESPPreviewOverlay(Config)
    Config = Config or {};
    local Overlay = Library:CreateOverlayWindow({
        Title = 'ESP Preview';
        Size = UDim2.fromOffset(200, 254);
        Position = Config.Position or UDim2.fromOffset(940, 80);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 160;
    });

    local Groupbox = Overlay:AddGroupbox({ Name = 'Preview' });

    local PreviewHolder = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, -4, 0, 210);
        ClipsDescendants = true;
        ZIndex = 8;
        Parent = Groupbox.Container;
    });

    Library:AddToRegistry(PreviewHolder, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local Viewport = Library:Create('ViewportFrame', {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25);
        BorderColor3 = Color3.fromRGB(70, 70, 70);
        BorderSizePixel = 1;
        Size = UDim2.new(1, -2, 1, -2);
        Position = UDim2.new(0, 1, 0, 1);
        Ambient = Color3.fromRGB(200, 200, 200);
        LightColor = Color3.fromRGB(255, 255, 255);
        LightDirection = Vector3.new(-1, -1, -1);
        ZIndex = 9;
        Parent = PreviewHolder;
    });

    local worldModel = Instance.new('WorldModel');
    worldModel.Parent = Viewport;

    local camera = Instance.new('Camera');
    camera.Parent = Viewport;
    Viewport.CurrentCamera = camera;

    local clone;
    local previewOk = pcall(function()
        clone = Players:CreateHumanoidModelFromDescriptionAsync(
            Players:GetHumanoidDescriptionFromUserIdAsync(1),
            Enum.HumanoidRigType.R15
        );
    end);

    if not previewOk or not clone then
        pcall(function()
            clone = Players:CreateHumanoidModelFromDescription(
                Players:GetHumanoidDescriptionFromUserId(1),
                Enum.HumanoidRigType.R15
            );
        end);
    end;

    if clone then
        for _, obj in clone:GetDescendants() do
            if obj:IsA('LocalScript') or obj:IsA('Script') then
                obj:Destroy();
            end;
        end;
        clone.Parent = worldModel;

        local root = clone:WaitForChild('HumanoidRootPart');
        local target = root.Position + Vector3.new(0, -0.34, 0);
        local radius = 5.4;
        local height = 1;
        local angle = 0;
        local speed = math.rad(30);

        local previewAccum = 0;
        local previewStep = IsTouchDevice and 0.12 or 0.05;
        Library:GiveSignal(RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(dt)
            if not Overlay.Visible or not Overlay.Outer or not Overlay.Outer.Visible then
                return
            end;

            previewAccum += dt;
            if previewAccum < previewStep then
                return
            end;

            angle += speed * previewAccum;
            previewAccum = 0;
            local offset = Vector3.new(
                math.sin(angle) * radius,
                height,
                math.cos(angle) * radius
            );
            camera.CFrame = CFrame.lookAt(target + offset, target);
        end)));
    end;

    local Box = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderColor3 = Library.AccentColor;
        BorderSizePixel = 1;
        Position = UDim2.new(0.3, 0, 0.1, 0);
        Size = UDim2.new(0.4, 0, 0.78, 0);
        ZIndex = 12;
        Parent = PreviewHolder;
    });

    Library:AddToRegistry(Box, { BorderColor3 = 'AccentColor' });

    local HealthBarBg = Library:Create('Frame', {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40);
        BorderSizePixel = 0;
        Position = UDim2.new(0.22, 0, 0.1, 0);
        Size = UDim2.new(0, 3, 0.78, 0);
        ZIndex = 12;
        Parent = PreviewHolder;
    });

    Library:Create('Frame', {
        BackgroundColor3 = Color3.fromRGB(80, 220, 80);
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 13;
        Parent = HealthBarBg;
    });

    Library:CreateLabel({
        Position = UDim2.new(0.16, 0, 0.42, 0);
        Size = UDim2.new(0, 20, 0, 14);
        Text = '100';
        TextSize = 11;
        TextXAlignment = Enum.TextXAlignment.Center;
        ZIndex = 13;
        Parent = PreviewHolder;
    });

    Library:CreateLabel({
        Position = UDim2.new(0.5, 0, 0.02, 0);
        Size = UDim2.new(0.5, 0, 0, 14);
        Text = 'dummy';
        TextColor3 = Color3.fromRGB(180, 120, 255);
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Center;
        ZIndex = 13;
        Parent = PreviewHolder;
    });

    Library:CreateLabel({
        Position = UDim2.new(0.72, 0, 0.4, 0);
        Size = UDim2.new(0.26, 0, 0, 14);
        Text = 'standing';
        TextColor3 = Color3.fromRGB(80, 220, 255);
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 13;
        Parent = PreviewHolder;
    });

    Library:CreateLabel({
        Position = UDim2.new(0.3, 0, 0.9, 0);
        Size = UDim2.new(0.2, 0, 0, 14);
        Text = '12st';
        TextColor3 = Color3.fromRGB(255, 80, 80);
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 13;
        Parent = PreviewHolder;
    });

    Library:CreateLabel({
        Position = UDim2.new(0.52, 0, 0.9, 0);
        Size = UDim2.new(0.3, 0, 0, 14);
        Text = 'preview';
        TextColor3 = Color3.fromRGB(80, 220, 120);
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 13;
        Parent = PreviewHolder;
    });

    Overlay.Viewport = Viewport;
    Overlay.Box = Box;
    Groupbox:Resize();
    return Overlay;
end;

function Library:CreateClosestPlayerOverlay(Config)
    Config = Config or {};
    local Overlay = Library:CreateOverlayWindow({
        Title = 'Closest Player';
        AccentPart = 'Player';
        Size = UDim2.fromOffset(196, 56);
        Position = Config.Position or UDim2.fromOffset(40, 580);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 165;
    });

    local Z = Overlay.ZIndexBase + 5;
    local AvatarSize = 48;
    local ColumnGap = 6;
    local NameHeight = 14;
    local DistanceHeight = 13;
    local HealthTextHeight = 12;
    local HealthBarHeight = 8;
    local RowGap = 2;
    local HealthBlockHeight = HealthTextHeight + RowGap + HealthBarHeight;
    local InfoHeight = NameHeight + RowGap + DistanceHeight + RowGap + HealthBlockHeight;
    local PanelHeight = math.max(AvatarSize, InfoHeight);

    local Panel = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, -4, 0, PanelHeight);
        ZIndex = Z;
        Parent = Overlay.Container;
    });

    local Avatar = Library:Create('ImageLabel', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, math.floor((PanelHeight - AvatarSize) / 2));
        Size = UDim2.fromOffset(AvatarSize, AvatarSize);
        ZIndex = Z + 1;
        Parent = Panel;
    });

    Library:AddToRegistry(Avatar, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local InfoColumn = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Position = UDim2.new(0, AvatarSize + ColumnGap, 0, 0);
        Size = UDim2.new(1, -(AvatarSize + ColumnGap), 0, InfoHeight);
        ZIndex = Z + 1;
        Parent = Panel;
    });

    Library:Create('UIListLayout', {
        Padding = UDim.new(0, RowGap);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = InfoColumn;
    });

    local NameLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, NameHeight);
        LayoutOrder = 1;
        Text = 'None';
        TextSize = 13;
        TextTruncate = Enum.TextTruncate.AtEnd;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextYAlignment = Enum.TextYAlignment.Center;
        ZIndex = Z + 2;
        Parent = InfoColumn;
    });

    local DistanceLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, DistanceHeight);
        LayoutOrder = 2;
        Text = '—st';
        TextSize = 12;
        TextTransparency = 0.15;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextYAlignment = Enum.TextYAlignment.Center;
        ZIndex = Z + 2;
        Parent = InfoColumn;
    });

    Library:AddToRegistry(DistanceLabel, {
        TextColor3 = 'AccentColor';
    }, true);

    local HealthBlock = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 0, HealthBlockHeight);
        LayoutOrder = 3;
        ZIndex = Z + 2;
        Parent = InfoColumn;
    });

    local HealthLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, HealthTextHeight);
        Text = '0';
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Right;
        TextYAlignment = Enum.TextYAlignment.Center;
        ZIndex = Z + 3;
        Parent = HealthBlock;
    });

    local HealthBarOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 1, -HealthBarHeight);
        Size = UDim2.new(1, 0, 0, HealthBarHeight);
        ClipsDescendants = true;
        ZIndex = Z + 3;
        Parent = HealthBlock;
    });

    Library:AddToRegistry(HealthBarOuter, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local HealthBarFill = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Size = UDim2.new(0, 0, 1, 0);
        ZIndex = Z + 4;
        Parent = HealthBarOuter;
    });

    Library:AddToRegistry(HealthBarFill, {
        BackgroundColor3 = 'AccentColor';
    });

    local trackedThumbId;
    local healthTween;
    local refreshAccum = 0;

    local function FitOverlay()
        local nameWidth = select(1, Library:GetTextBounds(NameLabel.Text, Library.Font, 13));
        local width = math.ceil(nameWidth + AvatarSize + ColumnGap + 24);
        width = math.clamp(width, 180, 280);

        Panel.Size = UDim2.new(1, -4, 0, PanelHeight);
        Overlay.Container.Size = UDim2.new(1, -8, 0, PanelHeight);
        Overlay.Container.CanvasSize = UDim2.fromOffset(0, PanelHeight);

        if Overlay.ContentOuter then
            Overlay.ContentOuter.Size = UDim2.new(1, -12, 0, PanelHeight + 8);
        end;

        Overlay.Outer.Size = UDim2.fromOffset(width, 26 + PanelHeight + 8 + 6);
    end;

    function Overlay:Resize()
        FitOverlay();
    end;

    local function SetHealth(ratio, healthValue)
        ratio = math.clamp(ratio, 0, 1);
        HealthLabel.Text = tostring(math.floor(healthValue + 0.5));

        if healthTween then
            healthTween:Cancel();
        end;

        healthTween = TweenService:Create(HealthBarFill, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(ratio, 0, 1, 0);
        });
        healthTween:Play();
    end;

    local function ClearTarget()
        trackedThumbId = nil;
        Avatar.Image = '';
        NameLabel.Text = 'None';
        DistanceLabel.Text = '—st';
        SetHealth(0, 0);
        FitOverlay();
    end;

    local function UpdateAvatar(player)
        if not player or trackedThumbId == player.UserId then
            return
        end;

        trackedThumbId = player.UserId;
        local userId = player.UserId;

        task.spawn(function()
            local ok, thumb = pcall(function()
                return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
            end);

            if trackedThumbId == userId then
                Avatar.Image = ok and thumb or '';
            end;
        end);
    end;

    local function GetClosestPlayer()
        local localChar = LocalPlayer.Character;
        local localRoot = localChar and localChar:FindFirstChild('HumanoidRootPart');
        if not localRoot then
            return nil;
        end;

        local closestPlayer;
        local closestDistance = math.huge;

        for _, player in Players:GetPlayers() do
            if player ~= LocalPlayer then
                local character = player.Character;
                local root = character and character:FindFirstChild('HumanoidRootPart');
                if root then
                    local distance = (root.Position - localRoot.Position).Magnitude;
                    if distance < closestDistance then
                        closestDistance = distance;
                        closestPlayer = player;
                    end;
                end;
            end;
        end;

        return closestPlayer, closestDistance;
    end;

    function Overlay:Refresh()
        if not Overlay.Visible or not Overlay.Outer or not Overlay.Outer.Visible then
            return
        end;

        local player, distance = GetClosestPlayer();
        if not player then
            ClearTarget();
            return
        end;

        NameLabel.Text = player.DisplayName;
        DistanceLabel.Text = string.format('%dst', math.floor(distance + 0.5));
        UpdateAvatar(player);

        local humanoid = player.Character and player.Character:FindFirstChildOfClass('Humanoid');
        if humanoid and humanoid.MaxHealth > 0 then
            SetHealth(humanoid.Health / humanoid.MaxHealth, humanoid.Health);
        else
            SetHealth(0, 0);
        end;

        FitOverlay();
    end;

    Library:GiveSignal(RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(Delta)
        if not Overlay.Visible or not Overlay.Outer or not Overlay.Outer.Visible then
            return
        end;

        refreshAccum += Delta;
        if refreshAccum < 0.1 then
            return
        end;

        refreshAccum = 0;
        Overlay:Refresh();
    end)));

    Library.ClosestPlayerOverlay = Overlay;

    task.defer(function()
        Overlay:Refresh();
        FitOverlay();
    end);

    return Overlay;
end;

function Library:CreateKeybindsOverlay(Config)
    Config = Config or {};
    local Overlay = Library:CreateOverlayWindow({
        Title = 'Keybinds';
        Size = UDim2.fromOffset(196, 86);
        Position = Config.Position or UDim2.fromOffset(40, 490);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 170;
    });

    if Library.KeybindContainer then
        if Overlay.Container then
            Overlay.Container.Visible = false;
        end;

        Library.KeybindContainer.Parent = Overlay.ContentInner or Overlay.Inner;
        Library.KeybindContainer.Visible = true;
        Library.KeybindContainer.Position = UDim2.new(0, 6, 0, 4);
        Library.KeybindContainer.Size = UDim2.new(1, -12, 0, 0);
        Library.KeybindContainer.ZIndex = Overlay.Outer.ZIndex + 12;
        Library:SyncKeybindRowsZIndex();

        for _, option in Options do
            if type(option) == 'table' and option.Type == 'KeyPicker' and option.Update then
                option:Update();
            end;
        end;
    end;

    function Overlay:SetVisible(Bool)
        Overlay.Visible = not not Bool;
        Overlay.Outer.Visible = Overlay.Visible;
        Library:UpdateOverlayGlow(Overlay);
    end;

    Library.KeybindOverlay = Overlay;
    Library.KeybindTitleLabel = Overlay.TitleLabel;

    function Overlay:Resize()
        if Library.KeybindOverlayCompact or Library._UpdatingKeybindOverlaySize then
            return
        end;

        Library:UpdateKeybindOverlaySize();
    end;

    task.defer(function()
        Library:UpdateKeybindOverlaySize();
    end);
    return Overlay;
end;

function Library:CreateRadarOverlay(Config)
    Config = Config or {};

    local MapSize = Config.MapSize or 176;
    local Range = Config.Range or 120;
    local SampleGrid = Config.SampleGrid or (IsTouchDevice and 28 or 44);
    local FramePad = Config.FramePad or 12;
    local BlipPixel = Config.BlipPixel or 3;
    local ContentSize = MapSize + FramePad * 2;
    local OuterWidth = ContentSize + 12;
    local OuterHeight = 26 + ContentSize + 8;

    local Overlay = Library:CreateOverlayWindow({
        Title = 'Radar';
        AccentPart = 'ar';
        Size = UDim2.fromOffset(OuterWidth, OuterHeight);
        Position = Config.Position or UDim2.fromOffset(40, 40);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 160;
    });

    local ListLayout = Overlay.Container:FindFirstChildOfClass('UIListLayout');
    if ListLayout then
        ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        ListLayout.Padding = UDim.new(0, 0);
    end;

    Overlay.Container.ScrollBarThickness = 0;
    Overlay.Container.ScrollingEnabled = false;
    Overlay.Container.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;

    local Z = Overlay.ZIndexBase + 15;

    local Panel = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.fromOffset(ContentSize, ContentSize);
        ZIndex = Z;
        Parent = Overlay.Container;
    });

    local MapOuter = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromOffset(MapSize, MapSize);
        ClipsDescendants = true;
        ZIndex = Z + 1;
        Parent = Panel;
    });

    Library:AddToRegistry(MapOuter, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    local MapCanvas = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Color3.fromRGB(10, 10, 12);
        BorderSizePixel = 0;
        ClipsDescendants = true;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.new(1, -4, 1, -4);
        ZIndex = Z + 2;
        Parent = MapOuter;
    });

    local MapImage = Library:Create('ImageLabel', {
        BackgroundColor3 = Color3.fromRGB(10, 10, 12);
        BorderSizePixel = 0;
        Size = UDim2.fromScale(1, 1);
        ZIndex = Z + 2;
        Parent = MapCanvas;
    });

    local PixelGrid = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        ZIndex = Z + 2;
        Visible = false;
        Parent = MapCanvas;
    });

    local PixelFrames = table.create(SampleGrid * SampleGrid);

    local function LayoutPixelGrid()
        local CanvasX = math.max(MapCanvas.AbsoluteSize.X, MapSize - 4);
        local CanvasY = math.max(MapCanvas.AbsoluteSize.Y, MapSize - 4);
        local PixelW = CanvasX / SampleGrid;
        local PixelH = CanvasY / SampleGrid;

        for row = 0, SampleGrid - 1 do
            for col = 0, SampleGrid - 1 do
                local Index = row * SampleGrid + col + 1;
                local Pixel = PixelFrames[Index];
                if Pixel then
                    Pixel.Position = UDim2.fromOffset(col * PixelW, row * PixelH);
                    Pixel.Size = UDim2.fromOffset(PixelW, PixelH);
                end;
            end;
        end;
    end;

    for row = 0, SampleGrid - 1 do
        for col = 0, SampleGrid - 1 do
            local Pixel = Library:Create('Frame', {
                BackgroundColor3 = Color3.fromRGB(10, 10, 12);
                BorderSizePixel = 0;
                ZIndex = Z + 2;
                Parent = PixelGrid;
            });
            table.insert(PixelFrames, Pixel);
        end;
    end;

    local CrosshairH = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Library.OutlineColor;
        BackgroundTransparency = 0.65;
        BorderSizePixel = 0;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.new(1, 0, 0, 1);
        ZIndex = Z + 3;
        Parent = MapCanvas;
    });

    local CrosshairV = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Library.OutlineColor;
        BackgroundTransparency = 0.65;
        BorderSizePixel = 0;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.new(0, 1, 1, 0);
        ZIndex = Z + 3;
        Parent = MapCanvas;
    });

    Library:AddToRegistry(CrosshairH, { BackgroundColor3 = 'OutlineColor' });
    Library:AddToRegistry(CrosshairV, { BackgroundColor3 = 'OutlineColor' });

    local BlipContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        ZIndex = Z + 5;
        Parent = MapCanvas;
    });

    local MaxBlips = Config.MaxBlips or 32;
    local BlipPool = table.create(MaxBlips);
    local EnemyColor = Color3.fromRGB(255, 48, 48);

    for Index = 1, MaxBlips do
        BlipPool[Index] = Library:Create('Frame', {
            AnchorPoint = Vector2.new(0.5, 0.5);
            BackgroundColor3 = EnemyColor;
            BorderSizePixel = 0;
            Position = UDim2.fromScale(0.5, 0.5);
            Size = UDim2.fromOffset(BlipPixel, BlipPixel);
            Visible = false;
            ZIndex = Z + 6;
            Parent = BlipContainer;
        });
        Library:Create('UICorner', {
            CornerRadius = UDim.new(1, 0);
            Parent = BlipPool[Index];
        });
    end;

    local ArrowHolder = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundTransparency = 1;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromOffset(16, 16);
        ZIndex = Z + 7;
        Parent = MapCanvas;
    });

    local Arrow = Library:CreateLabel({
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromOffset(16, 16);
        Text = '▲';
        TextSize = 13;
        TextXAlignment = Enum.TextXAlignment.Center;
        TextYAlignment = Enum.TextYAlignment.Center;
        ZIndex = Z + 8;
        Parent = ArrowHolder;
    }, true);

    Library:AddToRegistry(Arrow, {
        TextColor3 = 'AccentColor';
    }, true);

    local CenterDot = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromOffset(3, 3);
        ZIndex = Z + 8;
        Parent = MapCanvas;
    });

    Library:AddToRegistry(CenterDot, {
        BackgroundColor3 = 'AccentColor';
    });

    local RayParams = RaycastParams.new();
    RayParams.FilterType = Enum.RaycastFilterType.Exclude;

    local EditableImage;
    local UseEditableImage = false;

    pcall(function()
        local AssetService = game:GetService('AssetService');
        EditableImage = AssetService:CreateEditableImage(Vector2.new(SampleGrid, SampleGrid));
        MapImage.Image = EditableImage;
        UseEditableImage = true;
        PixelGrid.Visible = false;
    end);

    if not UseEditableImage then
        pcall(function()
            EditableImage = Instance.new('EditableImage');
            EditableImage.Size = Vector2.new(SampleGrid, SampleGrid);
            MapImage.Image = EditableImage;
            UseEditableImage = true;
            PixelGrid.Visible = false;
        end);
    end;

    if not UseEditableImage then
        PixelGrid.Visible = true;
        MapImage.Visible = false;
        task.defer(LayoutPixelGrid);
    end;

    local function GetRaycastFilter()
        local Filter = {};

        for _, Player in Players:GetPlayers() do
            if Player.Character then
                table.insert(Filter, Player.Character);
            end;
        end;

        return Filter;
    end;

    local function GetHitColor(Result)
        if not Result then
            return Color3.fromRGB(10, 10, 12);
        end;

        if Result.Instance == workspace.Terrain then
            return workspace.Terrain:GetMaterialColor(Result.Material);
        end;

        local Part = Result.Instance;
        if Part:IsA('BasePart') then
            return Part.Color;
        end;

        return Color3.fromRGB(10, 10, 12);
    end;

    local function IsEnemyPlayer(Player)
        if Player == LocalPlayer then
            return false;
        end;

        if Library.EnemyPlayers and Library.EnemyPlayers[Player] then
            return true;
        end;

        if type(Config.IsEnemy) == 'function' then
            return not not Config.IsEnemy(Player);
        end;

        local MyTeam = LocalPlayer.Team;
        local TheirTeam = Player.Team;
        if MyTeam and TheirTeam then
            return MyTeam ~= TheirTeam;
        end;

        return true;
    end;

    local function WorldToRadarNorm(Origin, WorldPos)
        local Offset = WorldPos - Origin;
        local NormX = Offset.X / Range;
        local NormZ = Offset.Z / Range;
        local DistSq = NormX * NormX + NormZ * NormZ;

        if DistSq > 1 then
            local Dist = math.sqrt(DistSq);
            NormX /= Dist;
            NormZ /= Dist;
        end;

        return NormX, NormZ;
    end;

    local function FitOverlay()
        Panel.Size = UDim2.fromOffset(ContentSize, ContentSize);
        Overlay.Container.Size = UDim2.new(1, -8, 0, ContentSize);
        Overlay.Container.CanvasSize = UDim2.fromOffset(0, ContentSize);

        if Overlay.ContentOuter then
            Overlay.ContentOuter.Size = UDim2.new(1, -12, 0, ContentSize + 8);
        end;

        Overlay.Outer.Size = UDim2.fromOffset(OuterWidth, OuterHeight);
        LayoutPixelGrid();
    end;

    function Overlay:Resize()
        FitOverlay();
    end;

    local terrainAccum = 0;
    local terrainInterval = 1;

    local function UpdateTerrain()
        local Character = LocalPlayer.Character;
        local Root = Character and Character:FindFirstChild('HumanoidRootPart');
        if not Root then
            return
        end;

        RayParams.FilterDescendantsInstances = GetRaycastFilter();

        local Origin = Root.Position;
        local HalfGrid = SampleGrid / 2;
        local Step = (Range * 2) / SampleGrid;

        for row = 0, SampleGrid - 1 do
            for col = 0, SampleGrid - 1 do
                local OffsetX = (col - HalfGrid + 0.5) * Step;
                local OffsetZ = (row - HalfGrid + 0.5) * Step;
                local SamplePos = Origin + Vector3.new(OffsetX, 0, OffsetZ);
                local RayOrigin = SamplePos + Vector3.new(0, 512, 0);
                local Result = workspace:Raycast(RayOrigin, Vector3.new(0, -1024, 0), RayParams);
                local Color = GetHitColor(Result);

                if UseEditableImage and EditableImage then
                    pcall(function()
                        EditableImage:SetRGB(col, row, Color);
                    end);
                else
                    local Pixel = PixelFrames[row * SampleGrid + col + 1];
                    if Pixel then
                        Pixel.BackgroundColor3 = Color;
                    end;
                end;
            end;
        end;
    end;

    local UpdateBlips = LPH_NO_VIRTUALIZE(function(Root, Camera)
        local Origin = Root.Position;
        local BlipIndex = 0;

        for _, Player in Players:GetPlayers() do
            if Player ~= LocalPlayer and IsEnemyPlayer(Player) then
                local Character = Player.Character;
                local OtherRoot = Character and Character:FindFirstChild('HumanoidRootPart');
                if OtherRoot then
                    BlipIndex += 1;
                    local Blip = BlipPool[BlipIndex];
                    if Blip then
                        local NormX, NormZ = WorldToRadarNorm(Origin, OtherRoot.Position);

                        Blip.BackgroundColor3 = EnemyColor;
                        Blip.Size = UDim2.fromOffset(BlipPixel, BlipPixel);
                        Blip.Position = UDim2.fromScale(NormX * 0.5 + 0.5, NormZ * 0.5 + 0.5);
                        Blip.Visible = true;
                    end;
                end;
            end;
        end;

        for Index = BlipIndex + 1, MaxBlips do
            local Blip = BlipPool[Index];
            if Blip then
                Blip.Visible = false;
            end;
        end;

        local Look = Camera.CFrame.LookVector;
        ArrowHolder.Rotation = math.deg(math.atan2(Look.X, -Look.Z));
    end);

    local UpdateRadar = LPH_NO_VIRTUALIZE(function(Delta)
        if not Overlay.Visible then
            return
        end;

        local Character = LocalPlayer.Character;
        local Root = Character and Character:FindFirstChild('HumanoidRootPart');
        local Camera = workspace.CurrentCamera;
        if not Root or not Camera then
            for Index = 1, MaxBlips do
                BlipPool[Index].Visible = false;
            end;
            return
        end;

        terrainAccum += Delta;
        if terrainAccum >= terrainInterval then
            terrainAccum = 0;
            UpdateTerrain();
        end;

        UpdateBlips(Root, Camera);
    end);

    function Overlay:SetVisible(Bool)
        Overlay.Visible = not not Bool;
        Overlay.Outer.Visible = Overlay.Visible;
        Library:UpdateOverlayGlow(Overlay);
    end;

    Overlay._RadarUpdate = RunService.RenderStepped:Connect(UpdateRadar);
    Library:GiveSignal(Overlay._RadarUpdate);

    Library.RadarOverlay = Overlay;

    task.defer(function()
        FitOverlay();
        UpdateTerrain();
    end);

    return Overlay;
end;

function Library:CreateVelocityGraphOverlay(Config)
    Config = Config or {};

    local BoxWidth = Config.Width or 200;
    local BoxHeight = Config.Height or 80;
    local LabelHeight = 16;
    local LabelGap = 4;
    local ContentHeight = LabelHeight + LabelGap + BoxHeight;
    local OuterWidth = BoxWidth + 24;
    local OuterHeight = 26 + ContentHeight + 14;

    local Overlay = Library:CreateOverlayWindow({
        Title = 'Velocity';
        AccentPart = 'ity';
        Size = UDim2.fromOffset(OuterWidth, OuterHeight);
        Position = Config.Position or UDim2.new(0.5, -OuterWidth / 2, 1, -240);
        Visible = Config.Visible;
        ZIndex = Config.ZIndex or 155;
    });

    local Z = Overlay.ZIndexBase + 15;

    local Content = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, -4, 0, ContentHeight);
        ZIndex = Z;
        Parent = Overlay.Container;
    });

    local SpeedLabel = Library:CreateLabel({
        Size = UDim2.new(1, 0, 0, LabelHeight);
        Text = 'SPEED: 0';
        TextSize = 13;
        TextXAlignment = Enum.TextXAlignment.Center;
        ZIndex = Z + 2;
        Parent = Content;
    });

    local GraphArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = true;
        Position = UDim2.new(0, 0, 0, LabelHeight + LabelGap);
        Size = UDim2.new(1, 0, 0, BoxHeight);
        ZIndex = Z + 1;
        Parent = Content;
    });

    local GraphState = {
        Lines = {};
        LastY = BoxHeight - 2;
        LinePool = {};
        MaxLines = BoxWidth;
    };

    for Index = 1, GraphState.MaxLines do
        GraphState.LinePool[Index] = Library:Create('Frame', {
            AnchorPoint = Vector2.new(0, 0.5);
            BackgroundColor3 = Color3.fromRGB(220, 220, 220);
            BorderSizePixel = 0;
            Visible = false;
            ZIndex = Z + 3;
            Parent = GraphArea;
        });
    end;

    local function FitOverlay()
        Content.Size = UDim2.new(1, -4, 0, ContentHeight);
        Overlay.Container.Size = UDim2.new(1, -8, 0, ContentHeight);
        Overlay.Container.CanvasSize = UDim2.fromOffset(0, ContentHeight);

        if Overlay.ContentOuter then
            Overlay.ContentOuter.Size = UDim2.new(1, -12, 0, ContentHeight + 8);
        end;

        Overlay.Outer.Size = UDim2.fromOffset(OuterWidth, OuterHeight);
    end;

    function Overlay:Resize()
        FitOverlay();
    end;

    local function SetGraphVisible(Visible)
        for _, Segment in GraphState.LinePool do
            Segment.Visible = Visible;
        end;
    end;

    local function PlaceSegment(Segment, XFrom, YFrom, XTo, YTo, Transparency)
        local DeltaX = XTo - XFrom;
        local DeltaY = YTo - YFrom;
        local Length = math.sqrt(DeltaX * DeltaX + DeltaY * DeltaY);

        if Length < 0.35 then
            Segment.Visible = false;
            return
        end;

        local Angle = math.deg(math.atan2(DeltaY, DeltaX));
        local MidY = (YFrom + YTo) * 0.5;

        Segment.Size = UDim2.fromOffset(Length, 1.2);
        Segment.Position = UDim2.fromOffset(XFrom, MidY);
        Segment.Rotation = Angle;
        Segment.BackgroundTransparency = Transparency;
        Segment.Visible = true;
    end;

    local UpdateGraph = LPH_NO_VIRTUALIZE(function()
        if not Overlay.Visible or not Overlay.Outer or not Overlay.Outer.Visible then
            SetGraphVisible(false);
            return
        end;

        local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart');
        if not Root then
            SetGraphVisible(false);
            return
        end;

        local GraphWidth = math.max(math.floor(GraphArea.AbsoluteSize.X + 0.5), BoxWidth);
        local GraphBaseY = BoxHeight;

        local Velocity = Root.AssemblyLinearVelocity;
        local Vel = (Vector3.new(Velocity.X * 1.25, 0, Velocity.Z * 1.25)).Magnitude * 14;

        local Unit = GraphBaseY - (Vel / 7.5);
        Unit = math.clamp(Unit, 2, GraphBaseY - 2);

        SpeedLabel.Text = string.format('SPEED: %d', math.floor(Vel));

        if #GraphState.Lines >= GraphWidth then
            table.remove(GraphState.Lines, 1);
        end;

        for _, Line in GraphState.Lines do
            Line.XFrom -= 1;
            Line.XTo -= 1;
        end;

        table.insert(GraphState.Lines, {
            XFrom = GraphWidth - 1;
            YFrom = GraphState.LastY;
            XTo = GraphWidth;
            YTo = Unit;
        });

        GraphState.LastY = Unit;

        local Count = #GraphState.Lines;
        for Index, Line in GraphState.Lines do
            local AgeFromRight = Count - Index;
            local Transparency = math.clamp(AgeFromRight / 50, 0, 1) * 0.55;
            PlaceSegment(GraphState.LinePool[Index], Line.XFrom, Line.YFrom, Line.XTo, Line.YTo, Transparency);
        end;

        for Index = Count + 1, GraphState.MaxLines do
            local Segment = GraphState.LinePool[Index];
            if Segment then
                Segment.Visible = false;
            end;
        end;
    end);

    function Overlay:SetVisible(Bool)
        Overlay.Visible = not not Bool;
        Overlay.Outer.Visible = Overlay.Visible;
        Library:UpdateOverlayGlow(Overlay);

        if not Overlay.Visible then
            SetGraphVisible(false);
        end;
    end;

    function Overlay:CleanupDrawings()
        SetGraphVisible(false);
        table.clear(GraphState.Lines);
        GraphState.LastY = BoxHeight - 2;
    end;

    Overlay._GraphUpdate = RunService.RenderStepped:Connect(UpdateGraph);
    Library:GiveSignal(Overlay._GraphUpdate);

    Library.VelocityGraphOverlay = Overlay;

    task.defer(function()
        FitOverlay();
    end);

    return Overlay;
end;

function Library:WrapKeybindOverlay(Config)
    return Library:CreateKeybindsOverlay(Config or {});
end;

function Library:GiveSignal(Signal)
    table.insert(Library.Signals, Signal);
end;

function Library:Unload()
    for Idx = #Library.Signals, 1, -1 do
        local Connection = table.remove(Library.Signals, Idx);
        Connection:Disconnect();
    end;

    if Library.OnUnload then
        Library.OnUnload();
    end;

    if Library.VelocityGraphOverlay and Library.VelocityGraphOverlay.CleanupDrawings then
        Library.VelocityGraphOverlay:CleanupDrawings();
    end;

    ScreenGui:Destroy();
end;

function Library:OnUnload(Callback)
    Library.OnUnload = Callback;
end;

Library:GiveSignal(ScreenGui.DescendantRemoving:Connect(function(Instance)
    if Library.RegistryMap[Instance] then
        Library:RemoveFromRegistry(Instance);
    end;
end));

local BaseAddons = {};

do
    local Funcs = {};

    function Funcs:AddColorPicker(Idx, Info)
        local ToggleLabel = self.TextLabel;

        assert(Info.Default, 'AddColorPicker: Missing default value.');

        local ColorPicker = {
            Value = Info.Default;
            Transparency = Info.Transparency or 0;
            Type = 'ColorPicker';
            Title = type(Info.Title) == 'string' and Info.Title or 'Color picker',
            Callback = Info.Callback or function(Color) end;
        };

        function ColorPicker:SetHSVFromRGB(Color)
            local H, S, V = Color3.toHSV(Color);

            ColorPicker.Hue = H;
            ColorPicker.Sat = S;
            ColorPicker.Vib = V;
        end;

        ColorPicker:SetHSVFromRGB(ColorPicker.Value);

        local DisplayFrame = Library:Create('Frame', {
            BackgroundColor3 = ColorPicker.Value;
            BorderColor3 = Library.AccentColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = IsTouchDevice and UDim2.new(0, 18, 0, 10) or UDim2.new(0, 28, 0, 14);
            ZIndex = ToggleLabel.ZIndex + 1;
            Parent = ToggleLabel;
        });

        Library:AddToRegistry(DisplayFrame, { BorderColor3 = 'AccentColor' });

        local PickerFrameOuter = Library:Create('Frame', {
            Name = 'Color';
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18),
            Size = UDim2.fromOffset(230, 226);
            Visible = false;
            ZIndex = 15;
            Parent = ScreenGui,
        });

        Library:MakeDraggable(PickerFrameOuter, 20);

        if IsTouchDevice then
            Library:Create('UIScale', {
                Scale = Library.MobilePickerScale or Library.MobileOverlayScale or 0.55;
                Parent = PickerFrameOuter;
            });
        end;

        local PickerFrameInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 16;
            Parent = PickerFrameOuter;
        });

        local Highlight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 2);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local TitleLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 0, 20);
            Position = UDim2.new(0, 5, 0, 2);
            TextXAlignment = Enum.TextXAlignment.Left;
            Text = ColorPicker.Title;
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local FlagLabel = Library:CreateLabel({
            Size = UDim2.new(1, -10, 0, 20);
            Position = UDim2.new(0, 5, 0, 2);
            TextXAlignment = Enum.TextXAlignment.Right;
            Text = "flagname";
            TextColor3 = Color3.fromRGB(80, 80, 80);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local Divider = Library:Create('Frame', {
            BackgroundColor3 = Library.OutlineColor;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 0, 1);
            Position = UDim2.new(0, 0, 0, 22);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 25);
            Size = UDim2.new(1, -8, 0, 110);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local SatVibMapInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = SatVibMapOuter;
        });

        local SatVibMap = Library:Create('ImageLabel', {
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Image = 'rbxassetid://4155801252';
            Parent = SatVibMapInner;
        });

        local CursorOuter = Library:Create('ImageLabel', {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Size = UDim2.new(0, 6, 0, 6);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ImageColor3 = Color3.new(0, 0, 0);
            ZIndex = 19;
            Parent = SatVibMap;
        });

        local CursorInner = Library:Create('ImageLabel', {
            Size = UDim2.new(0, CursorOuter.Size.X.Offset - 2, 0, CursorOuter.Size.Y.Offset - 2);
            Position = UDim2.new(0, 1, 0, 1);
            BackgroundTransparency = 1;
            Image = 'http://www.roblox.com/asset/?id=9619665977';
            ZIndex = 20;
            Parent = CursorOuter;
        });

        local HueSelectorOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 140);
            Size = UDim2.new(1, -8, 0, 10);
            ZIndex = 17;
            Parent = PickerFrameInner;
        });

        local HueSelectorInner = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorOuter;
        });

        local HueCursor = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(1, 1, 1);
            AnchorPoint = Vector2.new(0.5, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 2, 1, 0);
            ZIndex = 18;
            Parent = HueSelectorInner;
        });

        local InputWidth = 47;
        local InputHeight = 18;
        local InputSpacing = 4;

        local function CreateInputBox(posX, width, placeholder)
            local BoxOuter = Library:Create('Frame', {
                BorderColor3 = Color3.new(0, 0, 0);
                Position = UDim2.new(0, posX, 0, 155);
                Size = UDim2.new(0, width, 0, InputHeight);
                ZIndex = 18;
                Parent = PickerFrameInner;
            });
            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 18;
                Parent = BoxOuter;
            });
            local TextBox = Library:Create('TextBox', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Font = Library.Font;
                PlaceholderColor3 = Color3.fromRGB(120, 120, 120);
                PlaceholderText = placeholder;
                Text = "";
                TextColor3 = Library.FontColor;
                TextSize = 13;
                TextStrokeTransparency = 0;
                TextXAlignment = Enum.TextXAlignment.Center;
                ZIndex = 20;
                Parent = BoxInner;
            });
            Library:ApplyTextStroke(TextBox);
            Library:AddToRegistry(BoxInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
            Library:AddToRegistry(TextBox, { TextColor3 = 'FontColor' });
            return TextBox;
        end;

        local RBox = CreateInputBox(4, 48, "R");
        local GBox = CreateInputBox(4 + 48 + 4, 48, "G");
        local BBox = CreateInputBox(4 + 48*2 + 8, 48, "B");
        local HexBox = CreateInputBox(4 + 48*3 + 12, 66, "HEX");

        local function CreateButton(posX, width, text)
            local BtnOuter = Library:Create('Frame', {
                BorderColor3 = Color3.new(0, 0, 0);
                Position = UDim2.new(0, posX, 0, 177);
                Size = UDim2.new(0, width, 0, 18);
                ZIndex = 18;
                Parent = PickerFrameInner;
            });
            local BtnInner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 18;
                Parent = BtnOuter;
            });
            local Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 13;
                Text = text;
                ZIndex = 20;
                Parent = BtnInner;
            });
            Library:OnHighlight(BtnOuter, BtnOuter,
                { BorderColor3 = 'AccentColor' },
                { BorderColor3 = 'Black' }
            );
            Library:AddToRegistry(BtnInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });
            return BtnOuter;
        end;

        local CopyBtn = CreateButton(4, 109, "Copy");
        local PasteBtn = CreateButton(4 + 109 + 4, 109, "Paste");

        local ConfirmBtnOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 199);
            Size = UDim2.new(1, -8, 0, 18);
            ZIndex = 18;
            Parent = PickerFrameInner;
        });
        local ConfirmBtnInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 18;
            Parent = ConfirmBtnOuter;
        });
        local ConfirmLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 13;
            Text = "Confirm";
            ZIndex = 20;
            Parent = ConfirmBtnInner;
        });
        Library:OnHighlight(ConfirmBtnOuter, ConfirmBtnOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );
        ConfirmBtnOuter.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                ColorPicker:Hide();
            end;
        end);
        Library:AddToRegistry(ConfirmBtnInner, { BackgroundColor3 = 'MainColor'; BorderColor3 = 'OutlineColor'; });

        local ContextMenu = {}
        do
            ContextMenu.Options = {};
            ContextMenu.Container = Library:Create('Frame', {
                BorderColor3 = Color3.new(),
                ZIndex = 14,
                Visible = false,
                Parent = ScreenGui
            });

            ContextMenu.Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.fromScale(1, 1);
                ZIndex = 15;
                Parent = ContextMenu.Container;
            });

            Library:Create('UIListLayout', {
                Name = 'Layout',
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = ContextMenu.Inner;
            });

            Library:Create('UIPadding', {
                Name = 'Padding',
                PaddingLeft = UDim.new(0, 4),
                Parent = ContextMenu.Inner,
            });

            local function updateMenuPosition()
                ContextMenu.Container.Position = UDim2.fromOffset(
                    (DisplayFrame.AbsolutePosition.X + DisplayFrame.AbsoluteSize.X) + 4,
                    DisplayFrame.AbsolutePosition.Y + 1
                );
            end;

            local function updateMenuSize()
                local menuWidth = 60;
                for i, label in next, ContextMenu.Inner:GetChildren() do
                    if label:IsA('TextLabel') then
                        menuWidth = math.max(menuWidth, label.TextBounds.X);
                    end;
                end;

                ContextMenu.Container.Size = UDim2.fromOffset(
                    menuWidth + 8,
                    ContextMenu.Inner.Layout.AbsoluteContentSize.Y + 4
                );
            end;

            DisplayFrame:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition);
            ContextMenu.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize);

            task.spawn(updateMenuPosition);
            task.spawn(updateMenuSize);

            Library:AddToRegistry(ContextMenu.Inner, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            function ContextMenu:Show()
                self.Container.Visible = true;
            end;

            function ContextMenu:Hide()
                self.Container.Visible = false;
            end;

            function ContextMenu:AddOption(Str, Callback)
                if type(Callback) ~= 'function' then
                    Callback = function() end;
                end;

                local Button = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, 0, 0, 15);
                    TextSize = 13;
                    Text = Str;
                    ZIndex = 16;
                    Parent = self.Inner;
                    TextXAlignment = Enum.TextXAlignment.Left,
                });

                Library:OnHighlight(Button, Button,
                    { TextColor3 = 'AccentColor' },
                    { TextColor3 = 'FontColor' }
                );

                Button.InputBegan:Connect(function(Input)
                    if not IsPrimaryPress(Input) then
                        return
                    end;

                    Callback();
                end);
            end;

            ContextMenu:AddOption('Copy color', function()
                Library.ColorClipboard = ColorPicker.Value;
                Library:Notify('Copied color!', 2);
            end);

            ContextMenu:AddOption('Paste color', function()
                if not Library.ColorClipboard then
                    return Library:Notify('You have not copied a color!', 2);
                end;
                ColorPicker:SetValueRGB(Library.ColorClipboard);
            end);

            ContextMenu:AddOption('Copy HEX', function()
                pcall(setclipboard, ColorPicker.Value:ToHex());
                Library:Notify('Copied hex code to clipboard!', 2);
            end);

            ContextMenu:AddOption('Copy RGB', function()
                pcall(setclipboard, table.concat({ math.floor(ColorPicker.Value.R * 255), math.floor(ColorPicker.Value.G * 255), math.floor(ColorPicker.Value.B * 255) }, ', '));
                Library:Notify('Copied RGB values to clipboard!', 2);
            end);

        end;

        Library:AddToRegistry(PickerFrameInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });
        Library:AddToRegistry(Highlight, { BackgroundColor3 = 'AccentColor'; });
        Library:AddToRegistry(SatVibMapInner, { BackgroundColor3 = 'BackgroundColor'; BorderColor3 = 'OutlineColor'; });

        local SequenceTable = {};

        for Hue = 0, 1, 0.1 do
            table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
        end;

        local HueSelectorGradient = Library:Create('UIGradient', {
            Color = ColorSequence.new(SequenceTable);
            Rotation = 0;
            Parent = HueSelectorInner;
        });

        local function onRGBFocusLost()
            local r = tonumber(RBox.Text) or 255;
            local g = tonumber(GBox.Text) or 255;
            local b = tonumber(BBox.Text) or 255;
            ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(Color3.fromRGB(r, g, b));
            ColorPicker:Display();
        end;
        RBox.FocusLost:Connect(onRGBFocusLost);
        GBox.FocusLost:Connect(onRGBFocusLost);
        BBox.FocusLost:Connect(onRGBFocusLost);

        HexBox.FocusLost:Connect(function()
            local success, result = pcall(Color3.fromHex, HexBox.Text);
            if success and typeof(result) == 'Color3' then
                ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib = Color3.toHSV(result);
            end;
            ColorPicker:Display();
        end);

        CopyBtn.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                Library.ColorClipboard = ColorPicker.Value;
                Library:Notify('Copied color!', 2);
            end;
        end);

        PasteBtn.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                if Library.ColorClipboard then
                    ColorPicker:SetValueRGB(Library.ColorClipboard);
                else
                    Library:Notify('No color copied!', 2);
                end;
            end;
        end);

        function ColorPicker:Display()
            ColorPicker.Value = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Sat, ColorPicker.Vib);
            SatVibMap.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1);

            Library:Create(DisplayFrame, {
                BackgroundColor3 = ColorPicker.Value;
                BackgroundTransparency = ColorPicker.Transparency;
                BorderColor3 = Library:GetDarkerColor(ColorPicker.Value);
            });

            CursorOuter.Position = UDim2.new(ColorPicker.Sat, 0, 1 - ColorPicker.Vib, 0);
            HueCursor.Position = UDim2.new(ColorPicker.Hue, 0, 0, 0);

            RBox.Text = tostring(math.floor(ColorPicker.Value.R * 255));
            GBox.Text = tostring(math.floor(ColorPicker.Value.G * 255));
            BBox.Text = tostring(math.floor(ColorPicker.Value.B * 255));
            HexBox.Text = ColorPicker.Value:ToHex();

            if not Library.ThemeUpdating then
                Library:SafeCallback(ColorPicker.Callback, ColorPicker.Value);
                Library:SafeCallback(ColorPicker.Changed, ColorPicker.Value);
            end;
        end;

        function ColorPicker:OnChanged(Func)
            ColorPicker.Changed = Func;
            Func(ColorPicker.Value);
        end;

        function ColorPicker:Show()
            for Frame, Val in next, Library.OpenedFrames do
                if Frame.Name == 'Color' then
                    Frame.Visible = false;
                    Library.OpenedFrames[Frame] = nil;
                end;
            end;

            PickerFrameOuter.Position = UDim2.fromOffset(DisplayFrame.AbsolutePosition.X, DisplayFrame.AbsolutePosition.Y + 18);
            Library:ApplyPopupZIndex(PickerFrameOuter, 15);
            PickerFrameOuter.Visible = true;
            Library.OpenedFrames[PickerFrameOuter] = true;
        end;

        function ColorPicker:Hide()
            PickerFrameOuter.Visible = false;
            Library.OpenedFrames[PickerFrameOuter] = nil;
        end;

        function ColorPicker:SetValue(HSV, Transparency)
            local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3]);

            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        function ColorPicker:SetValueRGB(Color, Transparency)
            ColorPicker.Transparency = Transparency or 0;
            ColorPicker:SetHSVFromRGB(Color);
            ColorPicker:Display();
        end;

        SatVibMap.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                while IsPressActive(Input) do
                    local Pos = GetPointerPosition(Input);
                    local MinX = SatVibMap.AbsolutePosition.X;
                    local MaxX = MinX + SatVibMap.AbsoluteSize.X;
                    local MouseX = math.clamp(Pos.X, MinX, MaxX);

                    local MinY = SatVibMap.AbsolutePosition.Y;
                    local MaxY = MinY + SatVibMap.AbsoluteSize.Y;
                    local MouseY = math.clamp(Pos.Y, MinY, MaxY);

                    ColorPicker.Sat = (MouseX - MinX) / (MaxX - MinX);
                    ColorPicker.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        HueSelectorInner.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                while IsPressActive(Input) do
                    local Pos = GetPointerPosition(Input);
                    local MinX = HueSelectorInner.AbsolutePosition.X;
                    local MaxX = MinX + HueSelectorInner.AbsoluteSize.X;
                    local MouseX = math.clamp(Pos.X, MinX, MaxX);

                    ColorPicker.Hue = ((MouseX - MinX) / (MaxX - MinX));
                    ColorPicker:Display();

                    RenderStepped:Wait();
                end;

                Library:AttemptSave();
            end;
        end);

        DisplayFrame.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                if PickerFrameOuter.Visible then
                    ColorPicker:Hide();
                else
                    ContextMenu:Hide();
                    ColorPicker:Show();
                end;
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ContextMenu:Show();
                ColorPicker:Hide();
            end;
        end);

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                local Pos = GetPointerPosition(Input);
                local AbsPos, AbsSize = PickerFrameOuter.AbsolutePosition, PickerFrameOuter.AbsoluteSize;

                if Pos.X < AbsPos.X or Pos.X > AbsPos.X + AbsSize.X
                    or Pos.Y < (AbsPos.Y - 20 - 1) or Pos.Y > AbsPos.Y + AbsSize.Y then

                    ColorPicker:Hide();
                end;

                if not Library:IsMouseOverFrame(ContextMenu.Container) then
                    ContextMenu:Hide();
                end;
            end;

            if Input.UserInputType == Enum.UserInputType.MouseButton2 and ContextMenu.Container.Visible then
                if not Library:IsMouseOverFrame(ContextMenu.Container) and not Library:IsMouseOverFrame(DisplayFrame) then
                    ContextMenu:Hide();
                end;
            end;
        end));

        ColorPicker:Display();
        ColorPicker.DisplayFrame = DisplayFrame;

        if type(ColorPicker)=="table" and ColorPicker.SetVisible==nil then ColorPicker.SetVisible=function() end end;
        Options[Idx] = ColorPicker;

        return self;
    end;

    function Funcs:AddKeyPicker(Idx, Info)
        local ParentObj = self;
        local ToggleLabel = self.TextLabel;
        local Container = self.Container;

        assert(Info.Default, 'AddKeyPicker: Missing default value.');

        local KeyPicker = {
            Value = Info.Default;
            Toggled = false;
            Mode = Info.Mode or 'Toggle';
            Type = 'KeyPicker';
            Callback = Info.Callback or function(Value) end;
            ChangedCallback = Info.ChangedCallback or function(New) end;

            SyncToggleState = Info.SyncToggleState or false;
        };

        if KeyPicker.SyncToggleState then
            Info.Modes = { 'Toggle' };
            Info.Mode = 'Toggle';

            if ParentObj.Type == 'Toggle' then
                KeyPicker.Toggled = not not ParentObj.Value;
            end;
        end;

        local PickOuter = Library:Create('Frame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Size = UDim2.new(0, 28, 0, 15);
            ZIndex = ToggleLabel.ZIndex + 1;
            Parent = ToggleLabel;
        });

        local PickInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = ToggleLabel.ZIndex + 2;
            Parent = PickOuter;
        });

        Library:AddToRegistry(PickInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 1, 0);
            Position = UDim2.new(0, 2, 0, 0);
            TextSize = 12;
            TextColor3 = Color3.new(1, 1, 1);
            Text = Info.Default == 'None' and '( - )' or Info.Default;
            ZIndex = ToggleLabel.ZIndex + 3;
            Parent = PickInner;
        });

        local function UpdateDisplayWidth(text)
            local display = text == 'None' and '( - )' or text;
            DisplayLabel.Text = display;
            local textWidth = Library:GetTextBounds(display, Library.Font, 13);
            PickOuter.Size = UDim2.new(0, textWidth + 6, 0, 15);
        end;
        UpdateDisplayWidth(Info.Default);

        local ModeSelectOuter = Library:Create('Frame', {
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
            Size = UDim2.new(0, 60, 0, 45 + 2);
            Visible = false;
            ZIndex = Library:GetPopupZIndex(0);
            Parent = ScreenGui;
        });

        ToggleLabel:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
            ModeSelectOuter.Position = UDim2.fromOffset(ToggleLabel.AbsolutePosition.X + ToggleLabel.AbsoluteSize.X + 4, ToggleLabel.AbsolutePosition.Y + 1);
        end);

        local ModeSelectInner = Library:Create('Frame', {
            BackgroundColor3 = Library.BackgroundColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Library:GetPopupZIndex(1);
            Parent = ModeSelectOuter;
        });

        Library:AddToRegistry(ModeSelectInner, {
            BackgroundColor3 = 'BackgroundColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ModeSelectInner;
        });

        local rowBase = Library:GetKeybindRowZBase();

        local KeybindRow = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -4, 0, 22);
            Visible = false;
            ZIndex = rowBase;
            Parent = Library.KeybindContainer;
        });

        local NameLabel = Library:CreateLabel({
            Text = Info.Text or '';
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(1, -84, 1, 0);
            TextSize = 13;
            TextColor3 = Color3.new(1, 1, 1);
            ZIndex = rowBase + 3;
            Parent = KeybindRow;
        }, true);

        Library:SetGradientText(NameLabel, Info.Text or '');

        local KeyBox = Library:Create('Frame', {
            AnchorPoint = Vector2.new(1, 0.5);
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Position = UDim2.new(1, 0, 0.5, 0);
            Size = UDim2.fromOffset(52, 18);
            ZIndex = rowBase + 3;
            Parent = KeybindRow;
        });

        Library:AddToRegistry(KeyBox, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        }, true);

        local ValueLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 1, 0);
            Position = UDim2.new(0, 2, 0, 0);
            TextSize = 12;
            TextColor3 = Color3.new(1, 1, 1);
            TextXAlignment = Enum.TextXAlignment.Center;
            ZIndex = rowBase + 5;
            Parent = KeyBox;
        }, true);

        KeyPicker.KeybindRow = KeybindRow;
        KeyPicker.NameLabel = NameLabel;
        KeyPicker.KeyBox = KeyBox;

        local Modes = Info.Modes or { 'Always', 'Toggle', 'Hold' };
        local ModeButtons = {};

        for Idx, Mode in next, Modes do
            local ModeButton = {};

            local Label = Library:CreateLabel({
                Active = false;
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 13;
                Text = Mode;
                ZIndex = Library:GetPopupZIndex(2);
                Parent = ModeSelectInner;
            });

            function ModeButton:Select()
                for _, Button in next, ModeButtons do
                    Button:Deselect();
                end;

                KeyPicker.Mode = Mode;

                Label.TextColor3 = Library.AccentColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'AccentColor';

                ModeSelectOuter.Visible = false;
            end;

            function ModeButton:Deselect()
                KeyPicker.Mode = nil;

                Label.TextColor3 = Library.FontColor;
                Library.RegistryMap[Label].Properties.TextColor3 = 'FontColor';
            end;

            Label.InputBegan:Connect(function(Input)
                if IsPrimaryPress(Input) then
                    ModeButton:Select();
                    Library:AttemptSave();
                end;
            end);

            if Mode == KeyPicker.Mode then
                ModeButton:Select();
            end;

            ModeButtons[Mode] = ModeButton;
        end;

        function KeyPicker:Update()
            if Info.NoUI then
                return;
            end;

            local State = KeyPicker:GetState();
            local keyText = KeyPicker.Value == 'None' and '-' or KeyPicker.Value;

            NameLabel.Text = Info.Text or '';
            ValueLabel.Text = keyText;
            ValueLabel.TextColor3 = Color3.new(1, 1, 1);
            ValueLabel.TextTransparency = 0;
            Library:SetGradientText(NameLabel, Info.Text or '');

            local textWidth = Library:GetTextBounds(keyText, Library.Font, 12);
            KeyBox.Size = UDim2.fromOffset(math.max(textWidth + 10, 36), 18);

            PickOuter.ZIndex = ToggleLabel.ZIndex + 1;
            PickInner.ZIndex = ToggleLabel.ZIndex + 2;
            DisplayLabel.ZIndex = ToggleLabel.ZIndex + 3;

            KeybindRow.Visible = State;
            Library:SyncKeybindRowsZIndex();
            Library:UpdateKeybindOverlaySize();
        end;

        function KeyPicker:GetState()
            if KeyPicker.Mode == 'Always' then
                return true;
            elseif KeyPicker.Mode == 'Hold' then
                if KeyPicker.Value == 'None' then
                    return false;
                end;

                local Key = KeyPicker.Value;

                if Key == 'MB1' or Key == 'MB2' then
                    return Key == 'MB1' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        or Key == 'MB2' and InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
                else
                    return InputService:IsKeyDown(Enum.KeyCode[KeyPicker.Value]);
                end;
            else
                return KeyPicker.Toggled;
            end;
        end;

        function KeyPicker:SetValue(Data)
            local Key, Mode = Data[1], Data[2];
            UpdateDisplayWidth(Key);
            ModeButtons[Mode]:Select();
            KeyPicker:Update();
        end;

        function KeyPicker:OnClick(Callback)
            KeyPicker.Clicked = Callback;
        end;

        function KeyPicker:OnChanged(Callback)
            KeyPicker.Changed = Callback;
            Callback(KeyPicker.Value);
        end;

        if ParentObj.Addons then
            table.insert(ParentObj.Addons, KeyPicker);
        end;

        function KeyPicker:DoClick()
            if ParentObj.Type == 'Toggle' and KeyPicker.SyncToggleState then
                ParentObj:SetValue(not ParentObj.Value);
            end;

            Library:SafeCallback(KeyPicker.Callback, KeyPicker.Toggled);
            Library:SafeCallback(KeyPicker.Clicked, KeyPicker.Toggled);
        end;

        local Picking = false;

        PickOuter.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                Picking = true;

                UpdateDisplayWidth('');

                local Break;
                local Text = '';

                task.spawn(function()
                    while (not Break) do
                        if Text == '...' then
                            Text = '';
                        end;

                        Text = Text .. '.';
                        UpdateDisplayWidth(Text);

                        wait(0.4);
                    end;
                end);

                wait(0.2);

                local Event;
                Event = InputService.InputBegan:Connect(function(Input)
                    local Key;

                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Key = 'MB1';
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = 'MB2';
                    end;

                    if Key == 'Escape' or Key == 'Backspace' then
                        Key = 'None';
                    end;

                    Break = true;
                    Picking = false;

                    UpdateDisplayWidth(Key);
                    KeyPicker.Value = Key;

                    Library:SafeCallback(KeyPicker.ChangedCallback, Input.KeyCode or Input.UserInputType);
                    Library:SafeCallback(KeyPicker.Changed, Input.KeyCode or Input.UserInputType);

                    Library:AttemptSave();

                    Event:Disconnect();
                end);
            elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and not Library:MouseIsOverOpenedFrame() then
                ModeSelectOuter.Visible = true;
            end;
        end);

        Library:GiveSignal(InputService.InputBegan:Connect(function(Input)
            if (not Picking) then
                if KeyPicker.Mode == 'Toggle' then
                    local Key = KeyPicker.Value;

                    if Key == 'MB1' or Key == 'MB2' then
                        if Key == 'MB1' and IsPrimaryPress(Input)
                        or Key == 'MB2' and Input.UserInputType == Enum.UserInputType.MouseButton2 then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick();
                        end;
                    elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                        if Input.KeyCode.Name == Key then
                            KeyPicker.Toggled = not KeyPicker.Toggled;
                            KeyPicker:DoClick();
                        end;
                    end;
                end;

                KeyPicker:Update();
            end;

            if IsPrimaryPress(Input) then
                local Pos = GetPointerPosition(Input);
                local AbsPos, AbsSize = ModeSelectOuter.AbsolutePosition, ModeSelectOuter.AbsoluteSize;

                if Pos.X < AbsPos.X or Pos.X > AbsPos.X + AbsSize.X
                    or Pos.Y < (AbsPos.Y - 20 - 1) or Pos.Y > AbsPos.Y + AbsSize.Y then

                    ModeSelectOuter.Visible = false;
                end;
            end;
        end));

        Library:GiveSignal(InputService.InputEnded:Connect(function(Input)
            if (not Picking) then
                KeyPicker:Update();
            end;
        end));

        KeyPicker:Update();

        if type(KeyPicker)=="table" and KeyPicker.SetVisible==nil then KeyPicker.SetVisible=function() end end;
        Options[Idx] = KeyPicker;

        return self;
    end;

    BaseAddons.__index = Funcs;
    BaseAddons.__namecall = function(Table, Key, ...)
        return Funcs[Key](Table, ...);
    end;
end;

BaseGroupbox = {};

do
    local Funcs = {};

    local function Z(Groupbox, Layer)
        return (Groupbox.ContentBaseZIndex or 10) + Layer;
    end;

    function Funcs:AddBlank(Size)
        local Groupbox = self;
        local Container = Groupbox.Container;

        Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, Size);
            ZIndex = Z(Groupbox, 1);
            Parent = Container;
        });
    end;

    function Funcs:AddLabel(Text, DoesWrap)
        local Label = {};

        local Groupbox = self;
        local Container = Groupbox.Container;

        local TextLabel = Library:CreateLabel({
            Size = UDim2.new(1, -4, 0, 15);
            TextSize = 14;
            Text = Text;
            TextWrapped = DoesWrap or false,
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        if DoesWrap then
            local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)));
            TextLabel.Size = UDim2.new(1, -4, 0, Y);
        else
            Library:Create('UIListLayout', {
                Padding = UDim.new(0, 4);
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TextLabel;
            });
        end;

        Label.TextLabel = TextLabel;
        Label.Container = Container;

        function Label:SetText(Text)
            TextLabel.Text = Text;

            if DoesWrap then
                local Y = select(2, Library:GetTextBounds(Text, Library.Font, 14, Vector2.new(TextLabel.AbsoluteSize.X, math.huge)));
                TextLabel.Size = UDim2.new(1, -4, 0, Y);
            end;

            Groupbox:Resize();
        end;

        if (not DoesWrap) then
            setmetatable(Label, BaseAddons);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Label;
    end;

    function Funcs:AddButton(...)
        local Button = {};
        local function ProcessButtonParams(Class, Obj, ...)
            local Props = select(1, ...);
            if type(Props) == 'table' then
                Obj.Text = Props.Text;
                Obj.Func = Props.Func;
                Obj.DoubleClick = Props.DoubleClick;
                Obj.Tooltip = Props.Tooltip;
            else
                Obj.Text = select(1, ...);
                Obj.Func = select(2, ...);
            end;

            assert(type(Obj.Func) == 'function', 'AddButton: `Func` callback is missing.');
        end;

        ProcessButtonParams('Button', Button, ...);

        local Groupbox = self;
        local Container = Groupbox.Container;

        local function CreateBaseButton(Button)
            local Outer = Library:Create('Frame', {
                BackgroundColor3 = Color3.new(0, 0, 0);
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, -4, 0, 20);
                ZIndex = Z(self, 5);
            });

            local Inner = Library:Create('Frame', {
                BackgroundColor3 = Library.MainColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = Z(self, 6);
                Parent = Outer;
            });

            local Label = Library:CreateLabel({
                Size = UDim2.new(1, 0, 1, 0);
                TextSize = 14;
                Text = Button.Text;
                ZIndex = Z(self, 6);
                Parent = Inner;
            });

            Library:Create('UIGradient', {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
                });
                Rotation = 90;
                Parent = Inner;
            });

            Library:AddToRegistry(Outer, {
                BorderColor3 = 'Black';
            });

            Library:AddToRegistry(Inner, {
                BackgroundColor3 = 'MainColor';
                BorderColor3 = 'OutlineColor';
            });

            Library:OnHighlight(Outer, Outer,
                { BorderColor3 = 'AccentColor' },
                { BorderColor3 = 'Black' }
            );

            return Outer, Inner, Label;
        end;

        local function InitEvents(Button)
            local function WaitForEvent(event, timeout, validator)
                local bindable = Instance.new('BindableEvent');
                local connection = event:Once(function(...)

                    if type(validator) == 'function' and validator(...) then
                        bindable:Fire(true);
                    else
                        bindable:Fire(false);
                    end;
                end);
                task.delay(timeout, function()
                    connection:disconnect();
                    bindable:Fire(false);
                end);
                return bindable.Event:Wait();
            end;

            local function ValidateClick(Input)
                if Library:MouseIsOverOpenedFrame() then
                    return false;
                end;

                return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch;
            end;

            Button.Outer.InputBegan:Connect(function(Input)
                if not ValidateClick(Input) then return end;
                if Button.Locked then return end;

                if Button.DoubleClick then
                    Library:RemoveFromRegistry(Button.Label);
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'AccentColor' });

                    Button.Label.TextColor3 = Library.AccentColor;
                    Button.Label.Text = 'Are you sure?';
                    Button.Locked = true;

                    local clicked = WaitForEvent(Button.Outer.InputBegan, 0.5, ValidateClick);

                    Library:RemoveFromRegistry(Button.Label);
                    Library:AddToRegistry(Button.Label, { TextColor3 = 'FontColor' });

                    Button.Label.TextColor3 = Library.FontColor;
                    Button.Label.Text = Button.Text;
                    task.defer(rawset, Button, 'Locked', false);

                    if clicked then
                        Library:SafeCallback(Button.Func);
                    end;

                    return
                end;

                Library:SafeCallback(Button.Func);
            end);
        end;

        Button.Outer, Button.Inner, Button.Label = CreateBaseButton(Button);
        Button.Outer.Parent = Container;

        InitEvents(Button);

        function Button:AddTooltip(tooltip)
            if type(tooltip) == 'string' then
                Library:AddToolTip(tooltip, self.Outer);
            end;
            return self;
        end;

        function Button:SetText(text)
            self.Text = text;
            self.Label.Text = text;
            return self;
        end;

        function Button:AddButton(...)
            local SubButton = {};

            ProcessButtonParams('SubButton', SubButton, ...);

            self.Outer.Size = UDim2.new(0.5, -2, 0, 20);

            SubButton.Outer, SubButton.Inner, SubButton.Label = CreateBaseButton(SubButton);

            SubButton.Outer.Position = UDim2.new(1, 3, 0, 0);
            SubButton.Outer.Size = UDim2.fromOffset(self.Outer.AbsoluteSize.X - 2, self.Outer.AbsoluteSize.Y);
            SubButton.Outer.Parent = self.Outer;

            function SubButton:AddTooltip(tooltip)
                if type(tooltip) == 'string' then
                    Library:AddToolTip(tooltip, self.Outer);
                end;
                return SubButton;
            end;

            function SubButton:SetText(text)
                self.Text = text;
                self.Label.Text = text;
                return self;
            end;

            if type(SubButton.Tooltip) == 'string' then
                SubButton:AddTooltip(SubButton.Tooltip);
            end;

            InitEvents(SubButton);
            return SubButton;
        end;

        if type(Button.Tooltip) == 'string' then
            Button:AddTooltip(Button.Tooltip);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        return Button;
    end;

    function Funcs:AddDivider()
        local Groupbox = self;
        local Container = self.Container;

        local Divider = {
            Type = 'Divider',
        };

        Groupbox:AddBlank(2);
        local DividerOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 5);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        local DividerInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = DividerOuter;
        });

        Library:AddToRegistry(DividerOuter, {
            BorderColor3 = 'Black';
        });

        Library:AddToRegistry(DividerInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Groupbox:AddBlank(9);
        Groupbox:Resize();
    end;

    function Funcs:AddInput(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.');

        local Textbox = {
            Value = Info.Default or '';
            Numeric = Info.Numeric or false;
            Finished = Info.Finished or false;
            Type = 'Input';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.NoLabel then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 15);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = Z(self, 5);
                Parent = Container;
            });

            Groupbox:AddBlank(1);
        end;

        local TextBoxOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        local TextBoxInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = TextBoxOuter;
        });

        Library:AddToRegistry(TextBoxInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:OnHighlight(TextBoxOuter, TextBoxOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, TextBoxOuter);
        end;

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = TextBoxInner;
        });

        local Container = Library:Create('Frame', {
            BackgroundTransparency = 1;

            Position = UDim2.new(0, 5, 0, 2);
            Size = UDim2.new(1, -10, 1, -4);

            ZIndex = Z(self, 7);
            Parent = TextBoxInner;
        });

        local Box = Library:Create('TextBox', {
            BackgroundTransparency = 1;

            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(5, 1),

            Font = Library.Font;
            PlaceholderColor3 = Color3.fromRGB(120, 120, 120);
            PlaceholderText = Info.Placeholder or '';

            Text = Info.Default or '';
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 1;
            TextTransparency = 1;
            ClearTextOnFocus = false;
            TextXAlignment = Enum.TextXAlignment.Left;

            ZIndex = Z(self, 7);
            Parent = Container;
        });

        local TextOverlay = Library:CreateLabel({
            BackgroundTransparency = 1;
            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(5, 1),
            Font = Library.Font;
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = Z(self, 7);
            Parent = Container;
        });

        Box:GetPropertyChangedSignal('Position'):Connect(function()
            TextOverlay.Position = Box.Position;
        end);

        local CustomCaret = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Size = UDim2.new(0, 2, 1, -4);
            Position = UDim2.fromOffset(2, 2);
            ZIndex = Z(self, 9);
            Visible = false;
            Parent = Container;
        });

        Library:AddToRegistry(CustomCaret, {
            BackgroundColor3 = 'AccentColor';
        });

        local CaretBlinkTween;
        local CaretBlinkConnection;
        local LastTextLength = #(Info.Default or '');
        local TextAnimTween;

        local function StopCaretBlink()
            if CaretBlinkTween then
                CaretBlinkTween:Cancel();
                CaretBlinkTween = nil;
            end;

            if CaretBlinkConnection then
                CaretBlinkConnection:Disconnect();
                CaretBlinkConnection = nil;
            end;

            CustomCaret.BackgroundTransparency = 0;
        end;

        local function StartCaretBlink()
            StopCaretBlink();

            CaretBlinkConnection = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
                if not Box:IsFocused() then
                    StopCaretBlink();
                end;
            end));

            local function Blink()
                if not Box:IsFocused() then
                    return
                end;

                CaretBlinkTween = TweenService:Create(CustomCaret, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0.55,
                });

                CaretBlinkTween:Play();
                CaretBlinkTween.Completed:Connect(function()
                    if Box:IsFocused() then
                        CaretBlinkTween = TweenService:Create(CustomCaret, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            BackgroundTransparency = 0,
                        });
                        CaretBlinkTween:Play();
                        CaretBlinkTween.Completed:Connect(Blink);
                    end;
                end);
            end;

            Blink();
        end;

        local function PlayTextEntryAnimation()
            if TextAnimTween then
                TextAnimTween:Cancel();
            end;

            TextOverlay.TextTransparency = 0.45;
            TextOverlay.Position = UDim2.new(Box.Position.X.Scale, Box.Position.X.Offset, 0, -2);

            TextAnimTween = TweenService:Create(TextOverlay, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                TextTransparency = 0,
                Position = Box.Position,
            });
            TextAnimTween:Play();
        end;

        function Textbox:SetValue(Text)
            if Info.MaxLength and #Text > Info.MaxLength then
                Text = Text:sub(1, Info.MaxLength);
            end;

            if Textbox.Numeric then
                if (not tonumber(Text)) and Text:len() > 0 then
                    Text = Textbox.Value;
                end;
            end;

            Textbox.Value = Text;
            Box.Text = Text;
            LastTextLength = #Text;

            Library:SafeCallback(Textbox.Callback, Textbox.Value);
            Library:SafeCallback(Textbox.Changed, Textbox.Value);
        end;

        if Textbox.Finished then
            Box.FocusLost:Connect(function(enter)
                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end);
        else
            Box:GetPropertyChangedSignal('Text'):Connect(function()
                Textbox:SetValue(Box.Text);
                Library:AttemptSave();
            end);
        end;

        local function Update()
            local PADDING = 2;
            local reveal = Container.AbsoluteSize.X;

            if Box.Text == "" then
                TextOverlay.Text = Box.PlaceholderText;
                TextOverlay.TextColor3 = Box.PlaceholderColor3;
            else
                TextOverlay.Text = Box.Text;
                TextOverlay.TextColor3 = Library.FontColor;
            end;

            if not Box:IsFocused() or Box.TextBounds.X <= reveal - 2 * PADDING then
                TweenService:Create(Box, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0, PADDING, 0, 0)
                }):Play();
            else
                local cursor = Box.CursorPosition;
                if cursor ~= -1 then
                    local subtext = string.sub(Box.Text, 1, cursor-1);
                    local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X;
                    local currentCursorPos = Box.Position.X.Offset + width;

                    local targetX = Box.Position.X.Offset;
                    if currentCursorPos < PADDING then
                        targetX = PADDING-width;
                    elseif currentCursorPos > reveal - PADDING - 1 then
                        targetX = reveal-width-PADDING-1;
                    end;

                    TweenService:Create(Box, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromOffset(targetX, 0)
                    }):Play();
                end;
            end;

            if Box:IsFocused() then
                CustomCaret.Visible = true;
                local cursor = Box.CursorPosition;
                if cursor ~= -1 then
                    local subtext = string.sub(Box.Text, 1, cursor-1);
                    local width = TextService:GetTextSize(subtext, Box.TextSize, Box.Font, Vector2.new(math.huge, math.huge)).X;
                    local caretTargetX = Box.Position.X.Offset + width + 1;
                    TweenService:Create(CustomCaret, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromOffset(math.clamp(caretTargetX, PADDING, reveal - PADDING), 2)
                    }):Play();
                else
                    CustomCaret.Visible = false;
                end;
            else
                CustomCaret.Visible = false;
                StopCaretBlink();
            end;
        end;

        local function OnTextChanged()
            local newLength = #Box.Text;
            if Box:IsFocused() and newLength > LastTextLength then
                PlayTextEntryAnimation();
            end;
            LastTextLength = newLength;
            Update();
        end;

        task.spawn(Update);

        Box:GetPropertyChangedSignal('Text'):Connect(OnTextChanged);
        Box:GetPropertyChangedSignal('CursorPosition'):Connect(Update);
        Box.FocusLost:Connect(function()
            StopCaretBlink();
            Update();
        end);
        Box.Focused:Connect(function()
            StartCaretBlink();
            Update();
        end);

        Library:AddToRegistry(Box, {
            TextColor3 = 'FontColor';
        });

        function Textbox:OnChanged(Func)
            Textbox.Changed = Func;
            Func(Textbox.Value);
        end;

        Groupbox:AddBlank(5);
        Groupbox:Resize();

        if type(Textbox)=="table" and Textbox.SetVisible==nil then Textbox.SetVisible=function() end end;
        Options[Idx] = Textbox;

        return Textbox;
    end;

    function Funcs:AddToggle(Idx, Info)
        assert(Info.Text, 'AddInput: Missing `Text` string.');

        local Toggle = {
            Value = Info.Default or false;
            Type = 'Toggle';

            Callback = Info.Callback or function(Value) end;
            Addons = {},
            Risky = Info.Risky,
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local ToggleOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(0, 13, 0, 13);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        Library:AddToRegistry(ToggleOuter, {
            BorderColor3 = 'Black';
        });

        local ToggleInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = ToggleOuter;
        });

        Library:AddToRegistry(ToggleInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local ToggleLabel = Library:CreateLabel({
            Size = UDim2.new(0, 216, 1, 0);
            Position = UDim2.new(1, 6, 0, 0);
            TextSize = 14;
            Text = Info.Text;
            TextXAlignment = Enum.TextXAlignment.Left;
            ZIndex = Z(self, 6);
            Parent = ToggleInner;
        });

        local function UpdateToggleLabelWidth()
            local available = Container.AbsoluteSize.X / Library:GetUIScaleFactor(Container) - (ToggleOuter.Size.X.Offset + 6) - 4;
            ToggleLabel.Size = UDim2.new(0, math.max(available, 60), 1, 0);
        end;

        Container:GetPropertyChangedSignal('AbsoluteSize'):Connect(UpdateToggleLabelWidth);
        task.spawn(UpdateToggleLabelWidth);

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4);
            FillDirection = Enum.FillDirection.Horizontal;
            HorizontalAlignment = Enum.HorizontalAlignment.Right;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = ToggleLabel;
        });

        local ToggleRegion = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(0, 170, 1, 0);
            ZIndex = Z(self, 8);
            Parent = ToggleOuter;
        });

        Library:OnHighlight(ToggleRegion, ToggleOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        function Toggle:UpdateColors()
            Toggle:Display();
        end;

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, ToggleRegion);
        end;

        function Toggle:Display()
            if Toggle.BgTween then Toggle.BgTween:Cancel() end;
            if Toggle.BorderTween then Toggle.BorderTween:Cancel() end;

            local targetBg = Toggle.Value and Library.AccentColor or Library.MainColor;
            local targetBorder = Toggle.Value and Library.AccentColorDark or Library.OutlineColor;

            local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            Toggle.BgTween = TweenService:Create(ToggleInner, tweenInfo, { BackgroundColor3 = targetBg });
            Toggle.BorderTween = TweenService:Create(ToggleInner, tweenInfo, { BorderColor3 = targetBorder });

            Toggle.BgTween:Play();
            Toggle.BorderTween:Play();

            Library.RegistryMap[ToggleInner].Properties.BackgroundColor3 = Toggle.Value and 'AccentColor' or 'MainColor';
            Library.RegistryMap[ToggleInner].Properties.BorderColor3 = Toggle.Value and 'AccentColorDark' or 'OutlineColor';
        end;

        function Toggle:OnChanged(Func)
            Toggle.Changed = Func;
            Func(Toggle.Value);
        end;

        function Toggle:SetValue(Bool)
            Bool = (not not Bool);

            Toggle.Value = Bool;
            Toggle:Display();

            for _, Addon in next, Toggle.Addons do
                if Addon.Type == 'KeyPicker' and Addon.SyncToggleState then
                    Addon.Toggled = Bool;
                    Addon:Update();
                end;
            end;

            Library:SafeCallback(Toggle.Callback, Toggle.Value);
            Library:SafeCallback(Toggle.Changed, Toggle.Value);
            Library:UpdateDependencyBoxes();
        end;

        ToggleRegion.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                Library:PlayToggleSound();
                Toggle:SetValue(not Toggle.Value);
                Library:AttemptSave();
            end;
        end);

        if Toggle.Risky then
            Library:RemoveFromRegistry(ToggleLabel);
            ToggleLabel.TextColor3 = Library.RiskColor;
            Library:AddToRegistry(ToggleLabel, { TextColor3 = 'RiskColor' });
        end;

        Toggle:Display();
        Groupbox:AddBlank(Info.BlankSize or 5 + 2);
        Groupbox:Resize();

        Toggle.TextLabel = ToggleLabel;
        Toggle.Container = Container;
        setmetatable(Toggle, BaseAddons);

        if type(Toggle)=="table" and Toggle.SetVisible==nil then Toggle.SetVisible=function() end end;
        Toggles[Idx] = Toggle;

        Library:UpdateDependencyBoxes();

        return Toggle;
    end;

    function Funcs:AddSlider(Idx, Info)
        assert(Info.Default, 'AddSlider: Missing default value.');
        assert(Info.Text, 'AddSlider: Missing slider text.');
        assert(Info.Min, 'AddSlider: Missing minimum value.');
        assert(Info.Max, 'AddSlider: Missing maximum value.');
        assert(Info.Rounding, 'AddSlider: Missing rounding value.');

        local Slider = {
            Value = Info.Default;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = math.clamp(Info.Rounding or 0, 0, 3);
            Type = 'Slider';
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.Compact then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = Z(self, 5);
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end;

        local SliderContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        local DecrementBtn = Library:Create('TextButton', {
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, -1);
            Size = UDim2.new(0, 12, 1, 0);
            Font = Library.Font;
            Text = "-";
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextYAlignment = Enum.TextYAlignment.Center;
            ZIndex = Z(self, 8);
            Parent = SliderContainer;
        });

        local IncrementBtn = Library:Create('TextButton', {
            BackgroundTransparency = 1;
            Position = UDim2.new(1, -12, 0, -1);
            Size = UDim2.new(0, 12, 1, 0);
            Font = Library.Font;
            Text = "+";
            TextColor3 = Library.FontColor;
            TextSize = 14;
            TextYAlignment = Enum.TextYAlignment.Center;
            ZIndex = Z(self, 8);
            Parent = SliderContainer;
        });

        Library:OnHighlight(DecrementBtn, DecrementBtn,
            { TextColor3 = 'AccentColor' },
            { TextColor3 = 'FontColor' }
        );

        Library:OnHighlight(IncrementBtn, IncrementBtn,
            { TextColor3 = 'AccentColor' },
            { TextColor3 = 'FontColor' }
        );

        local SliderOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 16, 0, 0);
            Size = UDim2.new(1, -32, 0, 13);
            ZIndex = Z(self, 5);
            Parent = SliderContainer;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = SliderOuter;
        });

        function Slider:GetBarWidth()
            return math.max(SliderInner.AbsoluteSize.X, 1);
        end;

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderColor3 = Library.AccentColorDark;
            Size = UDim2.new(0, 0, 1, 0);
            ZIndex = Z(self, 7);
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
            BorderColor3 = 'AccentColorDark';
        });

        local HideBorderRight = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2.new(1, 0, 0, 0);
            Size = UDim2.new(0, 1, 1, 0);
            ZIndex = Z(self, 8);
            Parent = Fill;
        });

        Library:AddToRegistry(HideBorderRight, {
            BackgroundColor3 = 'AccentColor';
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            Text = 'Infinite';
            ZIndex = Z(self, 9);
            Parent = SliderInner;
        });

        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, SliderOuter);
        end;

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
            Fill.BorderColor3 = Library.AccentColorDark;
        end;

        function Slider:Display()
            local Suffix = Info.Suffix or "";

            if Info.Compact then
                DisplayLabel.Text = Info.Text .. ": " .. Slider.Value .. Suffix;
            elseif Info.HideMax then
                DisplayLabel.Text = tostring(Slider.Value) .. Suffix;
            else
                DisplayLabel.Text = ("%s/%s"):format(Slider.Value .. Suffix, Slider.Max .. Suffix);
            end;

            local Width = Slider:GetBarWidth();

            local X = math.clamp(
                math.round(
                    Library:MapValue(
                        Slider.Value,
                        Slider.Min,
                        Slider.Max,
                        0,
                        Width
                    )
                ),
                0,
                Width
            );

            if Slider.Tween then
                Slider.Tween:Cancel();
            end;

            Slider.Tween = TweenService:Create(
                Fill,
                TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, X, 1, 0)
                }
            );

            Slider.Tween:Play();

            HideBorderRight.Visible = X > 0 and X < Width;
        end;

        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func(Slider.Value);
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value + 0.5);
            end;

            return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value));
        end;

        function Slider:GetValueFromXOffset(X)
            return Round(
                Library:MapValue(
                    X,
                    0,
                    Slider:GetBarWidth(),
                    Slider.Min,
                    Slider.Max
                )
            );
        end;

        function Slider:SetValue(Str)
            local Num = tonumber(Str);

            if (not Num) then
                return;
            end;

            Num = math.clamp(Num, Slider.Min, Slider.Max);

            Slider.Value = Round(Num);
            Slider:Display();

            Library:SafeCallback(Slider.Callback, Slider.Value);
            Library:SafeCallback(Slider.Changed, Slider.Value);
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                local mPos = GetPointerPosition(Input).X;
                local gPos = Fill.Size.X.Offset;
                local Diff = mPos - (Fill.AbsolutePosition.X + gPos);

                while IsPressActive(Input) do
                    local nMPos = GetPointerPosition(Input).X;
                    local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slider:GetBarWidth());

                    local nValue = Slider:GetValueFromXOffset(nX);
                    local OldValue = Slider.Value;
                    Slider.Value = nValue;

                    Slider:Display();

                    if nValue ~= OldValue then
                        Library:PlaySliderSound();
                        Library:SafeCallback(Slider.Callback, Slider.Value);
                        Library:SafeCallback(Slider.Changed, Slider.Value);
                    end;

                    RenderStepped:Wait();
                end;

                Library:StopSliderSound();
                Library:AttemptSave();
            end;
        end);

        Library:BindHoldButton(DecrementBtn, function()
            local step = 10 ^ -Slider.Rounding;
            local OldValue = Slider.Value;
            Slider:SetValue(Slider.Value - step);
            if Slider.Value ~= OldValue then
                Library:PlaySliderSound();
            end;
            Library:AttemptSave();
        end);

        Library:BindHoldButton(IncrementBtn, function()
            local step = 10 ^ -Slider.Rounding;
            local OldValue = Slider.Value;
            Slider:SetValue(Slider.Value + step);
            if Slider.Value ~= OldValue then
                Library:PlaySliderSound();
            end;
            Library:AttemptSave();
        end);

        SliderInner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            Slider:Display();
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        if type(Slider)=="table" and Slider.SetVisible==nil then Slider.SetVisible=function() end end;
        Options[Idx] = Slider;

        return Slider;
    end;

    function Funcs:AddRangeSlider(Idx, Info)
        assert(Info.DefaultLower, 'AddRangeSlider: Missing default lower value.');
        assert(Info.DefaultUpper, 'AddRangeSlider: Missing default upper value.');
        assert(Info.Text, 'AddRangeSlider: Missing slider text.');
        assert(Info.Min, 'AddRangeSlider: Missing minimum value.');
        assert(Info.Max, 'AddRangeSlider: Missing maximum value.');
        assert(Info.Rounding, 'AddRangeSlider: Missing rounding value.');

        local Slider = {
            ValueLower = Info.DefaultLower;
            ValueUpper = Info.DefaultUpper;
            Min = Info.Min;
            Max = Info.Max;
            Rounding = math.clamp(Info.Rounding or 0, 0, 3);
            MaxSize = 200;
            Type = 'RangeSlider';
            Callback = Info.Callback or function(Lower, Upper) end;
        };

        Slider.Value = { Slider.ValueLower, Slider.ValueUpper };

        local Groupbox = self;
        local Container = Groupbox.Container;

        if not Info.Compact then
            Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = Z(self, 5);
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end;

        local SliderContainer = Library:Create('Frame', {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, -4, 0, 13);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        local SliderOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Position = UDim2.new(0, 4, 0, 0);
            Size = UDim2.new(1, -8, 0, 13);
            ZIndex = Z(self, 5);
            Parent = SliderContainer;
        });

        Library:AddToRegistry(SliderOuter, {
            BorderColor3 = 'Black';
        });

        local SliderInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = SliderOuter;
        });

        Library:AddToRegistry(SliderInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Fill = Library:Create('Frame', {
            BackgroundColor3 = Library.AccentColor;
            BorderSizePixel = 0;
            ZIndex = Z(self, 7);
            Parent = SliderInner;
        });

        Library:AddToRegistry(Fill, {
            BackgroundColor3 = 'AccentColor';
        });

        local HeadLower = Library:Create('Frame', {
            BackgroundColor3 = Color3.fromRGB(200, 200, 200);
            BorderColor3 = Color3.fromRGB(0, 0, 0);
            Size = UDim2.new(0, 3, 1, 2);
            Position = UDim2.new(0, 0, 0, -1);
            ZIndex = Z(self, 8);
            Parent = SliderInner;
        });

        local HeadUpper = Library:Create('Frame', {
            BackgroundColor3 = Color3.fromRGB(200, 200, 200);
            BorderColor3 = Color3.fromRGB(0, 0, 0);
            Size = UDim2.new(0, 3, 1, 2);
            Position = UDim2.new(0, 0, 0, -1);
            ZIndex = Z(self, 8);
            Parent = SliderInner;
        });

        local DisplayLabel = Library:CreateLabel({
            Size = UDim2.new(1, 0, 1, 0);
            TextSize = 14;
            ZIndex = Z(self, 9);
            Parent = SliderInner;
        });

        Library:OnHighlight(SliderOuter, SliderOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, SliderOuter);
        end;

        local function Round(Value)
            if Slider.Rounding == 0 then
                return math.floor(Value + 0.5);
            end;
            return tonumber(string.format('%.' .. Slider.Rounding .. 'f', Value));
        end;

        function Slider:Display()
            local Suffix = Info.Suffix or '';
            DisplayLabel.Text = string.format('%s%s - %s%s', tostring(Slider.ValueLower), Suffix, tostring(Slider.ValueUpper), Suffix);

            local barWidth = SliderInner.AbsoluteSize.X > 0 and SliderInner.AbsoluteSize.X or 222;
            local xLower = Library:MapValue(Slider.ValueLower, Slider.Min, Slider.Max, 0, barWidth);
            local xUpper = Library:MapValue(Slider.ValueUpper, Slider.Min, Slider.Max, 0, barWidth);

            if Slider.TweenFill then Slider.TweenFill:Cancel() end;
            if Slider.TweenHeadLower then Slider.TweenHeadLower:Cancel() end;
            if Slider.TweenHeadUpper then Slider.TweenHeadUpper:Cancel() end;

            local tInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            Slider.TweenFill = TweenService:Create(Fill, tInfo, {
                Position = UDim2.new(0, xLower, 0, 0),
                Size = UDim2.new(0, xUpper - xLower, 1, 0)
            });
            Slider.TweenHeadLower = TweenService:Create(HeadLower, tInfo, {
                Position = UDim2.new(0, xLower - 1, 0, -1)
            });
            Slider.TweenHeadUpper = TweenService:Create(HeadUpper, tInfo, {
                Position = UDim2.new(0, xUpper - 1, 0, -1)
            });

            Slider.TweenFill:Play();
            Slider.TweenHeadLower:Play();
            Slider.TweenHeadUpper:Play();
        end;

        function Slider:UpdateColors()
            Fill.BackgroundColor3 = Library.AccentColor;
        end;

        function Slider:OnChanged(Func)
            Slider.Changed = Func;
            Func(Slider.ValueLower, Slider.ValueUpper);
        end;

        function Slider:GetValueFromXOffset(X)
            local barWidth = SliderInner.AbsoluteSize.X > 0 and SliderInner.AbsoluteSize.X or 222;
            return Round(Library:MapValue(X, 0, barWidth, Slider.Min, Slider.Max));
        end;

        function Slider:SetValue(Lower, Upper)
            local numLower = tonumber(Lower) or Slider.ValueLower;
            local numUpper = tonumber(Upper) or Slider.ValueUpper;

            numLower = math.clamp(numLower, Slider.Min, Slider.Max);
            numUpper = math.clamp(numUpper, Slider.Min, Slider.Max);

            if numLower > numUpper then
                numLower = numUpper;
            end;

            Slider.ValueLower = Round(numLower);
            Slider.ValueUpper = Round(numUpper);
            Slider.Value = { Slider.ValueLower, Slider.ValueUpper };

            Slider:Display();

            Library:SafeCallback(Slider.Callback, Slider.ValueLower, Slider.ValueUpper);
            Library:SafeCallback(Slider.Changed, Slider.ValueLower, Slider.ValueUpper);
        end;

        SliderInner.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                local relativeX = GetPointerPosition(Input).X - SliderInner.AbsolutePosition.X;
                local clickValue = Slider:GetValueFromXOffset(relativeX);

                local distToLower = math.abs(clickValue - Slider.ValueLower);
                local distToUpper = math.abs(clickValue - Slider.ValueUpper);
                local activeHead = (distToLower < distToUpper) and "Lower" or "Upper";

                while IsPressActive(Input) do
                    local curRelativeX = math.clamp(GetPointerPosition(Input).X - SliderInner.AbsolutePosition.X, 0, SliderInner.AbsoluteSize.X > 0 and SliderInner.AbsoluteSize.X or 222);
                    local curVal = Slider:GetValueFromXOffset(curRelativeX);

                    local oldLower = Slider.ValueLower;
                    local oldUpper = Slider.ValueUpper;

                    if activeHead == "Lower" then
                        curVal = math.clamp(curVal, Slider.Min, Slider.ValueUpper);
                        Slider.ValueLower = curVal;
                    else
                        curVal = math.clamp(curVal, Slider.ValueLower, Slider.Max);
                        Slider.ValueUpper = curVal;
                    end;

                    Slider.Value = { Slider.ValueLower, Slider.ValueUpper };
                    Slider:Display();

                    if Slider.ValueLower ~= oldLower or Slider.ValueUpper ~= oldUpper then
                        Library:PlaySliderSound();
                        Library:SafeCallback(Slider.Callback, Slider.ValueLower, Slider.ValueUpper);
                        Library:SafeCallback(Slider.Changed, Slider.ValueLower, Slider.ValueUpper);
                    end;

                    RenderStepped:Wait();
                end;

                Library:StopSliderSound();
                Library:AttemptSave();
            end;
        end);

        SliderInner:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            Slider:Display();
        end);

        Slider:Display();
        Groupbox:AddBlank(Info.BlankSize or 6);
        Groupbox:Resize();

        if type(Slider)=="table" and Slider.SetVisible==nil then Slider.SetVisible=function() end end;
        Options[Idx] = Slider;

        return Slider;
    end;

    function Funcs:AddDropdown(Idx, Info)
        if Info.SpecialType == 'Player' then
            Info.Values = GetPlayersString();
            Info.AllowNull = true;
        elseif Info.SpecialType == 'Team' then
            Info.Values = GetTeamsString();
            Info.AllowNull = true;
        end;

        assert(Info.Values, 'AddDropdown: Missing dropdown value list.');
        assert(Info.AllowNull or Info.Default, 'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.');

        if (not Info.Text) then
            Info.Compact = true;
        end;

        local Dropdown = {
            Values = Info.Values;
            Value = Info.Multi and {};
            Multi = Info.Multi;
            Type = 'Dropdown';
            SpecialType = Info.SpecialType;
            Callback = Info.Callback or function(Value) end;
        };

        local Groupbox = self;
        local Container = Groupbox.Container;

        local RelativeOffset = 0;

        if not Info.Compact then
            local DropdownLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 10);
                TextSize = 14;
                Text = Info.Text;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextYAlignment = Enum.TextYAlignment.Bottom;
                ZIndex = Z(self, 5);
                Parent = Container;
            });

            Groupbox:AddBlank(3);
        end;

        for _, Element in next, Container:GetChildren() do
            if not Element:IsA('UIListLayout') then
                RelativeOffset = RelativeOffset + Element.Size.Y.Offset;
            end;
        end;

        local DropdownOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            Size = UDim2.new(1, -4, 0, 20);
            ZIndex = Z(self, 5);
            Parent = Container;
        });

        Library:AddToRegistry(DropdownOuter, {
            BorderColor3 = 'Black';
        });

        local DropdownInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = Z(self, 6);
            Parent = DropdownOuter;
        });

        Library:AddToRegistry(DropdownInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        Library:Create('UIGradient', {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
            });
            Rotation = 90;
            Parent = DropdownInner;
        });

        local DropdownArrow = Library:CreateLabel({
            AnchorPoint = Vector2.new(1, 0.5);
            BackgroundTransparency = 1;
            Position = UDim2.new(1, -5, 0.5, 0);
            Size = UDim2.new(0, 12, 1, 0);
            Text = '+';
            TextSize = 14;
            TextXAlignment = Enum.TextXAlignment.Right;
            ZIndex = Z(self, 8);
            Parent = DropdownInner;
        });

        local ItemList = Library:CreateLabel({
            Position = UDim2.new(0, 5, 0, 0);
            Size = UDim2.new(1, -20, 1, 0);
            TextSize = 14;
            Text = '--';
            TextXAlignment = Enum.TextXAlignment.Left;
            TextWrapped = true;
            ZIndex = Z(self, 7);
            Parent = DropdownInner;
        });

        Library:OnHighlight(DropdownOuter, DropdownOuter,
            { BorderColor3 = 'AccentColor' },
            { BorderColor3 = 'Black' }
        );

        if type(Info.Tooltip) == 'string' then
            Library:AddToolTip(Info.Tooltip, DropdownOuter);
        end;

        local MAX_DROPDOWN_ITEMS = 8;

        local ListOuter = Library:Create('Frame', {
            BackgroundColor3 = Color3.new(0, 0, 0);
            BorderColor3 = Color3.new(0, 0, 0);
            ZIndex = 20;
            Visible = false;
            Parent = ScreenGui;
        });

        local function RecalculateListPosition()
            ListOuter.Position = UDim2.fromOffset(DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + DropdownOuter.Size.Y.Offset + 1);
        end;

        local function RecalculateListSize(YSize)
            local height = YSize or (MAX_DROPDOWN_ITEMS * 20 + 2);
            Dropdown.ListHeight = height;
            if ListOuter.Visible then
                ListOuter.Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, height);
            end;
        end;

        RecalculateListPosition();
        RecalculateListSize();

        DropdownOuter:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition);

        local ListInner = Library:Create('Frame', {
            BackgroundColor3 = Library.MainColor;
            BorderColor3 = Library.OutlineColor;
            BorderMode = Enum.BorderMode.Inset;
            BorderSizePixel = 0;
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListOuter;
        });

        Library:AddToRegistry(ListInner, {
            BackgroundColor3 = 'MainColor';
            BorderColor3 = 'OutlineColor';
        });

        local Scrolling = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            CanvasSize = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            ZIndex = 21;
            Parent = ListInner;

            TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',

            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.AccentColor,
        });

        Library:AddToRegistry(Scrolling, {
            ScrollBarImageColor3 = 'AccentColor'
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 0);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            Parent = Scrolling;
        });

        function Dropdown:Display()
            local Values = Dropdown.Values;
            local Str = '';

            if Info.Multi then
                for Idx, Value in next, Values do
                    if Dropdown.Value[Value] then
                        Str = Str .. Value .. ', ';
                    end;
                end;

                Str = Str:sub(1, #Str - 2);
            else
                Str = Dropdown.Value or '';
            end;

            ItemList.Text = (Str == '' and '...' or Str);
        end;

        function Dropdown:GetActiveValues()
            if Info.Multi then
                local T = {};

                for Value, Bool in next, Dropdown.Value do
                    table.insert(T, Value);
                end;

                return T;
            else
                return Dropdown.Value and 1 or 0;
            end;
        end;

        function Dropdown:BuildDropdownList()
            local Values = Dropdown.Values;
            local Buttons = {};

            for _, Element in next, Scrolling:GetChildren() do
                if not Element:IsA('UIListLayout') then
                    Element:Destroy();
                end;
            end;

            local Count = 0;

            for Idx, Value in next, Values do
                local Table = {};

                Count = Count + 1;

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Middle;
                    Size = UDim2.new(1, -1, 0, 20);
                    ZIndex = 23;
                    Active = true,
                    Parent = Scrolling;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Active = false;
                    Size = UDim2.new(1, -6, 1, 0);
                    Position = UDim2.new(0, 6, 0, 0);
                    TextSize = 14;
                    Text = Value;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 25;
                    Parent = Button;
                });

                Library:OnHighlight(Button, Button,
                    { BorderColor3 = 'AccentColor', ZIndex = 24 },
                    { BorderColor3 = 'OutlineColor', ZIndex = 23 }
                );

                local Selected;

                if Info.Multi then
                    Selected = Dropdown.Value[Value];
                else
                    Selected = Dropdown.Value == Value;
                end;

                function Table:UpdateButton()
                    if Info.Multi then
                        Selected = Dropdown.Value[Value];
                    else
                        Selected = Dropdown.Value == Value;
                    end;

                    ButtonLabel.TextColor3 = Selected and Library.AccentColor or Library.FontColor;
                    Library.RegistryMap[ButtonLabel].Properties.TextColor3 = Selected and 'AccentColor' or 'FontColor';
                end;

                ButtonLabel.InputBegan:Connect(function(Input)
                    if IsPrimaryPress(Input) then
                        local Try = not Selected;

                        if Dropdown:GetActiveValues() == 1 and (not Try) and (not Info.AllowNull) then
                        else
                            if Info.Multi then
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value[Value] = true;
                                else
                                    Dropdown.Value[Value] = nil;
                                end;
                            else
                                Selected = Try;

                                if Selected then
                                    Dropdown.Value = Value;
                                else
                                    Dropdown.Value = nil;
                                end;

                                for _, OtherButton in next, Buttons do
                                    OtherButton:UpdateButton();
                                end;
                            end;

                            Table:UpdateButton();
                            Dropdown:Display();

                            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
                            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);

                            Library:UpdateDependencyBoxes();

                            Library:AttemptSave();
                        end;
                    end;
                end);

                Table:UpdateButton();
                Dropdown:Display();

                Buttons[Button] = Table;
            end;

            Scrolling.CanvasSize = UDim2.fromOffset(0, (Count * 20) + 1);

            local Y = math.clamp(Count * 20, 0, MAX_DROPDOWN_ITEMS * 20) + 1;
            RecalculateListSize(Y);
        end;

        function Dropdown:SetValues(NewValues)
            if NewValues then
                Dropdown.Values = NewValues;
            end;

            Dropdown:BuildDropdownList();
        end;

        function Dropdown:OpenDropdown()
            if Dropdown.Tween then Dropdown.Tween:Cancel() end;

            RecalculateListPosition();
            Library:ApplyPopupZIndex(ListOuter, 20);
            ListOuter.Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, 0);
            ListOuter.Visible = true;
            ListOuter.ClipsDescendants = false;
            ListInner.ClipsDescendants = false;
            Library.OpenedFrames[ListOuter] = true;

            Dropdown.Tween = TweenService:Create(ListOuter, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, Dropdown.ListHeight or 162)
            });
            DropdownArrow.Text = '-';

            Dropdown.Tween:Play();
        end;

        function Dropdown:CloseDropdown()
            if Dropdown.Tween then Dropdown.Tween:Cancel() end;

            Dropdown.Tween = TweenService:Create(ListOuter, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(DropdownOuter.AbsoluteSize.X, 0)
            });
            DropdownArrow.Text = '+';

            local connection;
            connection = Dropdown.Tween.Completed:Connect(function()
                ListOuter.Visible = false;
                Library.OpenedFrames[ListOuter] = nil;
                connection:Disconnect();
            end);

            Dropdown.Tween:Play();
        end;

        function Dropdown:OnChanged(Func)
            Dropdown.Changed = Func;
            Func(Dropdown.Value);
        end;

        function Dropdown:SetValue(Val)
            local previousValue = Dropdown.Value;

            if Dropdown.Multi then
                local nTable = {};

                for Value, Bool in next, Val do
                    if table.find(Dropdown.Values, Value) then
                        nTable[Value] = true;
                    end;
                end;

                Dropdown.Value = nTable;
            else
                if (not Val) then
                    Dropdown.Value = nil;
                elseif table.find(Dropdown.Values, Val) then
                    Dropdown.Value = Val;
                end;
            end;

            if Dropdown.Value == previousValue then
                Dropdown:Display();
                return;
            end;

            Dropdown:BuildDropdownList();

            Library:SafeCallback(Dropdown.Callback, Dropdown.Value);
            Library:SafeCallback(Dropdown.Changed, Dropdown.Value);
        end;

        DropdownOuter.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                if ListOuter.Visible then
                    Dropdown:CloseDropdown();
                else
                    Dropdown:OpenDropdown();
                end;
            end;
        end);

        InputService.InputBegan:Connect(function(Input)
            if IsPrimaryPress(Input) then
                local Pos = GetPointerPosition(Input);
                local AbsPos, AbsSize = ListOuter.AbsolutePosition, ListOuter.AbsoluteSize;

                if Pos.X < AbsPos.X or Pos.X > AbsPos.X + AbsSize.X
                    or Pos.Y < (AbsPos.Y - 20 - 1) or Pos.Y > AbsPos.Y + AbsSize.Y then

                    Dropdown:CloseDropdown();
                end;
            end;
        end);

        Dropdown:BuildDropdownList();
        Dropdown:Display();

        local Defaults = {};

        if type(Info.Default) == 'string' then
            local Idx = table.find(Dropdown.Values, Info.Default);
            if Idx then
                table.insert(Defaults, Idx);
            end;
        elseif type(Info.Default) == 'table' then
            for _, Value in next, Info.Default do
                local Idx = table.find(Dropdown.Values, Value);
                if Idx then
                    table.insert(Defaults, Idx);
                end;
            end;
        elseif type(Info.Default) == 'number' and Dropdown.Values[Info.Default] ~= nil then
            table.insert(Defaults, Info.Default);
        end;

        if next(Defaults) then
            for i = 1, #Defaults do
                local Index = Defaults[i];
                if Info.Multi then
                    Dropdown.Value[Dropdown.Values[Index]] = true;
                else
                    Dropdown.Value = Dropdown.Values[Index];
                end;

                if (not Info.Multi) then break end;
            end;

            Dropdown:BuildDropdownList();
            Dropdown:Display();
        end;

        Groupbox:AddBlank(Info.BlankSize or 5);
        Groupbox:Resize();

        if type(Dropdown)=="table" and Dropdown.SetVisible==nil then Dropdown.SetVisible=function() end end;
        Options[Idx] = Dropdown;
        Dropdown.Outer = DropdownOuter;
        Dropdown.ListOuter = ListOuter;

        Library:UpdateDependencyBoxes();

        return Dropdown;
    end;

    function Funcs:AddDependencyBox()
        local Depbox = {Dependencies = {}};
        local Groupbox = self;
        local Container = Groupbox.Container;
        local Holder = Library:Create('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            Visible = false,
            Parent = Container,
        });
        local Frame = Library:Create('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = true,
            Parent = Holder,
        });
        local Layout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Frame,
        });

        function Depbox:Resize()
            Holder.Size = NewUDim2(1, 0, 0, Layout.AbsoluteContentSize.Y);

            Groupbox:Resize();
        end;

        Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Depbox:Resize();
        end);
        Holder:GetPropertyChangedSignal('Visible'):Connect(function()
            Depbox:Resize();
        end);

        function Depbox:Update()
            for _, Dependency in next, Depbox.Dependencies do
                local Elem = Dependency[1];
                local Expected = Dependency[2];
                local CurrentValue = Elem.Value;

                if CurrentValue == nil then
                    Holder.Visible = false;

                    Depbox:Resize();

                    return
                end;
                if CurrentValue ~= Expected then
                    Holder.Visible = false;

                    Depbox:Resize();

                    return
                end;
            end;

            Holder.Visible = true;

            Depbox:Resize();
        end;
        function Depbox:SetupDependencies(Dependencies)
            for _, Dependency in next, Dependencies do
                assert(type(Dependency) == 'table', 'SetupDependencies: Dependency is not of type `table`.');
                assert(Dependency[1], 'SetupDependencies: Dependency is missing element argument.');
                assert(Dependency[2] ~= nil, 'SetupDependencies: Dependency is missing value argument.');
            end;

            Depbox.Dependencies = Dependencies;

            Depbox:Update();
        end;

        Depbox.Container = Frame;

        setmetatable(Depbox, BaseGroupbox);
        table.insert(Library.DependencyBoxes, Depbox);

        return Depbox;
    end;

    BaseGroupbox.__index = Funcs;
    BaseGroupbox.__namecall = function(Table, Key, ...)
        local Method = rawget(Table, Key) or Funcs[Key];
        return Method(Table, ...);
    end;
end;

function Library:UpdateNotificationArea()
    local area = Library.NotificationArea;
    local layout = Library.NotificationListLayout;
    if not area or not layout then
        return
    end;

    local margin = 12;
    local spot = Library.NotificationSpot or 'Top Right';

    if spot == 'Top Left' then
        area.AnchorPoint = Vector2.new(0, 0);
        area.Position = UDim2.new(0, margin, 0, margin);
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        layout.VerticalAlignment = Enum.VerticalAlignment.Top;
    elseif spot == 'Bottom Right' then
        area.AnchorPoint = Vector2.new(1, 1);
        area.Position = UDim2.new(1, -margin, 1, -margin);
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    elseif spot == 'Bottom Left' then
        area.AnchorPoint = Vector2.new(0, 1);
        area.Position = UDim2.new(0, margin, 1, -margin);
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    elseif spot == 'Center' then
        area.AnchorPoint = Vector2.new(0.5, 0.5);
        area.Position = UDim2.new(0.5, 0, 0.5, 0);
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        layout.VerticalAlignment = Enum.VerticalAlignment.Center;
    else
        area.AnchorPoint = Vector2.new(1, 0);
        area.Position = UDim2.new(1, -margin, 0, margin);
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
        layout.VerticalAlignment = Enum.VerticalAlignment.Top;
    end;
end;

function Library:SetNotificationSpot(Spot)
    Library.NotificationSpot = Spot;
    Library:UpdateNotificationArea();
end;

function Library:SetNotificationAnimation(Animation)
    Library.NotificationAnimation = Animation;
end;

function Library:PlayNotificationEnter(NotifyInner, TotalW)
    local animation = Library.NotificationAnimation or 'Slide Right to Left';
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    NotifyInner.AnchorPoint = Vector2.new(0, 0);
    NotifyInner.Position = UDim2.fromOffset(0, 0);
    NotifyInner.Size = UDim2.new(1, 0, 1, 0);

    if animation == 'Slide Left to Right' then
        NotifyInner.Position = UDim2.fromOffset(-TotalW, 0);
        TweenService:Create(NotifyInner, tweenInfo, {
            Position = UDim2.fromOffset(0, 0),
        }):Play();
    elseif animation == 'Middle Outwards' then
        NotifyInner.AnchorPoint = Vector2.new(0.5, 0.5);
        NotifyInner.Position = UDim2.new(0.5, 0, 0.5, 0);
        NotifyInner.Size = UDim2.new(0, 0, 1, 0);
        TweenService:Create(NotifyInner, tweenInfo, {
            Size = UDim2.new(1, 0, 1, 0),
        }):Play();
    else
        NotifyInner.Position = UDim2.fromOffset(TotalW, 0);
        TweenService:Create(NotifyInner, tweenInfo, {
            Position = UDim2.fromOffset(0, 0),
        }):Play();
    end;
end;

function Library:PlayNotificationExit(NotifyInner, TotalW, Callback)
    local animation = Library.NotificationAnimation or 'Slide Right to Left';
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local tween;

    if animation == 'Slide Left to Right' then
        tween = TweenService:Create(NotifyInner, tweenInfo, {
            Position = UDim2.fromOffset(TotalW, 0),
        });
    elseif animation == 'Middle Outwards' then
        NotifyInner.AnchorPoint = Vector2.new(0.5, 0.5);
        NotifyInner.Position = UDim2.new(0.5, 0, 0.5, 0);
        tween = TweenService:Create(NotifyInner, tweenInfo, {
            Size = UDim2.new(0, 0, 1, 0),
        });
    else
        tween = TweenService:Create(NotifyInner, tweenInfo, {
            Position = UDim2.fromOffset(-TotalW, 0),
        });
    end;

    tween.Completed:Connect(function()
        if Callback then
            Callback();
        end;
    end);
    tween:Play();
end

do
    Library.NotificationArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        AnchorPoint = Vector2.new(1, 0);
        Position = UDim2.new(1, -12, 0, 12);
        Size = UDim2.new(0, 480, 1, -24);
        ZIndex = 100;
        Parent = ScreenGui;
    });

    Library.NotificationListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, 6);
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        HorizontalAlignment = Enum.HorizontalAlignment.Right;
        VerticalAlignment = Enum.VerticalAlignment.Top;
        Parent = Library.NotificationArea;
    });

    Library.NotificationIndex = 0;
    Library:UpdateNotificationArea();

    local WatermarkOuter = Library:Create('Frame', {
        AnchorPoint = Vector2.new(0.5, 0);
        BorderSizePixel = 0;
        Position = UDim2.new(0.5, 0, 0, 15);
        Size = UDim2.new(0, 213, 0, 20);
        ZIndex = 200;
        Visible = false;
        Parent = ScreenGui;
    });

    local WatermarkInner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderSizePixel = 0;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 201;
        Parent = WatermarkOuter;
    });

    Library:AddToRegistry(WatermarkInner, {
        BackgroundColor3 = 'MainColor';
    });

    local InnerFrame = Library:Create('Frame', {
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 202;
        Parent = WatermarkInner;
    });

    local Gradient = Library:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
            ColorSequenceKeypoint.new(1, Library.MainColor),
        });
        Rotation = -90;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(Gradient, {
        Color = function()
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                ColorSequenceKeypoint.new(1, Library.MainColor),
            });
        end
    });

    local AccentLine = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 0, 1);
        ZIndex = 205;
        Parent = InnerFrame;
    });

    Library:AddToRegistry(AccentLine, {
        BackgroundColor3 = 'AccentColor';
    });

    local WatermarkLabel = Library:CreateLabel({
        Position = UDim2.new(0, 5, 0, 0);
        Size = UDim2.new(1, -10, 1, -1);
        TextSize = 14;
        TextXAlignment = Enum.TextXAlignment.Center;
        ZIndex = 203;
        Parent = InnerFrame;
    });

    Library.Watermark = WatermarkOuter;
    Library.WatermarkText = WatermarkLabel;
    Library:MakeDraggable(Library.Watermark);

    local KeybindContainer = Library:Create('Frame', {
        BackgroundTransparency = 1;
        Size = UDim2.new(1, 0, 0, 0);
        Visible = false;
        ZIndex = 200;
        Parent = ScreenGui;
    });

    Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = KeybindContainer;
    });

    Library:Create('UIPadding', {
        PaddingLeft = UDim.new(0, 5),
        Parent = KeybindContainer,
    });

    Library.KeybindContainer = KeybindContainer;
end;

function Library:SetWatermarkVisibility(Bool)
    Library.Watermark.Visible = Bool;
end;

function Library:SetWatermark(Text)
    local rawText = Text or '';
    Library.LastWatermarkText = rawText;

    local X, Y = Library:GetTextBounds(rawText, Library.Font, 14);
    Library.Watermark.Size = UDim2.new(0, X + 16, 0, (Y * 1.5) + 3);
    Library:SetAccentTitle(Library.WatermarkText, rawText, Library.WatermarkAccentPart or '.lol');
end;

getgenv().ZRHUB_wm = getgenv().ZRHUB_wm or { ping = true, executor = false, fps = true, time = true };
task.spawn(function()
    local fps = 60;
    local execName = nil;

    local function getPing()
        local ok, v = pcall(function()
            return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue();
        end);
        if ok and v then return math.floor(v + 0.5) end;
        return 0;
    end;

    local function getExecutor()
        if execName ~= nil then return execName end;
        local fn = identifyexecutor or getexecutorname;
        if fn then
            local ok, name, ver = pcall(fn);
            if ok and name then
                execName = tostring(name);
                if ver and tostring(ver) ~= "" then execName = execName .. " " .. tostring(ver) end;
            else
                execName = "";
            end;
        else
            execName = "";
        end;
        return execName;
    end;

    RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(dt)
        if dt and dt > 0 then
            local instant = 1 / dt;
            fps = fps + (instant - fps) * 0.1;
        end;
    end));

    while task.wait(0.5) do
        if Library.Watermark and Library.Watermark.Visible then
            local wm = getgenv().ZRHUB_wm or {};
            local parts = { "ZRHUB.lol" };
            if wm.fps ~= false then
                parts[#parts + 1] = string.format("%d fps", math.floor(fps + 0.5));
            end;
            if wm.ping ~= false then
                parts[#parts + 1] = string.format("%d ms", getPing());
            end;
            if wm.executor then
                local ex = getExecutor();
                if ex ~= "" then parts[#parts + 1] = ex end;
            end;
            if wm.time ~= false then
                parts[#parts + 1] = os.date("%X");
            end;
            Library:SetWatermark(table.concat(parts, " | "));
        end;
    end;
end);

local SOUND_URLS = {
    Toggle = 'https://raw.githubusercontent.com/xhafodev/UI/main/pop%20UI%20sound.mp3',
    Notification = 'https://raw.githubusercontent.com/xhafodev/UI/main/notify.mp3',
    Slider = 'https://raw.githubusercontent.com/xhafodev/UI/main/slider.mp3',
};

function Library:EnsureSoundFile(Folder, FileName, Url)
    if not writefile or not isfile or not getcustomasset then
        return nil;
    end;

    local Path = Folder .. '/sounds/' .. FileName;
    if not isfile(Path) then
        if not game.HttpGet then
            return nil;
        end;

        local Success, Content = pcall(function()
            return game:HttpGet(Url);
        end);

        if not Success or not Content then
            return nil;
        end;

        writefile(Path, Content);
    end;

    return getcustomasset(Path);
end;

function Library:ApplySoundSettings(Settings)
    self.ToggleSoundEnabled = Settings.ToggleSoundEnabled ~= false;
    self.NotificationSoundEnabled = Settings.NotificationSoundEnabled ~= false;
    self.SliderSoundEnabled = Settings.SliderSoundEnabled ~= false;
    self.ToggleSoundVolume = math.clamp(tonumber(Settings.ToggleSoundVolume) or 1, 0, 1);
    self.ToggleSoundSpeed = math.clamp(tonumber(Settings.ToggleSoundSpeed) or 1, 0.25, 3);
    self.NotificationSoundVolume = math.clamp(tonumber(Settings.NotificationSoundVolume) or 1, 0, 1);
    self.NotificationSoundSpeed = math.clamp(tonumber(Settings.NotificationSoundSpeed) or 1, 0.25, 3);
    self.SliderSoundVolume = math.clamp(tonumber(Settings.SliderSoundVolume) or 1, 0, 1);
    self.SliderSoundSpeed = math.clamp(tonumber(Settings.SliderSoundSpeed) or 1, 0.25, 3);
end;

function Library:SaveSoundSettings()
    if not writefile then
        return;
    end;

    local SettingsPath = (self.SoundSettingsFolder or 'ZRHUB') .. '/settings/sounds.json';
    local Data = {
        ToggleSoundEnabled = self.ToggleSoundEnabled;
        NotificationSoundEnabled = self.NotificationSoundEnabled;
        SliderSoundEnabled = self.SliderSoundEnabled;
        ToggleSoundVolume = self.ToggleSoundVolume;
        ToggleSoundSpeed = self.ToggleSoundSpeed;
        NotificationSoundVolume = self.NotificationSoundVolume;
        NotificationSoundSpeed = self.NotificationSoundSpeed;
        SliderSoundVolume = self.SliderSoundVolume;
        SliderSoundSpeed = self.SliderSoundSpeed;
    };

    local Success, Encoded = pcall(function()
        return HttpService:JSONEncode(Data);
    end);

    if Success then
        writefile(SettingsPath, Encoded);
    end;
end;

function Library:InitSoundSettings(Folder)
    local Defaults = {
        ToggleSoundEnabled = true;
        NotificationSoundEnabled = true;
        SliderSoundEnabled = true;
        ToggleSoundVolume = 1;
        ToggleSoundSpeed = 1;
        NotificationSoundVolume = 1;
        NotificationSoundSpeed = 1;
        SliderSoundVolume = 1;
        SliderSoundSpeed = 1;
    };

    self.SoundSettingsFolder = Folder or 'ZRHUB';
    local SettingsPath = self.SoundSettingsFolder .. '/settings/sounds.json';
    local Settings = Defaults;

    if isfile and readfile and isfile(SettingsPath) then
        local Success, Decoded = pcall(function()
            return HttpService:JSONDecode(readfile(SettingsPath));
        end);

        if Success and type(Decoded) == 'table' then
            for Key, Value in next, Defaults do
                if Decoded[Key] ~= nil then
                    Settings[Key] = Decoded[Key];
                end;
            end;
        end;
    end;

    self:ApplySoundSettings(Settings);

    if not isfile or not isfile(SettingsPath) then
        self:SaveSoundSettings();
    end;

    self:InitSoundAssets();
end;

function Library:InitSoundAssets()
    local Folder = self.SoundSettingsFolder or 'ZRHUB';

    if not self.ToggleSound then
        local ToggleAsset = self:EnsureSoundFile(Folder, 'toggle.mp3', SOUND_URLS.Toggle);
        if ToggleAsset then
            self.ToggleSound = Instance.new('Sound');
            self.ToggleSound.Name = 'ZRHUBToggleSound';
            self.ToggleSound.SoundId = ToggleAsset;
            self.ToggleSound.Volume = self.ToggleSoundVolume;
            self.ToggleSound.PlaybackSpeed = self.ToggleSoundSpeed;
            self.ToggleSound.Parent = SoundService;
        end;
    end;

    if not self.NotificationSound then
        local NotifyAsset = self:EnsureSoundFile(Folder, 'notify.mp3', SOUND_URLS.Notification);
        if NotifyAsset then
            self.NotificationSound = Instance.new('Sound');
            self.NotificationSound.Name = 'ZRHUBNotificationSound';
            self.NotificationSound.SoundId = NotifyAsset;
            self.NotificationSound.Volume = self.NotificationSoundVolume;
            self.NotificationSound.PlaybackSpeed = self.NotificationSoundSpeed;
            self.NotificationSound.Parent = SoundService;
        end;
    end;

    if not self.SliderSound then
        local SliderAsset = self:EnsureSoundFile(Folder, 'slider.mp3', SOUND_URLS.Slider);
        if SliderAsset then
            self.SliderSound = Instance.new('Sound');
            self.SliderSound.Name = 'ZRHUBSliderSound';
            self.SliderSound.SoundId = SliderAsset;
            self.SliderSound.Volume = self.SliderSoundVolume;
            self.SliderSound.PlaybackSpeed = self.SliderSoundSpeed;
            self.SliderSound.Parent = SoundService;
        end;
    end;

    self._SoundAssetsInitialized = true;
end;

function Library:PlaySliderSound()
    if not self.SliderSoundEnabled then
        return
    end;

    self:InitSoundAssets();

    local Sound = self.SliderSound;
    if not Sound then
        return
    end;

    Sound.Volume = self.SliderSoundVolume;
    Sound.PlaybackSpeed = self.SliderSoundSpeed;

    if Sound.IsPlaying then
        Sound:Stop();
    end;

    Sound.TimePosition = 0;
    Sound:Play();
end;

function Library:StopSliderSound()
    local Sound = self.SliderSound;
    if Sound and Sound.IsPlaying then
        Sound:Stop();
    end;
end;

function Library:PlayToggleSound()
    if not self.ToggleSoundEnabled then
        return;
    end;

    self:InitSoundAssets();

    local Sound = self.ToggleSound;
    if not Sound then
        return;
    end;

    Sound.Volume = self.ToggleSoundVolume;
    Sound.PlaybackSpeed = self.ToggleSoundSpeed;

    if Sound.IsPlaying then
        Sound:Stop();
    end;

    Sound.TimePosition = 0;
    Sound:Play();
end;

function Library:PlayNotificationSound()
    if not self.NotificationSoundEnabled then
        return;
    end;

    self:InitSoundAssets();

    local Sound = self.NotificationSound;
    if not Sound then
        return;
    end;

    Sound.Volume = self.NotificationSoundVolume;
    Sound.PlaybackSpeed = self.NotificationSoundSpeed;

    if Sound.IsPlaying then
        Sound:Stop();
    end;

    Sound.TimePosition = 0;
    Sound:Play();
end;

function Library:Notify(Text, Time)
    Library:PlayNotificationSound();

    local Duration = Time or 5;
    local TextSize = 13;
    local BarHeight = 2;
    local PadX = 10;
    local PadY = 6;

    local XSize, YSize = Library:GetTextBounds(Text, Library.Font, TextSize);
    local TotalW = math.ceil(XSize + PadX * 2 + 20);
    local TotalH = math.ceil(YSize + PadY * 2 + BarHeight + 4);

    Library.NotificationIndex = (Library.NotificationIndex or 0) + 1;

    local NotifyOuter = Library:Create('Frame', {
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = true;
        LayoutOrder = Library.NotificationIndex;
        Size = UDim2.fromOffset(TotalW, TotalH);
        ZIndex = 100;
        Parent = Library.NotificationArea;
    });

    local NotifyInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        BorderMode = Enum.BorderMode.Inset;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 101;
        Parent = NotifyOuter;
    });

    Library:AddToRegistry(NotifyInner, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    }, true);

    local function ApplySize(width, height)
        TotalW = width;
        TotalH = height;
        NotifyOuter.Size = UDim2.fromOffset(TotalW, TotalH);
    end;

    Library:PlayNotificationEnter(NotifyInner, TotalW);

    local NotifyLabel = Library:CreateLabel({
        Position = UDim2.new(0, PadX, 0, PadY);
        Size = UDim2.new(1, -PadX * 2, 1, -(PadY * 2 + BarHeight));
        Text = Text;
        RichText = true;
        TextSize = TextSize;
        TextWrapped = false;
        TextTruncate = Enum.TextTruncate.None;
        TextXAlignment = Enum.TextXAlignment.Left;
        TextYAlignment = Enum.TextYAlignment.Top;
        ZIndex = 103;
        Parent = NotifyInner;
    });

    Library:AddToRegistry(NotifyLabel, {
        TextColor3 = 'FontColor';
    }, true);

    task.defer(function()
        if not NotifyLabel.Parent then
            return
        end;

        local measuredW = NotifyLabel.TextBounds.X + PadX * 2 + 16;
        local measuredH = math.max(NotifyLabel.TextBounds.Y + PadY * 2 + BarHeight + 4, TotalH);
        if measuredW > TotalW then
            ApplySize(math.ceil(measuredW), measuredH);
        end;
    end);

    local ProgressBar = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 1, -BarHeight);
        Size = UDim2.new(1, 0, 0, BarHeight);
        ZIndex = 104;
        Parent = NotifyInner;
    });

    Library:AddToRegistry(ProgressBar, {
        BackgroundColor3 = 'AccentColor';
    }, true);

    TweenService:Create(ProgressBar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, BarHeight);
    }):Play();

    task.spawn(function()
        task.wait(Duration);

        Library:PlayNotificationExit(NotifyInner, TotalW, function()
            NotifyOuter:Destroy();
        end);
    end);
end;

function Library:CreateWindow(...)
    local Arguments = { ... };
    local Config = { AnchorPoint = Vector2.zero };

    if type(...) == 'table' then
        Config = ...;
    else
        Config.Title = Arguments[1];
        Config.AutoShow = Arguments[2] or false;
    end;

    if type(Config.Title) ~= 'string' then Config.Title = 'No title' end;
    if type(Config.TabPadding) ~= 'number' then Config.TabPadding = 10 end;
    if type(Config.MenuFadeTime) ~= 'number' then Config.MenuFadeTime = 0.2 end;

    if typeof(Config.Position) ~= 'UDim2' then Config.Position = UDim2.fromOffset(175, 50) end;
    if typeof(Config.Size) ~= 'UDim2' then Config.Size = UDim2.fromOffset(460, 400) end

    do
        local saved = getgenv().ZRHUB_ui_size;
        if not saved then
            pcall(function()
                if isfile and isfile('ZRHUB/ui_size.txt') then
                    local d = tostring(readfile('ZRHUB/ui_size.txt'));
                    local x, y = d:match('(%d+),(%d+)');
                    if x and y then saved = { tonumber(x), tonumber(y) } end;
                end;
            end);
        end;
        if type(saved) == 'table' and tonumber(saved[1]) and tonumber(saved[2]) then
            Config.Size = UDim2.fromOffset(tonumber(saved[1]), tonumber(saved[2]));
        end;
    end;

    if Config.Center then
        Config.AnchorPoint = Vector2.new(0.5, 0.5);
        Config.Position = UDim2.fromScale(0.5, 0.5);
    end;

    local Window = {
        Tabs = {};
    };

    Library.OverlayZIndexBase = nil;

    local Outer = Library:Create('Frame', {
        AnchorPoint = Config.AnchorPoint,
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        ClipsDescendants = false;
        Position = Config.Position,
        Size = Config.Size,
        Visible = false;
        ZIndex = 1;
        Parent = ScreenGui;
    });

    Window.Outer = Outer;
    Library.MainWindow = Window;

    Library:MakeDraggable(Outer, 25);

    local Inner = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderSizePixel = 0;
        ClipsDescendants = false;
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = Outer;
    });

    Library:AddToRegistry(Inner, {
        BackgroundColor3 = 'MainColor';
    });

    do
        local UIS = game:GetService('UserInputService');
        local MINW, MINH = 340, 300;
        Library.MainWindowOuter = Outer;
        local function persistSize()
            local s = Outer.AbsoluteSize;
            getgenv().ZRHUB_ui_size = { math.floor(s.X), math.floor(s.Y) };
            pcall(function()
                if writefile then
                    if makefolder and isfolder and not isfolder('ZRHUB') then makefolder('ZRHUB') end;
                    writefile('ZRHUB/ui_size.txt', math.floor(s.X) .. ',' .. math.floor(s.Y));
                end;
            end);
        end;
        function Library:GetWindowSize()
            local s = Outer.AbsoluteSize;
            return math.floor(s.X), math.floor(s.Y);
        end;
        function Library:SetWindowSize(x, y)
            x, y = tonumber(x), tonumber(y);
            if not (x and y) then return end;
            Outer.Size = UDim2.fromOffset(math.max(MINW, x), math.max(MINH, y));
            persistSize();
        end;

        local Handle = Library:Create('TextButton', {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -3, 1, -3),
            Size = UDim2.fromOffset(20, 20),
            BackgroundTransparency = 1,
            Text = '',
            AutoButtonColor = false,
            ZIndex = 60,
            Parent = Outer,
        });
        for i = 1, 3 do
            local grip = Library:Create('Frame', {
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.new(1, 0, 1, -(i - 1) * 4),
                Size = UDim2.fromOffset(4 + (i - 1) * 5, 2),
                BackgroundColor3 = Library.AccentColor,
                BorderSizePixel = 0,
                ZIndex = 61,
                Parent = Handle,
            });
            Library:AddToRegistry(grip, { BackgroundColor3 = 'AccentColor' });
        end;

        local resizing, startPos, startSize = false, nil, nil;
        Handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                resizing = true;
                startPos = UIS:GetMouseLocation();
                startSize = Outer.AbsoluteSize;
            end;
        end);
        Library:GiveSignal(UIS.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(input)
            if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local cur = UIS:GetMouseLocation();
                local w = math.max(MINW, startSize.X + (cur.X - startPos.X));
                local h = math.max(MINH, startSize.Y + (cur.Y - startPos.Y));
                Outer.Size = UDim2.fromOffset(w, h);
            end;
        end)));
        Library:GiveSignal(UIS.InputEnded:Connect(function(input)
            if resizing and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                resizing = false;
                persistSize();
            end;
        end));
    end;

    Window.ZIndexBase = 10;
    Window.GlowLayers = Library:CreateOverlayGlowLayers(Inner, 1);

    local AnimatedTopBar = Library:Create('Frame', {
        BackgroundColor3 = Library.AccentColor;
        BorderSizePixel = 0;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 0, 2);
        ZIndex = 5;
        Parent = Inner;
    });

    Library:AddToRegistry(AnimatedTopBar, {
        BackgroundColor3 = 'AccentColor';
    });

    local WindowLabel = Library:CreateLabel({
        Position = UDim2.new(0, 8, 0, 4);
        Size = UDim2.new(1, -16, 0, 22);
        Text = "";
        TextSize = 15;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 6;
        Parent = Inner;
    });

    local AccentPart = Config.AccentPart or '.lol';

    local function UpdateTitle()
        local rawTitle = Config.Title or "ZRHUB.lol";
        Library:SetAccentTitle(WindowLabel, rawTitle, AccentPart);
    end;

    Library.UpdateTitle = UpdateTitle;
    UpdateTitle();

    local MainSectionOuter = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Library.OutlineColor;
        ClipsDescendants = true;
        Position = UDim2.new(0, 8, 0, 30);
        Size = UDim2.new(1, -16, 1, -52);
        ZIndex = 1;
        Parent = Inner;
    });

    Library:AddToRegistry(MainSectionOuter, {
        BackgroundColor3 = 'BackgroundColor';
        BorderColor3 = 'OutlineColor';
    });

    local MainSectionInner = Library:Create('Frame', {
        BackgroundColor3 = Library.BackgroundColor;
        BorderColor3 = Color3.new(0, 0, 0);
        BorderMode = Enum.BorderMode.Inset;
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.new(1, 0, 1, 0);
        ZIndex = 1;
        Parent = MainSectionOuter;
    });

    Library:AddToRegistry(MainSectionInner, {
        BackgroundColor3 = 'BackgroundColor';
    });

    local TabArea = Library:Create('Frame', {
        BackgroundTransparency = 1;
        ClipsDescendants = false;
        Position = UDim2.new(0, 12, 0, 6);
        Size = UDim2.new(1, -24, 0, 22);
        ZIndex = 1;
        Parent = MainSectionInner;
    });

    Window.TabArea = TabArea;
    Window.TabPadding = Config.TabPadding;
    Window.TabEntries = {};
    Window.TabTextSize = 16;

    local TabListLayout = Library:Create('UIListLayout', {
        Padding = UDim.new(0, Config.TabPadding);
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
        Parent = TabArea;
    });

    Window.TabListLayout = TabListLayout;

    function Window:UpdateTabLayout()
        if not self.TabArea or not self.TabEntries then
            return
        end;

        local Count = #self.TabEntries;
        if Count == 0 then
            return
        end;

        local AreaWidth = self.TabArea.AbsoluteSize.X;
        if AreaWidth <= 0 then
            return
        end;

        local Padding = self.TabPadding or 10;
        local SidePadding = 12;
        local BaseTextSize = self.TabTextSize or 16;
        local MinTextSize = 11;

        local TotalPadding = Padding * (Count - 1);
        local EqualWidth = math.max(24, math.floor((AreaWidth - TotalPadding) / Count));
        local AvailableTextWidth = EqualWidth - SidePadding * 2;

        local function LongestTextWidth(Size)
            local Longest = 0;
            for _, Entry in self.TabEntries do
                local Width = select(1, Library:GetTextBounds(Entry.Name, Library.Font, Size));
                Longest = math.max(Longest, Width);
            end;
            return Longest;
        end;

        local TextSize = BaseTextSize;
        if LongestTextWidth(TextSize) > AvailableTextWidth then
            for Size = BaseTextSize, MinTextSize, -1 do
                TextSize = Size;
                if LongestTextWidth(Size) <= AvailableTextWidth then
                    break;
                end;
            end;
        end;

        for _, Entry in self.TabEntries do
            Entry.Label.TextSize = TextSize;
            Entry.Button.Size = UDim2.new(0, EqualWidth, 1, 0);
        end;
    end;

    TabArea:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
        Window:UpdateTabLayout();
    end);

    local TabContainer = Library:Create('Frame', {
        BackgroundColor3 = Library.MainColor;
        BorderColor3 = Library.OutlineColor;
        ClipsDescendants = true;
        Position = UDim2.new(0, 8, 0, 32);
        Size = UDim2.new(1, -16, 1, -40);
        ZIndex = 3;
        Parent = MainSectionInner;
    });

    local placeName = 'Baseplate';
    pcall(function()
        placeName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name;
    end);

    Library.PlaceName = placeName;
    Library.AnonymousMode = false;

    local FooterLeft = Library:CreateLabel({
        Position = UDim2.new(0, 10, 1, -18);
        Size = UDim2.new(0.5, -10, 0, 14);
        Text = '';
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Left;
        ZIndex = 6;
        Parent = Inner;
    });

    local FooterRight = Library:CreateLabel({
        Position = UDim2.new(0.5, 0, 1, -18);
        Size = UDim2.new(0.5, -10, 0, 14);
        Text = '';
        TextSize = 12;
        TextXAlignment = Enum.TextXAlignment.Right;
        ZIndex = 6;
        Parent = Inner;
    });

    Library.FooterLeft = FooterLeft;
    Library.FooterRight = FooterRight;
    Library:UpdateFooter();

    Library:AddToRegistry(TabContainer, {
        BackgroundColor3 = 'MainColor';
        BorderColor3 = 'OutlineColor';
    });

    function Window:SetWindowTitle(Title, NewAccentPart)
        Config.Title = Title;
        if NewAccentPart then
            Config.AccentPart = NewAccentPart;
            AccentPart = NewAccentPart;
        end;
        UpdateTitle();
    end;

    function Window:AddTab(Name)
        local Tab = {
            Groupboxes = {};
            Tabboxes = {};
        };

        local defaultLayoutOrder = 100;
        if Name == 'Main' then
            defaultLayoutOrder = 1;
        elseif Name == 'Misc' then
            defaultLayoutOrder = 500;
        elseif Name:lower():find('setting') then
            defaultLayoutOrder = 1000;
        end;

        local TabButton = Library:Create('TextButton', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            AutoButtonColor = false;
            Size = UDim2.new(0, 0, 1, 0);
            Text = '';
            ZIndex = 2;
            LayoutOrder = defaultLayoutOrder;
            Parent = TabArea;
        });

        local TabButtonLabel = Library:CreateLabel({
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Text = Name;
            TextSize = Window.TabTextSize or 16;
            TextColor3 = Color3.new(1, 1, 1);
            TextTransparency = 0.35;
            ZIndex = 3;
            Parent = TabButton;
        });

        Tab.TabButton = TabButton;
        Tab.TabButtonLabel = TabButtonLabel;
        Tab.Name = Name;

        table.insert(Window.TabEntries, {
            Name = Name;
            Button = TabButton;
            Label = TabButtonLabel;
        });

        task.defer(function()
            Window:UpdateTabLayout();
        end);

        local TabGlow, TabUnderline = Library:CreateTabBottomGlow(TabButton, {
            GlowHeight = 18;
            LineHeight = 2;
            ZIndex = 1;
        });

        Tab.TabGlow = TabGlow;
        Tab.TabUnderline = TabUnderline;

        local TabFrame = Library:Create('Frame', {
            Name = 'TabFrame',
            BackgroundTransparency = 1;
            Position = UDim2.new(0, 0, 0, 0);
            Size = UDim2.new(1, 0, 1, 0);
            Visible = false;
            ZIndex = 4;
            Parent = TabContainer;
        });

        local LeftSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            ClipsDescendants = true;
            Position = UDim2.new(0, 8 - 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 1, -16);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 3;
            ScrollBarImageColor3 = Library.AccentColor;
            ZIndex = 5;
            Parent = TabFrame;
        });

        local RightSide = Library:Create('ScrollingFrame', {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            ClipsDescendants = true;
            Position = UDim2.new(0.5, 4 + 1, 0, 8 - 1);
            Size = UDim2.new(0.5, -12 + 2, 1, -16);
            CanvasSize = UDim2.new(0, 0, 0, 0);
            BottomImage = '';
            TopImage = '';
            ScrollBarThickness = 3;
            ScrollBarImageColor3 = Library.AccentColor;
            ZIndex = 5;
            Parent = TabFrame;
        });

        Library:AddToRegistry(LeftSide, { ScrollBarImageColor3 = 'AccentColor' });
        Library:AddToRegistry(RightSide, { ScrollBarImageColor3 = 'AccentColor' });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = LeftSide;
        });

        Library:Create('UIListLayout', {
            Padding = UDim.new(0, 8);
            FillDirection = Enum.FillDirection.Vertical;
            SortOrder = Enum.SortOrder.LayoutOrder;
            HorizontalAlignment = Enum.HorizontalAlignment.Center;
            Parent = RightSide;
        });

        for _, Side in next, { LeftSide, RightSide } do
            Side:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                Side.CanvasSize = UDim2.fromOffset(0, Side.UIListLayout.AbsoluteContentSize.Y + 8);
            end);
        end;

        function Tab:ShowTab()
            for _, Tab in next, Window.Tabs do
                Tab:HideTab();
            end;

            Library:SetTabGlowVisible(TabGlow, TabUnderline, true);
            TabButtonLabel.TextTransparency = 0;
            TabFrame.Visible = true;

            for _, Groupbox in next, Tab.Groupboxes do
                if Groupbox.Resize then
                    Groupbox:Resize();
                end;
            end;
        end;

        function Tab:HideTab()
            Library:SetTabGlowVisible(TabGlow, TabUnderline, false);
            TabButtonLabel.TextTransparency = 0.35;
            TabFrame.Visible = false;
        end;

        function Tab:SetLayoutOrder(Position)
            TabButton.LayoutOrder = Position;
            TabListLayout:ApplyLayout();
        end;

        function Tab:AddGroupbox(Info)
            local Groupbox = {};
            local PreviousOverlayBase = Library.OverlayZIndexBase;
            Library.OverlayZIndexBase = nil;

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 507 + 2);
                ZIndex = 6;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 7;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local Highlight = Library:Create('Frame', {
                BackgroundColor3 = Library.AccentColor;
                BorderSizePixel = 0;
                Size = UDim2.new(1, 0, 0, 2);
                ZIndex = 8;
                Parent = BoxInner;
            });

            Library:AddToRegistry(Highlight, {
                BackgroundColor3 = 'AccentColor';
            });

            local GroupboxLabel = Library:CreateLabel({
                Size = UDim2.new(1, 0, 0, 18);
                Position = UDim2.new(0, 4, 0, 2);
                TextSize = 14;
                Text = Info.Name;
                TextXAlignment = Enum.TextXAlignment.Left;
                ZIndex = 9;
                Parent = BoxInner;
            });

            local Container = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 6, 0, 20);
                Size = UDim2.new(1, -8, 1, -20);
                ZIndex = 10;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = Container;
            });

            local ListLayout = Container:FindFirstChildOfClass('UIListLayout');

            function Groupbox:Resize()
                local Size = 0;
                local SumSize = 0;
                local ChildCount = 0;

                for _, Element in next, Groupbox.Container:GetChildren() do
                    if (not Element:IsA('UIListLayout')) and Element.Visible then
                        ChildCount += 1;
                        SumSize += Element.Size.Y.Offset;
                    end;
                end;

                if ListLayout and ChildCount > 1 then
                    SumSize += ListLayout.Padding.Offset * (ChildCount - 1);
                end;

                if ListLayout then
                    Size = ListLayout.AbsoluteContentSize.Y;
                end;

                Size = math.max(Size, SumSize);

                BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 4);
            end;

            if ListLayout then
                ListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                    Groupbox:Resize();
                end);
            end;

            Groupbox.Container = Container;
            Groupbox.ContentBaseZIndex = 10;
            setmetatable(Groupbox, BaseGroupbox);

            Groupbox:AddBlank(3);
            Groupbox:Resize();

            Tab.Groupboxes[Info.Name] = Groupbox;

            Library.OverlayZIndexBase = PreviousOverlayBase;
            return Groupbox;
        end;

        function Tab:AddLeftGroupbox(Name)
            return Tab:AddGroupbox({ Side = 1; Name = Name; });
        end;

        function Tab:AddRightGroupbox(Name)
            return Tab:AddGroupbox({ Side = 2; Name = Name; });
        end;

        function Tab:AddTabbox(Info)
            local Tabbox = {
                Tabs = {};
            };

            local BoxOuter = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Library.OutlineColor;
                BorderMode = Enum.BorderMode.Inset;
                Size = UDim2.new(1, 0, 0, 0);
                ZIndex = 6;
                Parent = Info.Side == 1 and LeftSide or RightSide;
            });

            Library:AddToRegistry(BoxOuter, {
                BackgroundColor3 = 'BackgroundColor';
                BorderColor3 = 'OutlineColor';
            });

            local BoxInner = Library:Create('Frame', {
                BackgroundColor3 = Library.BackgroundColor;
                BorderColor3 = Color3.new(0, 0, 0);
                Size = UDim2.new(1, -2, 1, -2);
                Position = UDim2.new(0, 1, 0, 1);
                ZIndex = 7;
                Parent = BoxOuter;
            });

            Library:AddToRegistry(BoxInner, {
                BackgroundColor3 = 'BackgroundColor';
            });

            local TabboxButtons = Library:Create('Frame', {
                BackgroundTransparency = 1;
                Position = UDim2.new(0, 0, 0, 0);
                Size = UDim2.new(1, 0, 0, 18);
                ZIndex = 8;
                Parent = BoxInner;
            });

            Library:Create('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal;
                HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SortOrder = Enum.SortOrder.LayoutOrder;
                Parent = TabboxButtons;
            });

            function Tabbox:AddTab(Name)
                local Tab = {};

                local Button = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Color3.new(0, 0, 0);
                    Size = UDim2.new(0.5, 0, 1, 0);
                    ZIndex = 6;
                    Parent = TabboxButtons;
                });

                Library:AddToRegistry(Button, {
                    BackgroundColor3 = 'MainColor';
                });

                local ButtonLabel = Library:CreateLabel({
                    Size = UDim2.new(1, 0, 1, 0);
                    TextSize = 14;
                    Text = Name;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 7;
                    Parent = Button;
                });

                local Block = Library:Create('Frame', {
                    BackgroundColor3 = Library.BackgroundColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 1);
                    Visible = false;
                    ZIndex = 9;
                    Parent = Button;
                });

                Library:AddToRegistry(Block, {
                    BackgroundColor3 = 'BackgroundColor';
                });

                local Container = Library:Create('Frame', {
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0, 6, 0, 20);
                    Size = UDim2.new(1, -8, 1, -20);
                    ZIndex = 10;
                    Visible = false;
                    Parent = BoxInner;
                });

                local TabUnderline = Library:Create('Frame', {
                    BackgroundColor3 = Library.AccentColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 0, 0, 0);
                    Size = UDim2.new(1, 0, 0, 2);
                    Visible = false;
                    ZIndex = 10;
                    Parent = Button;
                });

                Library:AddToRegistry(TabUnderline, {
                    BackgroundColor3 = 'AccentColor';
                });

                Library:Create('UIListLayout', {
                    FillDirection = Enum.FillDirection.Vertical;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    Parent = Container;
                });

                function Tab:Show()
                    for _, Tab in next, Tabbox.Tabs do
                        Tab:Hide();
                    end;

                    Container.Visible = true;
                    Block.Visible = true;
                    TabUnderline.Visible = true;

                    Button.BackgroundColor3 = Library.BackgroundColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'BackgroundColor';

                    Tab:Resize();
                end;

                function Tab:Hide()
                    Container.Visible = false;
                    Block.Visible = false;
                    TabUnderline.Visible = false;

                    Button.BackgroundColor3 = Library.MainColor;
                    Library.RegistryMap[Button].Properties.BackgroundColor3 = 'MainColor';
                end;

                function Tab:Resize()
                    local TabCount = 0;

                    for _, Tab in next, Tabbox.Tabs do
                        TabCount = TabCount + 1;
                    end;

                    for _, Button in next, TabboxButtons:GetChildren() do
                        if not Button:IsA('UIListLayout') then
                            Button.Size = UDim2.new(1 / TabCount, 0, 1, 0);
                        end;
                    end;

                    if (not Container.Visible) then
                        return;
                    end;

                    local Size = 0;

                    for _, Element in next, Tab.Container:GetChildren() do
                        if (not Element:IsA('UIListLayout')) and Element.Visible then
                            Size = Size + Element.Size.Y.Offset;
                        end;
                    end;

                    BoxOuter.Size = UDim2.new(1, 0, 0, 20 + Size + 2 + 2);
                end;

                Button.InputBegan:Connect(function(Input)
                    if IsPrimaryPress(Input) and not Library:MouseIsOverOpenedFrame() then
                        Tab:Show();
                        Tab:Resize();
                    end;
                end);

                Tab.Container = Container;
                Tabbox.Tabs[Name] = Tab;

                setmetatable(Tab, BaseGroupbox);
                Tab.ContentBaseZIndex = 10;

                Tab:AddBlank(3);
                Tab:Resize();

                if #TabboxButtons:GetChildren() == 2 then
                    Tab:Show();
                end;

                return Tab;
            end;

            Tab.Tabboxes[Info.Name or ''] = Tabbox;

            return Tabbox;
        end;

        function Tab:AddLeftTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 1; });
        end;

        function Tab:AddRightTabbox(Name)
            return Tab:AddTabbox({ Name = Name, Side = 2; });
        end;

        TabButton.MouseButton1Click:Connect(function()
            Tab:ShowTab();
        end);

        if #TabContainer:GetChildren() == 1 then
            Tab:ShowTab();
        end;

        Window.Tabs[Name] = Tab;
        return Tab;
    end;

    local ModalElement = Library:Create('TextButton', {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 0, 0, 0);
        Visible = true;
        Text = '';
        Modal = false;
        Parent = ScreenGui;
    });

    local TransparencyCache = {};
    local Toggled = false;

    function Library:Toggle()
        Toggled = not Toggled;

        Library.MenuOpen = Toggled;
        ModalElement.Modal = Toggled;

        Outer.Visible = Toggled;

        Library:SyncOverlaysWithMenu(Toggled);
        Library:UpdateMenuBlur();
        Library:UpdateOverlayGlow(Library.MainWindow);

        if Library.OnToggle then
            task.spawn(Library.OnToggle, Toggled);
        end;
    end;

    Library.MenuBindPickers = Library.MenuBindPickers or {};

    Library:GiveSignal(InputService.InputBegan:Connect(function(Input, Processed)
        local pressed;
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            pressed = Input.KeyCode.Name;
        elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressed = 'MB1';
        elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressed = 'MB2';
        end;

        if not pressed then
            return
        end;

        local pickers = Library.MenuBindPickers or {};
        local bound = false;
        for _, picker in eli_ipairs(pickers) do
            if picker and picker.Value and picker.Value ~= 'None' then
                bound = true;
                if picker.Value == pressed then
                    task.spawn(Library.Toggle);
                    return
                end;
            end;
        end;

        if not bound and Input.KeyCode == Enum.KeyCode.RightShift then
            task.spawn(Library.Toggle);
        end;
    end));

    if Config.AutoShow then
        task.spawn(function()
            Library:Toggle();
            Library:UpdateMenuBlur();
        end);
    end;

    Window.Holder = Outer;

    return Window;
end;

local function OnPlayerChange()
    local PlayerList = GetPlayersString();

    for _, Value in next, Options do
        if Value.Type == 'Dropdown' and Value.SpecialType == 'Player' then
            Value:SetValues(PlayerList);
        end;
    end;
end;

Players.PlayerAdded:Connect(OnPlayerChange);
Players.PlayerRemoving:Connect(OnPlayerChange);

Library.Toggles = Toggles;
Library.Options = Options;

getgenv().Library = Library;

return Library;
end)();
-- ================= Obsidian UI =================
local ObsidianRepo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/";
local ZR_Red = (function()
if getgenv().Library and type(getgenv().Library) == "table" and type(getgenv().Library.Exit) == "function" then
    pcall(function() getgenv().Library:Exit() end)
end

cloneref = cloneref or function(...) return ... end
local __zrfs = {}
isfolder = isfolder or function() return false end
makefolder = makefolder or function() end
isfile = isfile or function(p) return __zrfs[p] ~= nil end
writefile = writefile or function(p, c) __zrfs[p] = c end
readfile = readfile or function(p) return __zrfs[p] or "" end
delfile = delfile or function(p) __zrfs[p] = nil end
listfiles = listfiles or function() return {} end


local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local CoreGui = cloneref(game:GetService("CoreGui"))

gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer
local IsMobile = UserInputService.TouchEnabled or false
local GuiInset = GuiService:GetGuiInset().Y
local Mouse = cloneref(LocalPlayer:GetMouse())

local Library = { 
    Flags = { },
    MenuKeybind = tostring(Enum.KeyCode.X), -- has to be a string

    Directory = "ZRHUB_UI",
    Folders = {
        Assets = "/Assets",
        Configs = "/Configs",
        Themes = "/Themes"
    },

    FontSize = 12,

    Animation = {
        Time = 0.3,
        Style = "Quint",
        Direction = "Out"
    },

    TabAnimation = {
        Time = 1,
        Style = "Exponential",
        Direction = "Out"
    },

    ColorpickerAnimation = {
        Time = 0.55,
        Style = "Exponential",
        Direction = "Out"
    },

    NotifAnimation = {
        Time = 0.85,
        Style = "Exponential",
        Direction = "Out"
    },

    ZIndexOrder = {
        ["OptionHolder"] = 4,
        ["KeybindWindow"] = 4, -- burp
        ["ColorpickerWindow"] = 6
    },

    -- Ignore below
    Threads = { },
    Connections = { },
    SetFlags = { },

    ThemingStuff = { },
    ThemeMap = { },

    OpenFrames = { },

    Holder = nil,
    UnusedHolder = nil,

    Font = nil,

    Notifications = { },
    KeyList = nil,

    Theme = nil,
} do 
    Library.__index = Library

    local Flags = Library.Flags 
    local SetFlags = Library.SetFlags

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    -- Folders
    if not isfolder(Library.Directory) then 
        makefolder(Library.Directory)
    end

    for _, Folder in Library.Folders do 
        if not isfolder(Library.Directory .. Folder) then 
            makefolder(Library.Directory .. Folder)
        end
    end



    local Themes = {
        ["Preset"] = {
            ["Border"] = Color3.fromRGB(2, 0, 0),
            ["Outline"] = Color3.fromRGB(46, 16, 19),
            ["Background"] = Color3.fromRGB(11, 7, 8),
            ["Inline"] = Color3.fromRGB(18, 11, 12),
            ["Accent"] = Color3.fromRGB(225, 29, 46),
            ["Text"] = Color3.fromRGB(236, 226, 227),
            ["Inactive Text"] = Color3.fromRGB(138, 112, 115),
            ["Element"] = Color3.fromRGB(34, 19, 21),
            ["Element 2"] = Color3.fromRGB(56, 26, 30),
            ["Hovered Element"] = Color3.fromRGB(68, 30, 35)
        }
    }

    Library.Theme = Themes.Preset

    -- Custom Font
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`))
        end

        local ok, font = pcall(function()
            return CustomFont:New("TahomaXP", 400, "Regular", {
                Id = Library.Directory .. Library.Folders.Assets .. "/TahomaXP.ttf",
                Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/windows-xp-tahoma.ttf"
            })
        end)
        Library.Font = ok and font or Font.fromEnum(Enum.Font.Arial)
    end

    -- icons: the same lucide icon pack Obsidian uses
    do
        local okIcons, Icons = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua"))()
        end)
        Library.GetIcon = function(Self, Name)
            if not okIcons or type(Icons) ~= "table" or type(Name) ~= "string" then return nil end
            local ok, Icon = pcall(Icons.GetAsset, Name)
            if ok and type(Icon) == "table" and (Icon.Url or Icon.Id) then return Icon end
            return nil
        end
    end

    Library.Exit = function(Self)
        for _, Connection in Library.Connections do 
            Connection:Disconnect()
        end

        for _, Thread in Library.Threads do 
            coroutine.close(Thread)
        end

        if Self.Holder then 
            Self.Holder.Instance:Destroy()
        end

        if Self.UnusedHolder then 
            Self.UnusedHolder.Instance:Destroy()
        end

        for Index, Value in Library.Notifications do 
            Value.Items.Notification.Instance:Destroy()
        end

        if Self.NotifHolder then 
            Self.NotifHolder.Instance:Destroy()
        end

        Library = nil
        getgenv().Library = nil
    end

    Library.Create = function(Self, Class, Properties)
        local Data = {
            Class = Class,
            Properties = Properties,
            Instance = Instance.new(Class)
        }

        for Index, Property in Properties do 
            if Property == "FontFace" then
                Data.Instance[Property] = Library.Font
                continue
            end

            if Property == "TextSize" then 
                Data.Instance[Property] = Library.FontSize
                continue
            end

            if Property == "Name" then 
                Data.Instance[Property] = "\0"
                continue
            end

            if Class == "TextButton" then 
                if Property == "AutoButtonColor" then 
                    Data.Instance[Property] = false
                    continue
                end

                if Property == "Text" then 
                    Data.Instance[Property] = ""
                    continue
                end
            end

            Data.Instance[Index] = Property
        end

        return setmetatable(Data, Library)
    end

    Library.Thread = function(Self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        table.insert(Library.Threads, NewThread)
        return NewThread
    end

    Library.Connect = function(Self, Signal, Callback)
        local Connection

        if Self.Instance then
            if Self.Instance[Signal] then 
                if IsMobile and Signal == "MouseButton1Down" then 
                    Connection = Self.Instance.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Callback(Input)
                        end
                    end)

                    return
                end
                
                Connection = Self.Instance[Signal]:Connect(Callback)
            else
                Connection = Signal:Connect(Callback)
            end
        else
            Connection = Signal:Connect(Callback)
        end

        table.insert(Library.Connections, Connection)
        return Connection
    end

    Library.Tween = function(Self, Properties, Info, IsRawItem)
        if not Library then return end 

        local Object = Self.Instance or IsRawItem
        Info = Info or TweenInfo.new(Library.Animation.Time, Enum.EasingStyle[Library.Animation.Style], Enum.EasingDirection[Library.Animation.Direction])

        if not Object then 
            return 
        end

        local NewTween = TweenService:Create(Object, Info, Properties)
        NewTween:Play()

        return NewTween
    end

    Library.GetTweenProperty = function(Self, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return { }
        end

        if Object:IsA("Frame") then
            return { "BackgroundTransparency" }
        elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
            return { "BackgroundTransparency", "ImageTransparency" }
        elseif Object:IsA("ScrollingFrame") then
            return { "BackgroundTransparency", "ScrollBarImageTransparency" }
        elseif Object:IsA("TextBox") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("UIStroke") then 
            return { "Transparency" }
        end
    end

    Library.Fade = function(Self, Property, Visibility, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return 
        end

        local OldTransparency = Object[Property]
        Object[Property] = Visibility and 1 or OldTransparency

        local NewTween = Library:Tween({[Property] = Visibility and OldTransparency or 1}, nil, Object)

        Library:Connect(NewTween.Completed, function()
            if not Visibility then 
                task.wait()
                Object[Property] = OldTransparency
            end
        end)

        return NewTween
    end

    Library.FadeDescendants = function(Self, Visibility, Callback)
        if Visibility then 
            Self.Instance.Visible = true 
        end

        local NewTween 

        local Children = Self.Instance:GetDescendants()
        table.insert(Children, Self.Instance)

        for _, Child in Children do 
            local TransparencyProperty = Library:GetTweenProperty(Child)

            if not TransparencyProperty then 
                continue 
            end

            if type(TransparencyProperty) == "table" then
                for _, Property in TransparencyProperty do
                    NewTween = Library:Fade(Property, Visibility, Child)
                end
            else
                NewTween = Library:Fade(TransparencyProperty, Visibility, Child)
            end
        end

        Library:Connect(NewTween.Completed, function()
            if Callback and type(Callback) == "function" then 
                Callback()
            end

            Self.Instance.Visible = Visibility
        end)
    end

    Library.MakeDraggable = function(Self)
        if not Self.Instance then 
            return
        end
    
        local Gui = Self.Instance
        local Dragging = false 
        local DragStart
        local StartPosition 
        Self.__CanLock = true
    
        local Set = function(Input)
            local Scale = Library:GetScreenScale()
            local DragDelta = (Input.Position - DragStart) / Scale
            
            local NewX = StartPosition.X.Offset + DragDelta.X
            local NewY = StartPosition.Y.Offset + DragDelta.Y

            local ScreenSize = Gui.Parent.AbsoluteSize / Scale
            local GuiSize = Gui.AbsoluteSize / Scale
            
            NewX = math.clamp(NewX, 0, ScreenSize.X - GuiSize.X)
            NewY = math.clamp(NewY, 0, ScreenSize.Y - GuiSize.Y)
    
            Self:Tween({Position = UDim2.new(0, NewX, 0, NewY)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
        end
    
        local InputChanged
    
        Self:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Library.DragLocked then return end
                Dragging = true
                DragStart = Input.Position
                StartPosition = Gui.Position
    
                if InputChanged then 
                    return
                end
    
                InputChanged = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        InputChanged:Disconnect()
                        InputChanged = nil
                    end
                end)
            end
        end)
    
        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Dragging then
                    Set(Input)
                end
            end
        end)
    
        return Dragging
    end

    Library.MakeResizeable = function(Self, Minimum)
        if not Self.Instance then 
            return
        end

        local Gui = Self.Instance

        local Resizing = false 
        local CurrentSide = nil

        local StartMouse = nil 
        local StartPosition = nil 
        local StartSize = nil
        
        local EdgeThickness = 2

        local MakeEdge = function(Name, Position, Size)
            local Button = Library:Create("TextButton", {
                Name = "\0",
                Size = Size,
                Position = Position,
                BackgroundColor3 = Color3.fromRGB(166, 147, 243),
                BackgroundTransparency = 1,
                Text = "",
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = Gui,
            })  Button:AddToTheme({BackgroundColor3 = "Accent"})

            return Button
        end

        local Edges = {
            {Button = MakeEdge(
                "Left", 
                UDim2.new(0, 0, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "L"
            },

            {Button = MakeEdge(
                "Right", 
                UDim2.new(1, -EdgeThickness, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "R"
            },

            {Button = MakeEdge(
                "Top", UDim2.new(0, 0, 0, 0), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "T"
            },

            {Button = MakeEdge(
                "Bottom", 
                UDim2.new(0, 0, 1, -EdgeThickness), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "B"
            },
        }

        local BeginResizing = function(Side)
            Resizing = true 
            CurrentSide = Side 

            StartMouse = UserInputService:GetMouseLocation()

            StartPosition = Vector2.new(Gui.Position.X.Offset, Gui.Position.Y.Offset)
            StartSize = Vector2.new(Gui.Size.X.Offset, Gui.Size.Y.Offset)
            
            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
            end
        end

        local EndResizing = function()
            Resizing = false 
            CurrentSide = nil

            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = 1
            end
        end

        for Index, Value in Edges do 
            Value.Button:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    BeginResizing(Value.Side)
                end
            end)
        end

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Resizing then
                    EndResizing()
                end
            end
        end)

        Library:Connect(RunService.RenderStepped, function()
            if not Resizing or not CurrentSide then 
                return 
            end

            local MouseLocation = UserInputService:GetMouseLocation()
            local dx = MouseLocation.X - StartMouse.X
            local dy = MouseLocation.Y - StartMouse.Y
        
            local x, y = StartPosition.X, StartPosition.Y
            local w, h = StartSize.X, StartSize.Y

            if CurrentSide == "L" then
                x = StartPosition.X + dx
                w = StartSize.X - dx
            elseif CurrentSide == "R" then
                w = StartSize.X + dx
            elseif CurrentSide == "T" then
                y = StartPosition.Y + dy
                h = StartSize.Y - dy
            elseif CurrentSide == "B" then
                h = StartSize.Y + dy
            end
        
            if w < Minimum.X then
                if CurrentSide == "L" then
                    x = x - (Minimum.X - w)
                end
                w = Minimum.X
            end
            if h < Minimum.Y then
                if CurrentSide == "T" then
                    y = y - (Minimum.Y - h)
                end
                h = Minimum.Y
            end
        
            Self:Tween({Position = UDim2.fromOffset(x, y)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
            Self:Tween({Size = UDim2.fromOffset(w, h)}, TweenInfo.new(0.65, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
        end)
    end

    Library.IsMouseOverFrame = function(Self)
        if not Self.Instance then 
            return 
        end

        local Object = Self.Instance

        local MousePosition = Vector2.new(Mouse.X, Mouse.Y)

        return MousePosition.X >= Object.AbsolutePosition.X and MousePosition.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X 
        and MousePosition.Y >= Object.AbsolutePosition.Y and MousePosition.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
    end

    Library.SafeCall = function(Self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, table.unpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success, Result
    end

    Library.Round = function(Self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return math.floor(Number * Multiplier) / Multiplier
    end

    Library.GetConfig = function(Self)
        local Config = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        if not Success then
            warn("Failed to get config:\n"..Result)
            return
        end

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(Self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.GetConfigsList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Configs)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.AddToTheme = function(Self, Properties)
        local Object = Self.Instance

        local ThemeData = {
            Item = Object,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                if not Library.Theme[Value] then
                    Object[Property] = Value 
                end

                Object[Property] = Library.Theme[Value]
            else
                Object[Property] = Value()
            end
        end

        table.insert(Library.ThemingStuff, ThemeData)
        Library.ThemeMap[Object] = ThemeData
        return Self
    end

    Library.ChangeItemTheme = function(Self, Properties)
        local Object = Self.Instance

        if not Library.ThemeMap[Object] then 
            return
        end

        Library.ThemeMap[Object].Properties = Properties
        Library.ThemeMap[Object] = Library.ThemeMap[Object]
    end

    Library.ChangeTheme = function(Self, Theme, Color)
        Library.Theme[Theme] = Color

        for _, Item in Library.ThemingStuff do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.OnHover = function(Self, OnHoverEnter, OnHoverLeave)
        local Object = Self.Instance

        if not Object then 
            return 
        end 

        Library:Connect(Object.MouseEnter, OnHoverEnter)
        Library:Connect(Object.MouseLeave, OnHoverLeave)
    end

    Library.GetScreenScale = function(Self)
        local Scale = 1
    
        for _, Obj in Library.Holder.Instance:GetDescendants() do
            if Obj:IsA("UIScale") then
                Scale *= Obj.Scale
            end
        end
    
        return Scale
    end
    
    Library.PopupPosition = function(Self, Anchor, Popup, ExtraY)
        local Scale = Library:GetScreenScale()
        ExtraY = ExtraY or 0
    
        local X = Anchor.AbsolutePosition.X / Scale
        local Y = (Anchor.AbsolutePosition.Y + Anchor.AbsoluteSize.Y + GuiInset + ExtraY) / Scale
    
        return UDim2.fromOffset(X, Y)
    end

    Library.VisibleCheck = function(Self)
        local Object = Self.Instance 

        if not Object then 
            return 
        end

        local OriginalParent = Object.Parent

        Library:Connect(Object:GetPropertyChangedSignal("Visible"), function()
            local IsVisible = Object.Visible
            Object.Parent = IsVisible and OriginalParent or Library.UnusedHolder.Instance
        end)
    end

    Library.GetTheme = function(Self)
        local Config = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Color and Value.Flag:find("Theming") then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                end
            end
        end)

        if not Success then
            warn("Failed to get theme:\n"..Result)
            return
        end

        return HttpService:JSONEncode(Config)
    end

    Library.LoadTheme = function(Self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                end
            end
        end)

        return Success, Result
    end

    Library.GetThemesList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Themes)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.Holder = Library:Create("ScreenGui", {
        Parent = gethui(),
        IgnoreGuiInset = true,
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Library:Create("ScreenGui", {
        Parent = gethui(),
        IgnoreGuiInset = true,
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Library:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        Enabled = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    -- themes
    Library:Thread(function()
        writefile(Library.Directory .. Library.Folders.Themes .. "/ZRHUB Red.json", '{"AccentTheming":{"Color":"#e11d2e","Alpha":0},"BackgroundTheming":{"Color":"#0b0708","Alpha":0},"Hovered ElementTheming":{"Color":"#441e23","Alpha":0},"OutlineTheming":{"Color":"#2e1013","Alpha":0},"InlineTheming":{"Color":"#120b0c","Alpha":0},"ElementTheming":{"Color":"#221315","Alpha":0},"Element 2Theming":{"Color":"#381a1e","Alpha":0},"BorderTheming":{"Color":"#020000","Alpha":0},"Inactive TextTheming":{"Color":"#8a7073","Alpha":0},"TextTheming":{"Color":"#ece2e3","Alpha":0}}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Sky.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#93eeff","Alpha":0},"BackgroundTheming":{"Color":"#141718","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#444949","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#292d2e","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#1f2324","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#2e3131","Alpha":0},"Element 2Theming":{"Color":"#454a4b","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Sky","BorderTheming":{"Color":"#1a1d1d","Alpha":0},"AutoParry":false,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#868686","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#ffffff","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Magma.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#e92b1a","Alpha":0},"BackgroundTheming":{"Color":"#221c1c","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#362a2a","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#291d1d","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#1f1717","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#292121","Alpha":0},"Element 2Theming":{"Color":"#363131","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Magma","BorderTheming":{"Color":"#000000","Alpha":0},"AutoParry":true,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#867979","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#d0cfe3","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Sand.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#ffe593","Alpha":0},"BackgroundTheming":{"Color":"#2d2e25","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"keybindModeDropdown":"Toggle","keybind2ModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#47473b","Alpha":0},"keybind2ShowInKeybindsList":true,"target":"Head","OutlineTheming":{"Color":"#585344","Alpha":0},"keybind3ShowInKeybindsList":true,"InlineTheming":{"Color":"#3f4137","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#36362c","Alpha":0},"Element 2Theming":{"Color":"#414133","Alpha":0},"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"ThemeName":"Sand","BorderTheming":{"Color":"#141403","Alpha":0},"AutoParry":false,"ConfigName":"","keybindShowInKeybindsList":true,"Inactive TextTheming":{"Color":"#888784","Alpha":0},"walkspeed":16,"TextTheming":{"Color":"#d0cfe3","Alpha":0},"MenuKeybindShowInKeybindsList":true,"textbox":"default"}')
        writefile(Library.Directory .. Library.Folders.Themes .. "/Navy.json", '{"MenuKeybindModeDropdown":"Toggle","AccentTheming":{"Color":"#0066ff","Alpha":0},"BackgroundTheming":{"Color":"#1c1e24","Alpha":0},"color":{"Color":"#ffffff","Alpha":0},"Watermark":true,"keybind2ModeDropdown":"Toggle","keybindModeDropdown":"Toggle","Hovered ElementTheming":{"Color":"#282b31","Alpha":0},"keybind2ShowInKeybindsList":true,"ThemeName":"Navy","InlineTheming":{"Color":"#202229","Alpha":0},"textbox":"default","OutlineTheming":{"Color":"#252a36","Alpha":0},"keybind":{"Key":"Enum.KeyCode.E","Mode":"Toggle"},"MenuKeybind":{"Key":"Enum.KeyCode.X","Mode":"Toggle"},"BorderTheming":{"Color":"#030303","Alpha":0},"keybind3":{"Key":"Enum.KeyCode.R","Mode":"Toggle"},"keybind3ModeDropdown":"Toggle","ElementTheming":{"Color":"#1d202b","Alpha":0},"Keybind list":true,"keybind2":{"Key":"Enum.KeyCode.F","Mode":"Toggle"},"AutoParry":true,"keybind3ShowInKeybindsList":true,"Element 2Theming":{"Color":"#3e414b","Alpha":0},"keybindShowInKeybindsList":true,"ConfigName":"","Inactive TextTheming":{"Color":"#65697e","Alpha":0},"walkspeed":34,"TextTheming":{"Color":"#a5a4bb","Alpha":0},"MenuKeybindShowInKeybindsList":true,"target":"Head"}')
    end)

    do
        local ColorpickerInfo = TweenInfo.new(Library.ColorpickerAnimation.Time, Enum.EasingStyle[Library.ColorpickerAnimation.Style], Enum.EasingDirection[Library.ColorpickerAnimation.Direction])

        Library.CreateColorpicker = function(Self, Data)
            local Colorpicker = {
                Hue = 0,
                Saturation = 0,
                Value = 0,

                Alpha = 0,

                Color = Color3.fromRGB(255, 255, 255),
                HexValue = "#FFFFFF",

                Flag = Data.Flag,
                IsOpen = false,

                Items = { }
            }

            local Items = { } do 
                Items["ColorpickerButton"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Data.Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 23, 0, 9),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 57, 83)
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["ColorpickerButton"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })                

                Items["ColorpickerWindow"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Library.Holder.Instance,
                    Visible = false,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1049, 0, 216),
                    Size = UDim2.new(0, 240, 0, 190),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["CurrentColor"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 10, 1, -10),
                    Size = UDim2.new(1, -20, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 57, 83)
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["CurrentColor"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["CurrentColor"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["CurrentColor"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Items["Alpha"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -10, 0, 10),
                    Size = UDim2.new(0, 15, 1, -40),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 57, 83)
                })
                
                Items["Fill"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Fill"].Instance,
                    Rotation = -90,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1)
                }
                })
                
                Items["AlphaDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["AlphaDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"]
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Hue"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -35, 0, 10),
                    Size = UDim2.new(0, 15, 1, -40),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                }
                })
                
                Items["HueDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["HueDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"]
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Palette"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 10, 0, 10),
                    Size = UDim2.new(1, -70, 1, -40),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 57, 83)
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Saturation"] = Library:Create("Frame", {
                    Name = "\0",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(1, 1, 1, 0),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Saturation"].Instance,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                Items["Value"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(1, 1, 1, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Value"].Instance,
                    Rotation = 90,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                Items["PaletteDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(0, 1, 0, 1),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["PaletteDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"]
                }):AddToTheme({Color = 'Border'})                

                Colorpicker.Items = Items
            end

            function Colorpicker:SetVisibility(Bool)
                Items["ColorpickerButton"].Instance.Visible = Bool
            end

            function Colorpicker:Update(IsFromAlpha)
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()
        
                Items["ColorpickerButton"]:Tween({BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween({BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)})

                Flags[Colorpicker.Flag] = {
                    Alpha = Colorpicker.Alpha,
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue,
                    Flag = Colorpicker.Flag,
                    Transparency = 1 - Colorpicker.Alpha
                }

                Items["CurrentColor"]:Tween({BackgroundColor3 = Colorpicker.Color})
    
                if not IsFromAlpha then 
                    Items["Alpha"]:Tween({BackgroundColor3 = Colorpicker.Color})
                end
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                end
            end

            local Debounce = false 
            local ColorpickerWindow = Items["ColorpickerWindow"].Instance
            local ColorpickerButton = Items["ColorpickerButton"].Instance

            local IsSettings = Data.Section and Data.Section.IsSettings

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 
                
                if Colorpicker.IsOpen then 
                    ColorpickerWindow.Position = Library:PopupPosition(ColorpickerButton, ColorpickerWindow, 0)

                    ColorpickerWindow.Visible = true
                    Items["ColorpickerWindow"]:Tween({
                        Position = Library:PopupPosition(ColorpickerButton, ColorpickerWindow, 10)
                    })

                    Items["ColorpickerWindow"]:FadeDescendants(true, function()
                        Debounce = false
                    end)

                    for Index, Value in Library.OpenFrames do
                        if Value ~= IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    Items["ColorpickerWindow"]:Tween({
                        Position = Library:PopupPosition(ColorpickerButton, ColorpickerWindow, -10)
                    })

                    Items["ColorpickerWindow"]:FadeDescendants(false, function()
                        Debounce = false
                    end)

                    if Library.OpenFrames[Colorpicker] then 
                        Library.OpenFrames[Colorpicker] = nil
                    end
                end

                local Descendants = ColorpickerWindow:GetDescendants()
                table.insert(Descendants, ColorpickerWindow)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if IsSettings then
                        Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow + 4 or 1
                    else 
                        Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow or 1
                    end
                end
            end

            Items["ColorpickerWindow"]:VisibleCheck()
    
            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end
    
                local ValueX = math.clamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = math.clamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)
    
                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY
    
                local SlideX = math.clamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local SlideY = math.clamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)
    
                Items["PaletteDragger"]:Tween({Position = UDim2.new(SlideX, 0, SlideY, 0)}, ColorpickerInfo)
                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged
    
            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end

                local ValueY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 1)
    
                Colorpicker.Hue = ValueY
    
                local SlideY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 0.99)
    
                Items["HueDragger"]:Tween({Position = UDim2.new(0, 0, SlideY, 0)}, ColorpickerInfo)
                Colorpicker:Update()
            end
    
            local SlidingAlpha = false 
            local AlphaChanged
    
            function Colorpicker:SlideAlpha(Input)
                if not Input or not SlidingAlpha then
                    return
                end
    
                local ValueY = math.clamp((Input.Position.Y - Items["Alpha"].Instance.AbsolutePosition.Y) / Items["Alpha"].Instance.AbsoluteSize.Y, 0, 1)
    
                Colorpicker.Alpha = ValueY
    
                local SlideY = math.clamp((Input.Position.Y - Items["Alpha"].Instance.AbsolutePosition.Y) / Items["Alpha"].Instance.AbsoluteSize.Y, 0, 0.99)
    
                Items["AlphaDragger"]:Tween({Position = UDim2.new(0, 0, SlideY, 0)}, ColorpickerInfo)
                Colorpicker:Update(true)
            end
    
            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = Color3.fromRGB(Color[1], Color[2], Color[3])
                elseif type(Color) == "string" then
                    Color = Color3.fromHex(Color)
                else
                    Color = Color -- Shit
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0  
    
                local PaletteValueX = math.clamp(1 - Colorpicker.Saturation, 0, 0.99)
                local PaletteValueY = math.clamp(1 - Colorpicker.Value, 0, 0.99)
    
                local AlphaPositionY = math.clamp(Colorpicker.Alpha, 0, 0.99)
                    
                local HuePositionY = math.clamp(Colorpicker.Hue, 0, 0.99)
    
                Items["PaletteDragger"]:Tween({Position = UDim2.new(PaletteValueX, 0, PaletteValueY, 0)}, ColorpickerInfo)
                Items["HueDragger"]:Tween({Position = UDim2.new(0, 0, HuePositionY, 0)}, ColorpickerInfo)
                Items["AlphaDragger"]:Tween({Position = UDim2.new(0, 0, AlphaPositionY, 0)}, ColorpickerInfo)
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)
    
            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingPalette = true 
    
                    Colorpicker:SlidePalette(Input)
    
                    if PaletteChanged then
                        return
                    end
    
                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false
    
                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)
    
            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingHue = true 
    
                    Colorpicker:SlideHue(Input)
    
                    if HueChanged then
                        return
                    end
    
                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false
    
                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)
    
            Items["Alpha"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingAlpha = true 
    
                    Colorpicker:SlideAlpha(Input)
    
                    if AlphaChanged then
                        return
                    end
    
                    AlphaChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingAlpha = false
    
                            AlphaChanged:Disconnect()
                            AlphaChanged = nil
                        end
                    end)
                end
            end)
    
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end
    
                    if SlidingHue then
                        Colorpicker:SlideHue(Input)
                    end
    
                    if SlidingAlpha then
                        Colorpicker:SlideAlpha(Input)
                    end
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Colorpicker.IsOpen then
                        if Items["ColorpickerWindow"]:IsMouseOverFrame() then 
                            return 
                        end

                        Colorpicker:SetOpen(false)
                    end
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default, Data.Alpha)
            end
    
            SetFlags[Colorpicker.Flag] = function(Value, Alpha)
                Colorpicker:Set(Value, Alpha)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(Self, Data)
            local Keybind = {
                Flag = Data.Flag,
                IsOpen = false,

                Key = "",
                Mode = "",
                Value = "",

                Toggled = false,
                Picking = false,

                Items = { },
            }

            local Items = { } do
                Items["KeyButtonOutline"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Data.Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 0, 0, 13),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeyButtonOutline"].Instance,
                    PaddingTop = UDim.new(0, 1),
                    PaddingBottom = UDim.new(0, 1),
                    PaddingRight = UDim.new(0, 1),
                    PaddingLeft = UDim.new(0, 1)
                })
                
                Items["KeyButton"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["KeyButtonOutline"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = "none",
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Element 2"]
                }):AddToTheme({BackgroundColor3 = 'Element 2', TextColor3 = 'Text'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["KeyButton"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeyButton"].Instance,
                    PaddingBottom = UDim.new(0, 2),
                    PaddingRight = UDim.new(0, 5),
                    PaddingLeft = UDim.new(0, 6)
                })             
                
                Items["KeybindWindow"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Library.Holder.Instance,
                    Visible = false,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 200, 0, 50),
                    Position = UDim2.new(0.5749104022979736, 0, 0.8196721076965332, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })

                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    Padding = UDim.new(0, 8)
                })                
                
                Keybind.Items = Items
            end

            Items["KeyButton"]:OnHover(function()
                Items["KeyButton"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                Items["KeyButton"]:Tween({BackgroundColor3 = Library.Theme.Element})
            end)

            local Debounce = false
            local KeybindWindow = Items["KeybindWindow"].Instance
            local KeyButton = Items["KeyButton"].Instance

            local IsSettings = Data.Section and Data.Section.IsSettings

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Keybind.IsOpen = Bool

                Debounce = true 
                
                if Keybind.IsOpen then 
                    KeybindWindow.Visible = true
                    KeybindWindow.Position = Library:PopupPosition(KeyButton, KeybindWindow, 0)

                    Items["KeybindWindow"]:Tween({
                        Position = Library:PopupPosition(KeyButton, KeybindWindow, 10)
                    })
                    
                    Items["KeybindWindow"]:FadeDescendants(true, function()
                        Debounce = false 
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Keybind] = Keybind 
                else
                    Items["KeybindWindow"]:Tween({
                        Position = Library:PopupPosition(KeyButton, KeybindWindow, -10)
                    })

                    Items["KeybindWindow"]:FadeDescendants(false, function()
                        Debounce = false
                    end)

                    if Library.OpenFrames[Keybind] then 
                        Library.OpenFrames[Keybind] = nil
                    end
                end

                local Descendants = KeybindWindow:GetDescendants()
                table.insert(Descendants, KeybindWindow)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if IsSettings then 
                        Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow or 1
                    else
                        Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow + 1 or 1
                    end
                end
            end

            Items["KeybindWindow"]:VisibleCheck()
    
            function Keybind:SetMode()
                Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            local KeybindObject 

            if Library.KeyList and Data.Name ~= "Menu Keybind" then 
                KeybindObject = Library.KeyList:Add("", "", "")
            end

            local Update = function()
                if KeybindObject then 
                    KeybindObject:Set(Data.Name, Keybind.Mode, Keybind.Value)
                    KeybindObject:SetStatus(Keybind.Toggled)
                end
            end

            local ModeDropdown = Library:Dropdown({
                Name = "Mode",
                Flag = Keybind.Flag .. "ModeDropdown",
                Parent = Items["KeybindWindow"],
                Items = { "Toggle", "Hold", "Always" },
                Default = "Toggle",
                Callback = function(Value)
                    Keybind.Mode = Value
                    Keybind:SetMode()

                    if Value == "Always" then 
                        Keybind:Press(true)
                    end

                    Update()
                end
            })

            local ShowInKeybindsList = Library:Toggle({
                Name = "Show in keybinds list",
                Flag = Keybind.Flag .. "ShowInKeybindsList",
                Parent = Items["KeybindWindow"],
                Default = true,
                Callback = function(Value)
                    if KeybindObject then 
                        KeybindObject:SetVis(Value)
                        Update()
                    end
                end
            })
    
            function Keybind:Press(Bool)
                if Keybind.Mode == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "Always" then 
                    Keybind.Toggled = true
                end
    
                Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Update()
            end
    
            function Keybind:Set(Key) -- this is so shit but its whatever
                if string.find(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)
    
                    Key = Key.Name == "Backspace" and "none" or Key.Name
    
                    local KeyString = Keys[Keybind.Key] or string.gsub(Key, "Enum.", "") or "none"
                    local TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "none"
    
                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay:lower()
    
                    Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "none" or Key.Key
                    Keybind.Key = tostring(Key.Key)
    
                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode()
                    else
                        Keybind.Mode = "Toggle"
                        Keybind:SetMode()
                    end
    
                    local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "none"
    
                    TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")
    
                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay:lower()
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                    
                    Update()
                elseif table.find({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode()
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                end

                Keybind.Picking = false
            end
    
            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 
    
                Items["KeyButton"].Instance.Text = ". . ."
    
                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end
    
                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)
    
            Library:Connect(UserInputService.InputBegan, function(Input, GPE)
                if Keybind.Value == "none" then
                    return
                end
    
                if not GPE then
                    if tostring(Input.KeyCode) == Keybind.Key then
                        if Keybind.Mode == "Toggle" then 
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then 
                            Keybind:Press(true)
                        elseif Keybind.Mode == "Always" then 
                            Keybind:Press(true)
                        end
                    elseif tostring(Input.UserInputType) == Keybind.Key then
                        if Keybind.Mode == "Toggle" then 
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then 
                            Keybind:Press(true)
                        elseif Keybind.Mode == "Always" then 
                            Keybind:Press(true)
                        end
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.IsOpen then 
                    if not Items["KeybindWindow"]:IsMouseOverFrame() and not ModeDropdown.Items.OptionHolder:IsMouseOverFrame() then
                        Keybind:SetOpen(false)
                    end
                end
            end)
    
            Library:Connect(UserInputService.InputEnded, function(Input, GPE)
                if GPE then
                    return
                end

                if Keybind.Value == "None" then
                    return
                end
    
                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end
            end)
    
            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)
    
            if Data.Default then 
                Keybind:Set({
                    Mode = Data.Mode or "Toggle",
                    Key = Data.Default,
                })
            end
    
            SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end

        Library.Watermark = function(Self, Params)
            Params = Params or { }

            local Watermark = {
                Name = Params.Name or Params.name or "Watermark",

                Items = { }
            }

            local Items = { } do 
                Items["Watermark"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 10, 0, GuiInset + 10),
                    Size = UDim2.new(0, 0, 0, 53),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})

                Items["Watermark"]:MakeDraggable()
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    PaddingTop = UDim.new(0, 10),
                    PaddingBottom = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10)
                })
                
                Items["Liner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 1, 0, 0),
                    Size = UDim2.new(1, 2, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                
                Library:Create("UIGradient", {
                    Parent = Items["Liner"].Instance,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 10, 20)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 10, 20))
                    })
                })

                Items["Glow"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Liner"].Instance,
                    ImageColor3 = Library.Theme["Accent"],
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.800000011920929,
                    Size = UDim2.new(1, 25, 1, 25),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                }):AddToTheme({ImageColor3 = 'Accent'})
                
                Items["Inline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    Size = UDim2.new(0, 0, 0, 25),
                    Position = UDim2.new(0, 0, 0, 6),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Inline"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Inline"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Items["Holder"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Inline"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Holder"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Holder"].Instance,
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })
                
                Items["Title"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Holder"].Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = Watermark.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Accent'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Title"].Instance,
                    PaddingBottom = UDim.new(0, 2)
                })

                Watermark.Items = Items 
            end

            function Watermark:SetVisibility(Bool)
                Items["Watermark"].Instance.Visible = Bool
            end

            function Watermark:SetText(Text)
                Items["Title"].Instance.Text = tostring(Text)
            end
            
            function Watermark:Add(Text)
                Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Holder"].Instance,
                    Size = UDim2.new(0, 1, 1, -10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                local NewItem = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Holder"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Text,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})

                function NewItem:SetText(Text)
                    NewItem.Instance.Text = tostring(Text)
                end

                function NewItem:SetVisibility(Bool)
                    NewItem.Instance.Visible = Bool
                end

                return NewItem
            end

            Self.Watermark = Watermark
            return setmetatable(Watermark, Library)
        end

        local KeybindTweenInfo = TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out) -- this is only for the keybind list and should not be used anywhere else
        
        Library.KeybindList = function(Self)
            local KeybindList = {
                Items = {},
                Keys = {}
            }
        
            local Items = {} do
                Items["KeybindList"] = Library:Create("Frame", {
                    Name = "\0", 
                    Parent = Library.Holder.Instance, 
                    AnchorPoint = Vector2.new(0, 0.5), 
                    Position = UDim2.new(0, 10, 0.5, 0), 
                    Size = UDim2.new(0, 34, 0, 53), 
                    ClipsDescendants = true, 
                    BorderSizePixel = 0, 
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = "Background"})

                Items["KeybindList"]:MakeDraggable()
        
                Library:Create("UIStroke", {
                    Parent = Items["KeybindList"].Instance, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Border"], 
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = "Border"})

                Library:Create("UIStroke", {
                    Parent = Items["KeybindList"].Instance, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = "Outline"})
        
                Library:Create("UIPadding", {
                    Parent = Items["KeybindList"].Instance, 
                    PaddingTop = UDim.new(0, 10), 
                    PaddingBottom = UDim.new(0, 12), 
                    PaddingRight = UDim.new(0, 10), 
                    PaddingLeft = UDim.new(0, 10)
                })
        
                Items["Liner"] = Library:Create("Frame", {
                    Parent = Items["KeybindList"].Instance, 
                    AnchorPoint = Vector2.new(1, 0), 
                    Position = UDim2.new(1, 1, 0, 0), 
                    Size = UDim2.new(1, 2, 0, 2), 
                    BorderSizePixel = 0, 
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = "Accent"})
        
                Items["Glow"] = Library:Create("ImageLabel", {
                    Parent = Items["Liner"].Instance, 
                    ImageColor3 = Library.Theme["Accent"], 
                    ScaleType = Enum.ScaleType.Slice, 
                    ImageTransparency = 0.8, 
                    Size = UDim2.new(1, 25, 1, 25), 
                    AnchorPoint = Vector2.new(0.5, 0.5), 
                    Image = "http://www.roblox.com/asset/?id=18245826428", 
                    BackgroundTransparency = 1, 
                    Position = UDim2.new(0.5, 0, 0.5, 0), 
                    BorderSizePixel = 0, 
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                }):AddToTheme({ImageColor3 = "Accent"})
        
                Items["Inline"] = Library:Create("Frame", {
                    Parent = Items["KeybindList"].Instance, 
                    Size = UDim2.new(0, 8, 0, 25), 
                    Position = UDim2.new(0, 0, 0, 6), 
                    ClipsDescendants = true,
                    BorderSizePixel = 0, 
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = "Inline"})
        
                Library:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = "Outline"})

                Library:Create("UIStroke", {
                    Parent = Items["Inline"].Instance, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Border"], 
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = "Border"})
        
                Items["Content"] = Library:Create("Frame", {
                    Parent = Items["Inline"].Instance, 
                    BackgroundTransparency = 1, 
                    Position = UDim2.new(0, 0, 0, 0), 
                    Size = UDim2.new(0, 0, 0, 25), 
                    BorderSizePixel = 0
                })
            end
        
            Library.KeyList = KeybindList
            Self.KeybindList = KeybindList
        
            function KeybindList:SetVisibility(Bool)
                Items["KeybindList"].Instance.Visible = Bool
            end
        
            function KeybindList:UpdateSize()
                local Width = 0
                local Y = 6
                local Count = 0
        
                for Index, Value in KeybindList.Keys do
                    if Value.Showing then
                        local RowHeight = 14
        
                        Value.Object.Instance.Visible = true
                        Width = math.max(Width, Value.Object.Instance.TextBounds.X)
        
                        Value.Object:Tween({Position = UDim2.new(0, 8, 0, Y), Size = UDim2.new(0, Value.Object.Instance.TextBounds.X, 0, RowHeight), TextTransparency = 0}, KeybindTweenInfo)
        
                        Y += RowHeight + 4
                        Count += 1
                    end
                end
        
                local TargetHeight = Count > 0 and math.max(25, Y + 5) or 25
        
                Items["Content"].Instance.Size = UDim2.new(0, Width, 0, TargetHeight)
        
                Items["Inline"]:Tween({Size = UDim2.new(0, Width + 14, 0, TargetHeight)}, KeybindTweenInfo)
                Items["KeybindList"]:Tween({Size = UDim2.new(0, Width + 34, 0, TargetHeight + 28)}, KeybindTweenInfo)

                local ActiveKeys = { }

                for Index, Value in KeybindList.Keys do
                    if Value.Showing then
                        table.insert(ActiveKeys, Value.Object.Instance.Text)
                    end
                end
        
                if #ActiveKeys == 0 then 
                    Items["KeybindList"].Instance.Visible = false
                else
                    Items["KeybindList"].Instance.Visible = true
                end
            end
        
            function KeybindList:Add(Name, Mode, Key)
                local NewKeyText = Library:Create("TextLabel", {
                    Parent = Items["Content"].Instance, 
                    FontFace = Library.Font, 
                    TextSize = Library.FontSize, 
                    TextColor3 = Library.Theme["Text"], 
                    Text = Name .. " - " .. Mode .. " [" .. Key .. "]", 
                    BackgroundTransparency = 1, 
                    BorderSizePixel = 0, 
                    Size = UDim2.new(0, 0, 0, 14), 
                    Position = UDim2.new(0, -8, 0, 6), 
                    TextTransparency = 1, 
                    Visible = false, 
                    TextYAlignment = Enum.TextYAlignment.Center, 
                    TextXAlignment = Enum.TextXAlignment.Left
                }):AddToTheme({TextColor3 = "Text"})
        
                local CanShow = true
        
                local NewKey = {
                    Object = NewKeyText,
                    Showing = false
                }
        
                table.insert(KeybindList.Keys, NewKey)
        
                function NewKey:SetVis(Bool)
                    CanShow = Bool

                    if not Bool then
                        NewKey:SetStatus(false)
                    end
                end
        
                function NewKey:Set(Name, Mode, Key)
                    NewKey.Object.Instance.Text = Name .. " - " .. Mode .. " [" .. Key .. "]"

                    KeybindList:UpdateSize()
                end
        
                function NewKey:SetStatus(Bool)
                    Bool = Bool and CanShow
        
                    if NewKey.Showing == Bool then
                        return
                    end
        
                    NewKey.Showing = Bool
        
                    if Bool then
                        NewKeyText.Instance.Visible = true
                        NewKeyText.Instance.Position = UDim2.new(0, 0, 0, NewKeyText.Instance.Position.Y.Offset)
                        NewKeyText.Instance.TextTransparency = 1
        
                        KeybindList:UpdateSize()
                    else
                        NewKeyText:Tween({Position = UDim2.new(0, 0, 0, NewKeyText.Instance.Position.Y.Offset), TextTransparency = 1}, KeybindTweenInfo)
        
                        KeybindList:UpdateSize()
        
                        task.delay(KeybindTweenInfo.Time, function()
                            if not NewKey.Showing then
                                NewKeyText.Instance.Visible = false
                            end
                        end)
                    end
                end
        
                return NewKey
            end
        
            KeybindList:UpdateSize()
        
            return setmetatable(KeybindList, Library)
        end

        local NotifTweenInfo = TweenInfo.new(Library.NotifAnimation.Time, Enum.EasingStyle[Library.NotifAnimation.Style], Enum.EasingDirection[Library.NotifAnimation.Direction])

        Library.Notification = function(Self, Name, Duration, Color)
            Duration = Duration or 5
            Color = Color or Library.Theme.Accent
        
            local Notification = {
                Duration = Duration,
                Removing = false,
                Items = {}
            }
        
            local Padding = 8
            local Spacing = 8
        
            local function UpdatePositions()
                local Y = GuiInset + Padding + 5
            
                for Index, Value in Library.Notifications do
                    local Height = Value.Items["Notification"].Instance.AbsoluteSize.Y
            
                    Value.Items["Notification"]:Tween({Position = UDim2.new(0, Padding, 0, Y)}, NotifTweenInfo)
            
                    Y += Height + Spacing
                end
            end
        
            local Items = {} do
                Items["Notification"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.NotifHolder.Instance,
                    Size = UDim2.new(0, 0, 0, 25),
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, -260, 0, GuiInset + Padding + 5),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = "Inline"})
        
                Library:Create("UIStroke", {
                    Name = "\0", 
                    Parent = 
                    Items["Notification"].Instance, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Border"], 
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = "Border"})

                Library:Create("UIStroke", {
                    Name = "\0", 
                    Parent = Items["Notification"].Instance, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border, 
                    LineJoinMode = Enum.LineJoinMode.Miter, 
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = "Outline"})
        
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })
        
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Notification"].Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = Name,
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 3, 0.5, -1),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = "Text"})
        
                Items["Liner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    Position = UDim2.new(0, -8, 0, 0),
                    Size = UDim2.new(0, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color
                })
        
                Items["DurationLiner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    Position = UDim2.new(0, -8, 0, 0),
                    Size = UDim2.new(1, 16, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color
                })
        
                Notification.Items = Items
            end
        
            local FadeNotification = function(Transparency) -- cant use fadedescendants because that one saves the transparency and it breaks and looks really gay 
                Items["Notification"]:Tween({BackgroundTransparency = Transparency}, NotifTweenInfo)
        
                for _, Value in Items["Notification"].Instance:GetDescendants() do
                    if Value:IsA("TextLabel") then
                        Library:Tween({TextTransparency = Transparency}, NotifTweenInfo, Value)
                    elseif Value:IsA("Frame") then
                        Library:Tween({BackgroundTransparency = Transparency}, NotifTweenInfo, Value)
                    elseif Value:IsA("UIStroke") then
                        Library:Tween({Transparency = Transparency}, NotifTweenInfo, Value)
                    end
                end
            end
        
            table.insert(Library.Notifications, 1, Notification)
        
            task.wait()
        
            local Width = Items["Notification"].Instance.AbsoluteSize.X
            local Height = Items["Notification"].Instance.AbsoluteSize.Y
        
            Items["Notification"].Instance.Size = UDim2.new(0, Width, 0, Height)
            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None
            Items["Notification"].Instance.BackgroundTransparency = 1
        
            for Index, Value in Items["Notification"].Instance:GetDescendants() do
                if Value:IsA("TextLabel") then
                    Value.TextTransparency = 1
                elseif Value:IsA("Frame") then
                    Value.BackgroundTransparency = 1
                elseif Value:IsA("UIStroke") then
                    Value.Transparency = 1
                end
            end
        
            UpdatePositions()
            FadeNotification(0)
        
            Items["DurationLiner"]:Tween({Size = UDim2.new(0, 0, 0, 1)}, TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
        
            task.spawn(function()
                local Tick = tick()
        
                while tick() - Tick < Duration and not Notification.Removing do
                    task.wait(0.05)
                end
        
                if Notification.Removing then return end
        
                Notification.Removing = true
        
                if not Library then return end 

                for Index, Value in Library.Notifications do
                    if Value == Notification then
                        table.remove(Library.Notifications, Index)
                        break
                    end
                end
        
                Items["Notification"]:Tween({Position = UDim2.new(0, -(Width + Padding + 20), 0, Items["Notification"].Instance.Position.Y.Offset)}, NotifTweenInfo)

                FadeNotification(1)
        
                task.delay(NotifTweenInfo.Time, function()
                    Items["Notification"].Instance:Destroy()
                    UpdatePositions()
                end)
            end)
        
            return Notification
        end
        
        Library.Window = function(Self, Params)
            Params = Params or { }

            local Window = {
                Name = Params.Name or Params.name or "Window",

                IsOpen = true,
                Pages = { },
                Items = { }
            }

            local Items = { } do 
                if IsMobile then 
                    Library:Create("UIScale", {
                        Parent = Library.Holder.Instance,
                        Scale = 0.7
                    })
                end

                Items["Outline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, 613, 0, 453),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})

                Items["Outline"]:MakeDraggable()
                Items["Outline"]:MakeResizeable(Vector2.new(Items["Outline"].Instance.AbsoluteSize.X, Items["Outline"].Instance.AbsoluteSize.Y))
                
                Items["Outline2"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Outline"].Instance,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["Background"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Outline2"].Instance,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                --[[
                Items["Title"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Background"].Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = Window.Name,
                    Position = UDim2.new(0, 8, 0, 8),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Accent'})
                --]]
                
                Items["Liner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    Size = UDim2.new(1, 0, 0, 2),
                    Position = UDim2.new(0, 0, 0, 30),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                
                Library:Create("UIGradient", {
                    Parent = Items["Liner"].Instance,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 10, 20)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 10, 20))
                    })
                })

                Items["Glow"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Liner"].Instance,
                    ImageColor3 = Library.Theme["Accent"],
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.800000011920929,
                    Size = UDim2.new(1, 8, 1, 8),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                }):AddToTheme({ImageColor3 = 'Accent'})
                
                Items["Pages"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, 0, 0, 30),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Pages"].Instance,
                    PaddingBottom = UDim.new(0, 4),
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Pages"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Content"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 30),
                    ClipsDescendants = true,
                    Size = UDim2.new(1, 0, 1, -30),
                    BorderSizePixel = 0
                })

                Window.Items = Items
            end

            local Debounce = false

            function Window:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                for Index, Value in Window.Pages do 
                    if Value.Debounce then 
                        return 
                    end
                end

                Debounce = true 

                Window.IsOpen = Bool
                Items["Outline"]:FadeDescendants(Bool, function()
                    Debounce = false
                end)

                for Index, Value in Library.OpenFrames do 
                    Value:SetOpen(false)
                end
            end

            function Window:Center()
                task.wait()
                local Outline = Items["Outline"].Instance
                local Scale = Library:GetScreenScale()
                local Screen = Outline.Parent.AbsoluteSize / Scale
                local Size = Outline.AbsoluteSize / Scale
                Outline.AnchorPoint = Vector2.new(0, 0)
                Outline.Position = UDim2.new(0, math.floor((Screen.X - Size.X) / 2), 0, math.floor((Screen.Y - Size.Y) / 2))
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                    if UserInputService:GetFocusedTextBox() then
                        return
                    end

                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            -- the title animation logic below
            local OffsetX = 30
            local OffsetY = 12

            if Params.Icon then
                Items["Icon"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Image = Params.Icon,
                    Position = UDim2.new(0, 7, 0, 5),
                    Size = UDim2.new(0, 20, 0, 20),
                    ScaleType = Enum.ScaleType.Fit
                })
                Library:Create("UICorner", { Parent = Items["Icon"].Instance, CornerRadius = UDim.new(0, 4) })
            else
                OffsetX = 8
            end
            local Width = 7 -- this would be the gap between each letter

            local WaveHeight = 4
            local WaveSpeed =  2.5
            local WaveSpacing = 0.25

            local Letters = { } -- try not to make the title too long since every letter is created individually for the animation

            for Index = 1, #Window.Name do 
                local Letter = Window.Name:sub(Index, Index)

                local NewLetter = Library:Create("TextLabel",{
                    Name = "\0",
                    Size = UDim2.new(0, Width, 0, 0),
                    Position = UDim2.new(0, OffsetX + ((Index - 1) * Width), 0, OffsetY),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Text = Letter,
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Background"].Instance
                }):AddToTheme({TextColor3 = 'Accent'})

                Letters[Index] = {
                    LetterInstance = NewLetter,
                    X = OffsetX + ((Index - 1) * Width),
                    Y = OffsetY
                }
            end

            Library:Connect(RunService.RenderStepped, function()
                local Tick = tick()

                for Index, Value in Letters do 
                    local OffsetY = math.sin((Tick * WaveSpeed) - (Index * WaveSpacing)) * WaveHeight

                    Value.LetterInstance.Instance.Position = UDim2.new(0, Value.X, 0, Value.Y + OffsetY)
                end
            end)            

            Window:Center()
            return setmetatable(Window, Library)
        end

        local PageInfo = TweenInfo.new(Library.TabAnimation.Time, Enum.EasingStyle[Library.TabAnimation.Style], Enum.EasingDirection[Library.TabAnimation.Direction])

        Library.Page = function(Self, Params)
            Params = Params or { }

            local Page = {
                Name = Params.Name or Params.name or "Page",

                Window = Self,
                ColumnsData = { },
                Items = { },
                Active = false,
                Debounce = false
            }

            local Items = { } do 
                Items["Inactive"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Page.Window.Items["Pages"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Page.Name,
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 0, 0, 20),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                Items["Inactive"].Instance.TextSize = Library.FontSize
                if Params.Icon then
                    local Icon = Library:GetIcon(Params.Icon)
                    if Icon then
                        Library:Create("UIPadding", {
                            Name = "\0",
                            Parent = Items["Inactive"].Instance,
                            PaddingLeft = UDim.new(0, 16)
                        })
                        Items["Icon"] = Library:Create("ImageLabel", {
                            Name = "\0",
                            Parent = Items["Inactive"].Instance,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(0, -16, 0.5, 0),
                            Size = UDim2.new(0, 12, 0, 12),
                            Image = Icon.Url or ("rbxassetid://" .. tostring(Icon.Id)),
                            ImageRectOffset = Icon.ImageRectOffset or Vector2.zero,
                            ImageRectSize = Icon.ImageRectSize or Vector2.zero,
                            ImageColor3 = Library.Theme["Inactive Text"]
                        }):AddToTheme({ImageColor3 = 'Inactive Text'})
                    end
                end

                Items["Underline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Inactive"].Instance,
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 1, 3),
                    Size = UDim2.new(0, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})         
                
                Items["Page"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.UnusedHolder.Instance,
                    BackgroundTransparency = 1,
                    Visible = false,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 11),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })
                
                Items["LeftColumn"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 100, 0, 100),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["LeftColumn"].Instance,
                    Padding = UDim.new(0, 15),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["LeftColumn"].Instance,
                    PaddingTop = UDim.new(0, 19),
                    PaddingBottom = UDim.new(0, 15),
                    PaddingRight = UDim.new(0, 2),
                    PaddingLeft = UDim.new(0, 10)
                })                

                Items["RightColumn"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 100, 0, 100),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["RightColumn"].Instance,
                    Padding = UDim.new(0, 15),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["RightColumn"].Instance,
                    PaddingTop = UDim.new(0, 19),
                    PaddingBottom = UDim.new(0, 15),
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 2)
                })

                Page.ColumnsData[1] = Items["LeftColumn"]
                Page.ColumnsData[2] = Items["RightColumn"]

                Page.Items = Items
            end

            Items["Inactive"]:OnHover(function()
                if Page.Active then return end 
                
                Items["Inactive"]:Tween({TextColor3 = Library.Theme.Text})
                if Items["Icon"] then Items["Icon"]:Tween({ImageColor3 = Library.Theme.Text}) end
            end, function()
                if Page.Active then return end 
                
                Items["Inactive"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                if Items["Icon"] then Items["Icon"]:Tween({ImageColor3 = Library.Theme["Inactive Text"]}) end
            end)

            function Page:Turn()
                local Old = Page.Window.Current 

                if Old == Page then 
                    return 
                end

                if Page.Debounce then 
                    return
                end

                if Old and Old.Debounce then 
                    return 
                end

                Page.Debounce = true 
                
                if Old then 
                    Old.Items["Page"].Instance.Position = UDim2.new(0, 0, 0, 0)
                    Old.Items["Inactive"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                    Old.Items["Inactive"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    if Old.Items["Icon"] then
                        Old.Items["Icon"]:ChangeItemTheme({ImageColor3 = "Inactive Text"})
                        Old.Items["Icon"]:Tween({ImageColor3 = Library.Theme["Inactive Text"]})
                    end
                    if Old.Items["Underline"] then
                        Old.Items["Underline"]:Tween({Size = UDim2.new(0, 0, 0, 2)})
                    end

                    Old.Items["Page"]:Tween({Position = UDim2.new(-1, 0, 0, 0)}, PageInfo)

                    Old.Items["Page"]:FadeDescendants(false, function()
                        Old.Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
                    end)

                    Old.Active = false
                end

                Items["Page"].Instance.Position = UDim2.new(1, 0, 0, 0)
                
                Items["Page"].Instance.Parent = Page.Window.Items["Content"].Instance
                Items["Page"].Instance.Visible = true
                Items["Page"]:FadeDescendants(true, function()
                    Page.Debounce = false
                end)

                Items["Inactive"]:ChangeItemTheme({TextColor3 = "Accent"})
                Items["Inactive"]:Tween({TextColor3 = Library.Theme["Accent"]})
                if Items["Icon"] then
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Accent"})
                    Items["Icon"]:Tween({ImageColor3 = Library.Theme["Accent"]})
                end
                Items["Underline"]:Tween({Size = UDim2.new(1, 0, 0, 2)})

                Items["Page"]:Tween({Position = UDim2.new(0, 0, 0, 0)}, PageInfo)

                Page.Window.Current = Page
                Page.Active = true
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                Page:Turn()
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn()
            end

            table.insert(Page.Window.Pages, Page)
            return setmetatable(Page, Library)
        end

        Library.Section = function(Self, Params)
            Params = Params or { } 

            local Section = {
                Name = Params.Name or Params.name or "Section",
                Side = Params.Side or Params.side or 1,

                Window = Self.Window,
                Page = Self,
                Items = { },
            }

            local Items = { } do 
                Items["Section"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Size = UDim2.new(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Section"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Section.Name,
                    Position = UDim2.new(0, 9, 0, -2),
                    Size = UDim2.new(0, 0, 0, 1),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Text"].Instance,
                    PaddingRight = UDim.new(0, 4),
                    PaddingLeft = UDim.new(0, 4)
                })
                
                Items["Content"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 10),
                    Size = UDim2.new(1, -16, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Content"].Instance,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    PaddingBottom = UDim.new(0, 8)
                })                

                Section.Items = Items
            end 

            function Section:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            return setmetatable(Section, Library)
        end

        Library.Toggle = function(Self, Params)
            Params = Params or { }

            local Toggle = {
                Name = Params.Name or Params.name or "Toggle",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or false,
                Callback = Params.Callback or Params.callback or function() end,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Toggle.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Toggle"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 12),
                    BorderSizePixel = 0
                })
                
                Items["Outline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Toggle"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(0, 9, 0, 9),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["Indicator"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Outline"].Instance,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element 2"]
                }):AddToTheme({BackgroundColor3 = 'Element 2'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Indicator"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Toggle"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Toggle.Name,
                    Position = UDim2.new(0, 18, 0, -1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})       
                
                Items["SubElements"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Toggle"].Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["SubElements"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
            
                Toggle.Items = Items
            end

            Items["Toggle"]:OnHover(function()
                if Toggle.Value then return end 
                Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                if Toggle.Value then return end 
                Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Element 2"]})
            end)

            function Toggle:Set(Bool)
                Toggle.Value = Bool 

                if Bool then 
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme.Accent})
                else
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element 2"})
                    Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme["Element 2"]})
                end

                Flags[Toggle.Flag] = Bool
                Library:SafeCall(Toggle.Callback, Bool)
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or 0,

                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Name = Data.Name or Data.name or Toggle.Name,
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                    Default = Data.Default or Data.default or nil,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",

                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Name = Keybind.Name,
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            Toggle:Set(Toggle.Default)

            SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return setmetatable(Toggle, Library)
        end

        Library.Button = function(Self, Params)
            Params = Params or { }

            local Button = {
                Name = Params.Name or Params.name or "Button",
                Callback = Params.Callback or Params.callback or function() end,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Button.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Button"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["Inline"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Button"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["RealButton"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Inline"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["RealButton"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["RealButton"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Button.Name,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, -1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Accent"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealButton"].Instance,
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})                

                Button.Items = Items
            end

            Items["RealButton"]:OnHover(function()
                Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                Items["RealButton"]:Tween({BackgroundColor3 = Library.Theme.Element})
            end)

            function Button:Press()
                pcall(function() -- i have to do this so it doesnt error on unload
                    Library:SafeCall(Button.Callback)

                    Items["Accent"]:Tween({BackgroundTransparency = 0, Size = UDim2.new(1, 0, 1, 0)})
                    task.wait(Library.Animation.Time - 0.1)
                    Items["Accent"]:Tween({BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0)})
                end)
            end

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            function Button:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            Items["RealButton"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return setmetatable(Button, Library)
        end

        Library.Slider = function(Self, Params)
            Params = Params or { }

            local Slider = {
                Name = Params.Name or Params.name or "Slider",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or 0,
                Min = Params.Min or Params.min or 0,
                Max = Params.Max or Params.max or 100,
                Callback = Params.Callback or Params.callback or function() end,
                Decimals = Params.Decimals or Params.decimals or 1,
                Suffix = Params.Suffix or Params.suffix or "",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = 0,
                Sliding = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Slider.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Slider"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 30),
                    BorderSizePixel = 0
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Slider.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["RealSliderOutline"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 9),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["RealSlider"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RealSliderOutline"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element 2"]
                }):AddToTheme({BackgroundColor3 = 'Element 2'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["AccentHolder"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0
                })
                
                Items["Accent"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["AccentHolder"].Instance,
                    Size = UDim2.new(0.5, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Accent"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Value"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = "2.5",
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 1, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Inactive Text'})                

                Slider.Items = Items 
            end

            Items["RealSlider"]:OnHover(function()
                Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme.Element})
            end)

            function Slider:Set(Value)
                Slider.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)

                Items["Accent"]:Tween({Size = UDim2.new((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)}, TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                Items["Value"].Instance.Text = string.format("%s%s", Slider.Value, Slider.Suffix)

                Flags[Slider.Flag] = Slider.Value
                Library:SafeCall(Slider.Callback, Slider.Value)
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:GetSize(Input)
                local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                return Value
            end

            function Slider:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            local InputChanged 
            
            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Items["Value"]:Tween({TextColor3 = Library.Theme.Text})
                    Slider.Sliding = true

                    local Value = Slider:GetSize(Input)

                    Slider:Set(Value)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Items["Value"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local Value = Slider:GetSize(Input)

                        Slider:Set(Value)
                    end
                end
            end)

            Slider:Set(Slider.Default)

            SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return setmetatable(Slider, Library)
        end

        Library.Dropdown = function(Self, Params)
            Params = Params or { }

            local Dropdown = {
                Name = Params.Name or Params.name or "Dropdown",
                OptionItems = Params.Items or Params.items or { },
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or "",
                Callback = Params.Callback or Params.callback or function() end,
                Multi = Params.Multi or Params.multi or false,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = { },
                Options = { },
                IsOpen = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Dropdown.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Dropdown"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 40),
                    BorderSizePixel = 0
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Dropdown"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Dropdown.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["RealDropdownOutline"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Dropdown"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["Inline"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RealDropdownOutline"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["RealDropdown"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Inline"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["RealDropdown"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Icon"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["RealDropdown"].Instance,
                    ImageColor3 = Library.Theme["Accent"],
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://98057726606591",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -1, 0.5, -1),
                    Size = UDim2.new(0, 16, 0, 16),
                    BorderSizePixel = 0
                }):AddToTheme({ImageColor3 = 'Accent'})
                
                Items["Value"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["RealDropdown"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = "none",
                    Size = UDim2.new(1, -24, 0, 0),
                    Position = UDim2.new(0, 4, 0.5, -1),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    AutomaticSize = Enum.AutomaticSize.Y
                }):AddToTheme({TextColor3 = 'Text'})          
                
                Items["OptionHolder"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Library.Holder.Instance,
                    Visible = false,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 200, 0, 50),
                    Position = UDim2.new(0, 792, 0, 649),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Border"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Border'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })

                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Dropdown.Items = Items 
            end

            Items["RealDropdown"]:OnHover(function()
                Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme.Element})
            end)

            function Dropdown:Set(Value)
                if Dropdown.Multi then 
                    if type(Value) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Value

                    for Index, Value in Value do
                        local OptionData = Dropdown.Options[Value]
                         
                        if not OptionData then
                            continue
                        end

                        OptionData.IsSelected = true 
                        OptionData:ToggleState("Active")
                    end

                    Flags[Dropdown.Flag] = Value
                    Items["Value"].Instance.Text = table.concat(Value, ", ")
                else
                    if not Dropdown.Options[Value] then
                        return
                    end

                    local OptionData = Dropdown.Options[Value]

                    Dropdown.Value = Value

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.IsSelected = false 
                            Value:ToggleState("Inactive")
                        else
                            Value.IsSelected = true 
                            Value:ToggleState("Active")
                        end
                    end

                    Flags[Dropdown.Flag] = Value
                    Items["Value"].Instance.Text = Value
                end

                Library:SafeCall(Dropdown.Callback, Dropdown.Value)
            end

            function Dropdown:Add(Value)
                local OptionButton = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["OptionHolder"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Value,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                local OptionData = {
                    Button = OptionButton,
                    Name = Value,
                    IsSelected = false
                }

                OptionButton:OnHover(function()
                    if OptionData.IsSelected then return end 

                    OptionButton:Tween({TextColor3 = Library.Theme.Text})
                end, function()
                    if OptionData.IsSelected then return end 

                    OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                end)
                
                function OptionData:ToggleState(Value)
                    if Value == "Active" then
                        OptionButton:ChangeItemTheme({TextColor3 = "Accent"})
                        OptionButton:Tween({TextColor3 = Library.Theme.Accent})
                    else
                        OptionButton:ChangeItemTheme({TextColor3 = "Inactive Text"})
                        OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end
                end

                function OptionData:Set()
                    Library:Thread(function()
                        Items["Value"]:Tween({TextTransparency = 1})
                        task.wait(0.1)
                        Items["Value"]:Tween({TextTransparency = 0})
                    end)

                    OptionData.IsSelected = not OptionData.IsSelected

                    if Dropdown.Multi then 
                        local Index = table.find(Dropdown.Value, OptionData.Name)

                        if Index then 
                            table.remove(Dropdown.Value, Index)
                        else
                            table.insert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:ToggleState(Index and "Inactive" or "Active")

                        Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "none"
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.IsSelected then 
                            Dropdown.Value = OptionData.Name
                            Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.IsSelected = true
                            OptionData:ToggleState("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.IsSelected = false 
                                    Value:ToggleState("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Flags[Dropdown.Flag] = nil

                            OptionData.IsSelected = false
                            OptionData:ToggleState("Inactive")

                            Items["Value"].Instance.Text = "none"
                        end
                    end

                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button.Instance:Destroy()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            function Dropdown:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool 
            end

            local Debounce = false 
            local OptionHolder = Items["OptionHolder"].Instance
            local RealDropdown = Items["RealDropdown"].Instance

            local IsSettings = Dropdown.Section and Dropdown.Section.IsSettings

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Dropdown.IsOpen = Bool

                Debounce = true 
                
                if Dropdown.IsOpen then 
                    Items["OptionHolder"].Instance.Visible = true

                    local Scale = Library:GetScreenScale()
                    OptionHolder.Position = Library:PopupPosition(RealDropdown, OptionHolder, 0)
                    OptionHolder.Size = UDim2.new(0, RealDropdown.AbsoluteSize.X / Scale, 0, 0)
                    
                    Items["OptionHolder"]:Tween({
                        Position = Library:PopupPosition(RealDropdown, OptionHolder, 10)
                    })
                    
                    Items["OptionHolder"]:FadeDescendants(true, function()
                        Debounce = false 
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= IsSettings and not Params.Parent then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    Items["OptionHolder"]:Tween({
                        Position = Library:PopupPosition(RealDropdown, OptionHolder, -10)
                    })

                    Items["OptionHolder"]:FadeDescendants(false, function()
                        Debounce = false
                    end)

                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end
                end

                local Descendants = OptionHolder:GetDescendants()
                table.insert(Descendants, OptionHolder)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if not Params.Parent then
                        Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder or 1
                    else
                        Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder + 3 or 1
                    end
                end
            end

            Items["OptionHolder"]:VisibleCheck()

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Dropdown.IsOpen and not Items["OptionHolder"]:IsMouseOverFrame() then
                        Dropdown:SetOpen(false)
                    end
                end
            end)

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            for Index, Value in Dropdown.OptionItems do 
                Dropdown:Add(Value)
            end

            Dropdown:Set(Dropdown.Default)

            SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return setmetatable(Dropdown, Library)
        end

        Library.List = function(Self, Params)
            Params = Params or { }

            local List = {
                OptionItems = Params.Items or Params.items or { },
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or "",
                Callback = Params.Callback or Params.callback or function() end,
                Multi = Params.Multi or Params.multi or false,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = { },
                Options = { },
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = List.Section.Items["Content"]
            end

            local Items = { } do 
                Items["List"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 200),
                    BorderSizePixel = 0
                })
                
                Items["SearchOutline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["List"].Instance,
                    Size = UDim2.new(1, 0, 0, 20),
                    Active = true,
                    Selectable = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["SearchInline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["SearchOutline"].Instance,
                    Active = true,
                    Position = UDim2.new(0, 1, 0, 1),
                    Selectable = true,
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["SearchBackground"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["SearchInline"].Instance,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, -2, 1, -2),
                    Position = UDim2.new(0, 1, 0, 1),
                    Selectable = true,
                    Active = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["SearchBackground"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Input"] = Library:Create("TextBox", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["SearchBackground"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    PlaceholderColor3 = Library.Theme["Inactive Text"],
                    PlaceholderText = "Search..",
                    Size = UDim2.new(1, -8, 0, 0),
                    TextColor3 = Library.Theme["Text"],
                    Text = "",
                    Position = UDim2.new(0, 4, 0.5, -1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ClearTextOnFocus = false,
                    AutomaticSize = Enum.AutomaticSize.Y
                }):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})
                
                Items["ListOutline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["List"].Instance,
                    Position = UDim2.new(0, 0, 0, 25),
                    Size = UDim2.new(1, 0, 1, -25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["ListInline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["ListOutline"].Instance,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["ListBackground"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["ListInline"].Instance,
                    Position = UDim2.new(0, 1, 0, 1),
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["ListBackground"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Holder"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["ListBackground"].Instance,
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarImageColor3 = Library.Theme["Accent"],
                    MidImage = "rbxassetid://81680855285439",
                    ScrollBarThickness = 2,
                    Size = UDim2.new(1, -16, 1, -16),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 8),
                    BottomImage = "rbxassetid://81680855285439",
                    TopImage = "rbxassetid://81680855285439"
                }):AddToTheme({ScrollBarImageColor3 = 'Accent'})
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Holder"].Instance,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Holder"].Instance,
                    PaddingBottom = UDim.new(0, 8)
                })                

                List.Items = Items 
            end

            function List:Set(Value)
                if List.Multi then 
                    if type(Value) ~= "table" then 
                        return
                    end

                    List.Value = Value

                    for Index, Value in Value do
                        local OptionData = List.Options[Value]
                         
                        if not OptionData then
                            continue
                        end

                        OptionData.IsSelected = true 
                        OptionData:ToggleState("Active")
                    end

                    Flags[List.Flag] = Value
                else
                    if not List.Options[Value] then
                        return
                    end

                    local OptionData = List.Options[Value]

                    List.Value = Value

                    for Index, Value in List.Options do
                        if Value ~= OptionData then
                            Value.IsSelected = false 
                            Value:ToggleState("Inactive")
                        else
                            Value.IsSelected = true 
                            Value:ToggleState("Active")
                        end
                    end

                    Flags[List.Flag] = Value
                end

                Library:SafeCall(List.Callback, List.Value)
            end

            function List:Add(Value)
                local OptionButton = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Parent = Items["Holder"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Value,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                local OptionData = {
                    Button = OptionButton,
                    Name = Value,
                    IsSelected = false
                }

                OptionButton:OnHover(function()
                    if OptionData.IsSelected then return end 

                    OptionButton:Tween({TextColor3 = Library.Theme.Text})
                end, function()
                    if OptionData.IsSelected then return end 

                    OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                end)
                
                function OptionData:ToggleState(Value)
                    if Value == "Active" then
                        OptionButton:ChangeItemTheme({TextColor3 = "Accent"})
                        OptionButton:Tween({TextColor3 = Library.Theme.Accent})
                    else
                        OptionButton:ChangeItemTheme({TextColor3 = "Inactive Text"})
                        OptionButton:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end
                end

                function OptionData:Set()
                    OptionData.IsSelected = not OptionData.IsSelected

                    if List.Multi then 
                        local Index = table.find(List.Value, OptionData.Name)

                        if Index then 
                            table.remove(List.Value, Index)
                        else
                            table.insert(List.Value, OptionData.Name)
                        end

                        OptionData:ToggleState(Index and "Inactive" or "Active")

                        Flags[List.Flag] = List.Value
                    else
                        if OptionData.IsSelected then 
                            List.Value = OptionData.Name
                            Flags[List.Flag] = OptionData.Name

                            OptionData.IsSelected = true
                            OptionData:ToggleState("Active")

                            for Index, Value in List.Options do 
                                if Value ~= OptionData then
                                    Value.IsSelected = false 
                                    Value:ToggleState("Inactive")
                                end
                            end
                        else
                            List.Value = nil
                            Flags[List.Flag] = nil

                            OptionData.IsSelected = false
                            OptionData:ToggleState("Inactive")
                        end
                    end

                    Library:SafeCall(List.Callback, List.Value)
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                List.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function List:Remove(Option)
                if List.Options[Option] then
                    List.Options[Option].Button.Instance:Destroy()
                    List.Options[Option] = nil
                end
            end

            function List:Refresh(NewList)
                for Index, Value in List.Options do 
                    List:Remove(Value.Name)
                end

                for Index, Value in NewList do 
                    List:Add(Value)
                end
            end

            function List:SetVisibility(Bool)
                Items["List"].Instance.Visible = Bool 
            end

            for Index, Value in List.OptionItems do 
                List:Add(Value)
            end

            Items["Input"]:Connect("Changed", function(Property)
                if Property == "Text" then
                    for Index, Value in List.Options do
                        if string.find(string.lower(Value.Name), string.lower(Items["Input"].Instance.Text)) then
                            Value.Button.Instance.Visible = true
                        else
                            Value.Button.Instance.Visible = false
                        end
                    end
                end
            end)

            List:Set(List.Default)

            SetFlags[List.Flag] = function(Value)
                List:Set(Value)
            end

            return setmetatable(List, Library)
        end

        Library.Label = function(Self, Params)
            Params = Params or { }

            local Label = {
                Name = Params.Name or Params.name or "Label",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Label.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Label"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 12),
                    BorderSizePixel = 0
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Label"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Label.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["SubElements"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Label"].Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["SubElements"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Label.Items = Items 
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool 
            end

            function Label:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or 0,

                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Name = Data.Name or Data.name or Label.Name,
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                    Default = Data.Default or Data.default or nil,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",

                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Name = Keybind.Name,
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Label:SetText(Label.Name)

            return setmetatable(Label, Library)
        end

        Library.Textbox = function(Self, Params)
            Params = Params or { }

            local Textbox = {
                Name = Params.Name or Params.name or "Textbox",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or "",
                Callback = Params.Callback or Params.callback or function() end,
                Finished = Params.Finished or Params.finished or false,
                Placeholder = Params.Placeholder or Params.placeholder or "",
                Numeric = Params.Numeric or Params.numeric or false,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,
                Value = "",

                Items = { },
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Textbox.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Textbox"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 40),
                    BorderSizePixel = 0
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Textbox"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Textbox.Name,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Outline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Textbox"].Instance,
                    Active = true,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 20),
                    Selectable = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Border"]
                }):AddToTheme({BackgroundColor3 = 'Border'})
                
                Items["Inline"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Outline"].Instance,
                    Active = true,
                    Position = UDim2.new(0, 1, 0, 1),
                    Selectable = true,
                    Size = UDim2.new(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["Background"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Inline"].Instance,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, -2, 1, -2),
                    Position = UDim2.new(0, 1, 0, 1),
                    Selectable = true,
                    Active = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 163, 163))
                }
                })
                
                Items["Input"] = Library:Create("TextBox", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Items["Background"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    PlaceholderColor3 = Library.Theme["Inactive Text"],
                    PlaceholderText = Textbox.Placeholder,
                    Size = UDim2.new(1, -8, 0, 0),
                    TextColor3 = Library.Theme["Text"],
                    Text = "",
                    Position = UDim2.new(0, 4, 0.5, -1),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    CursorPosition = -1,
                    ClearTextOnFocus = false,
                    AutomaticSize = Enum.AutomaticSize.Y
                }):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})                

                Textbox.Items = Items
            end

            Items["Background"]:OnHover(function()
                Items["Background"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
            end, function()
                Items["Background"]:Tween({BackgroundColor3 = Library.Theme.Element})
            end)

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Textbox:Set(Value)
                if Textbox.Numeric and string.len(tostring(Value)) > 0 and not tonumber(Value) then
                    Value = Textbox.Value
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Flags[Textbox.Flag] = Value

                Library:SafeCall(Textbox.Callback, Value)
            end

            if Textbox.Finished then 
                Items["Input"]:Connect("FocusLost", function(Bool)
                    if Bool then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            else
                Items["Input"]:Connect("Changed", function(Property)
                    if Property == "Text" then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            end

            Textbox:Set(Textbox.Default)

            SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end
            
            return setmetatable(Textbox, Library)
        end

        Library.Init = function(Self)
            local SettingsPage = Self:Page({Name = "settings", Icon = "settings"}) do 
                local ThemingSection = SettingsPage:Section({Name = "Theming", Side = 2}) do
                    for Index, Value in Library.Theme do 
                        ThemingSection:Label({Name = Index}):Colorpicker({
                            Name = Index,
                            Flag = Index.."Theming",
                            Default = Value,
                            Callback = function(Value)
                                Library.Theme[Index] = Value
                                Library:ChangeTheme(Index, Value)
                            end
                        })
                    end

                    local ThemeSelected 
                    local ThemeName
                    local ThemesFolder = Library.Directory .. Library.Folders.Themes .. "/"

                    local ThemesDropdown = ThemingSection:Dropdown({
                        Name = "Themes",
                        Flag = "Themes",
                        Default = "",
                        Items = { },
                        Callback = function(Value)
                            ThemeSelected = Value
                        end
                    })

                    ThemingSection:Textbox({
                        Name = "Theme name",
                        Flag = "ThemeName",
                        Default = "",
                        Callback = function(Value)
                            ThemeName = Value
                        end
                    })

                    ThemingSection:Button({
                        Name = "Save",
                        Callback = function()
                            if ThemeName then 
                                if ThemeName == "" then 
                                    return
                                end

                                if isfile(ThemesFolder .. ThemeName .. ".json") then 
                                    Library:Notification("Saved theme "..ThemeName, 3, Library.Theme.Accent)
                                    writefile(ThemesFolder .. ThemeName .. ".json", Library:GetConfig())
                                    return
                                end

                                writefile(ThemesFolder .. ThemeName .. ".json", Library:GetConfig())
                                Library:GetThemesList(ThemesDropdown)
                                Library:Notification("Created theme "..ThemeName, 3, Library.Theme.Accent)
                            end
                        end
                    })

                    ThemingSection:Button({
                        Name = "Load",
                        Callback = function()
                            if ThemeSelected then 
                                if not isfile(ThemesFolder .. ThemeSelected .. ".json") then
                                    Library:Notification("Theme does not exist", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                local Success, Error = Library:LoadConfig(readfile(ThemesFolder .. ThemeSelected .. ".json"))

                                if Success then 
                                    Library:Notification("Loaded theme "..ThemeSelected .. " succesfully", 3, Library.Theme.Accent)
                                else
                                    Library:Notification("Failed to load theme "..ThemeSelected .. " report this to the devs: "..Error, 3, Color3.fromRGB(255, 0, 0))
                                end
                            end
                        end
                    })

                    ThemingSection:Button({
                        Name = "Delete",
                        Callback = function()
                            if ThemeSelected then 
                                if not isfile(ThemesFolder .. ThemeSelected .. ".json") then
                                    Library:Notification("Theme does not exist", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                delfile(ThemesFolder .. ThemeSelected .. ".json")
                                Library:GetThemesList(ThemesDropdown)
                                Library:Notification("Deleted theme "..ThemeSelected, 3, Library.Theme.Accent)
                            end
                        end
                    })

                    Library:GetThemesList(ThemesDropdown)
                end
                
                local MenuSection = SettingsPage:Section({Name = "Menu", Side = 2}) do
                    MenuSection:Button({Name = "Exit", Callback = function()
                        Library:Exit()
                    end})

                    MenuSection:Label({ Name = "Menu Keybind" }):Keybind({
                        Name = "Menu Keybind",
                        Flag = "MenuKeybind",
                        Default = Library.MenuKeybind,
                        Mode = "Toggle",
                        Callback = function(Value)
                            Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
                        end
                    })

                    if Self.Watermark then
                        MenuSection:Toggle({
                            Name = "Watermark",
                            Flag = "Watermark",
                            Default = true,
                            Callback = function(Value)
                                Self.Watermark:SetVisibility(Value)
                            end
                        })
                    end

                    if Self.KeybindList then 
                        MenuSection:Toggle({
                            Name = "Keybind list",
                            Flag = "Keybind list",
                            Default = true,
                            Callback = function(Value)
                                Self.KeybindList:SetVisibility(Value)
                            end
                        })
                    end
                end

                local ConfigName 
                local ConfigSelected 
                local ConfigsFolder = Library.Directory .. Library.Folders.Configs .. "/"

                local ConfigsSection = SettingsPage:Section({Name = "Profiles", Side = 1}) do
                    local ConfigsList = ConfigsSection:List({
                        Flag = "Configs",
                        Items = { },
                        Multi = false,
                        Callback = function(Value)
                            ConfigSelected = Value
                        end
                    })

                    ConfigsSection:Textbox({
                        Name = "Config name",
                        Flag = "ConfigName",
                        Placeholder = "Config name",
                        Callback = function(Value)
                            ConfigName = Value 
                        end
                    })

                    ConfigsSection:Button({
                        Name = "Create",
                        Callback = function()
                            if ConfigName then 
                                if ConfigName == "" then 
                                    return
                                end

                                if isfile(ConfigsFolder .. ConfigName .. ".json") then 
                                    Library:Notification("Config with the name "..ConfigName.." already exists", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                writefile(ConfigsFolder .. ConfigName .. ".json", Library:GetConfig())
                                Library:GetConfigsList(ConfigsList)
                                Library:Notification("Created config "..ConfigName, 3, Library.Theme.Accent)
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "Load",
                        Callback = function()
                            if ConfigSelected then 
                                if not isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                                    Library:Notification("Config does not exist", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                local Success, Error = Library:LoadConfig(readfile(ConfigsFolder .. ConfigSelected .. ".json"))

                                if Success then 
                                    Library:Notification("Loaded config "..ConfigSelected .. " succesfully", 3, Library.Theme.Accent)
                                else
                                    Library:Notification("Failed to load config "..ConfigSelected .. " report this to the devs: "..Error, 3, Color3.fromRGB(255, 0, 0))
                                end
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "Delete",
                        Callback = function()
                            if ConfigSelected then 
                                if not isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                                    Library:Notification("Config does not exist", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                delfile(ConfigsFolder .. ConfigSelected .. ".json")
                                Library:GetConfigsList(ConfigsList)
                                Library:Notification("Deleted config "..ConfigSelected, 3, Library.Theme.Accent)
                            end
                        end
                    })

                    ConfigsSection:Button({
                        Name = "Overwrite",
                        Callback = function()
                            if ConfigSelected then 
                                if not isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                                    Library:Notification("Config does not exist", 3, Color3.fromRGB(255, 0, 0))
                                    return
                                end

                                writefile(ConfigsFolder .. ConfigSelected .. ".json", Library:GetConfig())
                                Library:Notification("Overwrote config "..ConfigSelected, 3, Library.Theme.Accent)
                            end
                        end
                    })

                    Library:GetConfigsList(ConfigsList)
                end


            end
        end
    end
end

getgenv().Library = Library
-- (library ready)
    return Library
end)()
do
-- ════════ bridge: the script talks to this (Obsidian style), this drives the red UI ════════
local ZR_RedWin
local ZR_ICON = "rbxthumb://type=Asset&id=129949624640047&w=150&h=150"
local ZR_UnloadFns = {}
local ZR_DepBoxes = {}

local function ZR_strip(s)
    return (tostring(s or ""):gsub("<[^>]+>", ""))
end

local function ZR_keyOf(name)
    if typeof(name) == "EnumItem" then return name end
    if type(name) ~= "string" or name == "" or name == "None" then return "None" end
    local ok, k = pcall(function() return Enum.KeyCode[name] end)
    if ok and k then return k end
    local ok2, m = pcall(function() return Enum.UserInputType[name] end)
    return ok2 and m or "None"
end

Library = {
    Options = {},
    Toggles = {},
    Unloaded = false,
    Toggled = true,
    CornerRadius = 3,
    ShowCustomCursor = false,
}
Options = Library.Options
Toggles = Library.Toggles
pcall(function()
    getgenv().Library = Library
    getgenv().Options = Options
    getgenv().Toggles = Toggles
end)

Library.Scheme = setmetatable({}, {
    __index = function(_, k)
        local T = ZR_Red.Theme
        if k == "BackgroundColor" then return T["Background"]
        elseif k == "MainColor" then return T["Inline"]
        elseif k == "AccentColor" then return T["Accent"]
        elseif k == "OutlineColor" then return T["Outline"]
        elseif k == "FontColor" then return T["Text"]
        elseif k == "Font" then return ZR_Red.Font
        end
    end,
})
for _, k in ipairs({ "MainColor", "BackgroundColor", "AccentColor", "OutlineColor", "FontColor" }) do
    Library[k] = Library.Scheme[k]
end

-- screen for the script's own overlays (hit notifications etc.)
do
    local sg = Instance.new("ScreenGui")
    sg.Name = "\0"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 100
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() sg.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not sg.Parent then sg.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
    Library.ScreenGui = sg
    local kf = Instance.new("Frame")
    kf.Visible = false
    kf.BackgroundTransparency = 1
    kf.Parent = sg
    Library.KeybindFrame = kf
end

do
    local realExit = ZR_Red.Exit
    ZR_Red.Exit = function(self, ...)
        if not Library.Unloaded then
            Library.Unloaded = true
            for _, f in ipairs(ZR_UnloadFns) do pcall(f) end
            pcall(function() Library.ScreenGui:Destroy() end)
        end
        return realExit(self, ...)
    end
end

function Library:OnUnload(fn) table.insert(ZR_UnloadFns, fn) end
function Library:Unload() pcall(function() ZR_Red:Exit() end) end
function Library:Toggle(v)
    pcall(function()
        if v == nil then v = not ZR_RedWin.IsOpen end
        if ZR_RedWin.IsOpen ~= v then ZR_RedWin:SetOpen(v) end
    end)
end
function Library:SetNotifySide() end
function Library:AddToRegistry() end
function Library:Notify(c, t)
    c = type(c) == "table" and c or { Description = tostring(c), Time = t }
    local title, desc = ZR_strip(c.Title), ZR_strip(c.Description)
    local text = (title ~= "" and desc ~= "") and (title .. "  -  " .. desc) or (title ~= "" and title or desc)
    pcall(function() ZR_Red:Notification(text, tonumber(c.Time) or 4, ZR_Red.Theme.Accent) end)
end

-- watermark
local ZR_WM, ZR_WMText
function Library:SetWatermark(text)
    pcall(function() if ZR_WMText then ZR_WMText:SetText(ZR_strip(text)) end end)
end
function Library:SetWatermarkVisibility(v)
    pcall(function() if ZR_WM then ZR_WM:SetVisibility(v == true) end end)
end

-- shown-when boxes
function Library:UpdateDependencyBoxes()
    for _, d in ipairs(ZR_DepBoxes) do pcall(d.__update) end
end

local function ZR_wrap(F, cb, conv)
    return function(v)
        if conv then v = conv(v) end
        F.Value = v
        if not F.__ready or F.__mute then return end
        for _, f in ipairs(F.__changed) do pcall(f, v) end
        if F.Changed then pcall(F.Changed, v) end
        if cb then
            local ok, err = pcall(cb, v)
            if not ok then warn("[ZRHUB] " .. tostring(err)) end
        end
        Library:UpdateDependencyBoxes()
    end
end

local function ZR_newF(holder)
    local F = { __changed = {}, __ready = false, __mute = false, __visible = true }
    function F:OnChanged(fn) table.insert(F.__changed, fn) end
    function F:SetVisible(v)
        F.__visible = v == true
        pcall(function() F.__el:SetVisibility(v == true) end)
    end
    function F:Display() end
    function F:SetDisabled() end
    if holder then table.insert(holder, F) end
    return F
end

local function ZR_addKey(holder, id, cfg, onChange)
    local K = { Toggled = false, Mode = cfg.Mode or "Toggle", Value = cfg.Default or "None" }
    local last = false
    local ok, kb = pcall(function()
        return holder:Keybind({
            Name = ZR_strip(cfg.Text or "Keybind"),
            Flag = id,
            Default = ZR_keyOf(cfg.Default),
            Mode = (cfg.Mode == "Hold" or cfg.Mode == "Always") and cfg.Mode or "Toggle",
            Callback = function(state)
                state = state == true
                K.Toggled = state
                if state ~= last then
                    last = state
                    pcall(onChange, state)
                end
            end,
        })
    end)
    K.__el = ok and kb or nil
    function K:GetState() return K.Toggled end
    function K:SetValue() end
    function K:OnClick() end
    function K:OnChanged() end
    Options[id] = K
    return K
end

local function ZR_addColor(holder, id, cfg)
    local C = { Value = cfg.Default or Color3.new(1, 1, 1), Transparency = cfg.Transparency or 0, __changed = {} }
    local ok, cp = pcall(function()
        return holder:Colorpicker({
            Name = ZR_strip(cfg.Title or "Color"),
            Flag = id,
            Default = C.Value,
            Callback = function(col)
                C.Value = col
                if cfg.Callback then pcall(cfg.Callback, col) end
                for _, f in ipairs(C.__changed) do pcall(f, col) end
            end,
        })
    end)
    C.__el = ok and cp or nil
    function C:SetValueRGB(col) pcall(function() C.__el:Set(col, 0) end) end
    function C:SetValue(col) C:SetValueRGB(col) end
    function C:OnChanged(fn) table.insert(C.__changed, fn) end
    Options[id] = C
    return C
end

-- builds the add-functions for one section (a groupbox, a tabbox tab or a shown-when box)
local function ZR_makeAdders(sec, list)
    local B = {}

    function B:AddToggle(id, cfg)
        cfg = cfg or {}
        local F = ZR_newF(list)
        F.Text = cfg.Text
        F.__el = sec:Toggle({
            Name = ZR_strip(cfg.Text),
            Flag = id,
            Default = cfg.Default == true,
            Callback = ZR_wrap(F, cfg.Callback, function(v) return v == true end),
        })
        F.Value = F.__el.Value == true
        F.__ready = true
        F.__hasKey = false
        function F:SetValue(v) F.__el:Set(v == true) end
        function F:AddKeyPicker(kid, kcfg)
            kcfg = kcfg or {}
            F.__hasKey = true
            if kid == "MenuKeybind" then return F end
            ZR_addKey(F.__el, kid, kcfg, function(state)
                if kcfg.SyncToggleState == false then
                    if kcfg.Callback then pcall(kcfg.Callback, state) end
                else
                    F:SetValue(not F.Value)
                    if kcfg.Callback then pcall(kcfg.Callback, F.Value) end
                end
            end)
            return F
        end
        function F:AddColorPicker(cid, ccfg)
            ZR_addColor(F.__el, cid, ccfg or {})
            return F
        end
        -- every toggle gets a keybind
        task.defer(function()
            if not F.__hasKey then
                F:AddKeyPicker(id .. "_ZRKey", { Default = "None", Mode = "Toggle", Text = cfg.Text })
            end
        end)
        Toggles[id] = F
        return F
    end

    function B:AddSlider(id, cfg)
        cfg = cfg or {}
        local F = ZR_newF(list)
        local r = tonumber(cfg.Rounding) or 0
        local mn, mx = tonumber(cfg.Min) or 0, tonumber(cfg.Max) or 100
        F.Suffix = cfg.Suffix or ""
        F.Min, F.Max = mn, mx
        F.__el = sec:Slider({
            Name = ZR_strip(cfg.Text),
            Flag = id,
            Min = mn,
            Max = mx,
            Default = math.clamp(tonumber(cfg.Default) or mn, mn, mx),
            Decimals = r > 0 and 10 ^ -r or 1,
            Suffix = F.Suffix,
            Callback = ZR_wrap(F, cfg.Callback),
        })
        F.Value = F.__el.Value
        F.__ready = true
        function F:SetValue(v) F.__el:Set(tonumber(v) or F.Value) end
        local function redraw()
            F.__mute = true
            pcall(function()
                F.__el.Suffix = F.Suffix or ""
                F.__el:Set(F.__el.Value)
            end)
            F.__mute = false
        end
        function F:Display() redraw() end
        function F:SetMin(a) F.Min = a; F.__el.Min = a; redraw() end
        function F:SetMax(b) F.Max = b; F.__el.Max = b; redraw() end
        Options[id] = F
        return F
    end

    function B:AddDropdown(id, cfg)
        cfg = cfg or {}
        local F = ZR_newF(list)
        local multi = cfg.Multi == true
        local values = cfg.Values or {}
        local default = cfg.Default
        if multi then
            local l = {}
            if type(default) == "table" then
                for k, v in pairs(default) do
                    if type(k) == "number" then table.insert(l, v) elseif v then table.insert(l, k) end
                end
            elseif type(default) == "string" then
                l = { default }
            end
            default = l
        else
            if type(default) == "number" and values[default] ~= nil then default = values[default] end
            if default == nil or not table.find(values, default) then
                default = (not cfg.AllowNull) and values[1] or nil
            end
        end
        local function toSet(v)
            if not multi then return v end
            local set = {}
            for _, x in ipairs(type(v) == "table" and v or {}) do set[x] = true end
            return set
        end
        F.Multi = multi
        F.__el = sec:Dropdown({
            Name = ZR_strip(cfg.Text),
            Flag = id,
            Items = values,
            Default = default or "",
            Multi = multi,
            Callback = ZR_wrap(F, cfg.Callback, toSet),
        })
        F.Value = toSet(F.__el.Value)
        if not multi and F.Value == "" then F.Value = nil end
        F.Values = values
        F.__ready = true
        function F:SetValue(v)
            if multi then
                local l = {}
                for k, on in pairs(type(v) == "table" and v or {}) do
                    if type(k) == "number" then table.insert(l, on) elseif on then table.insert(l, k) end
                end
                F.__el:Set(l)
            else
                F.__el:Set(v)
            end
        end
        function F:SetValues(newList)
            F.Values = newList or {}
            pcall(function() F.__el:Refresh(F.Values) end)
        end
        function F:AddValues(more)
            for _, v in ipairs(more or {}) do table.insert(F.Values, v) end
            F:SetValues(F.Values)
        end
        Options[id] = F
        return F
    end

    function B:AddInput(id, cfg)
        cfg = cfg or {}
        local F = ZR_newF(list)
        F.__el = sec:Textbox({
            Name = ZR_strip(cfg.Text),
            Flag = id,
            Default = tostring(cfg.Default or ""),
            Placeholder = tostring(cfg.Placeholder or ""),
            Numeric = cfg.Numeric == true,
            Finished = cfg.Finished ~= false,
            Callback = ZR_wrap(F, cfg.Callback),
        })
        F.Value = F.__el.Value
        F.__ready = true
        function F:SetValue(v) F.__el:Set(tostring(v)) end
        Options[id] = F
        return F
    end
    B.AddTextbox = B.AddInput

    function B:AddButton(a, b)
        local text, func
        if type(a) == "table" then text, func = a.Text, a.Func or a.Callback else text, func = a, b end
        local F = ZR_newF(list)
        F.__el = sec:Button({
            Name = ZR_strip(text),
            Callback = function()
                if func then
                    local ok, err = pcall(func)
                    if not ok then warn("[ZRHUB] " .. tostring(err)) end
                end
            end,
        })
        function F:AddButton(...) return B:AddButton(...) end
        return F
    end

    function B:AddLabel(a, wrap)
        local text = type(a) == "table" and (a.Text or "") or a
        if type(a) == "table" then wrap = a.DoesWrap end
        local F = ZR_newF(list)
        F.__el = sec:Label({ Name = ZR_strip(text) })
        if wrap then
            pcall(function()
                local items = F.__el.Items
                local holderFrame = items["Label"].Instance
                local lbl = items["Text"].Instance
                holderFrame.AutomaticSize = Enum.AutomaticSize.Y
                lbl.AutomaticSize = Enum.AutomaticSize.Y
                lbl.Size = UDim2.new(1, -4, 0, 12)
                lbl.TextWrapped = true
            end)
        end
        function F:SetText(t) pcall(function() F.__el:SetText(ZR_strip(t)) end) end
        function F:AddKeyPicker(kid, kcfg)
            kcfg = kcfg or {}
            if kid == "MenuKeybind" then return F end
            ZR_addKey(F.__el, kid, kcfg, function(state)
                if kcfg.Callback then pcall(kcfg.Callback, state) end
            end)
            return F
        end
        function F:AddColorPicker(cid, ccfg)
            ZR_addColor(F.__el, cid, ccfg or {})
            return F
        end
        return F
    end

    function B:AddDivider() return {} end

    function B:AddDependencyBox()
        local D = { __elements = {}, __deps = {}, __parent = list and list.__dep or nil }
        D.__elements.__dep = D
        local adders = ZR_makeAdders(sec, D.__elements)
        for k, v in pairs(adders) do D[k] = v end
        local function wanted(el, val)
            if el == nil then return true end
            local cur = el.Value
            if type(cur) == "table" then return cur[val] == true end
            return cur == val
        end
        function D.__shown()
            if D.__parent and not D.__parent.__shown() then return false end
            for _, dep in ipairs(D.__deps) do
                if not wanted(dep[1], dep[2]) then return false end
            end
            return true
        end
        function D.__update()
            local show = D.__shown()
            for _, el in ipairs(D.__elements) do
                if el.SetVisible then pcall(el.SetVisible, el, show) end
            end
        end
        function D:SetupDependencies(deps)
            D.__deps = deps or {}
            for _, dep in ipairs(D.__deps) do
                local el = dep[1]
                if type(el) == "table" and el.OnChanged then
                    pcall(function() el:OnChanged(function() D.__update() end) end)
                end
            end
            D.__update()
            task.defer(D.__update)
        end
        table.insert(ZR_DepBoxes, D)
        -- elements added later still follow the box
        task.defer(D.__update)
        return D
    end

    function B:AddUIPassthrough(_, cfg)
        local holderFrame = Instance.new("Frame")
        holderFrame.Name = "\0"
        holderFrame.BackgroundTransparency = 1
        holderFrame.ClipsDescendants = true
        holderFrame.Size = UDim2.new(1, 0, 0, tonumber(cfg and cfg.Height) or 100)
        if cfg and cfg.Instance then cfg.Instance.Parent = holderFrame end
        holderFrame.Parent = sec.Items["Content"].Instance
        local P = {}
        function P:SetHeight(h) holderFrame.Size = UDim2.new(1, 0, 0, h) end
        return P
    end

    return B
end

local function ZR_section(page, name, side)
    return ZR_makeAdders(page:Section({ Name = ZR_strip(name), Side = side }), nil)
end

local ZR_TAB_ICONS = {
    combat = "swords", character = "person-standing", visuals = "eye", world = "earth",
    misc = "circle-ellipsis", settings = "settings", credits = "info",
}

function Library:CreateWindow(cfg)
    ZR_RedWin = ZR_Red:Window({ Name = "ZRHUB", Icon = ZR_ICON })
    Library.__win = ZR_RedWin
    -- keep Library.Toggled + a Visible flag in step with the menu
    local holder = Instance.new("Frame")
    holder.Visible = true
    holder.BackgroundTransparency = 1
    holder.Size = UDim2.new()
    holder.Parent = Library.ScreenGui
    local realSetOpen = ZR_RedWin.SetOpen
    ZR_RedWin.SetOpen = function(self, b)
        realSetOpen(self, b)
        Library.Toggled = ZR_RedWin.IsOpen == true
        holder.Visible = Library.Toggled
    end
    Library.Toggled = ZR_RedWin.IsOpen ~= false
    pcall(function()
        ZR_WM = ZR_RedWin:Watermark({ Name = "ZRHUB" })
        ZR_WMText = ZR_WM:Add("Rivals")
    end)

    local W = { MainFrame = holder, Holder = holder }
    function W:AddTab(name, icon)
        local lname = string.lower(tostring(name))
        if lname == "ui settings" then lname = "settings" end
        icon = ZR_TAB_ICONS[lname] or icon
        local page = ZR_RedWin:Page({ Name = lname, Icon = icon })
        if lname == "settings" then ZR_Red.__SettingsPage = page end
        local T = {}
        function T:AddLeftGroupbox(n) return ZR_section(page, n, 1) end
        function T:AddRightGroupbox(n) return ZR_section(page, n, 2) end
        function T:AddGroupbox(n) return ZR_section(page, type(n) == "table" and n.Name or n, 1) end
        local function tabbox(side)
            local TB = {}
            local first
            function TB:AddTab(tn)
                tn = tostring(tn or "")
                local label = first and (first .. " - " .. tn) or tn
                first = first or tn
                return ZR_section(page, label, side)
            end
            return TB
        end
        function T:AddLeftTabbox() return tabbox(1) end
        function T:AddRightTabbox() return tabbox(2) end
        function T:AddTabbox(c) return tabbox((type(c) == "table" and c.Side == 2) and 2 or 1) end
        return T
    end
    return W
end

-- Toggle + Lock bar (Obsidian style), left side of the screen
function ZR_AddOpenButton()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local T = ZR_Red.Theme
    local face = ZR_Red.Font or Font.fromEnum(Enum.Font.Arial)

    local gui = Instance.new("ScreenGui")
    gui.Name = "\0"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
    if not gui.Parent then gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

    local bar = Instance.new("Frame")
    bar.AnchorPoint = Vector2.new(0, 0.5)
    bar.Position = UDim2.new(0, 12, 0.5, 0)
    bar.Size = UDim2.new(0, 0, 0, 32)
    bar.AutomaticSize = Enum.AutomaticSize.X
    bar.BackgroundColor3 = T["Inline"]
    bar.BorderSizePixel = 0
    bar.Parent = gui
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 5)
    local outline = Instance.new("UIStroke")
    outline.Color = T["Outline"]
    outline.Parent = bar
    local content = Instance.new("Frame")
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(0, 0, 1, 0)
    content.AutomaticSize = Enum.AutomaticSize.X
    content.Parent = bar
    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Horizontal
    list.VerticalAlignment = Enum.VerticalAlignment.Center
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = content
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = T["Accent"]
    line.Size = UDim2.new(1, -10, 0, 1)
    line.Position = UDim2.new(0, 5, 0, 0)
    line.ZIndex = 3
    line.Parent = bar
    local lg = Instance.new("UIGradient")
    lg.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) })
    lg.Parent = line

    local function iconImage(parent, name, size)
        local img = Instance.new("ImageLabel")
        img.BackgroundTransparency = 1
        img.Size = UDim2.new(0, size, 0, size)
        img.ImageColor3 = T["Text"]
        img.Parent = parent
        local function apply(n)
            local i = ZR_Red.GetIcon and ZR_Red:GetIcon(n)
            if i then
                img.Image = i.Url or ("rbxassetid://" .. tostring(i.Id))
                img.ImageRectOffset = i.ImageRectOffset or Vector2.zero
                img.ImageRectSize = i.ImageRectSize or Vector2.zero
            end
        end
        apply(name)
        return img, apply
    end

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.AutoButtonColor = false
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.Size = UDim2.new(0, 0, 1, 0)
    toggleBtn.AutomaticSize = Enum.AutomaticSize.X
    toggleBtn.LayoutOrder = 1
    toggleBtn.Parent = content
    local tl = Instance.new("UIListLayout")
    tl.FillDirection = Enum.FillDirection.Horizontal
    tl.VerticalAlignment = Enum.VerticalAlignment.Center
    tl.Padding = UDim.new(0, 6)
    tl.SortOrder = Enum.SortOrder.LayoutOrder
    tl.Parent = toggleBtn
    local tp = Instance.new("UIPadding")
    tp.PaddingLeft = UDim.new(0, 10)
    tp.PaddingRight = UDim.new(0, 10)
    tp.Parent = toggleBtn
    local menuIcon = iconImage(toggleBtn, "menu", 15)
    menuIcon.LayoutOrder = 1
    local toggleText = Instance.new("TextLabel")
    toggleText.BackgroundTransparency = 1
    toggleText.FontFace = face
    toggleText.TextSize = 13
    toggleText.Text = "Toggle"
    toggleText.TextColor3 = T["Text"]
    toggleText.AutomaticSize = Enum.AutomaticSize.X
    toggleText.Size = UDim2.new(0, 0, 1, 0)
    toggleText.LayoutOrder = 2
    toggleText.Parent = toggleBtn

    local div = Instance.new("Frame")
    div.BorderSizePixel = 0
    div.BackgroundColor3 = T["Outline"]
    div.Size = UDim2.new(0, 1, 0, 18)
    div.LayoutOrder = 2
    div.Parent = content

    local lockBtn = Instance.new("TextButton")
    lockBtn.AutoButtonColor = false
    lockBtn.BackgroundTransparency = 1
    lockBtn.Text = ""
    lockBtn.Size = UDim2.new(0, 34, 1, 0)
    lockBtn.LayoutOrder = 3
    lockBtn.Parent = content
    local lockIcon, setLockIcon = iconImage(lockBtn, "lock-open", 15)
    lockIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    lockIcon.Position = UDim2.new(0.5, 0, 0.5, 0)

    local function tween(o, props) TS:Create(o, TweenInfo.new(0.2), props):Play() end
    local function refresh()
        local open = ZR_RedWin and ZR_RedWin.IsOpen
        local accent = ZR_Red.Theme["Accent"]
        local text = ZR_Red.Theme["Text"]
        tween(menuIcon, { ImageColor3 = open and accent or text })
        tween(toggleText, { TextColor3 = open and accent or text })
        tween(lockIcon, { ImageColor3 = ZR_Red.DragLocked and accent or text })
        tween(outline, { Color = ZR_Red.DragLocked and accent or ZR_Red.Theme["Outline"] })
        setLockIcon(ZR_Red.DragLocked and "lock" or "lock-open")
    end

    local dragging, moved, startPos, startInput
    toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, moved = true, false
            startPos, startInput = bar.Position, input.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging or ZR_Red.DragLocked then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - startInput
            if d.Magnitude > 8 then moved = true end
            if moved then
                bar.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if not moved then
                Library:Toggle()
                task.delay(0.05, refresh)
            end
        end
    end)
    lockBtn.MouseButton1Click:Connect(function()
        ZR_Red.DragLocked = not ZR_Red.DragLocked
        refresh()
        Library:Notify({ Title = "ZRHUB", Description = ZR_Red.DragLocked and "Menu locked in place." or "Menu unlocked.", Time = 2 })
    end)

    task.spawn(function()
        while gui.Parent and not Library.Unloaded do
            task.wait(0.4)
            bar.BackgroundColor3 = ZR_Red.Theme["Inline"]
            div.BackgroundColor3 = ZR_Red.Theme["Outline"]
            line.BackgroundColor3 = ZR_Red.Theme["Accent"]
            refresh()
        end
    end)
    refresh()
    Library:OnUnload(function() pcall(function() gui:Destroy() end) end)
end

-- settings page extras + credits page (called at the very end)
function ZR_Finish()
    pcall(function() ZR_RedWin:Init() end)
    local credits = ZR_section(ZR_RedWin:Page({ Name = "credits", Icon = "info" }), "Credits", 1)
    credits:AddLabel("Made by tung zo1os")
    credits:AddButton({
        Text = "Copy Discord Link",
        Func = function()
            pcall(setclipboard, "https://discord.gg/TCuMcKy9j4")
            Library:Notify({ Title = "Copied!", Description = "Discord link copied.", Time = 3 })
        end,
    })
    ZR_AddOpenButton()
end

-- Obsidian add-ons are replaced by the red UI's own settings page
local function ZR_stub()
    return setmetatable({}, { __index = function() return function() end end })
end
ThemeManager = ZR_stub()
SaveManager = ZR_stub()
pcall(function()
    getgenv().ThemeManager = ThemeManager
    getgenv().SaveManager = SaveManager
end)
end
getgenv().Library = Library;

-- old ZRHUB widgets (radar, player list, velocity, closest player, watermark) still come from the original lib
for _, name in ipairs({ "CreateRadarOverlay", "CreatePlayerListOverlay", "CreateVelocityGraphOverlay", "CreateClosestPlayerOverlay" }) do
    Library[name] = function(_, cfg) return FourLib[name](FourLib, cfg) end;
end;
Library.Overlays = FourLib.Overlays;
Library.Watermark = FourLib.Watermark;
function Library:UpdateOverlayGlow(o) return FourLib:UpdateOverlayGlow(o) end;
function Library:SetOverlayGlowColor(c) return FourLib:SetOverlayGlowColor(c) end;
function Library:SetWatermarkVisibility(v) return FourLib:SetWatermarkVisibility(v) end;
function Library:SetAccentTitle(...) return FourLib:SetAccentTitle(...) end;
function Library:UpdateMenuBlur() end;
Library.KeybindOverlay = {
    SetVisible = function(_, v)
        pcall(function() Library.KeybindFrame.Visible = v end);
    end;
};
if type(Library.Create) ~= "function" then
    function Library:Create(Class, Props)
        local inst = typeof(Class) == "Instance" and Class or Instance.new(Class);
        local parent;
        for k, v in pairs(Props or {}) do
            if k == "Parent" then parent = v else pcall(function() inst[k] = v end) end;
        end;
        if parent then inst.Parent = parent end;
        return inst;
    end;
end;
if type(Library.AddToRegistry) ~= "function" then function Library:AddToRegistry() end end;
if type(Library.RemoveFromRegistry) ~= "function" then function Library:RemoveFromRegistry() end end;
if type(Library.UpdateColorsUsingRegistry) ~= "function" then function Library:UpdateColorsUsingRegistry() end end;
Library.RegistryMap = Library.RegistryMap or {};

-- colour / state names the script reads from the old lib
local function ZRHUB_syncScheme()
    local s = Library.Scheme or {};
    Library.AccentColor = s.AccentColor or Color3.fromRGB(125, 85, 255);
    Library.MainColor = s.MainColor or Color3.fromRGB(25, 25, 25);
    Library.BackgroundColor = s.BackgroundColor or Color3.fromRGB(15, 15, 15);
    Library.OutlineColor = s.OutlineColor or Color3.fromRGB(40, 40, 40);
    Library.FontColor = s.FontColor or Color3.new(1, 1, 1);
    Library.MenuOpen = Library.Toggled == true;
end;
ZRHUB_syncScheme();
local ZRHUB_syncConn = game:GetService("RunService").Heartbeat:Connect(function() pcall(ZRHUB_syncScheme) end);
Library:OnUnload(function()
    pcall(function() ZRHUB_syncConn:Disconnect() end);
    pcall(function() FourLib:Unload() end);
end);
end;

local Trove = (function()
    local Trove = {};
    Trove.__index = Trove;

    function Trove.new()
        return setmetatable({ _objects = {} }, Trove);
    end;

    function Trove:Add(object)
        self._objects[#self._objects + 1] = object;
        return object;
    end;

    function Trove:Destroy()
        local objects = self._objects;
        self._objects = {};
        for i = #objects, 1, -1 do
            local object = objects[i];
            local objectType = typeof(object);
            pcall(function()
                if objectType == 'RBXScriptConnection' then
                    object:Disconnect();
                elseif objectType == 'Instance' then
                    object:Destroy();
                elseif objectType == 'thread' then
                    task.cancel(object);
                elseif objectType == 'function' then
                    object();
                elseif objectType == 'table' then
                    if object.Destroy then
                        object:Destroy();
                    elseif object.Disconnect then
                        object:Disconnect();
                    end;
                end;
            end);
        end;
    end;

    Trove.Clean = Trove.Destroy;

    return Trove;
end)();

if not (type(Library) == "table" and Library.Options) then
    Library = getgenv().Library or Library;
end;
getgenv().Library = Library;
local Options = Library.Options;
local Toggles = Library.Toggles;
getgenv().silent_load = getgenv().silent_load or false;
getgenv().auto_load_enable = getgenv().auto_load_enable or false;
local Window = Library:CreateWindow({
    Title = 'ZRHUB',
    Icon = 'rbxthumb://type=Asset&id=129949624640047&w=150&h=150',
    Footer = 'Rivals',
    NotifySide = 'Right',
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    Resizable = true,
    Size = UDim2.fromOffset(740, 600),
});

if GLOBAL_TROVE then
    pcall(function()
        GLOBAL_TROVE:Destroy();
    end);
end;
local trove = Trove.new();
getgenv().GLOBAL_TROVE = trove;

Library:OnUnload(function()
    pcall(function()
        GLOBAL_TROVE:Destroy();
    end);
    getgenv().ZRHUB_loaded = false;
    getgenv().Library.Unloaded = true;
    getgenv().Library = nil;
end);

local font_indexes = {"ProggyClean", "Tahoma", "Verdana", "SmallestPixel", "ProggyTiny", "Minecraftia", "Tahoma Bold"};

local font_files = {
    ["ProggyClean"] = "ProggyClean.ttf",
    ["Tahoma"] = "fs-tahoma-8px.ttf",
    ["Verdana"] = "Verdana-Font.ttf",
    ["SmallestPixel"] = "smallest_pixel-7.ttf",
    ["ProggyTiny"] = "ProggyTiny.ttf",
    ["Minecraftia"] = "Minecraftia-Regular.ttf",
    ["Tahoma Bold"] = "tahoma_bold.ttf",
};

getgenv().fonts = {};
local fonts = getgenv().fonts;

task.spawn(function()
    for name, suffix in font_files do
        local ttf_path = "ZRHUB/rivals/fonts/" .. suffix;
        local font_path = "ZRHUB/rivals/fonts/" .. name .. ".font";

        if not isfile(ttf_path) then
            local okFont, font_data = pcall(game.HttpGet, game, "https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/" .. suffix);
            if okFont and type(font_data) == "string" and #font_data > 0 then
                writefile(ttf_path, font_data);
            else
                continue;
            end;
        end;

        local data = {
            name = name,
            faces = {{
                name = "Normal",
                weight = 400,
                style = "Normal",
                assetId = getcustomasset(ttf_path),
            }},
        };

        writefile(font_path, game:GetService("HttpService"):JSONEncode(data));

        fonts[name] = Font.new(getcustomasset(font_path), Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    end;
end);

local replicated_storage = cloneref(game:GetService("ReplicatedStorage"));
local players = cloneref(game:GetService("Players"));
local run_service = cloneref(game:GetService('RunService'));
local tween_service = cloneref(game:GetService('TweenService'));
local uis = cloneref(game:GetService("UserInputService"));
local http_service = cloneref(game:GetService("HttpService"));
local core_gui = cloneref(game:GetService("CoreGui"));
local lighting = cloneref(game:GetService("Lighting"));

local gethui = gethui or get_hui or get_hidden_gui or function()
    return core_gui;
end;

local local_player = players.LocalPlayer;
local camera = workspace.CurrentCamera;
local mouse = cloneref(local_player:GetMouse());
local modules = replicated_storage.Modules;
local first_person = workspace.ViewModels.FirstPerson;
local utility = require(modules.Utility);
local enum_lib = require(modules.EnumLibrary);
local item_lib = require(modules.ItemLibrary);
local cosmetic_lib = require(modules.CosmeticLibrary);
local data_ctrl = require(local_player.PlayerScripts.Controllers.PlayerDataController);
local rep_class = require(replicated_storage.Modules.ReplicatedClass);
local equip_remote = replicated_storage.Remotes.Data.EquipCosmetic;
local fav_remote = replicated_storage.Remotes.Data.FavoriteCosmetic;
local finishers = replicated_storage.Modules.Finishers;
local gun = require(local_player.PlayerScripts.Modules.ItemTypes.Gun);
local katana = require(local_player.PlayerScripts.Modules.Items.Katana);
local fighter_controller = require(local_player.PlayerScripts.Controllers.FighterController);
local camera_controller = require(local_player.PlayerScripts.Controllers.CameraController);
local mechanics_controller = require(local_player.PlayerScripts.Controllers.MechanicsController);
local tracer_effect = require(local_player.PlayerScripts.Modules.TracerEffect);
local pages = require(local_player.PlayerScripts.Modules.UserInterface.Pages);
local client_entity = require(local_player.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity);
local client_viewmodel = require(local_player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem.ClientViewModel);
local duel_controller = require(local_player.PlayerScripts.Controllers.DuelController);
local client_item = require(local_player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem);
local controls_controller = require(local_player.PlayerScripts.Controllers.ControlsController);
local player_data_controller = require(local_player.PlayerScripts.Controllers.PlayerDataController);
local equipment_state = require(local_player.PlayerScripts.Modules.UserInterface.Equipment.Interface.Customize.Options);
local cosmetic_state = require(local_player.PlayerScripts.Modules.UserInterface.Equipment.Interface.Customize.Cosmetics);
local cosmetic_inventory = player_data_controller:Get('CosmeticInventory');
local finisher = require(local_player.PlayerScripts.Modules.UserInterface.Equipment.Scene.FinisherPlayer);
local local_fighter = fighter_controller.LocalFighter;
local in_match = local_fighter:Get("IsInDuel") == true;
local trove = GLOBAL_TROVE;
local new_drawing = Drawing.new;
local old_force_auto = {};
local old_jump_fist = mechanics_controller._original_jump_power;
local oldoffsets = {};
local clickedontheremote = false;
local was_i_in_a_match = false;
local thisisforsubspace = {
    ['Subspace Tripmine'] = 'SubspaceTripmineHitbox'
};

local Tabs = {
    Home = Window:AddTab('Home', 'house'),
    Main = Window:AddTab('combat', 'crosshair'),
    visualstab = Window:AddTab('visuals', 'eye'),
    esptab = Window:AddTab('esp', 'scan-eye'),
    worldtab = Window:AddTab('world', 'globe'),
    character_tab = Window:AddTab('character', 'user'),
    misc_tab = Window:AddTab('misc', 'layers'),
    optimizations = Window:AddTab('optimizations', 'gauge'),
    ['UI Settings'] = Window:AddTab('settings', 'settings'),
    Credits = Window:AddTab('Credits', 'user'),
};

-- ===================== Home =====================
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local lp = Players.LocalPlayer
    local me = Tabs.Home:AddLeftGroupbox("ZRHUB", "user-round")
    local avatar = Instance.new("ImageLabel")
    avatar.BackgroundTransparency = 1
    avatar.Size = UDim2.new(1.4, 0, 1.4, 0)
    avatar.Position = UDim2.new(-0.2, 0, -0.2, 0)
    avatar.ScaleType = Enum.ScaleType.Fit
    avatar.Image = "rbxthumb://type=AvatarThumbnail&id=" .. tostring(lp.UserId) .. "&w=420&h=420"
    local pass
    pcall(function() pass = me:AddUIPassthrough("ZR_HomeAvatar", { Instance = avatar, Height = 225 }) end)
    task.spawn(function()
        local ok, image = pcall(function()
            return Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
        end)
        if ok and type(image) == "string" then pcall(function() avatar.Image = image end) end
        task.wait(0.1)
        local parent = avatar.Parent
        if parent and pass then
            local function fit()
                local x = parent.AbsoluteSize.X
                if x > 0 then pcall(function() pass:SetHeight(math.clamp(x, 180, 270)) end) end
            end
            fit()
            parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit)
        end
    end)
    local statsBox = Tabs.Home:AddRightGroupbox("Statistics", "blinds")
    local lTime = statsBox:AddLabel("Current time: <b>--:--</b>")
    local lFps = statsBox:AddLabel("FPS: <b>--</b>")
    local lPing = statsBox:AddLabel("Ping: <b>-- ms</b>")
    statsBox:AddDivider()
    local lPlayers = statsBox:AddLabel("Players in server: <b>--</b>")
    local lElapsed = statsBox:AddLabel("Elapsed time: <b>0 seconds</b>")
    local started, frames = tick(), 0
    local fc = RunService.RenderStepped:Connect(function() frames += 1 end)
    task.spawn(function()
        while not Library.Unloaded do
            task.wait(1)
            local fps = frames
            frames = 0
            pcall(function() lTime:SetText(string.format("Current time: <b>%s</b>", os.date("%H:%M"))) end)
            pcall(function() lFps:SetText("FPS: <b>" .. fps .. "</b>") end)
            pcall(function() lPing:SetText("Ping: <b>" .. math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5) .. " ms</b>") end)
            pcall(function() lPlayers:SetText("Players in server: <b>" .. #Players:GetPlayers() .. " / " .. Players.MaxPlayers .. "</b>") end)
            pcall(function() lElapsed:SetText("Elapsed time: <b>" .. math.floor(tick() - started) .. " seconds</b>") end)
        end
        fc:Disconnect()
    end)
end


getgenv().ZRHUB = {
    optimizations = {
        no_particles = false,
        no_shadows = false,
        low_quality = false,
        no_postfx = false,
        no_textures = false,
        no_atmosphere = false,
        fps_cap_enable = false,
        fps_cap = 60,
    },
    silent_aim = {
        enable = false,
        visualize = false,
        visualize_color = Color3.fromRGB(255, 40, 40),
        closest_part = false,
        show_fov = false,
        show_fill = false,
        fov_radius = 180,
        lerp = 0,
        follow_target = false,
        follow_gunpoint = false,
        fov_color = Color3.fromRGB(255, 40, 40),
        fov_fill_color = Color3.fromRGB(255, 40, 40),
        fov_fill_color2 = Color3.fromRGB(255, 255, 255),
        fov_fill_transparency = 0.6,
        fov_outline_transparency = 0.2,
        fov_thickness = 2,
        fov_color2 = Color3.fromRGB(255, 255, 255),
        fov_rotation_speed = 90,
        hit_chance = 100,
        riot_shield = false,
    },
    ragebot = {
        enable = false,
        ffa_mode = false,
        x = 0,
        y = 2,
        z = 0,
        prediction = true,
        prediction_amount = 1,
    },
    chams = {
        enable = false,
        team_check = false,
        mode = "highlight",
        fill_color = Color3.fromRGB(0, 170, 255),
        fill_transparency = 0.5,
        outline_color = Color3.fromRGB(255, 255, 255),
        outline_transparency = 0,
        material = "Neon",
        strip_textures = false,
        ghost = false,
    },
    crosshair = {
        enable = false,
        style = "cross",
        lines = true,
        top_line = true,
        bottom_line = true,
        left_line = true,
        right_line = true,
        rotation = 0,
        length = 6,
        thickness = 1,
        gap = 3,
        color = Color3.fromRGB(0, 255, 170),
        outline = false,
        outline_color = Color3.fromRGB(0, 0, 0),
        dot = false,
        rotating = false,
        rotating_speed = 120,
        spread = false,
        spread_scale = 1,
        animation = false,
        animation_mode = "pulse",
        animation_speed = 3,
        fade = false,
        fade_color = Color3.fromRGB(255, 0, 170),
        follow_target = false,
        follow_source = "target",
        shimmer = false,
        shimmer_speed = 4,
        text_enable = false,
        text_content = "ZRHUB",
        text_font = "Plex",
        text_size = 16,
        text_offset = 18,
        text_color = Color3.fromRGB(255, 255, 255),
        text_outline = true,
        text_animation = false,
    },
    aimbot = {
        enable = false,
        show_fov = false,
        follow_target = false,
        show_fill = false,
        fov_color = Color3.fromRGB(255, 40, 40),
        follow_gunpoint = false,
        fov_fill_color = Color3.fromRGB(255, 40, 40),
        fov_fill_color2 = Color3.fromRGB(255, 255, 255),
        fov_radius = 180,
        lerp = 0,
        fov_fill_transparency = 0.6,
        fov_outline_transparency = 0.2,
        fov_thickness = 2,
        fov_color2 = Color3.fromRGB(255, 255, 255),
        fov_rotation_speed = 90,
        smoothing = 1,
        closest_part = false,
    },

    auto_vote_map = {
        enable = false,
        map = "",
    },
    animation = {
        enable = false,
        select_animation = "",
        speed = 2,
    },

    triggerbot = {
        enable = false,
        team_check = false,
        reaction_time = 0.05,
        shoot_delay = 0.1,
        max_distance = 500,
    },
    weather = {
        enable = false,
        color = Color3.fromRGB(255, 255, 255),
        rate = 100,
        type = "snow",
    },
    esp = {
        enable = false,
        team_check = true,
        box = {
            enable = false,
            color = Color3.new(1, 1, 1),
            outline = Color3.new(0, 0, 0),
            inline = Color3.new(0, 0, 0),
            thickness = 1,
        },
        glow = {
            enable = false,
            color_start = Color3.new(1, 1, 1),
            color_end = Color3.new(1, 1, 1),
            transparency = 1,
            rotation = 90,
            speed = 2,
            animated = false,
        },
        filled = {
            enable = false,
            color_start = Color3.new(1, 1, 1),
            color_end = Color3.new(1, 1, 1),
            transparency = 0.75,
            rotation = 90,
            speed = 2,
            animated = false,
            hit_flash = false,
            hit_color = Color3.fromRGB(255, 40, 40),
            hit_time = 0.3,
        },
        visible = {
            enable = false,
            color = Color3.fromRGB(60, 255, 90),
        },
        highlight = {
            enable = false,
            fill_color = Color3.fromRGB(255, 40, 40),
            outline_color = Color3.fromRGB(255, 255, 255),
            fill_transparency = 0.55,
            outline_transparency = 0,
        },
        health = {
            enable = false,
            color_high = Color3.fromRGB(0, 255, 0),
            color_mid = Color3.fromRGB(255, 255, 0),
            color_low = Color3.fromRGB(255, 0, 0),
            width = 3,
            gap = 5,
        },
        text = {
            name = { enable = false, color = Color3.new(1, 1, 1) },
            studs = { enable = false, color = Color3.new(1, 1, 1) },
            tool = { enable = false, color = Color3.new(1, 1, 1), position = "right" },
            size = 9,
            gradient = false,
            gradient_color1 = Color3.fromRGB(255, 40, 40),
            gradient_color2 = Color3.fromRGB(255, 255, 255),
            flow = false,
            flow_speed = 1,
        },
        max_dist = 25000,
    },
    death_effects = {
        enable = false,
        type = "Explosion",
        color = Color3.fromRGB(255, 40, 40),
    },
    damage_numbers = {
        enable = false,
        remove_ingame = false,
        color_type = "Gradient",
        color1 = Color3.fromRGB(255, 80, 80),
        color2 = Color3.fromRGB(255, 210, 90),
        font = "GothamBold",
        duration = 0.8,
        rise = 42,
        text_size = 18,
    },
    trajectory = {
        enable = false,
        all_weapons = false,
        speed = 90,
        arc_up = 10,
        color = Color3.fromRGB(255, 40, 40),
    },
    target_hud = {
        enable = false,
        target_method = "",
        position_mode = "static",
        offset_x = 0,
        offset_y = 0,
        scale = 1,
    },

    world = {
        fog = false,
        fog_color = Color3.fromRGB(255, 255, 255),
        fog_start = 150,
        fog_end = 550,
        ambient = false,
        ambient_color = Color3.fromRGB(255, 255, 255),
        clock = false,
        clock_time = 14,
        brightness = false,
        brightness_level = 1,
        exposure = false,
        exposure_level = 0,
        color_shift_top = false,
        color_shift_top_color = Color3.fromRGB(255, 255, 255),
        color_shift_bottom = false,
        color_shift_bottom_color = Color3.fromRGB(255, 255, 255),
        skybox = false,
        skybox_selected = 'Deep Space',
        skybox_rotate = false,
        skybox_rotate_speed = 1,
        skybox_rotate_direction = 'Horizontal',
        skybox_rotate_method = 'Spin',
        skybox_remove_sun = false,
        skybox_remove_moon = false,
        skybox_remove_stars = false,
        atmosphere = false,
        atmosphere_glare = 1.5,
        atmosphere_haze = 10,
        atmosphere_offset = 0.4,
        atmosphere_density = 0.5,
        atmosphere_color = Color3.fromRGB(255, 255, 255),
        atmosphere_decay = Color3.fromRGB(90, 60, 30),
        blur = false,
        blur_size = 12,
        bloom = false,
        bloom_intensity = 1,
        bloom_size = 24,
        bloom_threshold = 0.9,
        depth_of_field = false,
        dof_focus = 25,
        dof_intensity = 0.15,
        sun_rays = false,
        sun_rays_intensity = 0.25,
        sun_rays_spread = 1,
        saturation = false,
        saturation_level = 0,
        contrast_level = 0,
        tint_color = Color3.fromRGB(255, 255, 255),
        lighting_technology = false,
        lighting_technology_mode = 'Future',
        global_shadows = true,
        env_diffuse = false,
        env_diffuse_scale = 1,
        env_specular = false,
        env_specular_scale = 1,
        outdoor_ambient = false,
        outdoor_ambient_color = Color3.fromRGB(70, 70, 70),
    },
    disable_anims = {
        enable = false,
        select = {},
    },
    fov_changer = {
        enable = false,
        fov = 80,
    },
    auto_slide = {
        enable = false,
    },
    guns = {
        no_muzzle_flash = false,
        no_spread = false,
        force_modifier_enable = false,
        force_modifier_v = 0,
    },
    targeting = {
        max_distance = 100,
        part = "Head",
        visible_only = false,
        anti_katana = false,
        riot_shield = false,
        auto_shoot = false,
    },
    device_spoof = {
        enable = false,
        type = "MouseKeyboard",
    },
    textures = {
        enable = false,
        material = "Brick",
        color = Color3.fromRGB(244, 244, 244),
        apply_to_viewmodel = false,
    },
    rage = {
        enable = false,
        auto = false,
        silent = false,
        hitpart = "HitboxHead",
        prediction = false,
        prediction_mult = 1.2,
        orbit_speed = 12,
        orbit_height = 2,
        orbit_radius = 0,
    },
    phase_spam = {
        enable = false,
        shoot_time = 1,
        hide_time = 1,
    },
    phase_hide = {
        enable = false,
    },
    profile = {
        spoof_local = false,
        spoof_local_name = "",
        spoof_other = false,
        spoof_other_name = "",
    },
    infinite_double_jump = {
        enable = false,
    },
    double_jump_height = {
        enable = false,
        height = 50,
    },
    sound_spammer = {
        enable = false,
        type = "DoubleJump",
    },
    auto_loadout = {
        enable = false,
        loadout = {
            'Assault Rifle', 'Handgun', 'Fists', 'Grenade'
        }
    },
    third_person = {
        enable = false,
    },
    arcade_server = {
        grab_drops = false,
        auto_respawn = false,
    },
    removals = {
        no_freeze_effect = false,
        no_burn_effect = false,
        no_flash_effect = false,
    },
    viewmodel_chams = {
        weapon_chams = {
            enable = false,
            color = Color3.fromRGB(255, 255, 255),
            material = "Neon",
            transparency = 0,
        },
        arm_chams = {
            enable = false,
            color = Color3.fromRGB(255, 255, 255),
            material = "Neon",
            transparency = 0,
            invisible = false,
        },
        weapon_highlight = {
            enable = false,
            color = Color3.fromRGB(255, 255, 255),
            transparency = 0.5,
            outline_color = Color3.fromRGB(255, 255, 255),
            outline_transparency = 0,
        },
        arm_highlight = {
            enable = false,
            color = Color3.fromRGB(255, 255, 255),
            transparency = 0.5,
            outline_color = Color3.fromRGB(255, 255, 255),
            outline_transparency = 0,
        },
    },
    viewmodel_offsets = {
        enable = false,
        x = 0,
        y = 0,
        z = 0,
    },
    viewmodel_custom = {
        enable = false,
        appearance = false,
        body = {
            color_enable = false,
            color = Color3.fromRGB(255, 255, 255),
            material_enable = false,
            material = "ForceField",
            disable_clothes = false,
            transparency = 0,
        },
        item = {
            color_enable = false,
            color = Color3.fromRGB(255, 255, 255),
            material_enable = false,
            material = "ForceField",
            transparency = 0,
        },
    },
    stretched_res = {
        enable = false,
        stretched_res_amount = 0.20
    },
    hit_notify = {
        enable = false,
        duration = 3,
        msg = "Hit {target} for {damage}"
    },
    custom_hitsounds = {
        enable = false,
        remove_default_hitsound = false,
        volume = 3,
        pitch = 1,
        selected = nil,
    },
    custom_hiteffects = {
        enable = false,
        color = Color3.fromRGB(255, 0, 0),
    },
    bullet_tracers = {
        enable = false,
        color_start = Color3.fromRGB(255, 255, 255),
        color_end = Color3.fromRGB(255, 255, 255),
        texture = "lightning",
        position_lerp_speed = 0,
        life_time = 1.5,
        glow = 4,
        width0 = 0.35,
        width1 = 0.15,
        speed = 3,
        spring_expand = false,
        expand_speed = 12,
        expand_damper = 0.6,
        curve_around = false,
        curve_height = 14,
        through_walls = false,
    },
    auto_queue = {
        enable = false,
        queue_mode = "",
    },
    thrower_esp = {
        enable = false,
        name = false,
        image = false,
        name_color = Color3.fromRGB(255, 255, 255),
        name_size = 14,
        distance = false,
        distance_color = Color3.fromRGB(255, 255, 255),
        distance_size = 12,
        thrower_select = "",
        font = "ProggyTiny",
    },
    fly = {
        enable = false,
        speed = 50,
    },
    walkspeed = {
        enable = false,
        multiplier = 1.5,
    },
    motion_blur = {
        enable = false,
        intensity = 0.5,
        sensitivity = 1,
    },
    slide_boost = {
        enable = false,
        speed = 60,
    },
    spoof = {
        level = {
            enable = false,
            value = 9,
        },
        streak = {
            enable = false,
            value = 9,
        },
    },
    player_status_spoof = {
        enable = false,
        select = "",
    },
    rank_spoof = {
        enable = false,
        rank = "Arch Nemesis",
    },
    elo_spoof = {
        enable = false,
        value = 60000,
    },
    name_spoof = {
        enable = false,
        display = "",
        username = "",
    },
};
local ELI = getgenv().ZRHUB;

local spoof_old = {
    level = local_player:GetAttribute("Level") ,
    streak = local_player:GetAttribute("StatisticDuelsWinStreak"),
    playerstatus = local_player:GetAttribute("PlayerStatus"),
    elo = local_player:GetAttribute("DisplayELO"),
};

run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.spoof.level.enable then
        local_player:SetAttribute("Level", ELI.spoof.level.value);
    end;
    if ELI.spoof.streak.enable then
        local_player:SetAttribute("StatisticDuelsWinStreak", ELI.spoof.streak.value);
    end;
    if ELI.player_status_spoof.enable then
        local_player:SetAttribute("PlayerStatus", ELI.player_status_spoof.select);
    end;
    if ELI.elo_spoof.enable then
        local_player:SetAttribute("DisplayELO", ELI.elo_spoof.value);
    end;
end));

do
    local RANK_ICONS = {
        ["Bronze"]       = "rbxassetid://111599878354131",
        ["Silver"]       = "rbxassetid://82834564754747",
        ["Gold"]         = "rbxassetid://80716950169934",
        ["Diamond"]      = "rbxassetid://131795064007344",
        ["Onyx"]         = "rbxassetid://114166096331502",
        ["Nemesis"]      = "rbxassetid://133903971285645",
        ["Arch Nemesis"] = "rbxassetid://134520747948636",
    };
    local function commas(n)
        local s = tostring(n);
        while true do
            local r;
            s, r = string.gsub(s, "^(-?%d+)(%d%d%d)", "%1,%2");
            if r == 0 then break end;
        end;
        return s;
    end;
    local function rankIconFor(rank)
        if RANK_ICONS[rank] then return RANK_ICONS[rank] end;
        local base = rank:gsub("%s*%d+%s*$", ""):gsub("^%s+", ""):gsub("%s+$", "");
        return RANK_ICONS[base] or "";
    end;

    local held = setmetatable({}, { __mode = "k" });
    local function anySpoofOn()
        return ELI.rank_spoof.enable or ELI.elo_spoof.enable or ELI.name_spoof.enable;
    end;
    local function lockText(label, value)
        if not label or not label:IsA("TextLabel") then return end;
        if label.Text ~= value then label.Text = value end;
        if held[label] then return end;
        held[label] = true;
        label:GetPropertyChangedSignal("Text"):Connect(function()
            if not anySpoofOn() then return end;
            if label.Text ~= value then label.Text = value end;
        end);
    end;
    local function lockImage(img, value)
        if not img or not (img:IsA("ImageLabel") or img:IsA("ImageButton")) then return end;
        if img.Image ~= value then img.Image = value end;
        if held[img] then return end;
        held[img] = true;
        img:GetPropertyChangedSignal("Image"):Connect(function()
            if not ELI.rank_spoof.enable then return end;
            if img.Image ~= value then img.Image = value end;
        end);
    end;

    local function nameMatches()
        local real = local_player.Name;
        local disp = local_player.DisplayName;
        return {
            [disp] = "display",
            [real] = "name",
            ["@" .. real] = "atname",
        };
    end;

    local function spoofNameLabel(label)
        if not ELI.name_spoof.enable then return end;
        local t = label.Text;
        if t == "" then return end;
        local disp = ELI.name_spoof.display ~= "" and ELI.name_spoof.display or local_player.DisplayName;
        local user = ELI.name_spoof.username ~= "" and ELI.name_spoof.username or local_player.Name;
        local m = nameMatches();
        local kind = m[t];
        if kind == "display" then
            lockText(label, disp);
        elseif kind == "name" then
            lockText(label, user);
        elseif kind == "atname" then
            lockText(label, "@" .. user);
        end;
    end;

    local function isMyRow(slot)
        local playerFrame = slot:FindFirstChild("Player");
        if not playerFrame then return false end;
        local m = nameMatches();
        for _, node in eli_ipairs(playerFrame:GetDescendants()) do
            if node:IsA("TextLabel") and m[node.Text] then
                return true;
            end;
        end;
        return false;
    end;

    local scan = LPH_NO_VIRTUALIZE(function()
        if not anySpoofOn() then return end;
        local gui = local_player:FindFirstChild("PlayerGui");
        if not gui then return end;
        local mainGui = gui:FindFirstChild("MainGui");
        local rankOn = ELI.rank_spoof.enable;
        local eloOn = ELI.elo_spoof.enable;
        local nameOn = ELI.name_spoof.enable;
        local rankText = ELI.rank_spoof.rank or "";
        local rankIcon = rankOn and rankIconFor(rankText) or "";
        local eloText = eloOn and commas(ELI.elo_spoof.value) or nil;

        local roots = { mainGui, gui:FindFirstChild("PlayerList") };
        for _, root in eli_ipairs(roots) do
            if root then
                for _, d in eli_ipairs(root:GetDescendants()) do
                    if d:IsA("TextLabel") then
                        if nameOn then spoofNameLabel(d); end;
                        if d.Name == "CurrentELO" and eloText and d:FindFirstAncestor("ELOBar") then
                            lockText(d, eloText);
                        elseif (d.Name == "LeftRank" or d.Name == "RightRank") and rankOn and rankText ~= "" and d:FindFirstAncestor("ELOBar") then
                            lockText(d, rankText);
                        end;
                    end;
                end;
            end;
        end;

        if rankOn and rankIcon ~= "" then
            local list = gui:FindFirstChild("PlayerList") or (mainGui and mainGui:FindFirstChild("PlayerList"));
            if list then
                for _, slot in eli_ipairs(list:GetDescendants()) do
                    if slot.Name == "PlayerListSlot" and isMyRow(slot) then
                        local stat = slot:FindFirstChild("Leaderstat");
                        local container = stat and stat:FindFirstChild("RankContainer");
                        if container then
                            for _, ic in eli_ipairs(container:GetDescendants()) do
                                if ic.Name == "Icon" and (ic:IsA("ImageLabel") or ic:IsA("ImageButton")) then
                                    lockImage(ic, rankIcon);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);

    task.spawn(function()
        while true do
            pcall(scan);
            task.wait(0.5);
        end;
    end);
end;

do
    local opt = ELI.optimizations;
    local lighting = game:GetService("Lighting");
    local particle_classes = {
        ParticleEmitter = true, Trail = true, Smoke = true, Fire = true, Sparkles = true,
    };
    local post_classes = {
        BloomEffect = true, BlurEffect = true, ColorCorrectionEffect = true,
        SunRaysEffect = true, DepthOfFieldEffect = true,
    };
    local particle_saved = setmetatable({}, { __mode = "k" });
    local texture_saved = setmetatable({}, { __mode = "k" });
    local post_saved = setmetatable({}, { __mode = "k" });
    local orig_shadows, orig_quality, orig_atmo_density;
    local shadows_saved, quality_saved, atmo_saved = false, false, false;

    local function applyParticle(inst, on)
        if not particle_classes[inst.ClassName] then return end;
        if on then
            if particle_saved[inst] == nil then particle_saved[inst] = inst.Enabled end;
            pcall(function() inst.Enabled = false end);
        elseif particle_saved[inst] ~= nil then
            pcall(function() inst.Enabled = particle_saved[inst] end);
            particle_saved[inst] = nil;
        end;
    end;

    local function applyTexture(inst, on)
        if not (inst:IsA("Decal") or inst:IsA("Texture")) then return end;
        if on then
            if texture_saved[inst] == nil then texture_saved[inst] = inst.Transparency end;
            pcall(function() inst.Transparency = 1 end);
        elseif texture_saved[inst] ~= nil then
            pcall(function() inst.Transparency = texture_saved[inst] end);
            texture_saved[inst] = nil;
        end;
    end;

    local function applyPost(inst, on)
        if not post_classes[inst.ClassName] then return end;
        if on then
            if post_saved[inst] == nil then post_saved[inst] = inst.Enabled end;
            pcall(function() inst.Enabled = false end);
        elseif post_saved[inst] ~= nil then
            pcall(function() inst.Enabled = post_saved[inst] end);
            post_saved[inst] = nil;
        end;
    end;

    local scanning = false;
    local function scanWorkspace()
        if scanning then return end;
        scanning = true;
        task.spawn(function()
            local list = workspace:GetDescendants();
            for i = 1, #list do
                local inst = list[i];
                applyParticle(inst, opt.no_particles);
                applyTexture(inst, opt.no_textures);
                if i % 800 == 0 then task.wait() end;
            end;
            scanning = false;
        end);
    end;

    local function scanLighting()
        for _, inst in eli_ipairs(lighting:GetDescendants()) do
            applyPost(inst, opt.no_postfx);
        end;
    end;

    local function applyShadows()
        if opt.no_shadows then
            if not shadows_saved then orig_shadows = lighting.GlobalShadows; shadows_saved = true end;
            pcall(function() lighting.GlobalShadows = false end);
        elseif shadows_saved then
            pcall(function() lighting.GlobalShadows = orig_shadows end);
            shadows_saved = false;
        end;
    end;

    local function applyQuality()
        pcall(function()
            local render = settings().Rendering;
            if opt.low_quality then
                if not quality_saved then orig_quality = render.QualityLevel; quality_saved = true end;
                render.QualityLevel = Enum.QualityLevel.Level01;
            elseif quality_saved then
                render.QualityLevel = orig_quality;
                quality_saved = false;
            end;
        end);
    end;

    local function applyAtmosphere()
        local atmo = lighting:FindFirstChildOfClass("Atmosphere");
        if opt.no_atmosphere then
            if atmo then
                if not atmo_saved then orig_atmo_density = atmo.Density; atmo_saved = true end;
                pcall(function() atmo.Density = 0 end);
            end;
            local clouds = workspace:FindFirstChild("Terrain") and workspace.Terrain:FindFirstChildOfClass("Clouds");
            if clouds then pcall(function() clouds.Enabled = false end) end;
        else
            if atmo and atmo_saved then
                pcall(function() atmo.Density = orig_atmo_density end);
                atmo_saved = false;
            end;
            local clouds = workspace:FindFirstChild("Terrain") and workspace.Terrain:FindFirstChildOfClass("Clouds");
            if clouds then pcall(function() clouds.Enabled = true end) end;
        end;
    end;

    local function applyFpsCap()
        if not setfpscap then return end;
        if opt.fps_cap_enable then
            pcall(setfpscap, opt.fps_cap);
        else
            pcall(setfpscap, 1000);
        end;
    end;

    trove:Add(workspace.DescendantAdded:Connect(function(inst)
        if opt.no_particles then applyParticle(inst, true) end;
        if opt.no_textures then applyTexture(inst, true) end;
    end));
    trove:Add(lighting.DescendantAdded:Connect(function(inst)
        if opt.no_postfx then applyPost(inst, true) end;
    end));

    getgenv().ZRHUB_apply_opt = function(kind)
        if kind == "particles" or kind == "textures" then scanWorkspace();
        elseif kind == "postfx" then scanLighting();
        elseif kind == "shadows" then applyShadows();
        elseif kind == "quality" then applyQuality();
        elseif kind == "atmosphere" then applyAtmosphere();
        elseif kind == "fpscap" then applyFpsCap();
        end;
    end;
end

do
    local FFLAG_PRESET = [==[
{
  "FFlagDebugGraphicsPreferVulkan": "True",
  "FFlagDebugGraphicsDisableDirect3D11": "True",
  "FFlagDisablePostFx": "True",
  "FIntDebugForceMSAASamples": "1",
  "DFIntDebugFRMQualityLevelOverride": "1",
  "DFFlagTextureQualityOverrideEnabled": "True",
  "DFIntTextureQualityOverride": "0",
  "FIntRenderShadowIntensity": "0",
  "FIntRenderShadowmapBias": "0",
  "FFlagRenderShadowSkipHugeCulling": "True",
  "FIntRenderLocalLightUpdatesMax": "1",
  "FIntRenderLocalLightUpdatesMin": "1",
  "FIntRenderLocalLightFadeInMs": "0",
  "FFlagGlobalWindActivated": "False",
  "FFlagGlobalWindRendering": "False",
  "FIntFRMMinGrassDistance": "0",
  "FIntFRMMaxGrassDistance": "0",
  "FIntRenderGrassDetailStrands": "0",
  "FIntRenderGrassHeightScaler": "0",
  "FIntGrassMovementReducedMotionFactor": "0",
  "FIntTerrainArraySliceSize": "0",
  "FIntSSAOMipLevels": "1",
  "FFlagDebugSSAOForce": "False",
  "FIntRobloxGuiBlurIntensity": "0",
  "FIntBloomFrmCutoff": "-1",
  "FFlagRenderNoLowFrmBloom": "False",
  "DFIntMaxFrameBufferSize": "4",
  "FFlagFastGPULightCulling3": "True",
  "FFlagDebugForceFSMCPULightCulling": "True",
  "FFlagRenderEnableGlobalInstancingD3D11": "True",
  "FFlagCommitToGraphicsQualityFix": "True",
  "DFIntTaskSchedulerTargetFps": "10000",
  "FFlagTaskSchedulerLimitTargetFpsTo2402": "False",
  "FFlagHandleAltEnterFullscreenManually": "False",
  "FIntTargetRefreshRate": "144",
  "FIntRefreshRateLowerBound": "120",
  "DFIntTextureCompositorActiveJobs": "0",
  "FIntTextureCompositorLowResFactor": "4",
  "DFIntDebugLimitMinTextureResolutionWhenSkipMips": "0",
  "FIntTextureCompositorMaxTextureSize": "256",
  "FIntDebugTextureManagerSkipMips": "-1",
  "DFIntDebugAdditionalNumberOfMipsToSkipForNonAlbedoTextures": "0",
  "FFlagDontRerenderForBadTexture": "True",
  "FFlagDontRenderInGameAds": "True",
  "FIntCameraMaxZoomDistance": "999999",
  "FFlagRenderTestEnableDistanceCulling": "True",
  "FFlagOcclusionCullingBetaFeature": "True",
  "FIntOcclusionCullingBetaFeatureRolloutPercent": "100",
  "FFlagEnableCullableScene2OptimizeStep": "True",
  "FIntEnableCullableScene2HundredthPercent3": "100"
}
]==];
    local http = game:GetService("HttpService");
    local function get_setter()
        return setfflag or set_fflag or (syn and syn.set_fflag) or (getgenv() and getgenv().setfflag);
    end;
    getgenv().ZRHUB_fflag_preset = FFLAG_PRESET;
    getgenv().ZRHUB_inject_fflags = function(json_str)
        if type(json_str) ~= "string" or json_str:gsub("%s", "") == "" then
            json_str = FFLAG_PRESET;
        end;
        local ok, decoded = pcall(function() return http:JSONDecode(json_str) end);
        if not ok or type(decoded) ~= "table" then
            return { ok = false, reason = "invalid json" };
        end;
        local setter = get_setter();
        local applied, total = 0, 0;
        if setter then
            for name, value in eli_pairs(decoded) do
                total = total + 1;
                if pcall(setter, name, tostring(value)) then applied = applied + 1 end;
            end;
        end;
        local saved = false;
        if writefile then
            pcall(function()
                if makefolder and isfolder and not isfolder("ZRHUB") then makefolder("ZRHUB") end;
                writefile("ZRHUB/fflags.json", json_str);
                saved = true;
            end);
        end;
        return { ok = true, live = setter ~= nil, applied = applied, total = total, saved = saved };
    end;
end;

local hitsound_dir = {
    ["windows xp"] = "rbxassetid://108009100115241",
    ["minecraft bow"] = "rbxassetid://3442683707",
    ["neverlose"] = "rbxassetid://97643101798871",
    ["steve"] = "rbxassetid://132883456216684",
    ["among us"] = "rbxassetid://93866204681438",
    ["bonk"] = "rbxassetid://5766898159",
    ["rust"] = "rbxassetid://1255040462",
    ["fatality"] = "rbxassetid://6534947869",
    ["hitmarker"] = "rbxassetid://133749572213659",
    ["csgo"] = "rbxassetid://5764885315",
    ["minecraft success bow hit"] = "rbxassetid://131197435969853",
};

local texture_id = {
    ["beam"] = "rbxassetid://12781852245",
    ["lightning"] = "rbxassetid://446111271",
    ["heartrate"] = "rbxassetid://5830549480",
    ["chain"] = "rbxassetid://9632168658",
    ["glitch"] = "rbxassetid://8089467613",
    ["swirl"] = "rbxassetid://5638168605",
    ["neon"] = "rbxassetid://6361963422",
    ["arrow1"] = "rbxassetid://17476697388",
    ["bullets1"] = "rbxassetid://9841273413",
    ["bullets2"] = "rbxassetid://1858602290",
    ["curve1"] = "rbxassetid://117681058875712",
    ["curve2"] = "rbxassetid://16616706916",
    ["curve3"] = "http://www.roblox.com/asset/?id=15253421443",
    ["curve4"] = "http://www.roblox.com/asset/?id=4537267850",
    ["curve5"] = "rbxassetid://1263079249",
    ["curve6"] = "rbxassetid://12781806168",
    ["dna"] = "http://www.roblox.com/asset/?id=7071778278",
    ["dna2"] = "rbxassetid://15881443696",
    ["dna3"] = "rbxassetid://123918947552219",
    ["dna4"] = "http://www.roblox.com/asset/?id=5259529792",
    ["dna5"] = "rbxassetid://76346066683743",
    ["dna6"] = "rbxassetid://14339578398",
    ["dna7"] = "rbxassetid://6479047126",
    ["glow1"] = "http://www.roblox.com/asset/?id=2382169232",
    ["laser1"] = "rbxassetid://6091329339",
    ["laser2"] = "rbxassetid://116093865393953",
    ["laser3"] = "rbxassetid://1277456789",
    ["laser4"] = "rbxassetid://6091329339",
    ["laser5"] = "rbxassetid://88990578414815",
    ["laser6"] = "rbxassetid://12781750620",
    ["line1"] = "rbxassetid://16726866463",
    ["line2"] = "http://www.roblox.com/asset/?id=18804963960",
    ["line3"] = "http://www.roblox.com/asset/?id=14987385912",
    ["line4"] = "rbxassetid://80526693693402",
    ["line5"] = "rbxassetid://88341572922411",
    ["none (solid)"] = "",
    ["pattern1"] = "rbxassetid://16892453445",
    ["pattern2"] = "rbxassetid://9632168313",
    ["pattern3"] = "rbxassetid://12781812529",
    ["pattern4"] = "rbxassetid://12781850191",
    ["ray1"] = "rbxassetid://14715282464",
    ["ray2"] = "http://www.roblox.com/asset/?id=446111271",
    ["ray3"] = "rbxassetid://16892384522",
};

getgenv().ZRHUB_materials = {
    presets = {
        ["Neon"]       = { material = Enum.Material.Neon },
        ["ForceField"] = { material = Enum.Material.ForceField },
        ["Glass"]      = { material = Enum.Material.Glass, reflectance = 0.10, transparency = 0.20 },
        ["Chrome"]     = { material = Enum.Material.Metal, reflectance = 1.00 },
        ["Ice"]        = { material = Enum.Material.Ice, reflectance = 0.35 },
        ["Diamond"]    = { material = Enum.Material.Glass, reflectance = 0.65, transparency = 0.10 },
        ["Hologram"]   = { material = Enum.Material.ForceField, transparency = 0.35 },
        ["Ghost"]      = { material = Enum.Material.Neon, transparency = 0.55 },
        ["Obsidian"]   = { material = Enum.Material.Glass, reflectance = 0.25 },
        ["Gold Foil"]  = { material = Enum.Material.Foil, reflectance = 0.50 },
        ["Frostbite"]  = { material = Enum.Material.Glacier, reflectance = 0.20 },
        ["Plasma"]     = { material = Enum.Material.Neon },
        ["Molten"]     = { material = Enum.Material.CorrodedMetal, reflectance = 0.05 },
        ["Prism"]      = { material = Enum.Material.Glass, reflectance = 0.40, transparency = 0.15 },
    },
    names = {
        "Neon", "ForceField", "Glass", "Chrome", "Ice", "Diamond", "Hologram",
        "Ghost", "Obsidian", "Gold Foil", "Frostbite", "Plasma", "Molten", "Prism",
    },
};

local theanimationsd = {
    ["Meditate"] = "96579993895076",
    ["Orbit"] = "133811691098518",
    ["Floss"] = "72174079036035",
    ["OJ"] = "110064349530772",
    ["Kicking Feet"] = "131879764029003",
    ["Take the L"] = "112884830175040",
    ["Hype"] = "80055417516516",
};

local world = {
    fog_color = lighting.FogColor,
    fog_start = lighting.FogStart,
    fog_end = lighting.FogEnd,
    ambient = lighting.Ambient,
    clock_time = lighting.ClockTime,
    brightness = lighting.Brightness,
    exposure = lighting.ExposureCompensation,
    color_shift_top = lighting.ColorShift_Top,
    color_shift_bottom = lighting.ColorShift_Bottom,
};

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.world.fog then
        lighting.FogColor = ELI.world.fog_color;
        lighting.FogStart = ELI.world.fog_start;
        lighting.FogEnd = ELI.world.fog_end;
    end;
    if ELI.world.ambient then
        lighting.Ambient = ELI.world.ambient_color;
    end;
    if ELI.world.clock then
        lighting.ClockTime = ELI.world.clock_time;
    end;
    if ELI.world.brightness then
        lighting.Brightness = ELI.world.brightness_level;
    end;
    if ELI.world.exposure then
        lighting.ExposureCompensation = ELI.world.exposure_level;
    end;
    if ELI.world.color_shift_top then
        lighting.ColorShift_Top = ELI.world.color_shift_top_color;
    end;
    if ELI.world.color_shift_bottom then
        lighting.ColorShift_Bottom = ELI.world.color_shift_bottom_color;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.double_jump_height.enable then
        mechanics_controller._original_jump_power = ELI.double_jump_height.height;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.auto_slide.enable then
        if mechanics_controller.IsSprinting then
            mechanics_controller:Slide();
        end;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.fly.enable and local_player.Character and local_player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = local_player.Character.HumanoidRootPart;
        local move_vector = Vector3.new(0, 0, 0);
        if uis:IsKeyDown(Enum.KeyCode.W) then
            move_vector += camera.CFrame.LookVector;
        end;
        if uis:IsKeyDown(Enum.KeyCode.S) then
            move_vector -= camera.CFrame.LookVector;
        end;
        if uis:IsKeyDown(Enum.KeyCode.A) then
            move_vector -= camera.CFrame.RightVector;
        end;
        if uis:IsKeyDown(Enum.KeyCode.D) then
            move_vector += camera.CFrame.RightVector;
        end;
        if uis:IsKeyDown(Enum.KeyCode.Space) then
            move_vector += Vector3.new(0, 1, 0);
        end;
        if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
            move_vector -= Vector3.new(0, 1, 0);
        end;
        if move_vector.Magnitude > 0 then
            hrp.CFrame += move_vector.Unit * ELI.fly.speed * run_service.Heartbeat:Wait();
        else
            hrp.CFrame = CFrame.new(hrp.Position) * (hrp.CFrame - hrp.CFrame.Position);
        end;
        hrp.AssemblyLinearVelocity = Vector3.zero;
        hrp.AssemblyAngularVelocity = Vector3.zero;
    end;
end)))

do
    local motion_blur = Instance.new("BlurEffect");
    motion_blur.Name = "ZRHUB_motion_blur";
    motion_blur.Size = 0;
    motion_blur.Enabled = false;
    motion_blur.Parent = lighting;
    trove:Add(motion_blur);

    local motion_blur_look = camera.CFrame.LookVector;
    trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(dt)
        local cfg = ELI.motion_blur;
        if not cfg.enable then
            if motion_blur.Enabled then
                motion_blur.Enabled = false;
                motion_blur.Size = 0;
            end;
            motion_blur_look = camera.CFrame.LookVector;
            return
        end;
        motion_blur.Enabled = true;
        local look = camera.CFrame.LookVector;
        local delta = (look - motion_blur_look).Magnitude;
        motion_blur_look = look;
        local target = math.clamp(delta / math.max(dt, 1 / 240) * cfg.sensitivity * cfg.intensity * 0.35, 0, 56 * cfg.intensity);
        motion_blur.Size = motion_blur.Size + (target - motion_blur.Size) * math.min(dt * 20, 1);
    end)));

    local walkspeed_base = 16;
    local walkspeed_applying = false;
    local walkspeed_conn = nil;

    local function walkspeed_apply(humanoid)
        if not ELI.walkspeed.enable then return end;
        walkspeed_applying = true;
        humanoid.WalkSpeed = walkspeed_base * ELI.walkspeed.multiplier;
        walkspeed_applying = false;
    end;

    local function walkspeed_bind(humanoid)
        if walkspeed_conn then
            walkspeed_conn:Disconnect();
            walkspeed_conn = nil;
        end;
        walkspeed_base = humanoid.WalkSpeed;
        walkspeed_conn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(LPH_NO_VIRTUALIZE(function()
            if walkspeed_applying then return end;
            walkspeed_base = humanoid.WalkSpeed;
            walkspeed_apply(humanoid);
        end));
        trove:Add(walkspeed_conn);
        walkspeed_apply(humanoid);
    end;

    local function walkspeed_on_character(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 5);
        if humanoid then walkspeed_bind(humanoid) end;
    end;

    if local_player.Character then
        walkspeed_on_character(local_player.Character);
    end;
    trove:Add(local_player.CharacterAdded:Connect(walkspeed_on_character));

    local walkspeed_active = false;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        local character = local_player.Character;
        local humanoid = character and character:FindFirstChildOfClass("Humanoid");
        if not humanoid then return end;
        if ELI.walkspeed.enable then
            walkspeed_active = true;
            local desired = walkspeed_base * ELI.walkspeed.multiplier;
            if math.abs(humanoid.WalkSpeed - desired) > 0.05 then
                walkspeed_applying = true;
                humanoid.WalkSpeed = desired;
                walkspeed_applying = false;
            end;
        elseif walkspeed_active then
            walkspeed_active = false;
            walkspeed_applying = true;
            humanoid.WalkSpeed = walkspeed_base;
            walkspeed_applying = false;
        end;
    end)));
end

do
    local forced = false;
    if not Library.__ZRHUBDragHooked and type(Library.MouseIsOverFrame) == "function" then
        Library.__ZRHUBDragHooked = true;
        local old_mouse_over = Library.MouseIsOverFrame;
        Library.MouseIsOverFrame = function(self, frame, input)
            if not Library.MenuOpen and frame == Library.KeybindFrame then
                return false;
            end;
            return old_mouse_over(self, frame, input);
        end;
    end;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        if not Library.MenuOpen then
            Library.CantDragForced = true;
            forced = true;
        elseif forced then
            Library.CantDragForced = false;
            forced = false;
        end;
    end)));
end;

local accent_color      = Library.AccentColor;
local accent_color_dark = Color3.fromRGB(55, 58, 72);
local main_color        = Library.MainColor;
local background_color  = Library.BackgroundColor;
local outline_color     = Library.OutlineColor;
local font_color        = Library.FontColor;
local dim_color         = Library.FontColor;
local white_color       = Color3.new(1, 1, 1);
local hud_font          = Font.new("rbxasset://fonts/families/Code.json");

local device_map = {
    ["MouseKeyboard"] = "pc",
    ["Touch"]         = "mobile",
    ["Gamepad"]       = "console",
    ["VR"]            = "vr",
};

local G2L = {};

G2L["1"] = Instance.new("ScreenGui");
G2L["1"]["Name"] = "ZRHUBdatargethud";
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Global;
G2L["1"]["DisplayOrder"] = 998;
G2L["1"]["ResetOnSpawn"] = false;
G2L["1"]["Parent"] = local_player:WaitForChild("PlayerGui");

G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BackgroundColor3"] = Color3.new(0, 0, 0);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["Position"] = UDim2.fromOffset(14, 100);
G2L["2"]["Size"] = UDim2.fromOffset(480, 160);
G2L["2"]["Visible"] = false;
G2L["2"]["ZIndex"] = 1;
G2L["2"]["Active"] = true;

G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BackgroundColor3"] = main_color;
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["Position"] = UDim2.fromOffset(1, 1);
G2L["3"]["Size"] = UDim2.new(1, -2, 1, -2);
G2L["3"]["ZIndex"] = 1;

local hud_stroke = Instance.new("UIStroke", G2L["3"]);
hud_stroke.Color = accent_color;
hud_stroke.Thickness = 1;
hud_stroke.Transparency = 0;

G2L["4"] = Instance.new("Frame", G2L["3"]);
G2L["4"]["BackgroundColor3"] = background_color;
G2L["4"]["BorderColor3"] = outline_color;
G2L["4"]["Position"] = UDim2.fromOffset(8, 8);
G2L["4"]["Size"] = UDim2.new(1, -16, 1, -16);
G2L["4"]["ZIndex"] = 1;

G2L["5"] = Instance.new("Frame", G2L["4"]);
G2L["5"]["BackgroundColor3"] = background_color;
G2L["5"]["BorderColor3"] = Color3.new(0, 0, 0);
G2L["5"]["BorderMode"] = Enum.BorderMode.Inset;
G2L["5"]["Size"] = UDim2.fromScale(1, 1);
G2L["5"]["ZIndex"] = 1;

G2L["6"] = Instance.new("Frame", G2L["5"]);
G2L["6"]["BackgroundColor3"] = main_color;
G2L["6"]["BorderColor3"] = outline_color;
G2L["6"]["Position"] = UDim2.fromOffset(8, 8);
G2L["6"]["Size"] = UDim2.new(1, -16, 1, -16);
G2L["6"]["ZIndex"] = 2;

G2L["7"] = Instance.new("Frame", G2L["6"]);
G2L["7"]["BackgroundColor3"] = Color3.new(0, 0, 0);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["Position"] = UDim2.new(1, -54, 0, 4);
G2L["7"]["Size"] = UDim2.fromOffset(48, 48);
G2L["7"]["ZIndex"] = 3;

G2L["8"] = Instance.new("Frame", G2L["7"]);
G2L["8"]["BackgroundColor3"] = background_color;
G2L["8"]["BorderColor3"] = outline_color;
G2L["8"]["BorderMode"] = Enum.BorderMode.Inset;
G2L["8"]["Size"] = UDim2.fromScale(1, 1);
G2L["8"]["ZIndex"] = 4;

local weapon_highlight = Instance.new("Frame", G2L["7"]);
weapon_highlight.BackgroundTransparency = 1;
weapon_highlight.BorderSizePixel = 0;
weapon_highlight.Size = UDim2.fromScale(1, 1);
weapon_highlight.ZIndex = 6;
weapon_highlight.Visible = false;

local wh_stroke = Instance.new("UIStroke", weapon_highlight);
wh_stroke.Color = Library.AccentColor;
wh_stroke.Thickness = 1;
wh_stroke.Transparency = 0;

G2L["9"] = Instance.new("ImageLabel", G2L["8"]);
G2L["9"]["BackgroundTransparency"] = 1;
G2L["9"]["Size"] = UDim2.fromScale(1, 1);
G2L["9"]["Image"] = "";
G2L["9"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["9"]["ZIndex"] = 5;

G2L["10"] = Instance.new("TextLabel", G2L["8"]);
G2L["10"]["BackgroundTransparency"] = 1;
G2L["10"]["Size"] = UDim2.fromScale(1, 1);
G2L["10"]["FontFace"] = hud_font;
G2L["10"]["TextColor3"] = Color3.fromRGB(70, 72, 95);
G2L["10"]["TextSize"] = 18;
G2L["10"]["Text"] = "?";
G2L["10"]["ZIndex"] = 5;
G2L["10"]["Visible"] = true;

G2L["11"] = Instance.new("TextLabel", G2L["6"]);
G2L["11"]["BackgroundTransparency"] = 1;
G2L["11"]["Position"] = UDim2.fromOffset(7, 6);
G2L["11"]["Size"] = UDim2.new(1, -68, 0, 18);
G2L["11"]["FontFace"] = hud_font;
G2L["11"]["TextColor3"] = white_color;
G2L["11"]["TextSize"] = 16;
G2L["11"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["11"]["TextStrokeTransparency"] = 0;
G2L["11"]["RichText"] = true;
G2L["11"]["Text"] = "";
G2L["11"]["ZIndex"] = 3;

G2L["12"] = Instance.new("TextLabel", G2L["6"]);
G2L["12"]["BackgroundTransparency"] = 1;
G2L["12"]["Position"] = UDim2.fromOffset(7, 24);
G2L["12"]["Size"] = UDim2.new(1, -68, 0, 11);
G2L["12"]["FontFace"] = hud_font;
G2L["12"]["TextColor3"] = dim_color;
G2L["12"]["TextSize"] = 11;
G2L["12"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["12"]["TextStrokeTransparency"] = 0;
G2L["12"]["RichText"] = true;
G2L["12"]["Text"] = "";
G2L["12"]["ZIndex"] = 3;

G2L["13"] = Instance.new("Frame", G2L["6"]);
G2L["13"]["BackgroundColor3"] = outline_color;
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["Position"] = UDim2.fromOffset(7, 40);
G2L["13"]["Size"] = UDim2.new(1, -68, 0, 1);
G2L["13"]["ZIndex"] = 3;

G2L["14"] = Instance.new("TextLabel", G2L["6"]);
G2L["14"]["BackgroundTransparency"] = 1;
G2L["14"]["Position"] = UDim2.fromOffset(7, 46);
G2L["14"]["Size"] = UDim2.new(1, -68, 0, 12);
G2L["14"]["FontFace"] = hud_font;
G2L["14"]["TextColor3"] = font_color;
G2L["14"]["TextSize"] = 11;
G2L["14"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["14"]["TextStrokeTransparency"] = 0;
G2L["14"]["RichText"] = true;
G2L["14"]["Text"] = "health";
G2L["14"]["ZIndex"] = 3;

G2L["15"] = Instance.new("TextLabel", G2L["6"]);
G2L["15"]["BackgroundTransparency"] = 1;
G2L["15"]["Position"] = UDim2.fromOffset(7, 46);
G2L["15"]["Size"] = UDim2.new(1, -68, 0, 12);
G2L["15"]["FontFace"] = hud_font;
G2L["15"]["TextColor3"] = white_color;
G2L["15"]["TextSize"] = 11;
G2L["15"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["15"]["TextStrokeTransparency"] = 0;
G2L["15"]["Text"] = "";
G2L["15"]["ZIndex"] = 3;

G2L["16"] = Instance.new("Frame", G2L["6"]);
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
G2L["16"]["BorderSizePixel"] = 0;
G2L["16"]["Position"] = UDim2.fromOffset(7, 61);
G2L["16"]["Size"] = UDim2.new(1, -68, 0, 2);
G2L["16"]["ZIndex"] = 3;

G2L["17"] = Instance.new("Frame", G2L["16"]);
G2L["17"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
G2L["17"]["BorderSizePixel"] = 0;
G2L["17"]["Size"] = UDim2.fromScale(1, 1);
G2L["17"]["ZIndex"] = 4;

G2L["18"] = Instance.new("Frame", G2L["17"]);
G2L["18"]["BackgroundColor3"] = accent_color;
G2L["18"]["BorderSizePixel"] = 0;
G2L["18"]["Size"] = UDim2.fromScale(1, 1);
G2L["18"]["ZIndex"] = 5;

G2L["19"] = Instance.new("Frame", G2L["18"]);
G2L["19"]["BackgroundColor3"] = accent_color;
G2L["19"]["BorderSizePixel"] = 0;
G2L["19"]["Position"] = UDim2.new(1, 0, 0, 0);
G2L["19"]["Size"] = UDim2.new(0, 1, 1, 0);
G2L["19"]["ZIndex"] = 6;

G2L["20"] = Instance.new("TextLabel", G2L["6"]);
G2L["20"]["BackgroundTransparency"] = 1;
G2L["20"]["Position"] = UDim2.fromOffset(7, 68);
G2L["20"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["20"]["FontFace"] = hud_font;
G2L["20"]["TextColor3"] = dim_color;
G2L["20"]["TextSize"] = 11;
G2L["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["20"]["TextStrokeTransparency"] = 0;
G2L["20"]["Text"] = "weapon";
G2L["20"]["ZIndex"] = 3;

G2L["21"] = Instance.new("TextLabel", G2L["6"]);
G2L["21"]["BackgroundTransparency"] = 1;
G2L["21"]["Position"] = UDim2.fromOffset(7, 68);
G2L["21"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["21"]["FontFace"] = hud_font;
G2L["21"]["TextColor3"] = dim_color;
G2L["21"]["TextSize"] = 11;
G2L["21"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["21"]["TextStrokeTransparency"] = 0;
G2L["21"]["Text"] = "";
G2L["21"]["ZIndex"] = 3;

G2L["22"] = Instance.new("TextLabel", G2L["6"]);
G2L["22"]["BackgroundTransparency"] = 1;
G2L["22"]["Position"] = UDim2.fromOffset(7, 83);
G2L["22"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["22"]["FontFace"] = hud_font;
G2L["22"]["TextColor3"] = dim_color;
G2L["22"]["TextSize"] = 11;
G2L["22"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["22"]["TextStrokeTransparency"] = 0;
G2L["22"]["Text"] = "ammo";
G2L["22"]["ZIndex"] = 3;

G2L["23"] = Instance.new("TextLabel", G2L["6"]);
G2L["23"]["BackgroundTransparency"] = 1;
G2L["23"]["Position"] = UDim2.fromOffset(7, 83);
G2L["23"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["23"]["FontFace"] = hud_font;
G2L["23"]["TextColor3"] = dim_color;
G2L["23"]["TextSize"] = 10;
G2L["23"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["23"]["TextStrokeTransparency"] = 0;
G2L["23"]["Text"] = "";
G2L["23"]["ZIndex"] = 3;

G2L["24"] = Instance.new("TextLabel", G2L["6"]);
G2L["24"]["BackgroundTransparency"] = 1;
G2L["24"]["Position"] = UDim2.fromOffset(7, 98);
G2L["24"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["24"]["FontFace"] = hud_font;
G2L["24"]["TextColor3"] = dim_color;
G2L["24"]["TextSize"] = 11;
G2L["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["24"]["TextStrokeTransparency"] = 0;
G2L["24"]["Text"] = "studs";
G2L["24"]["ZIndex"] = 3;

G2L["25"] = Instance.new("TextLabel", G2L["6"]);
G2L["25"]["BackgroundTransparency"] = 1;
G2L["25"]["Position"] = UDim2.fromOffset(7, 98);
G2L["25"]["Size"] = UDim2.new(1, -68, 0, 13);
G2L["25"]["FontFace"] = hud_font;
G2L["25"]["TextColor3"] = dim_color;
G2L["25"]["TextSize"] = 11;
G2L["25"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["25"]["TextStrokeTransparency"] = 0;
G2L["25"]["Text"] = "";
G2L["25"]["ZIndex"] = 3;

local dragging = false;
local drag_start = nil;
local start_pos = nil;

local dragcolor2 = Instance.new("Frame", G2L["1"]);
dragcolor2.BackgroundColor3 = Library.AccentColor;
dragcolor2.BackgroundTransparency = 0.7;
dragcolor2.BorderSizePixel = 0;
dragcolor2.Size = G2L["2"].Size;
dragcolor2.Position = G2L["2"].Position;
dragcolor2.ZIndex = 200;
dragcolor2.Visible = false;

G2L["2"].InputBegan:Connect(function(input)
    if not (Library.MenuOpen and G2L["2"].Visible) then return end;
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true;
        drag_start = input.Position;
        start_pos = Vector2.new(G2L["2"].Position.X.Offset, G2L["2"].Position.Y.Offset);
        dragcolor2.Position = G2L["2"].Position;
        dragcolor2.Visible = true;
    end;
end);

uis.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - drag_start;
            dragcolor2.Position = UDim2.fromOffset(start_pos.X + delta.X,start_pos.Y + delta.Y);
        end;
    end;
end));

uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false;
            G2L["2"].Position = dragcolor2.Position;
            dragcolor2.Visible = false;
        end;
    end;
end);

local hud_sa_hp = 1;

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
    if not ELI.target_hud.enable then
        if G2L["2"]["Visible"] then
            G2L["2"]["Visible"] = false;
        end;
        dragging = false;
        if dragcolor2.Visible then
            dragcolor2.Visible = false;
        end;
        return;
    end;

    G2L["3"]["BackgroundColor3"] = Library.MainColor;
    G2L["4"]["BackgroundColor3"] = Library.BackgroundColor;
    G2L["4"]["BorderColor3"] = Library.OutlineColor;
    G2L["5"]["BackgroundColor3"] = Library.BackgroundColor;
    G2L["6"]["BackgroundColor3"] = Library.MainColor;
    G2L["6"]["BorderColor3"] = Library.OutlineColor;
    G2L["13"]["BackgroundColor3"] = Library.OutlineColor;
    G2L["16"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
    G2L["17"]["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
    G2L["18"]["BackgroundColor3"] = Library.AccentColor;
    G2L["19"]["BackgroundColor3"] = Library.AccentColor;
    dragcolor2.BackgroundColor3 = Library.AccentColor;
    wh_stroke.Color = Library.AccentColor;
    hud_stroke.Color = Library.AccentColor;
    G2L["12"]["TextColor3"] = Library.FontColor;
    G2L["14"]["TextColor3"] = Library.FontColor;
    G2L["20"]["TextColor3"] = Library.FontColor;
    G2L["21"]["TextColor3"] = Library.FontColor;
    G2L["22"]["TextColor3"] = Library.FontColor;
    G2L["23"]["TextColor3"] = Library.FontColor;
    G2L["24"]["TextColor3"] = Library.FontColor;
    G2L["25"]["TextColor3"] = Library.FontColor;

    if not dragging or not Library.MenuOpen then
        dragging = false;
        dragcolor2.Visible = false;
    end;

    local method = ELI.target_hud.target_method;
    local plr;

    if method == "silent aim" and ELI.silent_aim.enable then
        plr = getclosest();
    elseif method == "aimbot" and ELI.aimbot.enable then
        plr = getclosest2();
    end;

    if not plr or not fighter_controller:GetFighter(plr) then
        G2L["2"]["Visible"] = false;
        return;
    end;

    G2L["2"]["Visible"] = true;

    do
        local scaler = G2L["2"]:FindFirstChildOfClass("UIScale");
        if not scaler then
            scaler = Instance.new("UIScale", G2L["2"]);
        end;
        scaler.Scale = ELI.target_hud.scale or 1;
    end;

    do
        local hud = ELI.target_hud;
        local mode = hud.position_mode or "static";
        local ox = hud.offset_x or 0;
        local oy = hud.offset_y or 0;
        if mode == "static" then
            G2L["2"]["Position"] = UDim2.fromOffset(14 + ox, 100 + oy);
        else
            local anchor;
            if mode == "gunpoint" and GetMuzzlePos then
                anchor = GetMuzzlePos();
            elseif mode == "target" then
                local ent = fighter_controller:GetFighter(plr).Entity;
                local model = ent and ent.Model;
                local root = model and model:FindFirstChild("HumanoidRootPart");
                if root then
                    local sp = camera:WorldToViewportPoint(root.Position);
                    anchor = Vector2.new(sp.X, sp.Y);
                end;
            end;
            if not anchor then
                local vp = camera.ViewportSize;
                anchor = Vector2.new(vp.X / 2, vp.Y / 2);
            end;
            local sz = G2L["2"]["AbsoluteSize"];
            G2L["2"]["Position"] = UDim2.fromOffset(anchor.X - sz.X / 2 + ox, anchor.Y - sz.Y / 2 + oy);
        end;
    end;
    G2L["11"]["Text"] = fighter_controller:GetFighter(plr).Player.Name;
    G2L["12"]["Text"] = "level:  <font color='" .. string.format("#%02x%02x%02x", math.floor(Library.AccentColor.R * 255), math.floor(Library.AccentColor.G * 255), math.floor(Library.AccentColor.B * 255)) .. "'>" .. tostring(fighter_controller:GetFighter(plr).Player:GetAttribute("Level")) .. "</font>  device:  <font color='" .. string.format("#%02x%02x%02x", math.floor(Library.AccentColor.R * 255), math.floor(Library.AccentColor.G * 255), math.floor(Library.AccentColor.B * 255)) .. "'>" .. tostring(device_map[fighter_controller:GetFighter(plr):Get("Controls")] or "???") .. "</font>";

    if fighter_controller:GetFighter(plr).Entity and fighter_controller:GetFighter(plr).Entity.Model and fighter_controller:GetFighter(plr).Entity.Model:FindFirstChildOfClass("Humanoid") then
        local hum = fighter_controller:GetFighter(plr).Entity.Model:FindFirstChildOfClass("Humanoid");
        local hp = math.floor(hum.Health or 0);
        local max_hp = math.floor(hum.MaxHealth or 100);

        if max_hp > 0 then
            hud_sa_hp = hud_sa_hp + (hp / max_hp - hud_sa_hp) * math.min(dt * 8, 1);
        end;

        G2L["18"]["Size"] = UDim2.fromScale(hud_sa_hp, 1);
        G2L["15"]["Text"] = hp .. " / " .. max_hp;
    end;

    local equipped = fighter_controller:GetFighter(plr).EquippedItem;
    local weapon_name = equipped and ((equipped.Info and equipped.Info.Name) or equipped.Name) or "none";

    G2L["21"]["Text"] = weapon_name;

    local entry = item_lib.ViewModels and (item_lib.ViewModels[weapon_name] or (item_lib.ViewModels.Bundles and item_lib.ViewModels.Bundles[weapon_name]));
    local thumb = entry and (entry.ImageHighResolution or entry.Image or entry.Thumbnail) or "";

    if thumb ~= "" then
        G2L["9"]["Image"] = thumb;
        G2L["9"]["Visible"] = true;
        G2L["10"]["Visible"] = false;
    else
        G2L["9"]["Image"] = "";
        G2L["9"]["Visible"] = false;
        G2L["10"]["Visible"] = true;
    end;

    weapon_highlight.Visible = equipped and weapon_name ~= "none";

    if equipped then
        local ammo = equipped:Get("Ammo");

        if ammo == nil then
            for k, v in next, equipped do
                if tostring(k):lower() == "ammo" or tostring(k):lower() == "currentammo" then
                    ammo = v;
                    break;
                end;
            end;
        end;

        if ammo ~= nil and equipped.Info and equipped.Info.MaxAmmo then
            G2L["23"]["Text"] = tostring(ammo) .. "/" .. tostring(equipped.Info.MaxAmmo);
        elseif ammo ~= nil then
            G2L["23"]["Text"] = "???";
        else
            G2L["23"]["Text"] = "???";
        end;
    end;

    if fighter_controller:GetFighter(plr).Entity and local_player.Character and local_player.Character:FindFirstChild("HumanoidRootPart") then
        G2L["25"]["Text"] = math.floor((fighter_controller:GetFighter(plr).Entity.Model:FindFirstChild("HumanoidRootPart").Position - local_player.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude) .. " studs";
    end;
end)));

trove:Add(function()
    G2L["1"]:Destroy();
end);

local esp = {};
local cache = {};

local espgui = Instance.new("ScreenGui");
espgui.Name = "ESP";
espgui.DisplayOrder = 9e9;
espgui.ResetOnSpawn = false;
espgui.IgnoreGuiInset = true;
espgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
espgui.Parent = gethui();

local mainfont = Font.fromEnum(Enum.Font.Code);
local fontid = "esp_font.ttf";
pcall(function()
	if not isfile(fontid) then
		writefile(fontid, game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/smallest_pixel-7.ttf"));
	end;
	if isfile("esp_font.font") then delfile("esp_font.font") end;
	local fontdata = {
		name  = "ESPFont",
		faces = {{ name = "Regular", weight = 400, style = "normal", assetId = getcustomasset(fontid) }}
	};
	writefile("esp_font.font", http_service:JSONEncode(fontdata));
	mainfont = Font.new(getcustomasset("esp_font.font"));
end);

local aligncenter = Enum.TextXAlignment.Center;
local alignleft   = Enum.TextXAlignment.Left;
local alignmid    = Enum.TextYAlignment.Center;
local udim2offset = UDim2.fromOffset;
local v2new       = Vector2.new;
local v3new       = Vector3.new;
local csnew       = ColorSequence.new;
local cskp        = ColorSequenceKeypoint.new;
local nsnew       = NumberSequence.new;
local nskp        = NumberSequenceKeypoint.new;
local mfloor      = math.floor;
local mceil       = math.ceil;
local mclamp      = math.clamp;
local msin        = math.sin;
local mmax        = math.max;
local sfmt        = string.format;

local function makelabel(xalign)
	local lbl = Instance.new("TextLabel");
	lbl.BackgroundTransparency = 1;
	lbl.TextColor3 = Color3.new(1, 1, 1);
	lbl.TextStrokeTransparency = 0;
	lbl.TextStrokeColor3 = Color3.new(0, 0, 0);
	lbl.TextScaled = false;
	lbl.TextSize = 9;
	lbl.FontFace = mainfont;
	lbl.TextXAlignment = xalign or aligncenter;
	lbl.TextYAlignment = alignmid;
	lbl.Size = udim2offset(60, 12);
	lbl.Visible = false;
	lbl.Parent = espgui;
	local grad = Instance.new("UIGradient");
	grad.Enabled = false;
	grad.Parent = lbl;
	return lbl;
end;

applyTextGrad = function(lbl, seq, offset)
	local g = lbl:FindFirstChildOfClass("UIGradient");
	if not g then return end;
	if seq then
		g.Color = seq;
		g.Offset = offset;
		g.Enabled = true;
	else
		if g.Enabled then g.Enabled = false end;
	end;
end;

esp.getweapon = function(player)
	local viewmodels = workspace:FindFirstChild("ViewModels");
	if not viewmodels then return "None" end;

	local pname = player.Name;

	for _, child in viewmodels:GetChildren() do
		local parts = {};
		for part in child.Name:gmatch("[^-]+") do
			parts[#parts + 1] = part:match("^%s*(.-)%s*$");
		end;
		if #parts >= 2 and parts[1] == pname then
			return parts[2];
		end;
	end;

	local firstperson = viewmodels:FindFirstChild("FirstPerson");
	if firstperson then
		for _, child in firstperson:GetChildren() do
			local parts = {};
			for part in child.Name:gmatch("[^-]+") do
				parts[#parts + 1] = part:match("^%s*(.-)%s*$");
			end;
			if #parts >= 2 and parts[1] == pname then
				return parts[2];
			end;
		end;
	end;

	return "none";
end;

esp.getbounds = LPH_NO_VIRTUALIZE(function(root, dist)
	local hrp2d    = camera:WorldToViewportPoint(root.Position);
	local clamped  = math.min(dist, 535);
	local refpos   = root.Position + (camera.CFrame.Position - root.Position).Unit * (dist - clamped);
	local rootpos  = root.Position;

	local chartop    = camera:WorldToViewportPoint(refpos + v3new(0, 3, 0));
	local charbottom = camera:WorldToViewportPoint(refpos - v3new(0, 1, 0));
	local charsize   = (charbottom.Y - chartop.Y) / 2;

	local w = mfloor(charsize * 1.5);
	local h = mfloor(charsize * 3.2);

	local actualtop = camera:WorldToViewportPoint(rootpos + v3new(0, 3, 0));
	local left = mfloor(hrp2d.X - charsize * 0.75);
	local top  = mfloor(actualtop.Y);

	if w < 4 or h < 4 then return nil end;

	return left, top, w, h;
end);

esp.add = function(player)
	local cfg = ELI.esp;
	cache[player] = { box = {}, text = {}, bars = {} };
	local c = cache[player];

	c.box.filled = Instance.new("Frame");
	c.box.filled.BackgroundColor3 = Color3.new(1, 1, 1);
	c.box.filled.BackgroundTransparency = cfg.filled.transparency;
	c.box.filled.BorderSizePixel = 0;
	c.box.filled.Visible = false;
	c.box.filled.ZIndex = 2;
	c.box.filled.Parent = espgui;

	c.box.filledgradient = Instance.new("UIGradient");
	c.box.filledgradient.Color = csnew({ cskp(0, cfg.filled.color_start), cskp(1, cfg.filled.color_end) });
	c.box.filledgradient.Rotation = cfg.filled.rotation;
	c.box.filledgradient.Parent = c.box.filled;

	c.highlight = Instance.new("Highlight");
	c.highlight.Name = "\0";
	c.highlight.Enabled = false;
	c.highlight.Adornee = nil;
	pcall(function() c.highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end);
	c.highlight.FillColor = cfg.highlight.fill_color;
	c.highlight.OutlineColor = cfg.highlight.outline_color;
	c.highlight.FillTransparency = cfg.highlight.fill_transparency;
	c.highlight.OutlineTransparency = cfg.highlight.outline_transparency;
	pcall(function() c.highlight.Parent = core_gui end);

	c.box.outline = Drawing.new("Square");
	c.box.outline.Color = cfg.box.outline;
	c.box.outline.Thickness = 1;
	c.box.outline.Filled = false;
	c.box.outline.Visible = false;

	c.box.square = Drawing.new("Square");
	c.box.square.Color = cfg.box.color;
	c.box.square.Thickness = cfg.box.thickness;
	c.box.square.Filled = false;
	c.box.square.Visible = false;

	c.box.inline = Drawing.new("Square");
	c.box.inline.Color = cfg.box.inline;
	c.box.inline.Thickness = 1;
	c.box.inline.Filled = false;
	c.box.inline.Visible = false;

	c.box.glow = Instance.new("ImageLabel");
	c.box.glow.Image = "rbxassetid://110204605000367";
	c.box.glow.ScaleType = Enum.ScaleType.Slice;
	c.box.glow.SliceCenter = Rect.new(v2new(21, 21), v2new(79, 79));
	c.box.glow.AutomaticSize = Enum.AutomaticSize.XY;
	c.box.glow.ImageTransparency = cfg.glow.transparency;
	c.box.glow.ResampleMode = Enum.ResamplerMode.Pixelated;
	c.box.glow.Visible = false;
	c.box.glow.BackgroundTransparency = 1;
	c.box.glow.Position = udim2offset(-21, -21);
	c.box.glow.BorderColor3 = Color3.fromRGB(0, 0, 0);
	c.box.glow.Size = udim2offset(0, 0);
	c.box.glow.BorderSizePixel = 0;
	c.box.glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	c.box.glow.ZIndex = 1;
	c.box.glow.Parent = espgui;

	c.box.glowgradient = Instance.new("UIGradient");
	c.box.glowgradient.Rotation = cfg.glow.rotation;
	c.box.glowgradient.Color = csnew({ cskp(0, cfg.glow.color_start), cskp(1, cfg.glow.color_end) });
	c.box.glowgradient.Transparency = nsnew({ nskp(0, 0), nskp(1, 0) });
	c.box.glowgradient.Parent = c.box.glow;

	local glowpad = Instance.new("UIPadding");
	glowpad.PaddingTop    = UDim.new(0, 21);
	glowpad.PaddingBottom = UDim.new(0, 20);
	glowpad.PaddingLeft   = UDim.new(0, 21);
	glowpad.PaddingRight  = UDim.new(0, 20);
	glowpad.Parent = c.box.glow;

	c.text.name  = makelabel(aligncenter);
	c.text.studs = makelabel(aligncenter);
	c.text.tool  = makelabel(alignleft);

	c.bars.hp = {};
	c.bars.hp.lasthp = 1;
	c.bars.hp.lastdist = -1;
	c.bars.hp.lastdiststr = "";

	c.bars.hp.bg = Instance.new("Frame");
	c.bars.hp.bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
	c.bars.hp.bg.BackgroundTransparency = 0.3;
	c.bars.hp.bg.BorderSizePixel = 0;
	c.bars.hp.bg.Visible = false;
	c.bars.hp.bg.ZIndex = 3;
	c.bars.hp.bg.Parent = espgui;

	local hpcorner = Instance.new("UICorner");
	hpcorner.CornerRadius = UDim.new(0, 2);
	hpcorner.Parent = c.bars.hp.bg;

	local hpstroke = Instance.new("UIStroke");
	hpstroke.Color = Color3.new(0, 0, 0);
	hpstroke.Thickness = 1;
	hpstroke.LineJoinMode = Enum.LineJoinMode.Round;
	hpstroke.Parent = c.bars.hp.bg;

	c.bars.hp.fill = Instance.new("Frame");
	c.bars.hp.fill.BackgroundColor3 = Color3.new(1, 1, 1);
	c.bars.hp.fill.BackgroundTransparency = 0;
	c.bars.hp.fill.BorderSizePixel = 0;
	c.bars.hp.fill.ZIndex = 4;
	c.bars.hp.fill.Parent = espgui;

	local hpfillcorner = Instance.new("UICorner");
	hpfillcorner.CornerRadius = UDim.new(0, 2);
	hpfillcorner.Parent = c.bars.hp.fill;

	c.bars.hp.gradient = Instance.new("UIGradient");
	c.bars.hp.gradient.Color = csnew({
		cskp(0,   cfg.health.color_high),
		cskp(0.5, cfg.health.color_mid),
		cskp(1,   cfg.health.color_low)
	});
	c.bars.hp.gradient.Rotation = 90;
	c.bars.hp.gradient.Parent = c.bars.hp.fill;
end;

esp.remove = function(player)
	if not cache[player] then return end;
	local c = cache[player];

	if c.box then
		if c.box.filled   then c.box.filled:Destroy()   end;
		if c.box.square   then c.box.square:Remove()    end;
		if c.box.outline  then c.box.outline:Remove()   end;
		if c.box.inline   then c.box.inline:Remove()    end;
		if c.box.glow     then c.box.glow:Destroy()     end;
	end;

	if c.text then
		if c.text.name  then c.text.name:Destroy()  end;
		if c.text.studs then c.text.studs:Destroy() end;
		if c.text.tool  then c.text.tool:Destroy()  end;
	end;

	if c.bars and c.bars.hp then
		if c.bars.hp.bg   then c.bars.hp.bg:Destroy()   end;
		if c.bars.hp.fill then c.bars.hp.fill:Destroy() end;
	end;

	if c.highlight then pcall(function() c.highlight:Destroy() end) end;

	cache[player] = nil;
end;

esp.hide = function(player)
	if not cache[player] then return end;
	local c = cache[player];

	if c.box then
		if c.box.filled  then c.box.filled.Visible  = false end;
		if c.box.square  then c.box.square.Visible  = false end;
		if c.box.outline then c.box.outline.Visible = false end;
		if c.box.inline  then c.box.inline.Visible  = false end;
		if c.box.glow    then c.box.glow.Visible    = false end;
	end;

	if c.text then
		if c.text.name  then c.text.name.Visible  = false end;
		if c.text.studs then c.text.studs.Visible = false end;
		if c.text.tool  then c.text.tool.Visible  = false end;
	end;

	if c.bars and c.bars.hp then
		if c.bars.hp.bg   then c.bars.hp.bg.Visible   = false end;
		if c.bars.hp.fill then c.bars.hp.fill.Visible = false end;
	end;

	if c.highlight and c.highlight.Enabled then c.highlight.Enabled = false end;
end;

local tickval = 0;

esp.update = LPH_NO_VIRTUALIZE(function(player)
	if not cache[player] then return end;

	local character = player.Character;
	if not character or not character.Parent then esp.hide(player) return end;

	local root = character:FindFirstChild("HumanoidRootPart");
	local hum  = character:FindFirstChildWhichIsA("Humanoid");

	if not root or not hum          then esp.hide(player) return end;
	if hum.Health <= 0              then esp.hide(player) return end;

	local cfg = ELI.esp;

	if cfg.team_check and player:GetAttribute("TeamID") ~= nil
		and player:GetAttribute("TeamID") == local_player:GetAttribute("TeamID") then
		esp.hide(player);
		return
	end;

	local rootpos = root.Position;
	local camcf   = camera.CFrame.Position;
	local dist    = (camcf - rootpos).Magnitude;

	if dist > cfg.max_dist then esp.hide(player) return end;

	local _, onscreen = camera:WorldToViewportPoint(rootpos);
	if not onscreen then esp.hide(player) return end;

	local left, top, w, h = esp.getbounds(root, dist);
	if not left then esp.hide(player) return end;

	local c        = cache[player];
	local cbox     = c.box;
	local ctext    = c.text;
	local chp      = c.bars.hp;

	local espVisible = false;
	if cfg.visible.enable then
		if (tickval - (c.visT or 0)) >= 0.05 then
			local ok, seen = pcall(check_wall, root);
			c.vis = ok and seen == true;
			c.visT = tickval;
		end;
		espVisible = c.vis == true;
	end;
	local flashing = cfg.filled.hit_flash and (tickval - (c.hitFlash or 0)) < (cfg.filled.hit_time or 0.3);

	local cfgfill  = cfg.filled;
	local cfgbox   = cfg.box;
	local cfgglow  = cfg.glow;
	local cfghp    = cfg.health;
	local cfgtxt   = cfg.text;

	if cfgfill.enable then
		local fb = cbox.filled;
		fb.Visible = true;
		fb.BackgroundTransparency = cfgfill.transparency;
		fb.Position = udim2offset(left, top);
		fb.Size = udim2offset(w, h);
		local fc1, fc2;
		if flashing then
			fc1, fc2 = cfg.filled.hit_color, cfg.filled.hit_color;
		elseif espVisible then
			fc1, fc2 = cfg.visible.color, cfg.visible.color;
		else
			fc1, fc2 = cfgfill.color_start, cfgfill.color_end;
		end;
		if cbox.fillC1 ~= fc1 or cbox.fillC2 ~= fc2 then
			cbox.fillC1, cbox.fillC2 = fc1, fc2;
			cbox.filledgradient.Color = csnew({ cskp(0, fc1), cskp(1, fc2) });
		end;
		cbox.filledgradient.Rotation = cfgfill.animated and (msin(tickval * cfgfill.speed) * 90) + cfgfill.rotation or cfgfill.rotation;
	else
		cbox.filled.Visible = false;
	end;

	if cfg.highlight.enable and c.highlight then
		local hl = c.highlight;
		if hl.Adornee ~= character then hl.Adornee = character end;
		local hfill;
		if flashing then
			hfill = cfg.filled.hit_color;
		elseif espVisible then
			hfill = cfg.visible.color;
		else
			hfill = cfg.highlight.fill_color;
		end;
		if hl.FillColor ~= hfill then hl.FillColor = hfill end;
		if hl.OutlineColor ~= cfg.highlight.outline_color then hl.OutlineColor = cfg.highlight.outline_color end;
		hl.FillTransparency = cfg.highlight.fill_transparency;
		hl.OutlineTransparency = cfg.highlight.outline_transparency;
		if not hl.Enabled then hl.Enabled = true end;
	elseif c.highlight and c.highlight.Enabled then
		c.highlight.Enabled = false;
	end;

	if cfgbox.enable then
		local sq  = cbox.square;
		local ol  = cbox.outline;
		local il  = cbox.inline;

		ol.Visible   = true;
		ol.Color     = cfgbox.outline;
		ol.Position  = v2new(left - 1, top - 1);
		ol.Size      = v2new(w + 2, h + 2);

		sq.Visible   = true;
		sq.Color     = espVisible and cfg.visible.color or cfgbox.color;
		sq.Thickness = cfgbox.thickness;
		sq.Position  = v2new(left, top);
		sq.Size      = v2new(w, h);

		il.Visible   = true;
		il.Color     = cfgbox.inline;
		il.Position  = v2new(left + 1, top + 1);
		il.Size      = v2new(w - 2, h - 2);
	else
		cbox.outline.Visible = false;
		cbox.square.Visible  = false;
		cbox.inline.Visible  = false;
	end;

	if cfgglow.enable and cfgbox.enable then
		local gl = cbox.glow;
		gl.Visible          = true;
		gl.ImageTransparency = cfgglow.transparency;
		gl.ImageColor3      = cfgglow.color_start;
		gl.Position         = udim2offset(left - 21, top - 21);
		gl.Size             = udim2offset(w + 42, h + 42);
		if cbox.glowC1 ~= cfgglow.color_start or cbox.glowC2 ~= cfgglow.color_end then
			cbox.glowC1, cbox.glowC2 = cfgglow.color_start, cfgglow.color_end;
			cbox.glowgradient.Color = csnew({ cskp(0, cfgglow.color_start), cskp(1, cfgglow.color_end) });
		end;
	else
		cbox.glow.Visible = false;
	end;

	if cfghp.enable then
		local hptarget = mclamp(hum.Health / mmax(hum.MaxHealth, 1), 0, 1);
		local hplerp   = chp.lasthp + (hptarget - chp.lasthp) * 0.1;

		if math.abs(hplerp - chp.lasthp) > 0.001 then
			chp.lasthp = hplerp;
		end;

		local fillh = mceil(h * chp.lasthp);
		local barx  = left - cfghp.width - cfghp.gap;

		local bg   = chp.bg;
		local fill = chp.fill;

		bg.Visible  = true;
		bg.Position = udim2offset(barx, top);
		bg.Size     = udim2offset(cfghp.width, h);

		fill.Visible  = true;
		fill.Position = udim2offset(barx, top + h - fillh);
		fill.Size     = udim2offset(cfghp.width, fillh);

		chp.gradient.Color = csnew({
			cskp(0,   cfghp.color_high),
			cskp(0.5, cfghp.color_mid),
			cskp(1,   cfghp.color_low)
		});
	else
		chp.bg.Visible   = false;
		chp.fill.Visible = false;
	end;

	local txtsize = cfgtxt.size;

	local textGradSeq, textFlow;
	if cfgtxt.gradient then
		textGradSeq = csnew({ cskp(0, cfgtxt.gradient_color1), cskp(0.5, cfgtxt.gradient_color2), cskp(1, cfgtxt.gradient_color1) });
		textFlow = cfgtxt.flow and v2new((tickval * (cfgtxt.flow_speed or 1)) % 2 - 1, 0) or v2new(0, 0);
	end;

	local lname = ctext.name;
	lname.Visible    = cfgtxt.name.enable;
	lname.Text       = player.Name;
	lname.TextColor3 = textGradSeq and Color3.new(1, 1, 1) or cfgtxt.name.color;
	lname.TextSize   = txtsize;
	lname.Position   = udim2offset(left, top - 13);
	lname.Size       = udim2offset(w, 12);
	applyTextGrad(lname, textGradSeq, textFlow);

	local distm = mfloor(dist * 0.28);
	if distm ~= chp.lastdist then
		chp.lastdist    = distm;
		chp.lastdiststr = sfmt("%dM", distm);
	end;

	local lstuds = ctext.studs;
	lstuds.Visible    = cfgtxt.studs.enable;
	lstuds.Text       = chp.lastdiststr;
	lstuds.TextColor3 = textGradSeq and Color3.new(1, 1, 1) or cfgtxt.studs.color;
	lstuds.TextSize   = txtsize;
	lstuds.Position   = udim2offset(left, top + h + 2);
	lstuds.Size       = udim2offset(w, 12);
	applyTextGrad(lstuds, textGradSeq, textFlow);

	local ltool = ctext.tool;
	if cfgtxt.tool.enable then
		ltool.Visible    = true;
		ltool.Text       = esp.getweapon(player);
		ltool.TextColor3 = textGradSeq and Color3.new(1, 1, 1) or cfgtxt.tool.color;
		applyTextGrad(ltool, textGradSeq, textFlow);
				ltool.TextSize   = txtsize;
		local tpos = cfgtxt.tool.position;
		if tpos == "top" then
			local ty = cfgtxt.name.enable and (top - 26) or (top - 13);
			ltool.TextXAlignment = aligncenter;
			ltool.Position = udim2offset(left, ty);
			ltool.Size     = udim2offset(w, 12);
		elseif tpos == "bottom" then
			local ty = top + h + 2;
			if cfgtxt.studs.enable then ty = ty + 13 end;
			ltool.TextXAlignment = aligncenter;
			ltool.Position = udim2offset(left, ty);
			ltool.Size     = udim2offset(w, 12);
		else
			ltool.TextXAlignment = alignleft;
			ltool.Position = udim2offset(left + w + cfghp.width + cfghp.gap + 2, top);
			ltool.Size     = udim2offset(50, 12);
		end;
	else
		ltool.Visible = false;
	end;
end);

for _, player in players:GetPlayers() do
	if player ~= local_player then esp.add(player) end;
end;

players.PlayerAdded:Connect(function(player)
	if player ~= local_player then esp.add(player) end;
end);

players.PlayerRemoving:Connect(function(player)
	esp.remove(player);
end);

local ZRHUB_state = { esp_hidden = false, vm_chams_last = 0 };

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
	tickval = tick();

	if not ELI.esp.enable then
		if not ZRHUB_state.esp_hidden then
			ZRHUB_state.esp_hidden = true;
			for _, player in players:GetPlayers() do
				if player ~= local_player then esp.hide(player) end;
			end;
		end;
		return
	end;

	ZRHUB_state.esp_hidden = false;
	for _, player in players:GetPlayers() do
		if player ~= local_player then esp.update(player) end;
	end;
end)));

trove:Add(function()
	for _, player in players:GetPlayers() do esp.remove(player) end;
	espgui:Destroy();
end)

do
    ZRHUB_state.dmgCallbacks = {};
    ZRHUB_state.dmgQueue = {};
    ZRHUB_state.onDamage = function(fn) ZRHUB_state.dmgCallbacks[#ZRHUB_state.dmgCallbacks + 1] = fn end;
    ZRHUB_state.fireDamage = function(plr, amount, worldpos)
        local q = ZRHUB_state.dmgQueue;
        q[#q + 1] = { plr, amount, worldpos };
    end;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        local q = ZRHUB_state.dmgQueue;
        local n = #q;
        if n == 0 then return end;
        ZRHUB_state.dmgQueue = {};
        for i = 1, n do
            local d = q[i];
            for _, cb in ipairs(ZRHUB_state.dmgCallbacks) do
                pcall(cb, d[1], d[2], d[3]);
            end;
        end;
    end)));
end

do
    local dgui = Instance.new("ScreenGui");
    dgui.Name = "\0";
    dgui.ResetOnSpawn = false;
    dgui.IgnoreGuiInset = true;
    dgui.DisplayOrder = 500;
    pcall(function() dgui.Parent = gethui() end);
    if not dgui.Parent then pcall(function() dgui.Parent = game:GetService("CoreGui") end) end;
    if not dgui.Parent then pcall(function() dgui.Parent = local_player:FindFirstChildOfClass("PlayerGui") end) end;
    trove:Add(function() pcall(function() dgui:Destroy() end) end);
    local function fontOf(name)
        local ok, f = pcall(function() return Enum.Font[name] end);
        return (ok and f) or Enum.Font.GothamBold;
    end;
    ZRHUB_state.onDamage(function(plr, amount, worldpos)
        local cfg = ELI.damage_numbers;
        if not cfg.enable or not worldpos then return end;
        local sp, onscreen = camera:WorldToViewportPoint(worldpos);
        if not onscreen then return end;
        local lbl = Instance.new("TextLabel");
        lbl.BackgroundTransparency = 1;
        lbl.Size = UDim2.fromOffset(140, 26);
        lbl.AnchorPoint = Vector2.new(0.5, 0.5);
        lbl.Position = UDim2.fromOffset(sp.X, sp.Y);
        lbl.Font = fontOf(cfg.font);
        lbl.TextSize = cfg.text_size or 18;
        lbl.Text = "-" .. tostring(math.floor(amount + 0.5));
        lbl.TextStrokeTransparency = 1;
        lbl.TextColor3 = cfg.color1;
        lbl.ZIndex = 10;
        lbl.Parent = dgui;

        local stroke = Instance.new("UIStroke", lbl);
        stroke.Thickness = 1.5;
        stroke.Color = Color3.new(0, 0, 0);
        stroke.Transparency = 0.15;
        stroke.LineJoinMode = Enum.LineJoinMode.Round;

        local scale = Instance.new("UIScale", lbl);
        scale.Scale = 0.5;

        if cfg.color_type == "Gradient" then
            local grad = Instance.new("UIGradient", lbl);
            grad.Color = csnew({ cskp(0, cfg.color1), cskp(1, cfg.color2) });
            grad.Rotation = 90;
            lbl.TextColor3 = Color3.new(1, 1, 1);
        end;

        local startX, startY = sp.X, sp.Y;
        local jitter = math.random(-14, 14);
        local start = tick();
        local dur = cfg.duration or 0.8;
        local rise = cfg.rise or 42;
        local conn;
        conn = run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
            local t = (tick() - start) / dur;
            if t >= 1 then conn:Disconnect(); pcall(function() lbl:Destroy() end); return end;
            local ease = 1 - (1 - t) * (1 - t) * (1 - t);
            if cfg.color_type == "Rainbow" then
                lbl.TextColor3 = Color3.fromHSV((tick() * 0.6) % 1, 0.75, 1);
            end;
            local s;
            if t < 0.16 then
                s = 0.5 + (t / 0.16) * 0.62;
            else
                s = 1.12 - ((t - 0.16) / 0.84) * 0.12;
            end;
            scale.Scale = s;
            local fade = t < 0.55 and 0 or (t - 0.55) / 0.45;
            lbl.Position = UDim2.fromOffset(startX + jitter * ease, startY - rise * ease);
            lbl.TextTransparency = fade;
            stroke.Transparency = 0.15 + 0.85 * fade;
        end));
    end);
end;

local thrower = {};

workspace.ChildRemoved:Connect(function(obj)
    if not thrower[obj] then return end;
    thrower[obj].name:Destroy();
    thrower[obj].dist:Destroy();
    thrower[obj].icon:Destroy();
    thrower[obj] = nil;
end);

function get_skin_thumb(weapon_name)
    if weapon_name == "SubspaceTripmineHitbox" then
        local viewmodel_data = item_lib.ViewModels["Subspace Tripmine"];
        return viewmodel_data and (viewmodel_data.ImageHighResolution or viewmodel_data.Image) or "";
    end;

    local cosmetic_data = cosmetic_lib.Cosmetics[weapon_name];
    if cosmetic_data then
        return cosmetic_data.ImageHighResolution or cosmetic_data.Image or "";
    end;

    local viewmodel_data = item_lib.ViewModels[weapon_name];
    if viewmodel_data then
        return viewmodel_data.ImageHighResolution or viewmodel_data.Image or "";
    end;

    return "";
end;

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    local active = {};
    local current_font = getgenv().fonts[ELI.thrower_esp.font];

    if not current_font then return end;

    if not ELI.thrower_esp.enable then
        for _, v in next, thrower do
            v.name.Visible = false;
            v.dist.Visible = false;
            v.icon.Visible = false;
        end;
        return;
    end;

    for _, v in next, workspace:GetChildren() do
        local sel = ELI.thrower_esp.thrower_select;
        if type(sel) ~= "table" then continue end;

        local selected = false;
        local display_name = v.Name;

        for display, enabled in next, sel do
            if not enabled then continue end;

            local target_name = thisisforsubspace[display] or display;
            local actual_weapon = v.Name;

            local cosmetic_data = cosmetic_lib.Cosmetics[v.Name];
            if cosmetic_data and cosmetic_data.ItemName then
                actual_weapon = cosmetic_data.ItemName;
            end;

            if target_name == v.Name or target_name == actual_weapon then
                selected = true;
                display_name = display;
                break;
            end;
        end;

        if not selected then
            if thrower[v] then
                thrower[v].name:Destroy();
                thrower[v].dist:Destroy();
                thrower[v].icon:Destroy();
                thrower[v] = nil;
            end;
            continue;
        end;

        local root = v:FindFirstChildWhichIsA("BasePart");
        if not root then continue end;

        active[v] = true;

        if not thrower[v] then
            local thumb = get_skin_thumb(v.Name);

            local icon_label = Instance.new("ImageLabel");
            icon_label.BackgroundTransparency = 1;
            icon_label.Size = UDim2.fromOffset(140, 140);
            icon_label.Image = thumb;
            icon_label.Visible = false;
            icon_label.Parent = espgui;

            local name_label = Instance.new("TextLabel");
            name_label.BackgroundTransparency = 1;
            name_label.TextStrokeTransparency = 0;
            name_label.TextStrokeColor3 = Color3.new(0, 0, 0);
            name_label.TextScaled = false;
            name_label.FontFace = current_font;
            name_label.TextXAlignment = Enum.TextXAlignment.Center;
            name_label.Size = UDim2.fromOffset(80, 14);
            name_label.Visible = false;
            name_label.Parent = espgui;

            local dist_label = Instance.new("TextLabel");
            dist_label.BackgroundTransparency = 1;
            dist_label.TextStrokeTransparency = 0;
            dist_label.TextStrokeColor3 = Color3.new(0, 0, 0);
            dist_label.TextScaled = false;
            dist_label.FontFace = current_font;
            dist_label.TextXAlignment = Enum.TextXAlignment.Center;
            dist_label.Size = UDim2.fromOffset(80, 12);
            dist_label.Visible = false;
            dist_label.Parent = espgui;

            thrower[v] = { name = name_label, dist = dist_label, icon = icon_label };
        end;

        thrower[v].name.FontFace = current_font;
        thrower[v].dist.FontFace = current_font;
        thrower[v].icon.Image = get_skin_thumb(v.Name);

        local pos, on_screen = camera:WorldToViewportPoint(root.Position);

        thrower[v].icon.Visible = on_screen and ELI.thrower_esp.image == true;
        thrower[v].name.Visible = on_screen and ELI.thrower_esp.name == true;
        thrower[v].name.TextColor3 = ELI.thrower_esp.name_color;
        thrower[v].name.TextSize = ELI.thrower_esp.name_size;
        thrower[v].dist.Visible = on_screen and ELI.thrower_esp.distance == true;
        thrower[v].dist.TextColor3 = ELI.thrower_esp.distance_color;
        thrower[v].dist.TextSize = ELI.thrower_esp.distance_size;

        if on_screen then
            thrower[v].icon.Position = UDim2.fromOffset(pos.X - 70, pos.Y - 110);
            thrower[v].name.Position = UDim2.fromOffset(pos.X - 40, pos.Y - 7);
            thrower[v].name.Text = display_name;
            thrower[v].dist.Position = UDim2.fromOffset(pos.X - 40, pos.Y + 7);
            thrower[v].dist.Text = string.format("%.0fm", (camera.CFrame.Position - root.Position).Magnitude * 0.28);
        end;
    end;

    for obj, labels in next, thrower do
        if not active[obj] then
            labels.name:Destroy();
            labels.dist:Destroy();
            labels.icon:Destroy();
            thrower[obj] = nil;
        end;
    end;
end)));
local weather_types = {
    ["snow"] = {
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7374999523162842), NumberSequenceKeypoint.new(0.973, 0.768750011920929), NumberSequenceKeypoint.new(1, 1) }),
        Texture = "http://www.roblox.com/asset/?id=99851851",
        SpreadAngle = Vector2.new(50, 50),
        Speed = NumberRange.new(30, 30),
        LightEmission = 10,
        Rate = 1000,
        EmissionDirection = Enum.NormalId.Bottom,
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.33096909523010254), NumberSequenceKeypoint.new(0.551, 0.40189146995544434), NumberSequenceKeypoint.new(1, 0.33096909523010254) }),
    },
    ["rain"] = {
        Speed = NumberRange.new(60, 60),
        LockedToPart = true,
        Rate = 600,
        Texture = "rbxassetid://1822883048",
        EmissionDirection = Enum.NormalId.Bottom,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.7842668294906616), NumberSequenceKeypoint.new(0.75, 0.7842668294906616), NumberSequenceKeypoint.new(1, 1) }),
        Lifetime = NumberRange.new(0.800000011920929, 0.800000011920929),
        LightEmission = 0.05000000074505806,
        LightInfluence = 0.8999999761581421,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(1, 10) }),
    },
    ["light rain"] = {
        LockedToPart = true,
        Rate = 500,
        Squash = NumberSequence.new({ NumberSequenceKeypoint.new(0, 3), NumberSequenceKeypoint.new(1, 3) }),
        LightInfluence = 0.30000001192092896,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.435, 0), NumberSequenceKeypoint.new(1, 0) }),
        Texture = "rbxasset://textures/particles/sparkles_main.dds",
        Speed = NumberRange.new(30, 50),
        Lifetime = NumberRange.new(9, 9),
        LightEmission = 0.5,
        Brightness = 2,
        EmissionDirection = Enum.NormalId.Bottom,
        Orientation = Enum.ParticleOrientation.FacingCameraWorldUp,
        Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.20000000298023224), NumberSequenceKeypoint.new(1, 0.20000000298023224) }),
    },
};

local weather = {} do
    local part = Instance.new("Part");
    part.Size = Vector3.new(40, 40, 85);
    part.CanCollide = false;
    part.Massless = true;
    part.CastShadow = false;
    part.Transparency = 1;
    part.Anchored = true;
    part.Name = "weather";
    part.Parent = workspace;

    local emitter = Instance.new("ParticleEmitter");
    for prop, val in next, weather_types[ELI.weather.type] do
        emitter[prop] = val;
    end;
    emitter.Color = ColorSequence.new(ELI.weather.color);
    emitter.Enabled = false;
    emitter.Parent = part;

    weather.part = part;
    weather.emitter = emitter;
    weather.last_type = ELI.weather.type;

    trove:Add(part);
end;

function rebuild_emitter()
    weather.emitter:Destroy();

    local emitter = Instance.new("ParticleEmitter");
    for prop,val in next, weather_types[ELI.weather.type] do
        emitter[prop] = val;
    end;
    emitter.Color = ColorSequence.new(ELI.weather.color);
    emitter.Enabled = true;
    emitter.Parent = weather.part;

    weather.emitter = emitter;
    weather.last_type = ELI.weather.type;
end;

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if not ELI.weather.enable then
        weather.emitter.Enabled = false;
        return;
    end;

    if weather.last_type ~= ELI.weather.type then
        rebuild_emitter();
    end;

    weather.emitter.Enabled = true;
    weather.emitter.Rate = ELI.weather.rate;
    weather.emitter.Color = ColorSequence.new(ELI.weather.color);
    weather.part.CFrame = CFrame.new(camera.CFrame.Position + Vector3.new(0, 20, 0));
end)));

run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.stretched_res.enable then
    camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, ELI.stretched_res.stretched_res_amount, 0, 0, 0, 1);
    end;
end));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.infinite_double_jump.enable then
    mechanics_controller._double_jumps_used = {};
    end;
end)));

do
local active_tracers = 0;
local MAX_ACTIVE_TRACERS = 48;

function create_beam(from, to, lerp_override)
    if active_tracers >= MAX_ACTIVE_TRACERS then
        return;
    end;
    active_tracers += 1;
    local total_time = 0;
    local tween;
    local fade_duration = ELI.bullet_tracers.life_time;
    local direction = (to - from);
    local total_distance = direction.Magnitude;
    local unit = direction.Unit;
    local lerp_speed = lerp_override or ELI.bullet_tracers.position_lerp_speed;

    local origin_hold = Instance.new('Part');
    origin_hold.Anchored = true;
    origin_hold.CanCollide = false;
    origin_hold.CanTouch = false;
    origin_hold.CanQuery = false;
    origin_hold.Transparency = 1;
    origin_hold.CFrame = CFrame.new(from);
    origin_hold.Parent = workspace;

    local hit_hold = Instance.new('Part');
    hit_hold.Anchored = true;
    hit_hold.CanCollide = false;
    hit_hold.CanTouch = false;
    hit_hold.CanQuery = false;
    hit_hold.Transparency = 1;
    hit_hold.CFrame = CFrame.new(from);
    hit_hold.Parent = workspace;

    local origin_att = Instance.new('Attachment');
    origin_att.Parent = origin_hold;
    local hit_att = Instance.new('Attachment');
    hit_att.Parent = hit_hold;

    local tracer = Instance.new('Beam');
    tracer.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ELI.bullet_tracers.color_start),
        ColorSequenceKeypoint.new(0.5, ELI.bullet_tracers.color_end),
        ColorSequenceKeypoint.new(1, ELI.bullet_tracers.color_start),
    });
    tracer.Brightness = ELI.bullet_tracers.glow;
    tracer.LightEmission = ELI.bullet_tracers.glow;
    tracer.LightInfluence = 0;
    tracer.TextureSpeed = ELI.bullet_tracers.speed;
    tracer.TextureLength = 3;
    tracer.FaceCamera = true;
    tracer.Texture = texture_id[ELI.bullet_tracers.texture];
    tracer.TextureMode = Enum.TextureMode.Wrap;
    tracer.Attachment0 = origin_att;
    tracer.Attachment1 = hit_att;
    local base_width0 = ELI.bullet_tracers.width0;
    local base_width1 = ELI.bullet_tracers.width1;
    local spring_expand = ELI.bullet_tracers.spring_expand;
    local spring_speed = ELI.bullet_tracers.expand_speed;
    local spring_damper = ELI.bullet_tracers.expand_damper;
    local spring_pos = spring_expand and 0 or 1;
    local spring_vel = 0;
    tracer.Width0 = base_width0 * spring_pos;
    tracer.Width1 = base_width1 * spring_pos;
    tracer.Enabled = true;
    tracer.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 0.3),
    });

    pcall(function()
        local tcfg = ELI.bullet_tracers;
        if not tcfg.curve_around then
            return
        end;

        local params = RaycastParams.new();
        params.FilterType = Enum.RaycastFilterType.Exclude;
        params.FilterDescendantsInstances = { local_player.Character, origin_hold, hit_hold };

        local blocked = workspace:Raycast(from, to - from, params);
        if not (blocked and (blocked.Position - from).Magnitude < (total_distance - 2)) then
            return
        end;

        local maxH = tcfg.curve_height or 14;
        local right = unit:Cross(Vector3.yAxis);
        right = right.Magnitude > 0.01 and right.Unit or Vector3.xAxis;
        local upv = right:Cross(unit).Unit;
        if upv.Y < 0 then upv = -upv end;
        local mid = (from + to) * 0.5;

        local function pathClear(apex)
            local a = workspace:Raycast(from, apex - from, params);
            if a and (a.Position - from).Magnitude < (apex - from).Magnitude - 1 then return false end;
            local b = workspace:Raycast(apex, to - apex, params);
            if b and (b.Position - apex).Magnitude < (to - apex).Magnitude - 1 then return false end;
            return true;
        end;

        local dirs = {
            upv,
            (upv + right * 0.6).Unit,
            (upv - right * 0.6).Unit,
            right,
            -right,
        };
        local heights = { maxH * 0.7, maxH, maxH * 1.5 };

        local bestDir, bestH;
        for _, d in eli_ipairs(dirs) do
            for _, h in eli_ipairs(heights) do
                if pathClear(mid + d * h) then
                    bestDir, bestH = d, h;
                    break;
                end;
            end;
            if bestDir then break end;
        end;

        if not bestDir then
            bestDir = upv;
            bestH = math.min(maxH * 1.5, total_distance * 0.4);
        end;

        local ref = math.abs(bestDir.Y) < 0.99 and Vector3.yAxis or Vector3.xAxis;
        local u0 = bestDir:Cross(ref).Unit;
        local u1 = (-bestDir):Cross(ref).Unit;
        origin_att.CFrame = CFrame.fromMatrix(Vector3.zero, bestDir, u0);
        hit_att.CFrame = CFrame.fromMatrix(Vector3.zero, -bestDir, u1);
        tracer.CurveSize0 = bestH;
        tracer.CurveSize1 = bestH;
    end);

    tracer.Parent = workspace;

    local wallLine;
    if ELI.bullet_tracers.through_walls then
        pcall(function()
            wallLine = Drawing.new("Line");
            wallLine.Thickness = math.max(base_width0 * 4, 1.5);
            wallLine.Color = ELI.bullet_tracers.color_start;
            wallLine.Transparency = 1;
            wallLine.Visible = false;
        end);
    end;

    local elapsed = 0;
    tween = run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(delta_time)
        total_time += delta_time;
        elapsed += delta_time;

        local lerp_alpha = elapsed / lerp_speed;
        if lerp_alpha >= 1 then lerp_alpha = 1 end;

        local traveled = total_distance * lerp_alpha;
        if traveled > total_distance then traveled = total_distance end;

        hit_hold.CFrame = CFrame.new(from + unit * traveled);

        if wallLine then
            local a = camera:WorldToViewportPoint(from);
            local b = camera:WorldToViewportPoint(from + unit * traveled);
            if a.Z > 0 and b.Z > 0 then
                wallLine.From = Vector2.new(a.X, a.Y);
                wallLine.To = Vector2.new(b.X, b.Y);
                wallLine.Color = ELI.bullet_tracers.color_start;
                wallLine.Visible = true;
            else
                wallLine.Visible = false;
            end;
        end;

        if spring_expand then
            local accel = (1 - spring_pos) * spring_speed * spring_speed - 2 * spring_damper * spring_speed * spring_vel;
            spring_vel += accel * delta_time;
            spring_pos += spring_vel * delta_time;
            tracer.Width0 = base_width0 * spring_pos;
            tracer.Width1 = base_width1 * spring_pos;
        end;

        local alpha = tween_service:GetValue((total_time / fade_duration), Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        tracer.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1 + (alpha * 0.9)),
            NumberSequenceKeypoint.new(0.5, alpha),
            NumberSequenceKeypoint.new(1, 0.3 + (alpha * 0.7)),
        });

        if wallLine then
            wallLine.Transparency = math.clamp(1 - alpha, 0, 1);
        end;
    end));

    task.delay(fade_duration, function()
        if tween then tween:Disconnect(); end;
        if wallLine then pcall(function() wallLine:Remove() end) end;
        pcall(function() tracer:Destroy(); end);
        pcall(function() origin_hold:Destroy(); end);
        pcall(function() hit_hold:Destroy(); end);
        active_tracers -= 1;
        if active_tracers < 0 then active_tracers = 0; end;
    end);
end;
end;

local old_tracer = tracer_effect.Play; tracer_effect.Play = function(...)
    local args = {...};
    if ELI.silent_aim.visualize and ELI.silent_aim.enable
        and args[2] and args[2].IsLocal and args[2].RaycastResults then
        local st = ZRHUB_state.silentTarget;
        if st and (tick() - (ZRHUB_state.silentTargetT or 0)) < 0.2 then
            for _, v in next, args[2].RaycastResults do
                pcall(function() v.Position = st end);
            end;
        end;
    end;
    if ELI.bullet_tracers.enable then
        if args[2] and args[2].IsLocal then
            local muzzle = args[4] and args[4].MuzzlePosition;
            if muzzle and args[2].RaycastResults then
                for i,v in next, args[2].RaycastResults do
                    if v.Position then
                        create_beam(muzzle, v.Position, nil);
                    end;
                end;
            end;
            return;
        end;
    end;
    return old_tracer(...);
end;

trove:Add(function()
    tracer_effect.Play = old_tracer;
end);

function GetMuzzlePos()
    for M,P in first_person:GetDescendants() do
        if P.Name == "_muzzle" and P:IsA("Attachment") then
            local Pos = camera:WorldToViewportPoint(P.WorldPosition);
            return Vector2.new(Pos.X, Pos.Y);
        end;
    end;
    return Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
end;

local sfov_gui = Instance.new("ScreenGui", gethui());
sfov_gui.ResetOnSpawn = false;
sfov_gui.IgnoreGuiInset = true;

local sfov = Instance.new("Frame", sfov_gui);
sfov.BorderSizePixel = 0;
sfov.Visible = false;
sfov.BackgroundTransparency = 1;
Instance.new("UICorner", sfov).CornerRadius = UDim.new(1, 0);

local sfov_stroke = Instance.new("UIStroke", sfov);
sfov_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;

local sfov_fill_gradient = Instance.new("UIGradient", sfov);
local sfov_stroke_gradient = Instance.new("UIGradient", sfov_stroke);

local afov_gui = Instance.new("ScreenGui", gethui());
afov_gui.ResetOnSpawn = false;
afov_gui.IgnoreGuiInset = true;

local afov = Instance.new("Frame", afov_gui);
afov.BorderSizePixel = 0;
afov.Visible = false;
afov.BackgroundTransparency = 1;
Instance.new("UICorner", afov).CornerRadius = UDim.new(1, 0);

local afov_stroke = Instance.new("UIStroke", afov);
afov_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;

local afov_fill_gradient = Instance.new("UIGradient", afov);
local afov_stroke_gradient = Instance.new("UIGradient", afov_stroke);

local fov_rotation = 0;

local sfov_current_pos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
local sfov_current_radius = ELI.silent_aim.fov_radius;

local afov_current_pos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
local afov_current_radius = ELI.aimbot.fov_radius;

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
    local s_show = (ELI.silent_aim.enable or ZRHUB_state.zcSilentOn) and ELI.silent_aim.show_fov;
    local a_show = ELI.aimbot.enable and ELI.aimbot.show_fov;

    if not s_show and not a_show then
        if sfov.Visible then sfov.Visible = false end;
        if afov.Visible then afov.Visible = false end;
        return
    end;

    fov_rotation = (fov_rotation + ELI.silent_aim.fov_rotation_speed * dt) % 360;

    local scenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);

    local smuzzle;
    if ELI.silent_aim.follow_target and ELI.silent_aim.follow_gunpoint then
        local t = getclosest();
        if t and t.Character and t.Character:FindFirstChild(ELI.targeting.part) then
            local pos, onscreen = camera:WorldToViewportPoint(t.Character[ELI.targeting.part].Position);
            smuzzle = onscreen and Vector2.new(pos.X, pos.Y) or GetMuzzlePos();
        else
            smuzzle = GetMuzzlePos();
        end;
    elseif ELI.silent_aim.follow_target then
        local t = getclosest();
        if t and t.Character and t.Character:FindFirstChild(ELI.targeting.part) then
            local pos, onscreen = camera:WorldToViewportPoint(t.Character[ELI.targeting.part].Position);
            smuzzle = onscreen and Vector2.new(pos.X, pos.Y) or scenter;
        else
            smuzzle = scenter;
        end;
    elseif ELI.silent_aim.follow_gunpoint then
        smuzzle = GetMuzzlePos();
    else
        smuzzle = scenter;
    end;

    local amuzzle;
    if ELI.aimbot.follow_target and ELI.aimbot.follow_gunpoint then
        local t = getclosest2();
        if t and t.Character and t.Character:FindFirstChild(ELI.targeting.part) then
            local pos, onscreen = camera:WorldToViewportPoint(t.Character[ELI.targeting.part].Position);
            amuzzle = onscreen and Vector2.new(pos.X, pos.Y) or GetMuzzlePos();
        else
            amuzzle = GetMuzzlePos();
        end;
    elseif ELI.aimbot.follow_target then
        local t = getclosest2();
        if t and t.Character and t.Character:FindFirstChild(ELI.targeting.part) then
            local pos, onscreen = camera:WorldToViewportPoint(t.Character[ELI.targeting.part].Position);
            amuzzle = onscreen and Vector2.new(pos.X, pos.Y) or scenter;
        else
            amuzzle = scenter;
        end;
    elseif ELI.aimbot.follow_gunpoint then
        amuzzle = GetMuzzlePos();
    else
        amuzzle = scenter;
    end;

    local st = math.min(dt * (1 / math.max(ELI.silent_aim.lerp, 0.001)), 1);
    local at = math.min(dt * (1 / math.max(ELI.aimbot.lerp, 0.001)), 1);

    sfov_current_pos = sfov_current_pos:Lerp(smuzzle, st);
    sfov_current_radius = sfov_current_radius + (ELI.silent_aim.fov_radius - sfov_current_radius) * st;

    afov_current_pos = afov_current_pos:Lerp(amuzzle, at);
    afov_current_radius = afov_current_radius + (ELI.aimbot.fov_radius - afov_current_radius) * at;

    local s_fill_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ELI.silent_aim.fov_fill_color),
        ColorSequenceKeypoint.new(0.5, ELI.silent_aim.fov_fill_color3 or ELI.silent_aim.fov_fill_color2),
        ColorSequenceKeypoint.new(1, ELI.silent_aim.fov_fill_color2),
    });
    local s_stroke_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ELI.silent_aim.fov_color),
        ColorSequenceKeypoint.new(0.5, ELI.silent_aim.fov_color3 or ELI.silent_aim.fov_color2 or ELI.silent_aim.fov_color),
        ColorSequenceKeypoint.new(1, ELI.silent_aim.fov_color2 or ELI.silent_aim.fov_color),
    });

    sfov.Visible = (ELI.silent_aim.enable or ZRHUB_state.zcSilentOn) and ELI.silent_aim.show_fov;
    sfov.BackgroundColor3 = Color3.new(1, 1, 1);
    sfov.BackgroundTransparency = ELI.silent_aim.show_fill and ELI.silent_aim.fov_fill_transparency or 1;
    sfov.Size = UDim2.new(0, sfov_current_radius * 2, 0, sfov_current_radius * 2);
    sfov.Position = UDim2.new(0, sfov_current_pos.X - sfov_current_radius, 0, sfov_current_pos.Y - sfov_current_radius);
    sfov.Rotation = fov_rotation;
    sfov_stroke.Color = Color3.new(1, 1, 1);
    sfov_stroke.Transparency = ELI.silent_aim.fov_outline_transparency;
    sfov_stroke.Thickness = ELI.silent_aim.fov_thickness;
    sfov_fill_gradient.Enabled = ELI.silent_aim.show_fill;
    sfov_fill_gradient.Color = s_fill_gradient;
    sfov_fill_gradient.Rotation = fov_rotation;
    sfov_stroke_gradient.Color = s_stroke_gradient;
    sfov_stroke_gradient.Rotation = fov_rotation;

    local a_fill_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ELI.aimbot.fov_fill_color),
        ColorSequenceKeypoint.new(0.5, ELI.aimbot.fov_fill_color3 or ELI.aimbot.fov_fill_color2),
        ColorSequenceKeypoint.new(1, ELI.aimbot.fov_fill_color2),
    });
    local a_stroke_gradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ELI.aimbot.fov_color),
        ColorSequenceKeypoint.new(0.5, ELI.aimbot.fov_color3 or ELI.aimbot.fov_color2 or ELI.aimbot.fov_color),
        ColorSequenceKeypoint.new(1, ELI.aimbot.fov_color2 or ELI.aimbot.fov_color),
    });

    afov.Visible = ELI.aimbot.enable and ELI.aimbot.show_fov;
    afov.BackgroundColor3 = Color3.new(1, 1, 1);
    afov.BackgroundTransparency = ELI.aimbot.show_fill and ELI.aimbot.fov_fill_transparency or 1;
    afov.Size = UDim2.new(0, afov_current_radius * 2, 0, afov_current_radius * 2);
    afov.Position = UDim2.new(0, afov_current_pos.X - afov_current_radius, 0, afov_current_pos.Y - afov_current_radius);
    afov.Rotation = fov_rotation;
    afov_stroke.Color = Color3.new(1, 1, 1);
    afov_stroke.Transparency = ELI.aimbot.fov_outline_transparency;
    afov_stroke.Thickness = ELI.aimbot.fov_thickness;
    afov_fill_gradient.Enabled = ELI.aimbot.show_fill;
    afov_fill_gradient.Color = a_fill_gradient;
    afov_fill_gradient.Rotation = fov_rotation;
    afov_stroke_gradient.Color = a_stroke_gradient;
    afov_stroke_gradient.Rotation = fov_rotation;
end)));

trove:Add(function()
    sfov_gui:Destroy();
end);
trove:Add(function()
    afov_gui:Destroy();
end);

local deflecting = {};

is_deflecting = LPH_NO_VIRTUALIZE(function(plr)
    return deflecting[plr];
end);

has_riot = LPH_NO_VIRTUALIZE(function(plr)
    return workspace.ViewModels:FindFirstChild(plr.Name .. " - Riot Shield - Riot Shield") ~= nil;
end);

check_wall = LPH_NO_VIRTUALIZE(function(part)
    local ray = Ray.new(camera.CFrame.Position, part.Position - camera.CFrame.Position);
    local hit_part = workspace:FindPartOnRayWithIgnoreList(ray, {local_player.Character, part.Parent});
    return not hit_part;
end);

closest_part = LPH_NO_VIRTUALIZE(function(plr)
    local mouse_pos = Vector2.new(mouse.X,mouse.Y);
    local closest = math.huge;
    local closestp;
    for i,v in next, plr.Character:GetChildren() do
        if v:IsA("BasePart") then
            local pos,on_screen = camera:WorldToViewportPoint(v.Position);
            if on_screen then
                local dist = (mouse_pos - Vector2.new(pos.X,pos.Y)).Magnitude;
                if dist <= closest then
                    closest = dist;
                    closestp = v;
                end;
            end;
        end;
    end;
    return closestp;
end);

getclosest = LPH_NO_VIRTUALIZE(function()
    local closest = ELI.targeting.max_distance;
    local player;
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
    for i,v in players:GetPlayers() do
        if v ~= local_player and v.Character and v.Character:FindFirstChild(ELI.targeting.part) and v.Character.Humanoid.Health > 0 then
            if is_deflecting(v) then
                continue;
            end;

            if v:GetAttribute('TeamID') == local_player:GetAttribute('TeamID') then
                continue;
            end;
            if ELI.targeting.visible_only and not check_wall(v.Character[ELI.targeting.part]) then
                continue;
            end;
            if ELI.targeting.riot_shield and has_riot(v) then
                continue;
            end;
            local pos, on_screen = camera:WorldToViewportPoint(v.Character[ELI.targeting.part].Position);
            if on_screen then
                local dist = (center - Vector2.new(pos.X, pos.Y)).Magnitude;
                if dist < closest and dist <= ELI.silent_aim.fov_radius then
                    player = v;
                    closest = dist;
                end;
            end;
        end;
    end;
    return player;
end);

getclosest2 = LPH_NO_VIRTUALIZE(function()
    local closest = ELI.targeting.max_distance;
    local player;
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
     for i,v in players:GetPlayers() do
        if v ~= local_player and v.Character and v.Character:FindFirstChild(ELI.targeting.part) and v.Character.Humanoid.Health > 0 then
            if v:GetAttribute('TeamID') == local_player:GetAttribute('TeamID') then
                continue;
            end;
            if is_deflecting(v) then
                continue;
            end;
            if ELI.targeting.visible_only and not check_wall(v.Character[ELI.targeting.part]) then
                continue;
            end;
            if ELI.targeting.riot_shield and has_riot(v) then
                continue;
            end;
            local pos, on_screen = camera:WorldToViewportPoint(v.Character[ELI.targeting.part].Position);
            if on_screen then
                local dist = (center - Vector2.new(pos.X,pos.Y)).Magnitude;
                if dist < closest and dist < ELI.aimbot.fov_radius then
                    player = v;
                    closest = dist;
                end;
            end;
        end;
    end;
    return player;
end);

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.aimbot.enable and not ZRHUB_state.zc then
        local closest = getclosest2();
        if (closest and closest.Character) then
            local target_pos;
            if ELI.aimbot.closest_part then
                local part = closest_part(closest);
                target_pos = part and part.Position or closest.Character[ELI.targeting.part].Position;
            else
                target_pos = closest.Character[ELI.targeting.part].Position;
            end;
            camera_controller:MimicRotation(camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, target_pos), ELI.aimbot.smoothing));
        end;
    end;
end)));

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.slide_boost.enable then
        if mechanics_controller.IsSliding then
            mechanics_controller._sliding_velocity.Velocity = mechanics_controller._sliding_velocity.Velocity.Unit * ELI.slide_boost.speed;
        end;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.third_person.enable then
        if camera_controller.CameraState:GetPublicState() ~= camera_controller.CameraState.States.ThirdPerson then
            camera_controller.CameraState:TogglePOV();
        end;
    end;
end)))

do
local vm_material_presets = getgenv().ZRHUB_materials.presets;

local vm_arm_keywords = { "arm", "hand", "sleeve", "elbow", "wrist", "shoulder", "finger", "thumb", "glove" };

local vm_tracked = {};
local vm_arm_cache = setmetatable({}, { __mode = "k" });

local function vm_is_arm(part)
    local cached = vm_arm_cache[part];
    if cached ~= nil then
        return cached;
    end;

    local result = false;
    local name = string.lower(part.Name);
    for i = 1, #vm_arm_keywords do
        if string.find(name, vm_arm_keywords[i], 1, true) then
            result = true;
            break;
        end;
    end;

    if not result then
        local ancestor = part.Parent;
        while ancestor and ancestor ~= first_person do
            local aname = string.lower(ancestor.Name);
            if string.find(aname, "arm", 1, true) or string.find(aname, "rig", 1, true) then
                result = true;
                break;
            end;
            ancestor = ancestor.Parent;
        end;
    end;

    vm_arm_cache[part] = result;
    return result;
end;

local vm_visible_cache = setmetatable({}, { __mode = "k" });
local function vm_visible(part)
    if vm_visible_cache[part] == nil then
        vm_visible_cache[part] = part.Transparency < 1 and part.Size.Magnitude < 40;
    end;
    return vm_visible_cache[part];
end;

local function vm_store(part)
    if not vm_tracked[part] then
        vm_tracked[part] = {
            Material = part.Material,
            Color = part.Color,
            Reflectance = part.Reflectance,
            Transparency = part.Transparency,
            LocalTransparencyModifier = part.LocalTransparencyModifier,
        };
    end;
end;

local function vm_restore(part)
    local saved = vm_tracked[part];
    if saved then
        if part.Parent then
            part.Material = saved.Material;
            part.Color = saved.Color;
            part.Reflectance = saved.Reflectance;
            part.Transparency = saved.Transparency;
            part.LocalTransparencyModifier = saved.LocalTransparencyModifier;
        end;
        vm_tracked[part] = nil;
    end;
end;

local function vm_clear()
    for part in next, vm_tracked do
        vm_restore(part);
    end;
    table.clear(vm_tracked);
end;

local function vm_paint(part, preset_name, color, transparency)
    local preset = vm_material_presets[preset_name] or vm_material_presets["Neon"];
    part.Material = preset.material;
    part.Reflectance = preset.reflectance or 0;
    part.Transparency = math.clamp((preset.transparency or 0) + (transparency or 0), 0, 1);
    part.LocalTransparencyModifier = 0;
    part.Color = color;
end;

local function vm_owned()
    local character = local_player.Character;
    if not character or character.Parent ~= workspace then
        return false;
    end;
    if not first_person:IsDescendantOf(workspace) then
        return false;
    end;
    local humanoid = character:FindFirstChildOfClass("Humanoid");
    return humanoid ~= nil and humanoid.Health > 0;
end;

local vm_highlights = {};
local function vm_drop_highlight(part)
    if vm_highlights[part] then
        vm_highlights[part]:Destroy();
        vm_highlights[part] = nil;
    end;
end;
local function vm_set_highlight(part, hl_cfg)
    local hl = vm_highlights[part];
    if not hl or not hl.Parent then
        hl = Instance.new("Highlight");
        hl.Name = "ZRHUB_vm_highlight";
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        hl.Adornee = part;
        hl.Parent = part;
        vm_highlights[part] = hl;
    end;
    hl.FillColor = hl_cfg.color;
    hl.FillTransparency = hl_cfg.transparency;
    hl.OutlineColor = hl_cfg.outline_color;
    hl.OutlineTransparency = hl_cfg.outline_transparency;
end;
local function vm_clear_highlights()
    for part in eli_pairs(vm_highlights) do vm_drop_highlight(part) end;
end;

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    local cfg = ELI.viewmodel_chams;
    local wc, ac = cfg.weapon_chams, cfg.arm_chams;
    local wh, ah = cfg.weapon_highlight, cfg.arm_highlight;

    if not (wc.enable or ac.enable or wh.enable or ah.enable) or not vm_owned() then
        if next(vm_tracked) then vm_clear() end;
        if next(vm_highlights) then vm_clear_highlights() end;
        return
    end;

    local now = tick();
    if now - ZRHUB_state.vm_chams_last < 0.1 then return end;
    ZRHUB_state.vm_chams_last = now;

    for _, part in next, first_person:GetDescendants() do
        if part:IsA("BasePart") and vm_visible(part) then
            local is_arm = vm_is_arm(part);

            if is_arm and ac.enable then
                vm_store(part);
                if ac.invisible then
                    part.LocalTransparencyModifier = 1;
                    part.Transparency = 1;
                else
                    vm_paint(part, ac.material, ac.color, ac.transparency);
                end;
            elseif not is_arm and wc.enable then
                vm_store(part);
                vm_paint(part, wc.material, wc.color, wc.transparency);
            else
                vm_restore(part);
            end;

            if is_arm and ah.enable then
                vm_set_highlight(part, ah);
            elseif not is_arm and wh.enable then
                vm_set_highlight(part, wh);
            else
                vm_drop_highlight(part);
            end;
        end;
    end;

    for part in eli_pairs(vm_highlights) do
        if not part.Parent then vm_drop_highlight(part) end;
    end;
end)));
trove:Add(vm_clear_highlights);
end

do
    local base_materials = {
        ForceField    = Enum.Material.ForceField,
        Neon          = Enum.Material.Neon,
        Plastic       = Enum.Material.Plastic,
        SmoothPlastic = Enum.Material.SmoothPlastic,
        Wood          = Enum.Material.Wood,
        WoodPlanks    = Enum.Material.WoodPlanks,
        Marble        = Enum.Material.Marble,
        Slate         = Enum.Material.Slate,
    };

    local body_tracked = {};
    local item_tracked = {};
    local clothes_tracked = {};

    local function vmc_store(tracked, part)
        if not tracked[part] then
            tracked[part] = { material = part.Material, color = part.Color, transparency = part.Transparency };
        end;
    end;

    local function vmc_restore(tracked)
        for part, saved in eli_pairs(tracked) do
            if part.Parent then
                part.Material = saved.material;
                part.Color = saved.color;
                part.Transparency = saved.transparency;
            end;
            tracked[part] = nil;
        end;
    end;

    local function vmc_apply(tracked, part, cfg)
        vmc_store(tracked, part);
        if cfg.material_enable then
            part.Material = base_materials[cfg.material] or Enum.Material.Plastic;
        else
            part.Material = tracked[part].material;
        end;
        if cfg.color_enable then
            part.Color = cfg.color;
        else
            part.Color = tracked[part].color;
        end;
        part.Transparency = math.clamp((cfg.transparency or 0) / 100, 0, 1);
    end;

    local function vmc_restore_clothes()
        for inst, template in eli_pairs(clothes_tracked) do
            if inst.Parent then
                if inst:IsA("Shirt") then
                    inst.ShirtTemplate = template;
                elseif inst:IsA("Pants") then
                    inst.PantsTemplate = template;
                elseif inst:IsA("ShirtGraphic") then
                    inst.Graphic = template;
                end;
            end;
            clothes_tracked[inst] = nil;
        end;
    end;

    local function vmc_disable_clothes(character)
        for _, inst in eli_ipairs(character:GetDescendants()) do
            if inst:IsA("Shirt") then
                if clothes_tracked[inst] == nil then clothes_tracked[inst] = inst.ShirtTemplate end;
                inst.ShirtTemplate = "";
            elseif inst:IsA("Pants") then
                if clothes_tracked[inst] == nil then clothes_tracked[inst] = inst.PantsTemplate end;
                inst.PantsTemplate = "";
            elseif inst:IsA("ShirtGraphic") then
                if clothes_tracked[inst] == nil then clothes_tracked[inst] = inst.Graphic end;
                inst.Graphic = "";
            end;
        end;
    end;

    local function vmc_is_arm(part)
        local name = string.lower(part.Name);
        return string.find(name, "arm", 1, true) ~= nil or string.find(name, "hand", 1, true) ~= nil;
    end;

    local vmc_visible_cache = setmetatable({}, { __mode = "k" });
    local function vmc_visible(part)
        if vmc_visible_cache[part] == nil then
            vmc_visible_cache[part] = part.Transparency < 1 and part.Size.Magnitude < 40;
        end;
        return vmc_visible_cache[part];
    end;

    local vmc_last = 0;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        local vc = ELI.viewmodel_custom;
        local character = local_player.Character;

        if not vc.enable then
            if next(body_tracked) then vmc_restore(body_tracked) end;
            if next(item_tracked) then vmc_restore(item_tracked) end;
            if next(clothes_tracked) then vmc_restore_clothes() end;
            return
        end;

        local now = tick();
        if now - vmc_last < 0.1 then return end;
        vmc_last = now;

        if vc.appearance and character then
            for _, part in eli_ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and vmc_visible(part) then
                    vmc_apply(body_tracked, part, vc.body);
                end;
            end;
            if vc.body.disable_clothes then
                vmc_disable_clothes(character);
            elseif next(clothes_tracked) then
                vmc_restore_clothes();
            end;
        else
            if next(body_tracked) then vmc_restore(body_tracked) end;
            if next(clothes_tracked) then vmc_restore_clothes() end;
        end;

        if first_person and first_person:IsDescendantOf(workspace) then
            for _, part in eli_ipairs(first_person:GetDescendants()) do
                if part:IsA("BasePart") and not vmc_is_arm(part) and vmc_visible(part) then
                    vmc_apply(item_tracked, part, vc.item);
                end;
            end;
        elseif next(item_tracked) then
            vmc_restore(item_tracked);
        end;

        for part in eli_pairs(body_tracked) do
            if not part.Parent then body_tracked[part] = nil end;
        end;
        for part in eli_pairs(item_tracked) do
            if not part.Parent then item_tracked[part] = nil end;
        end;
    end)));
    trove:Add(function()
        vmc_restore(body_tracked);
        vmc_restore(item_tracked);
        vmc_restore_clothes();
    end);
end;

local skybox_changer = {};
do
    function skybox_changer:init()
        self.sky_object = lighting:FindFirstChildOfClass("Sky");
        if not self.sky_object then
            self.sky_object = Instance.new("Sky");
            self.sky_object.Parent = lighting;
        end;

        self.default_skybox = lighting:FindFirstChildOfClass("Sky") and lighting:FindFirstChildOfClass("Sky"):Clone() or nil;

        self.list = {
            ["SpongeBob"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=15962101128",
                SkyboxDn = "http://www.roblox.com/asset/?id=15970246218",
                SkyboxFt = "http://www.roblox.com/asset/?id=15962101128",
                SkyboxLf = "http://www.roblox.com/asset/?id=15962101128",
                SkyboxRt = "http://www.roblox.com/asset/?id=15962101128",
                SkyboxUp = "http://www.roblox.com/asset/?id=15962901054"
            },
            ["Deep Space"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=159248188",
                SkyboxDn = "http://www.roblox.com/asset/?id=159248183",
                SkyboxFt = "http://www.roblox.com/asset/?id=159248187",
                SkyboxLf = "http://www.roblox.com/asset/?id=159248173",
                SkyboxRt = "http://www.roblox.com/asset/?id=159248192",
                SkyboxUp = "http://www.roblox.com/asset/?id=159248176"
            },
            ["Crazy Hello City"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=5487778646",
                SkyboxDn = "http://www.roblox.com/asset/?id=5487764867",
                SkyboxFt = "http://www.roblox.com/asset/?id=5487778646",
                SkyboxLf = "http://www.roblox.com/asset/?id=5487778646",
                SkyboxRt = "http://www.roblox.com/asset/?id=5487778646",
                SkyboxUp = "http://www.roblox.com/asset/?id=5487762943"
            },
            ["One Piece"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=158516797",
                SkyboxDn = "http://www.roblox.com/asset/?id=158516788",
                SkyboxFt = "http://www.roblox.com/asset/?id=158516797",
                SkyboxLf = "http://www.roblox.com/asset/?id=158516797",
                SkyboxRt = "http://www.roblox.com/asset/?id=158516797",
                SkyboxUp = "http://www.roblox.com/asset/?id=158516792"
            },
            ["Matcha"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=151165214",
                SkyboxDn = "http://www.roblox.com/asset/?id=151165197",
                SkyboxFt = "http://www.roblox.com/asset/?id=151165224",
                SkyboxLf = "http://www.roblox.com/asset/?id=151165191",
                SkyboxRt = "http://www.roblox.com/asset/?id=151165206",
                SkyboxUp = "http://www.roblox.com/asset/?id=151165227"
            },
            ["Abyssal Blues"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=16269815885",
                SkyboxDn = "http://www.roblox.com/asset/?id=16269839652",
                SkyboxFt = "http://www.roblox.com/asset/?id=16269798011",
                SkyboxLf = "http://www.roblox.com/asset/?id=16269813852",
                SkyboxRt = "http://www.roblox.com/asset/?id=16269814948",
                SkyboxUp = "http://www.roblox.com/asset/?id=16269829700"
            },
            ["Pink Sky"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=271042516",
                SkyboxDn = "http://www.roblox.com/asset/?id=271077243",
                SkyboxFt = "http://www.roblox.com/asset/?id=271042556",
                SkyboxLf = "http://www.roblox.com/asset/?id=271042310",
                SkyboxRt = "http://www.roblox.com/asset/?id=271042467",
                SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
            },
            ["Green Sky"] = {
                SkyboxBk = "rbxassetid://921882045",
                SkyboxDn = "rbxassetid://921881907",
                SkyboxFt = "rbxassetid://921882121",
                SkyboxLf = "rbxassetid://921881811",
                SkyboxRt = "rbxassetid://921881989",
                SkyboxUp = "rbxassetid://921882259"
            },
            ["Purple Nebula"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=159454299",
                SkyboxDn = "http://www.roblox.com/asset/?id=159454296",
                SkyboxFt = "http://www.roblox.com/asset/?id=159454299",
                SkyboxLf = "http://www.roblox.com/asset/?id=159454299",
                SkyboxRt = "http://www.roblox.com/asset/?id=159454299",
                SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
            },
            ["Vaporwave"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=1417494030",
                SkyboxDn = "http://www.roblox.com/asset/?id=1417494146",
                SkyboxFt = "http://www.roblox.com/asset/?id=1417494030",
                SkyboxLf = "http://www.roblox.com/asset/?id=1417494030",
                SkyboxRt = "http://www.roblox.com/asset/?id=1417494030",
                SkyboxUp = "http://www.roblox.com/asset/?id=1417494643"
            },
            ["Redshift"] = {
                SkyboxBk = "http://www.roblox.com/asset/?id=2670643365",
                SkyboxDn = "http://www.roblox.com/asset/?id=2670643365",
                SkyboxFt = "http://www.roblox.com/asset/?id=2670643365",
                SkyboxLf = "http://www.roblox.com/asset/?id=2670643365",
                SkyboxRt = "http://www.roblox.com/asset/?id=2670643365",
                SkyboxUp = "http://www.roblox.com/asset/?id=2670643365"
            },
            ["Minecraft"] = { SkyboxBk = "rbxassetid://1876545003", SkyboxDn = "rbxassetid://1876544331", SkyboxFt = "rbxassetid://1876542941", SkyboxLf = "rbxassetid://1876543392", SkyboxRt = "rbxassetid://1876543764", SkyboxUp = "rbxassetid://1876544642" },
            ["PurpleDay"] = { SkyboxBk = "rbxassetid://296908715", SkyboxDn = "rbxassetid://296908724", SkyboxFt = "rbxassetid://296908740", SkyboxLf = "rbxassetid://296908755", SkyboxRt = "rbxassetid://296908764", SkyboxUp = "rbxassetid://296908769" },
            ["RedNight"] = { SkyboxBk = "rbxassetid://401664839", SkyboxDn = "rbxassetid://401664862", SkyboxFt = "rbxassetid://401664960", SkyboxLf = "rbxassetid://401664881", SkyboxRt = "rbxassetid://401664901", SkyboxUp = "rbxassetid://401664936" },
            ["Trollge"] = { SkyboxBk = "rbxassetid://6155393905", SkyboxDn = "rbxassetid://6155393905", SkyboxFt = "rbxassetid://6155393905", SkyboxLf = "rbxassetid://6155393905", SkyboxRt = "rbxassetid://6155393905", SkyboxUp = "rbxassetid://6155393905" },
            ["Night"] = { SkyboxBk = "rbxassetid://48020371", SkyboxDn = "rbxassetid://48020144", SkyboxFt = "rbxassetid://48020234", SkyboxLf = "rbxassetid://48020211", SkyboxRt = "rbxassetid://48020254", SkyboxUp = "rbxassetid://48020383" },
            ["Space"] = { SkyboxBk = "rbxassetid://149397692", SkyboxDn = "rbxassetid://149397686", SkyboxFt = "rbxassetid://149397697", SkyboxLf = "rbxassetid://149397684", SkyboxRt = "rbxassetid://149397688", SkyboxUp = "rbxassetid://149397702" },
            ["Default"] = { SkyboxBk = "rbxassetid://6444884337", SkyboxDn = "rbxassetid://6444884785", SkyboxFt = "rbxassetid://6444884337", SkyboxLf = "rbxassetid://6444884337", SkyboxRt = "rbxassetid://6444884337", SkyboxUp = "rbxassetid://6412503613" },
            ["VibeMorning"] = { SkyboxBk = "rbxassetid://1417494030", SkyboxDn = "rbxassetid://1417494146", SkyboxFt = "rbxassetid://1417494253", SkyboxLf = "rbxassetid://1417494402", SkyboxRt = "rbxassetid://1417494499", SkyboxUp = "rbxassetid://1417494643" },
            ["VibeNight"] = { SkyboxBk = "rbxassetid://5084575798", SkyboxDn = "rbxassetid://5084575916", SkyboxFt = "rbxassetid://5103949679", SkyboxLf = "rbxassetid://5103948542", SkyboxRt = "rbxassetid://5103948784", SkyboxUp = "rbxassetid://5084576400" },
            ["PurpleSplash"] = { SkyboxBk = "rbxassetid://8539982183", SkyboxDn = "rbxassetid://8539981943", SkyboxFt = "rbxassetid://8539981721", SkyboxLf = "rbxassetid://8539981424", SkyboxRt = "rbxassetid://8539980766", SkyboxUp = "rbxassetid://8539981085" },
            ["GreenSpace"] = { SkyboxBk = "rbxassetid://159248188", SkyboxDn = "rbxassetid://159248183", SkyboxFt = "rbxassetid://159248187", SkyboxLf = "rbxassetid://159248173", SkyboxRt = "rbxassetid://159248192", SkyboxUp = "rbxassetid://159248176" },
            ["Snowy"] = { SkyboxBk = "rbxassetid://155657655", SkyboxDn = "rbxassetid://155674246", SkyboxFt = "rbxassetid://155657609", SkyboxLf = "rbxassetid://155657671", SkyboxRt = "rbxassetid://155657619", SkyboxUp = "rbxassetid://155674931" },
            ["Spongebob"] = { SkyboxBk = "rbxassetid://10287764626", SkyboxDn = "rbxassetid://10287766382", SkyboxFt = "rbxassetid://10287764626", SkyboxLf = "rbxassetid://10287763421", SkyboxRt = "rbxassetid://10287764626", SkyboxUp = "rbxassetid://10287767597" },
            ["PinkDay"] = { SkyboxBk = "rbxassetid://271042516", SkyboxDn = "rbxassetid://271077243", SkyboxFt = "rbxassetid://271042556", SkyboxLf = "rbxassetid://271042310", SkyboxRt = "rbxassetid://271042467", SkyboxUp = "rbxassetid://271077958" },
            ["AlienRed"] = { SkyboxBk = "rbxassetid://1012890", SkyboxDn = "rbxassetid://1012891", SkyboxFt = "rbxassetid://1012887", SkyboxLf = "rbxassetid://1012889", SkyboxRt = "rbxassetid://1012888", SkyboxUp = "rbxassetid://1014449" },
            ["WallsOfAutumn"] = { SkyboxBk = "rbxassetid://7123244709", SkyboxDn = "rbxassetid://7123246497", SkyboxFt = "rbxassetid://7123255895", SkyboxLf = "rbxassetid://7123257992", SkyboxRt = "rbxassetid://7123279103", SkyboxUp = "rbxassetid://7123281828" },
            ["ColdWinterness"] = { SkyboxBk = "rbxassetid://7123754562", SkyboxDn = "rbxassetid://7123756028", SkyboxFt = "rbxassetid://7123757422", SkyboxLf = "rbxassetid://7123758897", SkyboxRt = "rbxassetid://7123760563", SkyboxUp = "rbxassetid://7123762364" },
            ["Oblivion"] = { SkyboxBk = "rbxassetid://7123654189", SkyboxDn = "rbxassetid://7123657455", SkyboxFt = "rbxassetid://7123662047", SkyboxLf = "rbxassetid://7123664533", SkyboxRt = "rbxassetid://7123666598", SkyboxUp = "rbxassetid://7123668994" },
            ["ClassicSky"] = { SkyboxBk = "rbxassetid://672345740", SkyboxDn = "rbxassetid://672345828", SkyboxFt = "rbxassetid://672345879", SkyboxLf = "rbxassetid://672345927", SkyboxRt = "rbxassetid://672346006", SkyboxUp = "rbxassetid://672346072" },
            ["PurpleNight"] = { SkyboxBk = "rbxassetid://5084575798", SkyboxDn = "rbxassetid://5084575916", SkyboxFt = "rbxassetid://5103949679", SkyboxLf = "rbxassetid://5103948542", SkyboxRt = "rbxassetid://5103948784", SkyboxUp = "rbxassetid://5084576400" },
            ["PurpleDayClear"] = { SkyboxBk = "rbxassetid://6847607535", SkyboxDn = "rbxassetid://6847607977", SkyboxFt = "rbxassetid://6847608302", SkyboxLf = "rbxassetid://6847608608", SkyboxRt = "rbxassetid://6847608986", SkyboxUp = "rbxassetid://6847609323" },
            ["YellowDay"] = { SkyboxBk = "rbxassetid://2651432901", SkyboxDn = "rbxassetid://2651434974", SkyboxFt = "rbxassetid://2651435990", SkyboxLf = "rbxassetid://2651436494", SkyboxRt = "rbxassetid://2651436979", SkyboxUp = "rbxassetid://2651437350" },
            ["MinecraftSky"] = { SkyboxBk = "rbxassetid://8735166756", SkyboxDn = "rbxassetid://8735166707", SkyboxFt = "rbxassetid://8735231668", SkyboxLf = "rbxassetid://8735166755", SkyboxRt = "rbxassetid://8735166751", SkyboxUp = "rbxassetid://8735166729" },
            ["Sunset"] = { SkyboxBk = "rbxassetid://150939022", SkyboxDn = "rbxassetid://150939038", SkyboxFt = "rbxassetid://150939047", SkyboxLf = "rbxassetid://150939056", SkyboxRt = "rbxassetid://150939063", SkyboxUp = "rbxassetid://150939082" },
            ["CartoonSky"] = { SkyboxBk = "rbxassetid://6778646360", SkyboxDn = "rbxassetid://6778658683", SkyboxFt = "rbxassetid://6778648039", SkyboxLf = "rbxassetid://6778649136", SkyboxRt = "rbxassetid://6778650519", SkyboxUp = "rbxassetid://6778658364" },
            ["Anime"] = { SkyboxBk = "rbxassetid://7643700666", SkyboxDn = "rbxassetid://7643743687", SkyboxFt = "rbxassetid://7644304186", SkyboxLf = "rbxassetid://7644288724", SkyboxRt = "rbxassetid://7643700819", SkyboxUp = "rbxassetid://7643757404" },
            ["HellSky"] = { SkyboxBk = "rbxassetid://437430787", SkyboxDn = "rbxassetid://437430804", SkyboxFt = "rbxassetid://437430543", SkyboxLf = "rbxassetid://437430732", SkyboxRt = "rbxassetid://437430747", SkyboxUp = "rbxassetid://437430771" },
            ["StarryNight"] = { SkyboxBk = "rbxassetid://8291078911", SkyboxDn = "rbxassetid://8291077403", SkyboxFt = "rbxassetid://8291081613", SkyboxLf = "rbxassetid://8291074004", SkyboxRt = "rbxassetid://8291080353", SkyboxUp = "rbxassetid://8291075054" },
            ["Omori"] = { SkyboxBk = "rbxassetid://8767416629", SkyboxDn = "rbxassetid://8767416629", SkyboxFt = "rbxassetid://8767416629", SkyboxLf = "rbxassetid://8767416629", SkyboxRt = "rbxassetid://8767416629", SkyboxUp = "rbxassetid://8767416629" },
            ["c00lkidd"] = { SkyboxBk = "rbxassetid://433381097", SkyboxDn = "rbxassetid://433381097", SkyboxFt = "rbxassetid://433381097", SkyboxLf = "rbxassetid://433381097", SkyboxRt = "rbxassetid://433381097", SkyboxUp = "rbxassetid://433381097" },
            ["ClearDay"] = { SkyboxBk = "rbxassetid://591058823", SkyboxDn = "rbxassetid://591059876", SkyboxFt = "rbxassetid://591058104", SkyboxLf = "rbxassetid://591057861", SkyboxRt = "rbxassetid://591057625", SkyboxUp = "rbxassetid://591059642" },
            ["Mountains"] = { SkyboxBk = "http://www.roblox.com/asset/?id=324014980", SkyboxDn = "http://www.roblox.com/asset/?id=324015477", SkyboxFt = "http://www.roblox.com/asset/?id=324014995", SkyboxLf = "http://www.roblox.com/asset/?id=324014679", SkyboxRt = "http://www.roblox.com/asset/?id=324015013", SkyboxUp = "http://www.roblox.com/asset/?id=324015409" },
            ["Forest"] = { SkyboxBk = "http://www.roblox.com/asset/?id=70945545", SkyboxDn = "http://www.roblox.com/asset/?id=70945449", SkyboxFt = "http://www.roblox.com/asset/?id=70945487", SkyboxLf = "http://www.roblox.com/asset/?id=70945523", SkyboxRt = "http://www.roblox.com/asset/?id=70945508", SkyboxUp = "http://www.roblox.com/asset/?id=70945531" },
            ["LargeForest"] = { SkyboxBk = "rbxassetid://17428978603", SkyboxDn = "rbxassetid://17428977445", SkyboxFt = "rbxassetid://17428977114", SkyboxLf = "rbxassetid://17428978399", SkyboxRt = "rbxassetid://17428976828", SkyboxUp = "rbxassetid://17428976669" },
            ["Crimson"] = { SkyboxBk = "rbxassetid://15832429892", SkyboxDn = "rbxassetid://15832430998", SkyboxFt = "rbxassetid://15832430210", SkyboxLf = "rbxassetid://15832430671", SkyboxRt = "rbxassetid://15832431198", SkyboxUp = "rbxassetid://15832429401" },
            ["PumpkinHill"] = { SkyboxBk = "rbxassetid://11202510597", SkyboxDn = "rbxassetid://11202510255", SkyboxFt = "rbxassetid://11202509993", SkyboxLf = "rbxassetid://11202510806", SkyboxRt = "rbxassetid://11202511066", SkyboxUp = "rbxassetid://11202509704" },
            ["AnimeIsland"] = { SkyboxBk = "http://www.roblox.com/asset/?id=14753804949", SkyboxDn = "http://www.roblox.com/asset/?id=14753795573", SkyboxFt = "http://www.roblox.com/asset/?id=14753807625", SkyboxLf = "http://www.roblox.com/asset/?id=14753797417", SkyboxRt = "http://www.roblox.com/asset/?id=14753799966", SkyboxUp = "http://www.roblox.com/asset/?id=14753810287" },
            ["SnowyMountains"] = { SkyboxBk = "http://www.roblox.com/asset/?id=368385273", SkyboxDn = "http://www.roblox.com/asset/?id=48015300", SkyboxFt = "http://www.roblox.com/asset/?id=368388290", SkyboxLf = "http://www.roblox.com/asset/?id=368390615", SkyboxRt = "http://www.roblox.com/asset/?id=368385190", SkyboxUp = "http://www.roblox.com/asset/?id=48015387" },
            ["Desert"] = { SkyboxBk = "rbxassetid://161319957", SkyboxDn = "rbxassetid://161319965", SkyboxFt = "rbxassetid://161319970", SkyboxLf = "rbxassetid://161319983", SkyboxRt = "rbxassetid://161319989", SkyboxUp = "rbxassetid://161319996" },
            ["Cloudy"] = { SkyboxBk = "http://www.roblox.com/asset/?id=225469345", SkyboxDn = "http://www.roblox.com/asset/?id=225469349", SkyboxFt = "http://www.roblox.com/asset/?id=225469359", SkyboxLf = "http://www.roblox.com/asset/?id=225469364", SkyboxRt = "http://www.roblox.com/asset/?id=225469372", SkyboxUp = "http://www.roblox.com/asset/?id=225469380" },
            ["Island"] = { SkyboxBk = "http://www.roblox.com/asset/?id=319343577", SkyboxDn = "http://www.roblox.com/asset/?id=319343653", SkyboxFt = "http://www.roblox.com/asset/?id=319343666", SkyboxLf = "http://www.roblox.com/asset/?id=319343686", SkyboxRt = "http://www.roblox.com/asset/?id=319343631", SkyboxUp = "http://www.roblox.com/asset/?id=319343614" },
            ["OrangeFog"] = { SkyboxBk = "http://www.roblox.com/asset/?id=458016711", SkyboxDn = "http://www.roblox.com/asset/?id=458016826", SkyboxFt = "http://www.roblox.com/asset/?id=458016532", SkyboxLf = "http://www.roblox.com/asset/?id=458016655", SkyboxRt = "http://www.roblox.com/asset/?id=458016782", SkyboxUp = "http://www.roblox.com/asset/?id=458016792" },
            ["FadeNight"] = { SkyboxBk = "http://www.roblox.com/asset/?id=16888843486", SkyboxDn = "http://www.roblox.com/asset/?id=16888845693", SkyboxFt = "http://www.roblox.com/asset/?id=16888848245", SkyboxLf = "http://www.roblox.com/asset/?id=16888850949", SkyboxRt = "http://www.roblox.com/asset/?id=16888854243", SkyboxUp = "http://www.roblox.com/asset/?id=16888857144" },
            ["Office"] = { SkyboxBk = "rbxassetid://658623433", SkyboxDn = "rbxassetid://316342560", SkyboxFt = "rbxassetid://658625205", SkyboxLf = "rbxassetid://658627155", SkyboxRt = "rbxassetid://658628504", SkyboxUp = "rbxassetid://658632701" },
            ["Spongebob2"] = { SkyboxBk = "rbxassetid://12049872454", SkyboxDn = "rbxassetid://12049872284", SkyboxFt = "rbxassetid://12049872181", SkyboxLf = "rbxassetid://12049872074", SkyboxRt = "rbxassetid://12049871884", SkyboxUp = "rbxassetid://12049871774" },
            ["PurpleFog"] = { SkyboxBk = "http://www.roblox.com/asset/?id=17279854976", SkyboxDn = "http://www.roblox.com/asset/?id=17279856318", SkyboxFt = "http://www.roblox.com/asset/?id=17279858447", SkyboxLf = "http://www.roblox.com/asset/?id=17279860360", SkyboxRt = "http://www.roblox.com/asset/?id=17279862234", SkyboxUp = "http://www.roblox.com/asset/?id=17279864507" },
            ["EarthSpace"] = { SkyboxBk = "rbxassetid://15753305495", SkyboxDn = "rbxassetid://15753362674", SkyboxFt = "rbxassetid://15753305823", SkyboxLf = "rbxassetid://15753310707", SkyboxRt = "rbxassetid://15753304774", SkyboxUp = "rbxassetid://15753304473" },
            ["GreenCloudy"] = { SkyboxBk = "rbxassetid://921882045", SkyboxDn = "rbxassetid://921881907", SkyboxFt = "rbxassetid://921882121", SkyboxLf = "rbxassetid://921881811", SkyboxRt = "rbxassetid://921881989", SkyboxUp = "rbxassetid://921882259" },
            ["SummerDay"] = { SkyboxBk = "http://www.roblox.com/asset/?version=1&id=135483466", SkyboxDn = "http://www.roblox.com/asset/?version=1&id=135483484", SkyboxFt = "http://www.roblox.com/asset/?version=1&id=135483461", SkyboxLf = "http://www.roblox.com/asset/?version=1&id=135483495", SkyboxRt = "http://www.roblox.com/asset/?version=1&id=135483499", SkyboxUp = "http://www.roblox.com/asset/?version=1&id=135483475" },
            ["SnowyPlains"] = { SkyboxBk = "http://www.roblox.com/asset/?id=155657655", SkyboxDn = "http://www.roblox.com/asset/?id=155674246", SkyboxFt = "http://www.roblox.com/asset/?id=155657609", SkyboxLf = "http://www.roblox.com/asset/?id=155657671", SkyboxRt = "http://www.roblox.com/asset/?id=155657619", SkyboxUp = "http://www.roblox.com/asset/?id=155674931" },
            ["Underwater"] = { SkyboxBk = "http://www.roblox.com/asset/?id=227635868", SkyboxDn = "http://www.roblox.com/asset/?id=227635921", SkyboxFt = "http://www.roblox.com/asset/?id=227635954", SkyboxLf = "http://www.roblox.com/asset/?id=227635974", SkyboxRt = "http://www.roblox.com/asset/?id=227635990", SkyboxUp = "http://www.roblox.com/asset/?id=227636031" },
            ["BlueAbyss"] = { SkyboxBk = "rbxassetid://16269815885", SkyboxDn = "rbxassetid://16269839652", SkyboxFt = "rbxassetid://16269798011", SkyboxLf = "rbxassetid://16269813852", SkyboxRt = "rbxassetid://16269814948", SkyboxUp = "rbxassetid://16269829700" },
            ["Poison"] = { SkyboxBk = "rbxassetid://1370716695", SkyboxDn = "rbxassetid://1370716766", SkyboxFt = "rbxassetid://1370716833", SkyboxLf = "rbxassetid://1370716898", SkyboxRt = "rbxassetid://1370716955", SkyboxUp = "rbxassetid://1370717024" },
            ["BlueSpace"] = { SkyboxBk = "rbxassetid://1127563035", SkyboxDn = "rbxassetid://1127563006", SkyboxFt = "rbxassetid://1127563026", SkyboxLf = "rbxassetid://1127563216", SkyboxRt = "rbxassetid://1127563115", SkyboxUp = "rbxassetid://1127562999" },
            ["AnimeMountains"] = { SkyboxBk = "http://www.roblox.com/asset/?id=12849370744", SkyboxDn = "http://www.roblox.com/asset/?id=12849378890", SkyboxFt = "http://www.roblox.com/asset/?id=12849390276", SkyboxLf = "http://www.roblox.com/asset/?id=12849405549", SkyboxRt = "http://www.roblox.com/asset/?id=12849398428", SkyboxUp = "http://www.roblox.com/asset/?id=12849426002" },
            ["PinkGradient"] = { SkyboxBk = "http://www.roblox.com/asset/?id=5371541816", SkyboxDn = "http://www.roblox.com/asset/?id=5371541154", SkyboxFt = "http://www.roblox.com/asset/?id=5371541816", SkyboxLf = "http://www.roblox.com/asset/?id=5371541816", SkyboxRt = "http://www.roblox.com/asset/?id=5371541816", SkyboxUp = "http://www.roblox.com/asset/?id=5371540604" },
            ["YellowGradient"] = { SkyboxBk = "http://www.roblox.com/asset/?id=159005370", SkyboxDn = "rbxassetid://858422412", SkyboxFt = "http://www.roblox.com/asset/?id=159005370", SkyboxLf = "http://www.roblox.com/asset/?id=159005370", SkyboxRt = "http://www.roblox.com/asset/?id=159005370", SkyboxUp = "http://www.roblox.com/asset/?id=159006363" },
            ["BlueGradient"] = { SkyboxBk = "http://www.roblox.com/asset/?id=4628466090", SkyboxDn = "http://www.roblox.com/asset/?id=4628471901", SkyboxFt = "http://www.roblox.com/asset/?id=4628466090", SkyboxLf = "http://www.roblox.com/asset/?id=4628466090", SkyboxRt = "http://www.roblox.com/asset/?id=4628466090", SkyboxUp = "http://www.roblox.com/asset/?id=4628472152" },
            ["GreenNebula"] = { SkyboxBk = "http://www.roblox.com/asset/?id=47974894", SkyboxDn = "http://www.roblox.com/asset/?id=47974690", SkyboxFt = "http://www.roblox.com/asset/?id=47974821", SkyboxLf = "http://www.roblox.com/asset/?id=47974776", SkyboxRt = "http://www.roblox.com/asset/?id=47974859", SkyboxUp = "http://www.roblox.com/asset/?id=47974909" },
            ["OrangeGradient"] = { SkyboxBk = "rbxassetid://6902754982", SkyboxDn = "rbxassetid://6902795826", SkyboxFt = "rbxassetid://6902754982", SkyboxLf = "rbxassetid://6902754982", SkyboxRt = "rbxassetid://6902754982", SkyboxUp = "rbxassetid://6902796078" },
            ["GreenAurora"] = { SkyboxBk = "http://www.roblox.com/asset/?id=16563478983", SkyboxDn = "http://www.roblox.com/asset/?id=16563481302", SkyboxFt = "http://www.roblox.com/asset/?id=16563484084", SkyboxLf = "http://www.roblox.com/asset/?id=16563485362", SkyboxRt = "http://www.roblox.com/asset/?id=16563487078", SkyboxUp = "http://www.roblox.com/asset/?id=16563489821" },
            ["Blank"] = { SkyboxBk = "http://www.roblox.com/asset/?ID=1361097", SkyboxDn = "http://www.roblox.com/asset/?ID=1361097", SkyboxFt = "http://www.roblox.com/asset/?ID=1361097", SkyboxLf = "http://www.roblox.com/asset/?ID=1361097", SkyboxRt = "http://www.roblox.com/asset/?ID=1361097", SkyboxUp = "http://www.roblox.com/asset/?ID=1361097" },
            ["Clouds"] = { SkyboxBk = "rbxassetid://570557514", SkyboxDn = "rbxassetid://570557775", SkyboxFt = "rbxassetid://570557559", SkyboxLf = "rbxassetid://570557620", SkyboxRt = "rbxassetid://570557672", SkyboxUp = "rbxassetid://570557727" },
            ["Cloudy Skies"] = { SkyboxBk = "rbxassetid://151165214", SkyboxDn = "rbxassetid://151165197", SkyboxFt = "rbxassetid://151165224", SkyboxLf = "rbxassetid://151165191", SkyboxRt = "rbxassetid://151165206", SkyboxUp = "rbxassetid://151165227" },
            ["Elegant Morning"] = { SkyboxBk = "rbxassetid://153767241", SkyboxDn = "rbxassetid://153767216", SkyboxFt = "rbxassetid://153767266", SkyboxLf = "rbxassetid://153767200", SkyboxRt = "rbxassetid://153767231", SkyboxUp = "rbxassetid://153767288" },
            ["Fade Blue"] = { SkyboxBk = "rbxassetid://153695414", SkyboxDn = "rbxassetid://153695352", SkyboxFt = "rbxassetid://153695452", SkyboxLf = "rbxassetid://153695320", SkyboxRt = "rbxassetid://153695383", SkyboxUp = "rbxassetid://153695471" },
            ["Neptune"] = { SkyboxBk = "rbxassetid://218955819", SkyboxDn = "rbxassetid://218953419", SkyboxFt = "rbxassetid://218954524", SkyboxLf = "rbxassetid://218958493", SkyboxRt = "rbxassetid://218957134", SkyboxUp = "rbxassetid://218950090" },
            ["Night Sky"] = { SkyboxBk = "rbxassetid://12064107", SkyboxDn = "rbxassetid://12064152", SkyboxFt = "rbxassetid://12064121", SkyboxLf = "rbxassetid://12063984", SkyboxRt = "rbxassetid://12064115", SkyboxUp = "rbxassetid://12064131" },
            ["Purple And Blue"] = { SkyboxBk = "rbxassetid://149397692", SkyboxDn = "rbxassetid://149397686", SkyboxFt = "rbxassetid://149397697", SkyboxLf = "rbxassetid://149397684", SkyboxRt = "rbxassetid://149397688", SkyboxUp = "rbxassetid://149397702" },
            ["Purple Clouds"] = { SkyboxBk = "rbxassetid://151165214", SkyboxDn = "rbxassetid://151165197", SkyboxFt = "rbxassetid://151165224", SkyboxLf = "rbxassetid://151165191", SkyboxRt = "rbxassetid://151165206", SkyboxUp = "rbxassetid://151165227" },
            ["Purple Galaxy"] = { SkyboxBk = "http://www.roblox.com/Asset/?ID=14543264135", SkyboxDn = "http://www.roblox.com/asset/?ID=14543358958", SkyboxFt = "http://www.roblox.com/asset/?ID=14543257810", SkyboxLf = "http://www.roblox.com/asset/?ID=14543275895", SkyboxRt = "http://www.roblox.com/asset/?ID=14543280890", SkyboxUp = "http://www.roblox.com/asset/?ID=14543371676" },
            ["Purple Nebula"] = { SkyboxBk = "rbxassetid://159454299", SkyboxDn = "rbxassetid://159454296", SkyboxFt = "rbxassetid://159454293", SkyboxLf = "rbxassetid://159454286", SkyboxRt = "rbxassetid://159454300", SkyboxUp = "rbxassetid://159454288" },
            ["Red Night Sky"] = { SkyboxBk = "http://www.roblox.com/Asset/?ID=401664839", SkyboxDn = "http://www.roblox.com/asset/?ID=401664862", SkyboxFt = "http://www.roblox.com/asset/?ID=401664960", SkyboxLf = "http://www.roblox.com/asset/?ID=401664881", SkyboxRt = "http://www.roblox.com/asset/?ID=401664901", SkyboxUp = "http://www.roblox.com/asset/?ID=401664936" },
            ["Redshift"] = { SkyboxBk = "rbxassetid://401664839", SkyboxDn = "rbxassetid://401664862", SkyboxFt = "rbxassetid://401664960", SkyboxLf = "rbxassetid://401664881", SkyboxRt = "rbxassetid://401664901", SkyboxUp = "rbxassetid://401664936" },
            ["Setting Sun"] = { SkyboxBk = "rbxassetid://626460377", SkyboxDn = "rbxassetid://626460216", SkyboxFt = "rbxassetid://626460513", SkyboxLf = "rbxassetid://626473032", SkyboxRt = "rbxassetid://626458639", SkyboxUp = "rbxassetid://626460625" },
            ["Twighlight"] = { SkyboxBk = "rbxassetid://264908339", SkyboxDn = "rbxassetid://264907909", SkyboxFt = "rbxassetid://264909420", SkyboxLf = "rbxassetid://264909758", SkyboxRt = "rbxassetid://264908886", SkyboxUp = "rbxassetid://264907379" },
            ["Vaporwave"] = { SkyboxBk = "rbxassetid://1417494030", SkyboxDn = "rbxassetid://1417494146", SkyboxFt = "rbxassetid://1417494253", SkyboxLf = "rbxassetid://1417494402", SkyboxRt = "rbxassetid://1417494499", SkyboxUp = "rbxassetid://1417494643" },
            ["Vivid Skies"] = { SkyboxBk = "rbxassetid://271042516", SkyboxDn = "rbxassetid://271077243", SkyboxFt = "rbxassetid://271042556", SkyboxLf = "rbxassetid://271042310", SkyboxRt = "rbxassetid://271042467", SkyboxUp = "rbxassetid://271077958" },
            ["ZRHUB Sky"] = { SkyboxBk = "rbxassetid://1898724755", SkyboxDn = "rbxassetid://1898727189", SkyboxFt = "rbxassetid://1898722814", SkyboxLf = "rbxassetid://1898729298", SkyboxRt = "rbxassetid://1898741025", SkyboxUp = "rbxassetid://1898736761" },
        };

        self.elements = {};
        for skybox_name, _ in next, self.list do
            table.insert(self.elements, skybox_name);
        end;

        self.selected = ELI.world.skybox_selected;
    end;

    function skybox_changer:update_skybox()
        self.last_apply = os.clock();

        for _, v in next, lighting:GetChildren() do
            if v:IsA("Sky") then
                v:Destroy();
            end;
        end;

        local world_cfg = ELI.world;
        local Sky;

        if not world_cfg.skybox then
            if self.default_skybox then
                Sky = self.default_skybox:Clone();
                Sky.Parent = lighting;
            end;
        else
            local skybox_data = self.list[world_cfg.skybox_selected or ""];
            if not skybox_data then return end;

            Sky = Instance.new("Sky");
            Sky.SkyboxBk = skybox_data.SkyboxBk;
            Sky.SkyboxDn = skybox_data.SkyboxDn;
            Sky.SkyboxFt = skybox_data.SkyboxFt;
            Sky.SkyboxLf = skybox_data.SkyboxLf;
            Sky.SkyboxRt = skybox_data.SkyboxRt;
            Sky.SkyboxUp = skybox_data.SkyboxUp;
            Sky.Parent = lighting;
        end;

        if Sky then
            if world_cfg.skybox_remove_sun then Sky.SunTextureId = "" end;
            if world_cfg.skybox_remove_moon then Sky.MoonTextureId = "" end;
            if world_cfg.skybox_remove_stars then Sky.StarCount = 0 end;
        end;
    end;

    skybox_changer:init();
    skybox_changer.last_apply = 0;

    local function skybox_reapply()
        local world_cfg = ELI.world;
        if not (world_cfg.skybox or world_cfg.skybox_remove_sun or world_cfg.skybox_remove_moon or world_cfg.skybox_remove_stars) then
            return;
        end;
        if os.clock() - skybox_changer.last_apply < 0.25 then
            return;
        end;
        skybox_changer:update_skybox();
    end;

    trove:Add(lighting.ChildRemoved:Connect(function(child)
        if child:IsA("Sky") then
            task.defer(skybox_reapply);
        end;
    end));

    trove:Add(lighting.ChildAdded:Connect(function(child)
        if child:IsA("Sky") then
            task.defer(skybox_reapply);
        end;
    end));

    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
        local world_cfg = ELI.world;
        local sky = lighting:FindFirstChildOfClass("Sky");
        if world_cfg.skybox_rotate and sky then
            if not skybox_changer.original_orientation then
                skybox_changer.original_orientation = sky.SkyboxOrientation;
            end;
            skybox_changer.rotation_tick = (skybox_changer.rotation_tick or 0) + (dt * world_cfg.skybox_rotate_speed * 0.5);
            local rotation_angle = 0;
            if world_cfg.skybox_rotate_method == 'Spin' then
                rotation_angle = (skybox_changer.rotation_tick * 20) % 360;
            elseif world_cfg.skybox_rotate_method == 'Wave' then
                rotation_angle = math.sin(skybox_changer.rotation_tick) * 180;
            elseif world_cfg.skybox_rotate_method == 'Alternate' then
                rotation_angle = math.abs((skybox_changer.rotation_tick * 40 % 720) - 360) - 180;
            end;
            local rot_v3 = Vector3.new(0, 0, 0);
            if world_cfg.skybox_rotate_direction == 'Horizontal' then
                rot_v3 = Vector3.new(0, rotation_angle, 0);
            elseif world_cfg.skybox_rotate_direction == 'Vertical' then
                rot_v3 = Vector3.new(rotation_angle, 0, 0);
            elseif world_cfg.skybox_rotate_direction == 'Diagonal' then
                rot_v3 = Vector3.new(rotation_angle, rotation_angle, rotation_angle);
            end;
            local success = pcall(function()
                sky.SkyboxOrientation = rot_v3;
            end);
            if not success and world_cfg.skybox_rotate_direction == 'Horizontal' then
                lighting.GeographicLatitude = rotation_angle;
            end;
        elseif not world_cfg.skybox_rotate and sky and skybox_changer.original_orientation then
            pcall(function()
                sky.SkyboxOrientation = skybox_changer.original_orientation;
            end);
            skybox_changer.original_orientation = nil;
            skybox_changer.rotation_tick = 0;
        end;
    end)));
end;

local atmosphere_changer = {};
do
    function atmosphere_changer:init()
        self.atmosphere_object = lighting:FindFirstChildOfClass("Atmosphere");
        if not self.atmosphere_object then
            self.atmosphere_object = Instance.new("Atmosphere");
            self.atmosphere_object.Parent = lighting;
        end;

        self.default_atmosphere = self.atmosphere_object:Clone();
        self.default_atmosphere.Parent = nil;

        self.properties = {};
        self.properties_list = {"glare", "haze", "offset", "density"};

        for _, property in next, self.properties_list do
            self.properties[property] = ELI.world["atmosphere_" .. property];
        end;

        if not ELI.world.atmosphere then
            self.atmosphere_object.Parent = nil;
        end;
    end;

    function atmosphere_changer:update_atmosphere()
        if not ELI.world.atmosphere then
            self.atmosphere_object.Parent = nil;

            if self.default_atmosphere then
                local Restored = self.default_atmosphere:Clone();
                Restored.Parent = lighting;
                self.atmosphere_object = Restored;
            end;

            return;
        end;

        if not self.atmosphere_object.Parent then
            self.atmosphere_object.Parent = lighting;
        end;

        for _, property in next, self.properties_list do
            local value = ELI.world["atmosphere_" .. property];
            if value == nil then continue end;
            self.atmosphere_object[property:sub(1, 1):upper() .. property:sub(2, #property)] = value;
        end;

        self.atmosphere_object.Color = ELI.world.atmosphere_color;
        self.atmosphere_object.Decay = ELI.world.atmosphere_decay;
    end;

    atmosphere_changer:init();
end;

local hooked = {};
function hookanim(vm)
    local anim = rawget(vm, "Animator");
    if not anim or hooked[anim] then return end;
    hooked[anim] = true;
    local mt = getmetatable(anim);
    local orig = rawget(anim, "PlayAnimation") or (mt and rawget(mt, "PlayAnimation"));
    if not orig then return end;
    anim.PlayAnimation = function(self, key, ...)
        local cfg = ELI.disable_anims;
        if cfg.enable then
            local k = tostring(key):lower();
            if table.find(cfg.select, "shoot") and k:find("shoot") then return end;
            if table.find(cfg.select, "attack") and k:find("attack") then return end;
            if table.find(cfg.select, "charge") and k:find("charge") then return end;
            if table.find(cfg.select, "equip") and k:find("equip") then return end;
            if table.find(cfg.select, "reload") and k:find("reload") then return end;
            if table.find(cfg.select, "throw") and k:find("throw") then return end;
        end;
        return orig(self, key, ...);
    end;
end;
local old_update = client_viewmodel.Update; client_viewmodel.Update = function(c, dt, movement_state, render_data)
    if c.ClientItem.ClientFighter.IsLocalPlayer then
        hookanim(c);

        local cfg = ELI.disable_anims;
        if cfg.enable then
            if table.find(cfg.select, "bobbing") then
                c._bobbing_value_spring.Value = Vector2.new(0, 0);
                c._bobbing_value_spring.Target = Vector2.new(0, 0);
                c._bobbing_speed_spring.Value = 0;
                c._bobbing_speed_spring.Target = 0;
                c._bobbing_tick = 0;
            end;

            if table.find(cfg.select, "landing") then
                c._landing_spring.Value = 0;
                c._landing_spring.Target = 0;
                c._jump_spring.Value = 0;
                c._jump_spring.Target = 0;
            end;

            if table.find(cfg.select, "sway") then
                c._sway_spring.Value = Vector2.new(0, 0);
                c._sway_spring.Target = Vector2.new(0, 0);
                c._tilt_spring.Value = Vector2.new(0, 0);
                c._tilt_spring.Target = Vector2.new(0, 0);
            end;

            if table.find(cfg.select, "equip") then
                c._equip_spring.Position = c._equip_spring.Target;
                c._equip_spring.Velocity = 0;
            end;

            if table.find(cfg.select, "inspect") then
                c._inspect_spring.Position = c._inspect_spring.Target;
                c._inspect_spring.Velocity = 0;
            end;

            if table.find(cfg.select, "sliding") and movement_state then
                movement_state.IsSliding = false;
            end;

            if table.find(cfg.select, "shoot") then
                c._recoil_spring.Value = Vector3.new(0, 0, 0);
                c._recoil_spring.Target = Vector3.new(0, 0, 0);
                c._unrecoil_spring.Value = Vector3.new(0, 0, 0);
                c._unrecoil_spring.Target = Vector3.new(0, 0, 0);
            end;

            if table.find(cfg.select, "impulse") then
                c._impulse_position_spring.Value = Vector3.new(0, 0, 0);
                c._impulse_position_spring.Target = Vector3.new(0, 0, 0);
            end;

            if table.find(cfg.select, "aim") then
                c._aim_spring.Position = c._aim_spring.Target;
                c._aim_spring.Velocity = 0;
            end;

            if table.find(cfg.select, "sprint") and movement_state then
                movement_state.IsActuallySprinting = false;
            end;
        end;
    end;

    return old_update(c, dt, movement_state, render_data);
end;

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.auto_vote_map.enable then
    replicated_storage.Remotes.Duels.Vote:FireServer(ELI.auto_vote_map.map);
    end;
end)));

do
local function fire_gui_button(btn)
    local fired = false;
    if firesignal then
        for _, sname in eli_ipairs({ "MouseButton1Click", "MouseButton1Down", "Activated" }) do
            local ok, sig = pcall(function() return btn[sname] end);
            if ok and sig then
                if pcall(firesignal, sig) then fired = true end;
            end;
        end;
    end;
    if not fired and getconnections then
        for _, sname in eli_ipairs({ "MouseButton1Click", "MouseButton1Down", "Activated" }) do
            local ok, sig = pcall(function() return btn[sname] end);
            if ok and sig then
                local good, cons = pcall(getconnections, sig);
                if good and cons then
                    for _, con in eli_ipairs(cons) do
                        pcall(function()
                            if con.Fire then con:Fire() elseif con.Function then con.Function() end;
                        end);
                        fired = true;
                    end;
                end;
            end;
        end;
    end;
    return fired;
end;

local function button_is_shown(gui)
    local cur = gui;
    while cur do
        if cur:IsA("ScreenGui") then return cur.Enabled == true end;
        if cur:IsA("GuiObject") and not cur.Visible then return false end;
        cur = cur.Parent;
    end;
    return false;
end;

local leave_words = { ["leave"] = true, ["leave match"] = true, ["leave duel"] = true, ["leave game"] = true, ["back to lobby"] = true, ["return to lobby"] = true, ["lobby"] = true };

local function try_auto_leave()
    local pg = local_player:FindFirstChildOfClass("PlayerGui");
    if not pg then return false end;
    for _, d in eli_ipairs(pg:GetDescendants()) do
        if d:IsA("TextButton") then
            local t = string.lower((d.Text or ""):gsub("^%s*(.-)%s*$", "%1"));
            if leave_words[t] and button_is_shown(d) then
                if fire_gui_button(d) then return true end;
            end;
        end;
    end;
    return false;
end;

trove:Add(task.spawn(function()
    while wait(1) do
        if ELI.auto_queue.enable and ELI.auto_queue.queue_mode ~= "" then
            local fighter = fighter_controller.LocalFighter;
            local currently_in_match = false;
            pcall(function()
                currently_in_match = fighter ~= nil and fighter:Get("IsInDuel") == true;
            end);
            if currently_in_match then
                clickedontheremote = false;
            else
                local pressed_leave = false;
                pcall(function() pressed_leave = try_auto_leave() end);
                if pressed_leave then
                    clickedontheremote = false;
                elseif not clickedontheremote then
                    pcall(function()
                        replicated_storage.Remotes.Matchmaking.JoinQueue:InvokeServer(ELI.auto_queue.queue_mode);
                    end);
                    clickedontheremote = true;
                end;
            end;
            was_i_in_a_match = currently_in_match;
        end;
    end;
end));
end;

local sorted_item_list = {};
local class_dir = {
    ['primary'] = 1,
    ['secondary'] = 2,
    ['melee'] = 3,
    ['utility'] = 4
};
for _, item in next, item_lib.Items do
    local key = item.Class;
    if not sorted_item_list[key] then
        sorted_item_list[key] = {};
    end;
    if item.Name == 'MISSING_WEAPON' then continue end;
    table.insert(sorted_item_list[key], item.Name);
end;

local pick_weapons = replicated_storage.Remotes.Replication.Fighter.PickWeapons;
trove:Add(task.spawn(LPH_NO_VIRTUALIZE(function()
    while task.wait() do
        if not ELI.auto_loadout.enable then
            continue;
        end;
        local loadout = ELI.auto_loadout.loadout;
        local current_page = pages.PageSystem.CurrentPage;
        if local_fighter and local_fighter:Get('CanPickWeapons') == true then
            if not current_page then continue end;
            if current_page.Name ~= 'PickWeapons' then continue end;
            local payload = {};
            for i = 1, local_fighter:GetMaxEquippableWeapons() do
                payload[i] = loadout[i];
            end;
            pick_weapons:FireServer(payload);
        end;
    end;
end)));

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.arcade_server.grab_drops then
        for _,v in next, workspace:GetChildren() do
            if v.Name == "_drop" and v:IsA("BasePart") and local_player.Character:FindFirstChildWhichIsA("HumanoidRootPart") then
                firetouchinterest(local_player.Character.HumanoidRootPart, v, 0);
                firetouchinterest(local_player.Character.HumanoidRootPart, v, 1);
            end;
        end;
    end;
end)));

trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.fov_changer.enable then
        camera.FieldOfView = ELI.fov_changer.fov;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.arcade_server.auto_respawn then
        replicated_storage.Remotes.Duels.RespawnNow:FireServer();
    end;
end)));

local triggerbot_handler = {};
triggerbot_handler.is_shooting = false;

trove:Add(task.spawn(function()
    while task.wait(0.05) do
        if ELI.triggerbot.enable then
            local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.Position, camera.CFrame.LookVector * 2500), {local_player.Character});
            if hit and hit.Parent:FindFirstChildWhichIsA('Humanoid') and hit.Parent:FindFirstChildWhichIsA('Humanoid').Health > 0 then
                local target_player = players:GetPlayerFromCharacter(hit.Parent);
                if ELI.triggerbot.team_check and target_player and target_player:GetAttribute('TeamID') == local_player:GetAttribute('TeamID') then
                    triggerbot_handler.is_shooting = false;
                else
                    if not triggerbot_handler.is_shooting then
                        task.wait(ELI.triggerbot.reaction_time);
                        triggerbot_handler.is_shooting = true;
                    end;
                    if local_fighter then
                        setthreadidentity(2);
                        local_fighter:Input('StartShooting');
                        setthreadidentity(7);
                        task.wait(ELI.triggerbot.shoot_delay);
                    end;
                end;
            else
                triggerbot_handler.is_shooting = false;
            end;
        end;
    end;
end));
trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.guns.force_modifier_enable then
        for i,v in next, item_lib.Items do
            v.InputSpammingEnabled.StartShooting = ELI.guns.force_modifier_v;
        end;
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.viewmodel_offsets.enable then
        for i, v in next, item_lib.ViewModels do
            if oldoffsets[i] then
                v.RootPartOffset = CFrame.new(oldoffsets[i].X + ELI.viewmodel_offsets.x, oldoffsets[i].Y + ELI.viewmodel_offsets.y, oldoffsets[i].Z + ELI.viewmodel_offsets.z);
            end;
        end;
    end;
end)));

local replicate_from_server = local_fighter.ReplicateFromServer; local_fighter.ReplicateFromServer = function(controller, _type, ...)
    if _type == 'DamageNumberEffect' then
        local hit_root, hit_damage, is_headshot = unpack({...});
        if not hit_root or not hit_damage then
            return replicate_from_server(controller, _type, ...);
        end;

        local hit_character = hit_root.Parent;
        if not hit_character or (hit_character and not hit_character:FindFirstChildOfClass('Humanoid')) then
            return replicate_from_server(controller, _type, ...);
        end;

        if ELI.esp.filled.hit_flash then
            local hp = players:GetPlayerFromCharacter(hit_character);
            if hp and cache[hp] then cache[hp].hitFlash = tick() end;
        end;

        if ELI.hit_notify.enable then
            local part = is_headshot and "Head" or "Body";
            local raw_message = ELI.hit_notify.msg;
            raw_message = raw_message:match('{target}') and raw_message:gsub('{target}', hit_character.Name) or raw_message;
            raw_message = raw_message:match('{damage}') and raw_message:gsub('{damage}', tostring(math.floor(hit_damage or 0))) or raw_message;
            raw_message = raw_message:match('{hitpart}') and raw_message:gsub('{hitpart}', part) or raw_message;

            local notify_duration = ELI.hit_notify.duration;

            task.spawn(function()
                local original_context = getthreadidentity();
                setthreadidentity(7);
                Library:Notify(raw_message, notify_duration);
                setthreadidentity(original_context);
            end);
        end;

        if ZRHUB_state.fireDamage and ELI.damage_numbers.enable then
            local hp = players:GetPlayerFromCharacter(hit_character);
            local ok, pos = pcall(function()
                return hit_root.Position + Vector3.new(0, is_headshot and 2.6 or 2.1, 0);
            end);
            ZRHUB_state.fireDamage(hp, hit_damage, ok and pos or nil);
        end;

        if ELI.damage_numbers.enable or ELI.damage_numbers.remove_ingame then
            return
        end;
    end;
    return replicate_from_server(controller, _type, ...);
end;

local play_hitmarker_sound = client_viewmodel.PlayHitmarkerSound; client_viewmodel.PlayHitmarkerSound = function(controller, critical, pitch)
    if ELI.custom_hitsounds.enable then
        if ELI.custom_hitsounds.selected and hitsound_dir[ELI.custom_hitsounds.selected] then
            local hitsound = hitsound_dir[ELI.custom_hitsounds.selected];
            if hitsound then
                local volume = ELI.custom_hitsounds.volume;
                local pitch = ELI.custom_hitsounds.pitch;
                controller:_CreateHitmarkerSound(hitsound, volume, pitch, local_player.PlayerGui, true, 1);
            end;

            if ELI.custom_hitsounds.remove_default_hitsound then
                return;
            end;
        end;
    end;

    return play_hitmarker_sound(controller, critical, pitch);
end;

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.device_spoof.enable then
        replicated_storage.Remotes.Replication.Fighter.SetControls:FireServer(ELI.device_spoof.type);
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.sound_spammer.enable then
        mechanics_controller:PlayMechanicsSound(ELI.sound_spammer.type);
    end;
end)));

trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    if ELI.targeting.auto_shoot then
        local target = getclosest();
        if (target and target.Character) then
            setthreadidentity(2);
            local_fighter:Input("StartShooting");
            setthreadidentity(7);
        end;
    end;
end)));

local old = katana._StartDeflecting; katana._StartDeflecting = function(...)
    local args = {...};
    local fighter = args[1].ClientFighter;
    local player = fighter and fighter.Player;
    if (player) then
        deflecting[player] = true;
        task.delay(args[1].Info.DeflectDuration or 0.1, function(...)
            deflecting[player] = false;
        end);
    end;
    return old(table.unpack(args));
end;

local items_backup = {};
local old = gun.StartShooting; gun.StartShooting = function(controller, is_empty, debounce)
    local client_fighter = controller.ClientFighter;
    if not client_fighter.Islocal_player then
        return old(controller, is_empty, debounce);
    end;
    if not is_empty and controller:Get("Ammo") <= 0 then
        return false;
    end;
    if ZRHUB_state.zcRoll then pcall(ZRHUB_state.zcRoll) end;
    local shoot_result = {old(controller, is_empty, debounce)};
    local current_item = client_fighter.EquippedItem;
    if current_item then
        if ELI.guns.no_spread then
            shoot_result[4] = true;
        end;
    end;
    return unpack(shoot_result);
end;

trove:Add(function()
    katana._StartDeflecting = old;
end);

local old_muzzle = utility.PlayParticles; utility.PlayParticles = function(s, p)
    if ELI.guns.no_muzzle_flash and p.Name == "_muzzle" then
        return;
    end;
    return old_muzzle(s, p);
end;

trove:Add(function()
    utility.PlayParticles = old_muzzle;
end);

local old_raycast = utility.Raycast; utility.Raycast = LPH_NO_VIRTUALIZE(function(...)
    if ZRHUB_state.zcSilentPos and debug.info(3, "n") == "StartShooting" then
        local target_pos = ZRHUB_state.zcSilentPos("raycast");
        if target_pos then
            local args = {...};
            args[3] = target_pos;
            return old_raycast(table.unpack(args));
        end;
    end;
    return old_raycast(...);
end);

trove:Add(function()
    utility.Raycast = old_raycast;
end);

-- ===== ZRHUB combat (rebuilt) =====
(function()
    local ZC = {
        silent = { enable = false, method = 'mouse', hit_chance = 100, fov = 180, auto_shoot = false, wall_check = true },
        aim = { enable = false, fov = 180, smooth_x = 4, smooth_y = 4, link = true, axis = 'Both', jump_delay = 0, sticky = false },
        trig = { enable = false, scoped = false, reaction = 0.05, offset = 0, delay = 0.1, distance = 2500, forget = 0.4, blacklist = {} },
        tgt = { part = 'Head', priority = 'Crosshair', team = true, visible = false, distance = 700, anti_katana = true, anti_riot = true },
        gun = { full_auto = false, fire_rate = 1, backstab = false, backstab_range = 12 },
        rage = { enable = false, mode = 'Silent', select = 'Closest', priority = {}, attempts = 1, interval = 0.1, through_walls = true, void = false, void_depth = 40 },
        aa = { enable = false, yaw = 'Spin', yaw_custom = 180, spin = 600, jitter = 60, pitch = 'Off', pitch_custom = 0, floor = false, floor_depth = 6 },
        orb = { enable = false, list = { SILENT = true, AIM = true, TRIGGER = true }, size = 58, alpha = 0.15 },
    };
    ZRHUB_state.zc = true;

    local rs, ws = run_service, workspace;
    local WHITE = Color3.new(1, 1, 1);
    local function cam() return ws.CurrentCamera end;
    local function myChar() return local_player.Character end;
    local function myRoot() local c = myChar(); return c and c:FindFirstChild('HumanoidRootPart') end;
    local function fighter() return fighter_controller.LocalFighter or local_fighter end;
    local function ident(n) pcall(function() setthreadidentity(n) end) end;
    local function shoot()
        local f = fighter(); if not f then return end;
        ident(2); pcall(function() f:Input('StartShooting') end); ident(7);
    end;
    local function center()
        local vp = cam().ViewportSize; return Vector2.new(vp.X / 2, vp.Y / 2);
    end;

    ---------------------------------------------------------------- targeting
    local rp = RaycastParams.new();
    rp.FilterType = Enum.RaycastFilterType.Exclude;
    local function filterList(extra)
        local l = { cam() };
        local c = myChar(); if c then l[#l + 1] = c end;
        local vm = ws:FindFirstChild('ViewModels'); if vm then l[#l + 1] = vm end;
        if extra then l[#l + 1] = extra end;
        return l;
    end;
    local function visible(part)
        local o = cam().CFrame.Position;
        rp.FilterDescendantsInstances = filterList(part.Parent);
        return ws:Raycast(o, part.Position - o, rp) == nil;
    end;

    local function alive(p)
        local c = p and p.Character; if not c then return nil end;
        local h = c:FindFirstChildOfClass('Humanoid');
        if not h or h.Health <= 0 then return nil end;
        if c:FindFirstChildOfClass('ForceField') then return nil end;
        return c, h;
    end;
    local function enemy(p)
        if p == local_player then return false end;
        if not alive(p) then return false end;
        local e1, e2 = p:GetAttribute('EnvironmentID'), local_player:GetAttribute('EnvironmentID');
        if e1 ~= nil and e2 ~= nil and e1 ~= e2 then return false end;
        if ZC.tgt.team then
            local t1, t2 = p:GetAttribute('TeamID'), local_player:GetAttribute('TeamID');
            if t1 ~= nil and t1 == t2 then return false end;
        end;
        if ZC.tgt.anti_katana and is_deflecting(p) then return false end;
        if ZC.tgt.anti_riot and has_riot(p) then return false end;
        return true;
    end;

    local function partOf(c)
        local name = ZC.tgt.part;
        if name == 'Closest' then
            local best, bd = nil, math.huge; local cc = center();
            for _, v in c:GetChildren() do
                if v:IsA('BasePart') and v.Transparency < 1 then
                    local s, on = cam():WorldToViewportPoint(v.Position);
                    if on then
                        local d = (Vector2.new(s.X, s.Y) - cc).Magnitude;
                        if d < bd then best, bd = v, d end;
                    end;
                end;
            end;
            if best then return best end;
            name = 'Head';
        elseif name == 'Random' then
            local opts = { 'Head', 'UpperTorso', 'HumanoidRootPart' };
            name = opts[math.random(1, #opts)];
        end;
        return c:FindFirstChild(name) or c:FindFirstChild('HitboxHead') or c:FindFirstChild('Head') or c:FindFirstChild('HumanoidRootPart');
    end;

    -- returns player, part, screen distance
    local function pick(fov, needVisible, forced)
        local cc, root = center(), myRoot();
        local best, bpart, bscore = nil, nil, math.huge;
        local list = forced or players:GetPlayers();
        for _, p in list do
            if enemy(p) then
                local c, h = alive(p);
                local part = partOf(c);
                if part then
                    local s, on = cam():WorldToViewportPoint(part.Position);
                    local sd = on and (Vector2.new(s.X, s.Y) - cc).Magnitude or math.huge;
                    local wd = root and (part.Position - root.Position).Magnitude or 0;
                    if wd <= ZC.tgt.distance and (fov == nil or sd <= fov) and (not needVisible or visible(part)) then
                        local score = ZC.tgt.priority == 'Distance' and wd
                            or ZC.tgt.priority == 'Health' and h.Health
                            or sd;
                        if score < bscore then best, bpart, bscore = p, part, score end;
                    end;
                end;
            end;
        end;
        return best, bpart, bscore;
    end;
    ZC.pick = pick;

    ---------------------------------------------------------------- silent aim
    local roll = { ok = true, t = 0 };
    local function rollShot()
        roll.ok = math.random(1, 100) <= ZC.silent.hit_chance; roll.t = os.clock();
    end;
    local rageTarget = nil; -- set by ragebot, overrides silent target
    local function silentPart()
        if rageTarget then
            local c = alive(rageTarget); if c then return partOf(c) end;
        end;
        if not ZC.silent.enable then return nil end;
        if os.clock() - roll.t < 0.35 and not roll.ok then return nil end;
        local _, part = pick(ZC.silent.fov, ZC.silent.wall_check or ELI.targeting.visible_only);
        return part;
    end;
    ZC.silentPart = silentPart;
    ZRHUB_state.zcRoll = rollShot;
    ZRHUB_state.zcSilentPos = function(method)
        if not rageTarget and ZC.silent.method ~= method then return nil end;
        local part = silentPart();
        if part then
            ZRHUB_state.silentTarget = part.Position; ZRHUB_state.silentTargetT = tick();
            return part.Position;
        end;
    end;

    -- mouse-location redirect
    local hookedFighter = nil;
    local function hookFighter()
        local f = fighter(); if not f or f == hookedFighter then return end;
        hookedFighter = f;
        pcall(function()
            local oldMouse = f.GetMouseLocation;
            if type(oldMouse) == 'function' then
                f.GetMouseLocation = function(...)
                    local part = ((ZC.silent.enable and ZC.silent.method == 'mouse') or rageTarget) and silentPart();
                    if part then
                        local s = cam():WorldToViewportPoint(part.Position);
                        return Vector2.new(s.X, s.Y);
                    end;
                    return oldMouse(...);
                end;
            end;
            local oldInput = f.Input;
            if type(oldInput) == 'function' then
                f.Input = function(self, action, ...)
                    if action == 'StartShooting' then
                        rollShot();
                        if ZC.gun.backstab then pcall(ZC.backstab) end;
                    end;
                    return oldInput(self, action, ...);
                end;
            end;
        end);
    end;
    hookFighter();
    trove:Add(task.spawn(function()
        while task.wait(2) do pcall(hookFighter) end;
    end));

    ---------------------------------------------------------------- aimbot
    local jumpT, wasAir, stickyP = -1e9, false, nil;
    local function angles(v) return math.atan2(-v.X, -v.Z), math.asin(math.clamp(v.Y, -1, 1)) end;
    local function wrap(a) return (a + math.pi) % (2 * math.pi) - math.pi end;
    local function alpha(s, dt)
        if s <= 1 then return 1 end;
        return 1 - (1 - 1 / s) ^ (dt * 60);
    end;
    trove:Add(rs.Heartbeat:Connect(function(dt)
        local c = myChar(); local h = c and c:FindFirstChildOfClass('Humanoid');
        if h then
            local air = h.FloorMaterial == Enum.Material.Air;
            if air and not wasAir then jumpT = os.clock() end;
            wasAir = air;
        end;
        if not ZC.aim.enable then stickyP = nil return end;
        if os.clock() - jumpT < ZC.aim.jump_delay then return end;

        local part;
        if ZC.aim.sticky and stickyP and enemy(stickyP) then
            part = partOf(stickyP.Character);
        else
            local p; p, part = pick(ZC.aim.fov, ELI.targeting.visible_only);
            stickyP = p;
        end;
        if not part then return end;

        local cf = cam().CFrame;
        local cy, cp = angles(cf.LookVector);
        local ty, tp = angles((part.Position - cf.Position).Unit);
        local sx = ZC.aim.smooth_x;
        local sy = ZC.aim.link and sx or ZC.aim.smooth_y;
        local ax, ay = alpha(sx, dt), alpha(sy, dt);
        if ZC.aim.axis == 'Horizontal' then ay = 0 elseif ZC.aim.axis == 'Vertical' then ax = 0 end;
        local ny, np = cy + wrap(ty - cy) * ax, cp + (tp - cp) * ay;
        local dir = Vector3.new(-math.sin(ny) * math.cos(np), math.sin(np), -math.cos(ny) * math.cos(np));
        pcall(function() camera_controller:MimicRotation(CFrame.lookAt(cf.Position, cf.Position + dir)) end);
    end));

    ---------------------------------------------------------------- triggerbot
    local trig = { pending = nil, last = 0, seen = 0 };
    local groups = {
        Head = function(n) return n:find('Head') end,
        Torso = function(n) return n:find('Torso') or n == 'HumanoidRootPart' end,
        Arms = function(n) return n:find('Arm') or n:find('Hand') end,
        Legs = function(n) return n:find('Leg') or n:find('Foot') end,
    };
    local baseFov = 70;
    local function scoped()
        local fov = cam().FieldOfView;
        if not uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            baseFov = math.max(baseFov * 0.995, fov);
        end;
        return uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) or fov < baseFov - 4;
    end;
    trove:Add(rs.Heartbeat:Connect(function()
        if not ZC.trig.enable then trig.pending = nil return end;
        local isScoped = scoped();
        if ZC.trig.scoped and not isScoped then trig.pending = nil return end;
        local cf = cam().CFrame;
        rp.FilterDescendantsInstances = filterList();
        local r = ws:Raycast(cf.Position, cf.LookVector * ZC.trig.distance, rp);
        local now = os.clock();
        local ok = false;
        if r and r.Instance then
            local model = r.Instance:FindFirstAncestorOfClass('Model');
            local p = model and players:GetPlayerFromCharacter(model);
            if p and enemy(p) then
                ok = true;
                for g, on in ZC.trig.blacklist do
                    if on and groups[g] and groups[g](r.Instance.Name) then ok = false end;
                end;
            end;
        end;
        if not ok then trig.pending = nil return end;
        if not trig.pending then
            local react = (now - trig.seen <= ZC.trig.forget) and 0 or (ZC.trig.reaction + math.random() * ZC.trig.offset);
            trig.pending = now + react;
        end;
        trig.seen = now;
        if now >= trig.pending and now - trig.last >= ZC.trig.delay then
            trig.last = now;
            task.spawn(shoot);
        end;
    end));

    ---------------------------------------------------------------- silent auto shoot
    trove:Add(rs.Heartbeat:Connect(function()
        if ZC.silent.enable and ZC.silent.auto_shoot and silentPart() then
            if os.clock() - (ZC.lastAuto or 0) >= 0.05 then ZC.lastAuto = os.clock(); task.spawn(shoot) end;
        end;
    end));

    ---------------------------------------------------------------- gun exploits
    local backups = {};
    local function isCooldownKey(k) return type(k) == 'string' and (k:find('Cooldown') or k:find('ShootDelay')) end;
    local function isRateKey(k) return type(k) == 'string' and k:find('FireRate') end;
    local function applyGuns()
        local active = ZC.gun.full_auto or ZC.gun.fire_rate ~= 1;
        for name, item in next, item_lib.Items do
            if type(item) == 'table' then
                local b = backups[name];
                if active and not b then
                    b = { keys = {} };
                    if type(item.InputSpammingEnabled) == 'table' then b.spam = item.InputSpammingEnabled.StartShooting end;
                    for k, v in item do
                        if type(v) == 'number' and (isCooldownKey(k) or isRateKey(k)) then b.keys[k] = v end;
                    end;
                    backups[name] = b;
                end;
                if b then
                    local m = math.max(ZC.gun.fire_rate, 0.1);
                    for k, v in b.keys do
                        item[k] = active and (isRateKey(k) and v * m or v / m) or v;
                    end;
                    if type(item.InputSpammingEnabled) == 'table' then
                        if ZC.gun.full_auto then
                            local base = type(b.spam) == 'number' and b.spam or 0.1;
                            item.InputSpammingEnabled.StartShooting = base / m;
                        else
                            item.InputSpammingEnabled.StartShooting = b.spam;
                        end;
                    end;
                    if not active then backups[name] = nil end;
                end;
            end;
        end;
    end;
    ZC.applyGuns = function() pcall(applyGuns) end;
    trove:Add(task.spawn(function()
        while task.wait(1) do if ZC.gun.full_auto or ZC.gun.fire_rate ~= 1 then ZC.applyGuns() end end;
    end));
    trove:Add(function() ZC.gun.full_auto = false; ZC.gun.fire_rate = 1; ZC.applyGuns() end);

    local MELEE = { 'Knife', 'Katana', 'Scythe', 'Fists', 'Chainsaw', 'Battle Axe', 'Trowel', 'Daggers', 'Maul', 'Gunblade' };
    local function holdingMelee()
        local f = fighter(); local it = f and f.EquippedItem; if not it then return false end;
        local n = (it.Info and it.Info.Name) or it.Name or '';
        for _, m in MELEE do if n:find(m, 1, true) then return true end end;
        return false;
    end;
    local stabbing = false;
    ZC.backstab = function()
        if stabbing or not holdingMelee() then return end;
        local root = myRoot(); if not root then return end;
        local best, bd = nil, ZC.gun.backstab_range;
        for _, p in players:GetPlayers() do
            if enemy(p) then
                local r = p.Character:FindFirstChild('HumanoidRootPart');
                if r then local d = (r.Position - root.Position).Magnitude; if d < bd then best, bd = r, d end end;
            end;
        end;
        if not best then return end;
        stabbing = true;
        local back = best.CFrame * CFrame.new(0, 0, 2.5);
        root.CFrame = CFrame.lookAt(back.Position, best.Position);
        task.delay(0.15, function() stabbing = false end);
    end;

    ---------------------------------------------------------------- desync (anti-aim / floor hide / void spam)
    local DS = { real = nil, flip = false, spin = 0 };
    local function fakeCF(root, dt)
        local real = root.CFrame; local pos = real.Position; local out = nil;
        if ZC.aa.enable then
            local yaw = angles(cam().CFrame.LookVector);
            local mode = ZC.aa.yaw;
            if mode == 'Spin' then DS.spin = (DS.spin + math.rad(ZC.aa.spin) * dt) % (2 * math.pi); yaw = DS.spin
            elseif mode == 'Jitter' then yaw = yaw + math.pi + (DS.flip and 1 or -1) * math.rad(ZC.aa.jitter)
            elseif mode == 'Backwards' then yaw = yaw + math.pi
            elseif mode == 'Custom' then yaw = yaw + math.rad(ZC.aa.yaw_custom) end;
            local pm = ZC.aa.pitch;
            local pitch = pm == 'Down' and -math.rad(89) or pm == 'Up' and math.rad(89) or pm == 'Custom' and math.rad(ZC.aa.pitch_custom) or 0;
            out = CFrame.new(pos) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0);
        end;
        if ZC.aa.floor then
            out = (out or real) - Vector3.new(0, ZC.aa.floor_depth, 0);
        end;
        if ZC.rage.enable and ZC.rage.void and DS.flip then
            out = (out or real) - Vector3.new(0, ZC.rage.void_depth, 0);
        end;
        return out;
    end;
    trove:Add(rs.Heartbeat:Connect(function(dt)
        DS.flip = not DS.flip;
        if stabbing then return end;
        local root = myRoot(); if not root then return end;
        local f = fakeCF(root, dt);
        if f then DS.real = root.CFrame; root.CFrame = f end;
    end));
    local function restore()
        if DS.real then
            local root = myRoot();
            if root then root.CFrame = DS.real end;
            DS.real = nil;
        end;
    end;
    pcall(function() rs:BindToRenderStep('ZRHUB_desync', Enum.RenderPriority.First.Value, restore) end);
    trove:Add(function() pcall(function() rs:UnbindFromRenderStep('ZRHUB_desync') end); restore() end);

    ---------------------------------------------------------------- ragebot
    local function rageList()
        local list = {};
        for name, on in ZC.rage.priority do
            local p = on and players:FindFirstChild(name);
            if p and enemy(p) then list[#list + 1] = p end;
        end;
        return #list > 0 and list or nil;
    end;
    local function rageSelect()
        local forced = rageList();
        local saved = ZC.tgt.priority;
        ZC.tgt.priority = ZC.rage.select == 'Lowest Health' and 'Health' or ZC.rage.select == 'Crosshair' and 'Crosshair' or 'Distance';
        local p, part = pick(nil, not ZC.rage.through_walls, forced);
        ZC.tgt.priority = saved;
        return p, part;
    end;
    local rageLast = 0;
    trove:Add(rs.Heartbeat:Connect(function()
        if not ZC.rage.enable then rageTarget = nil return end;
        local p = rageSelect();
        rageTarget = (ZC.rage.mode == 'Silent') and p or nil;
        if not p then return end;
        local now = os.clock();
        if now - rageLast < ZC.rage.interval then return end;
        rageLast = now;
        local f = fighter(); local it = f and f.EquippedItem; if not it then return end;
        local ammo; pcall(function() ammo = it:Get('Ammo') end);
        if ammo ~= nil and ammo <= 0 then
            ident(2); pcall(function() it:Input('StartReloading') end); ident(7);
            return;
        end;
        for _ = 1, ZC.rage.attempts do
            if ZC.rage.mode == 'Packet' then
                task.spawn(function() pcall(function() RagebotService:FireWeapon(p) end) end);
            else
                task.spawn(shoot);
            end;
        end;
    end));

    ---------------------------------------------------------------- FOV visuals glue
    local function syncFov()
        ELI.silent_aim.enable = ZC.silent.enable and ZC.silent.method == 'raycast' or false;
        ZRHUB_state.zcSilentOn = ZC.silent.enable;
        ELI.silent_aim.fov_radius = ZC.silent.fov;
        ELI.aimbot.fov_radius = ZC.aim.fov;
        ELI.aimbot.enable = ZC.aim.enable;
    end;
    syncFov();

    ---------------------------------------------------------------- UI helpers
    local function kp(t, id, name)
        t:AddKeyPicker(id, { Default = 'None', Text = name, Mode = 'Toggle', SyncToggleState = true, NoUI = false });
        return t;
    end;
    local function gradientPickers(t, prefix, tbl, fill)
        local k1, k2, k3 = fill and 'fov_fill_color' or 'fov_color', fill and 'fov_fill_color2' or 'fov_color2', fill and 'fov_fill_color3' or 'fov_color3';
        t:AddColorPicker(prefix .. '_1', { Title = 'color 1', Default = WHITE, Callback = function(v) tbl[k1] = v end })
         :AddColorPicker(prefix .. '_2', { Title = 'color 2', Default = WHITE, Callback = function(v) tbl[k2] = v end })
         :AddColorPicker(prefix .. '_3', { Title = 'color 3', Default = WHITE, Callback = function(v) tbl[k3] = v end });
    end;
    for _, tbl in { ELI.silent_aim, ELI.aimbot } do
        tbl.fov_color, tbl.fov_color2, tbl.fov_color3 = WHITE, WHITE, WHITE;
        tbl.fov_fill_color, tbl.fov_fill_color2, tbl.fov_fill_color3 = WHITE, WHITE, WHITE;
    end;
    local function fovVisuals(box, p, tbl)
        local show = box:AddToggle(p .. '_show_fov', { Text = 'show fov', Default = false, Callback = function(v) tbl.show_fov = v end });
        gradientPickers(show, p .. '_fovc', tbl, false);
        local fill = box:AddToggle(p .. '_show_fill', { Text = 'fill', Default = false, Callback = function(v) tbl.show_fill = v end });
        gradientPickers(fill, p .. '_fillc', tbl, true);
        box:AddSlider(p .. '_fill_t', { Text = 'fill transparency', Default = 0.6, Min = 0, Max = 1, Rounding = 2, Callback = function(v) tbl.fov_fill_transparency = v end });
        box:AddSlider(p .. '_thick', { Text = 'thickness', Default = 2, Min = 1, Max = 8, Rounding = 0, Callback = function(v) tbl.fov_thickness = v end });
        box:AddSlider(p .. '_spin', { Text = 'gradient spin', Default = 90, Min = 0, Max = 360, Rounding = 0, Suffix = '°/s', Callback = function(v) ELI.silent_aim.fov_rotation_speed = v end });
        box:AddToggle(p .. '_follow', { Text = 'follow target', Default = false, Callback = function(v) tbl.follow_target = v end });
    end;

    local combat = Tabs.Main;

    ---------------------------------------------------------------- LEFT: silent aim / aimbot
    local aimTabs = combat:AddLeftTabbox();
    local sa = aimTabs:AddTab('silent aim'); do
        kp(sa:AddToggle('zc_silent', { Text = 'silent aim', Default = false, Callback = function(v) ZC.silent.enable = v; syncFov() end }), 'zc_silent_key', 'silent aim');
        sa:AddDropdown('zc_silent_method', { Text = 'method', Values = { 'mouse', 'raycast' }, Default = 1, Callback = function(v) ZC.silent.method = v; syncFov() end });
        sa:AddSlider('zc_silent_hc', { Text = 'hit chance', Default = 100, Min = 1, Max = 100, Rounding = 0, Suffix = '%', Callback = function(v) ZC.silent.hit_chance = v; ELI.silent_aim.hit_chance = v end });
        sa:AddSlider('zc_silent_fov', { Text = 'fov', Default = 180, Min = 10, Max = 800, Rounding = 0, Suffix = 'px', Callback = function(v) ZC.silent.fov = v; syncFov() end });
        sa:AddToggle('zc_silent_wall', { Text = 'wall check', Default = true, Callback = function(v) ZC.silent.wall_check = v end });
        kp(sa:AddToggle('zc_silent_auto', { Text = 'auto shoot', Default = false, Callback = function(v) ZC.silent.auto_shoot = v end }), 'zc_silent_auto_key', 'auto shoot');
        fovVisuals(sa, 'zc_sfov', ELI.silent_aim);
    end;
    local ab = aimTabs:AddTab('aimbot'); do
        kp(ab:AddToggle('zc_aim', { Text = 'aimbot', Default = false, Callback = function(v) ZC.aim.enable = v; syncFov() end }), 'zc_aim_key', 'aimbot');
        ab:AddSlider('zc_aim_fov', { Text = 'fov', Default = 180, Min = 10, Max = 800, Rounding = 0, Suffix = 'px', Callback = function(v) ZC.aim.fov = v; syncFov() end });
        ab:AddSlider('zc_aim_sx', { Text = 'smoothing x', Default = 4, Min = 1, Max = 30, Rounding = 1, Callback = function(v) ZC.aim.smooth_x = v end });
        ab:AddSlider('zc_aim_sy', { Text = 'smoothing y', Default = 4, Min = 1, Max = 30, Rounding = 1, Callback = function(v) ZC.aim.smooth_y = v end });
        ab:AddToggle('zc_aim_link', { Text = 'match x / y smoothing', Default = true, Callback = function(v) ZC.aim.link = v end });
        ab:AddDropdown('zc_aim_axis', { Text = 'axis', Values = { 'Both', 'Horizontal', 'Vertical' }, Default = 1, Callback = function(v) ZC.aim.axis = v end });
        ab:AddSlider('zc_aim_jump', { Text = 'delay after jump', Default = 0, Min = 0, Max = 1.5, Rounding = 2, Suffix = 's', Callback = function(v) ZC.aim.jump_delay = v end });
        ab:AddToggle('zc_aim_sticky', { Text = 'sticky target', Default = false, Callback = function(v) ZC.aim.sticky = v end });
        fovVisuals(ab, 'zc_afov', ELI.aimbot);
    end;

    ---------------------------------------------------------------- LEFT: targeting
    local tg = combat:AddLeftGroupbox('targeting', 'crosshair'); do
        tg:AddDropdown('zc_part', { Text = 'hit part', Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso', 'Closest', 'Random' }, Default = 1, Callback = function(v) ZC.tgt.part = v; ELI.targeting.part = (v == 'Closest' or v == 'Random') and 'Head' or v; ELI.silent_aim.closest_part = v == 'Closest' end });
        tg:AddDropdown('zc_priority', { Text = 'priority', Values = { 'Crosshair', 'Distance', 'Health' }, Default = 1, Callback = function(v) ZC.tgt.priority = v end });
        tg:AddToggle('zc_team', { Text = 'team check', Default = true, Callback = function(v) ZC.tgt.team = v end });
        tg:AddToggle('zc_visible', { Text = 'visible only', Default = false, Callback = function(v) ZC.tgt.visible = v; ELI.targeting.visible_only = v end });
        tg:AddToggle('zc_anti_katana', { Text = 'ignore deflecting katana', Default = true, Callback = function(v) ZC.tgt.anti_katana = v; ELI.targeting.anti_katana = v end });
        tg:AddToggle('zc_anti_riot', { Text = 'ignore riot shield', Default = true, Callback = function(v) ZC.tgt.anti_riot = v; ELI.targeting.riot_shield = v; ELI.silent_aim.riot_shield = v end });
        tg:AddSlider('zc_distance', { Text = 'max distance', Default = 700, Min = 25, Max = 2500, Rounding = 0, Suffix = 'studs', Callback = function(v) ZC.tgt.distance = v end });
    end;

    ---------------------------------------------------------------- LEFT: gun exploits
    local ge = combat:AddLeftGroupbox('gun exploits', 'swords'); do
        kp(ge:AddToggle('zc_no_spread', { Text = 'no spread', Default = false, Callback = function(v) ELI.guns.no_spread = v end }), 'zc_no_spread_key', 'no spread');
        ge:AddToggle('zc_no_flash', { Text = 'no muzzle flash', Default = false, Callback = function(v) ELI.guns.no_muzzle_flash = v end });
        kp(ge:AddToggle('zc_full_auto', { Text = 'full auto', Default = false, Callback = function(v) ZC.gun.full_auto = v; ZC.applyGuns() end }), 'zc_full_auto_key', 'full auto');
        ge:AddSlider('zc_fire_rate', { Text = 'fire rate', Default = 1, Min = 1, Max = 5, Rounding = 1, Suffix = 'x', Callback = function(v) ZC.gun.fire_rate = v; ZC.applyGuns() end });
        kp(ge:AddToggle('zc_backstab', { Text = 'always backstab', Default = false, Callback = function(v) ZC.gun.backstab = v end }), 'zc_backstab_key', 'always backstab');
        ge:AddSlider('zc_backstab_range', { Text = 'backstab range', Default = 12, Min = 4, Max = 25, Rounding = 0, Suffix = 'studs', Callback = function(v) ZC.gun.backstab_range = v end });
    end;

    ---------------------------------------------------------------- RIGHT: triggerbot
    local tb = combat:AddRightGroupbox('triggerbot', 'mouse-pointer-click'); do
        kp(tb:AddToggle('zc_trig', { Text = 'triggerbot', Default = false, Callback = function(v) ZC.trig.enable = v end }), 'zc_trig_key', 'triggerbot');
        tb:AddToggle('zc_trig_scoped', { Text = 'only when scoped', Default = false, Callback = function(v) ZC.trig.scoped = v end });
        tb:AddSlider('zc_trig_react', { Text = 'reaction time', Default = 0.05, Min = 0, Max = 1, Rounding = 2, Suffix = 's', Callback = function(v) ZC.trig.reaction = v end });
        tb:AddSlider('zc_trig_offset', { Text = 'random reaction offset', Default = 0, Min = 0, Max = 0.5, Rounding = 2, Suffix = 's', Callback = function(v) ZC.trig.offset = v end });
        tb:AddSlider('zc_trig_delay', { Text = 'shot delay', Default = 0.1, Min = 0, Max = 1, Rounding = 2, Suffix = 's', Callback = function(v) ZC.trig.delay = v end });
        tb:AddSlider('zc_trig_forget', { Text = 'forget time', Default = 0.4, Min = 0, Max = 3, Rounding = 2, Suffix = 's', Callback = function(v) ZC.trig.forget = v end });
        tb:AddDropdown('zc_trig_black', { Text = 'part blacklist', Values = { 'Head', 'Torso', 'Arms', 'Legs' }, Multi = true, AllowNull = true, Callback = function(v) ZC.trig.blacklist = v or {} end });
        tb:AddSlider('zc_trig_dist', { Text = 'max distance', Default = 2500, Min = 25, Max = 2500, Rounding = 0, Suffix = 'studs', Callback = function(v) ZC.trig.distance = v end });
    end;

    ---------------------------------------------------------------- RIGHT: ragebot
    local rb = combat:AddRightGroupbox('ragebot', 'skull'); do
        rb:AddLabel('ragebot is very obvious, use at your own risk', true);
        kp(rb:AddToggle('zc_rage', { Text = 'ragebot', Default = false, Callback = function(v) ZC.rage.enable = v; if not v then rageTarget = nil end end }), 'zc_rage_key', 'ragebot');
        rb:AddDropdown('zc_rage_mode', { Text = 'mode', Values = { 'Silent', 'Packet' }, Default = 1, Callback = function(v) ZC.rage.mode = v end });
        rb:AddDropdown('zc_rage_select', { Text = 'target select', Values = { 'Closest', 'Lowest Health', 'Crosshair' }, Default = 1, Callback = function(v) ZC.rage.select = v end });
        rb:AddDropdown('zc_rage_priority', { Text = 'priority targets', SpecialType = 'Player', Multi = true, AllowNull = true, Callback = function(v) ZC.rage.priority = v or {} end });
        rb:AddToggle('zc_rage_walls', { Text = 'target through walls', Default = true, Callback = function(v) ZC.rage.through_walls = v end });
        rb:AddSlider('zc_rage_attempts', { Text = 'shoot attempts', Default = 1, Min = 1, Max = 5, Rounding = 0, Callback = function(v) ZC.rage.attempts = v end });
        rb:AddSlider('zc_rage_interval', { Text = 'shot interval', Default = 0.1, Min = 0, Max = 1, Rounding = 2, Suffix = 's', Callback = function(v) ZC.rage.interval = v end });
        kp(rb:AddToggle('zc_rage_void', { Text = 'void spam', Default = false, Callback = function(v) ZC.rage.void = v end }), 'zc_rage_void_key', 'void spam');
        rb:AddSlider('zc_rage_void_depth', { Text = 'void depth', Default = 40, Min = 10, Max = 200, Rounding = 0, Suffix = 'studs', Callback = function(v) ZC.rage.void_depth = v end });
    end;

    ---------------------------------------------------------------- RIGHT: anti-aim
    local aa = combat:AddRightGroupbox('anti aim', 'rotate-3d'); do
        kp(aa:AddToggle('zc_aa', { Text = 'anti aim', Default = false, Callback = function(v) ZC.aa.enable = v end }), 'zc_aa_key', 'anti aim');
        aa:AddDropdown('zc_aa_yaw', { Text = 'yaw', Values = { 'Spin', 'Jitter', 'Backwards', 'Custom' }, Default = 1, Callback = function(v) ZC.aa.yaw = v end });
        aa:AddSlider('zc_aa_spin', { Text = 'spin speed', Default = 600, Min = 30, Max = 3000, Rounding = 0, Suffix = '°/s', Callback = function(v) ZC.aa.spin = v end });
        aa:AddSlider('zc_aa_jitter', { Text = 'jitter range', Default = 60, Min = 0, Max = 180, Rounding = 0, Suffix = '°', Callback = function(v) ZC.aa.jitter = v end });
        aa:AddSlider('zc_aa_yaw_c', { Text = 'custom yaw', Default = 180, Min = -180, Max = 180, Rounding = 0, Suffix = '°', Callback = function(v) ZC.aa.yaw_custom = v end });
        aa:AddDropdown('zc_aa_pitch', { Text = 'pitch', Values = { 'Off', 'Down', 'Up', 'Custom' }, Default = 1, Callback = function(v) ZC.aa.pitch = v end });
        aa:AddSlider('zc_aa_pitch_c', { Text = 'custom pitch', Default = 0, Min = -89, Max = 89, Rounding = 0, Suffix = '°', Callback = function(v) ZC.aa.pitch_custom = v end });
        kp(aa:AddToggle('zc_floor', { Text = 'floor hide', Default = false, Callback = function(v) ZC.aa.floor = v end }), 'zc_floor_key', 'floor hide');
        aa:AddSlider('zc_floor_depth', { Text = 'hide depth', Default = 6, Min = 2, Max = 20, Rounding = 1, Suffix = 'studs', Callback = function(v) ZC.aa.floor_depth = v end });
    end;

    ---------------------------------------------------------------- RIGHT: mobile buttons
    local ORBS = {
        { id = 'zc_silent', label = 'SILENT' },
        { id = 'zc_aim', label = 'AIM' },
        { id = 'zc_trig', label = 'TRIGGER' },
        { id = 'zc_silent_auto', label = 'AUTO' },
        { id = 'zc_rage', label = 'RAGE' },
        { id = 'zc_aa', label = 'ANTI AIM' },
        { id = 'zc_floor', label = 'HIDE' },
        { id = 'zc_backstab', label = 'STAB' },
    };
    local orbGui = Instance.new('ScreenGui');
    orbGui.Name = 'ZRHUB_CombatOrbs'; orbGui.ResetOnSpawn = false; orbGui.IgnoreGuiInset = true; orbGui.DisplayOrder = 9999;
    pcall(function() orbGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling end);
    orbGui.Parent = gethui();
    trove:Add(function() orbGui:Destroy() end);
    local orbs = {};
    local function makeOrb(def, i)
        local s = ZC.orb.size;
        local b = Instance.new('TextButton');
        b.Name = def.id; b.AutoButtonColor = false; b.Text = '';
        b.Size = UDim2.fromOffset(s, s);
        b.Position = UDim2.new(1, -(s + 18) - math.floor((i - 1) / 4) * (s + 12), 0.25, ((i - 1) % 4) * (s + 12));
        b.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
        b.BackgroundTransparency = ZC.orb.alpha;
        b.Visible = false; b.Parent = orbGui;
        Instance.new('UICorner', b).CornerRadius = UDim.new(1, 0);
        local st = Instance.new('UIStroke', b); st.Thickness = 2; st.Color = WHITE; st.Transparency = 0.55;
        local glow = Instance.new('Frame', b);
        glow.AnchorPoint = Vector2.new(0.5, 0.5); glow.Position = UDim2.fromScale(0.5, 0.5);
        glow.Size = UDim2.fromScale(0.78, 0.78); glow.BackgroundColor3 = WHITE; glow.BackgroundTransparency = 1; glow.BorderSizePixel = 0;
        Instance.new('UICorner', glow).CornerRadius = UDim.new(1, 0);
        local g = Instance.new('UIGradient', glow);
        g.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 165));
        g.Rotation = 90;
        local t = Instance.new('TextLabel', b);
        t.BackgroundTransparency = 1; t.Size = UDim2.fromScale(1, 1); t.Text = def.label;
        t.Font = Enum.Font.GothamBold; t.TextScaled = true; t.TextColor3 = WHITE; t.ZIndex = 3;
        local pad = Instance.new('UIPadding', t);
        pad.PaddingLeft = UDim.new(0, 7); pad.PaddingRight = UDim.new(0, 7); pad.PaddingTop = UDim.new(0, 17); pad.PaddingBottom = UDim.new(0, 17);

        local dragging, moved, startPos, startIn = false, false, nil, nil;
        b.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging, moved, startPos, startIn = true, false, b.Position, input.Position;
            end;
        end);
        uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
                local d = input.Position - startIn;
                if d.Magnitude > 8 then moved = true end;
                if moved then b.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end;
            end;
        end);
        b.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                if dragging and not moved then
                    local tog = Toggles[def.id];
                    if tog then tog:SetValue(not tog.Value) end;
                end;
                dragging = false;
            end;
        end);
        orbs[def.id] = { btn = b, glow = glow, label = t, stroke = st, home = b.Position };
    end;
    for i, def in ORBS do makeOrb(def, i) end;
    local function refreshOrbs()
        for _, def in ORBS do
            local o = orbs[def.id];
            local on = Toggles[def.id] and Toggles[def.id].Value;
            o.btn.Visible = ZC.orb.enable and ZC.orb.list[def.label] == true;
            o.btn.Size = UDim2.fromOffset(ZC.orb.size, ZC.orb.size);
            o.btn.BackgroundTransparency = ZC.orb.alpha;
            o.glow.BackgroundTransparency = on and 0 or 1;
            o.label.TextColor3 = on and Color3.fromRGB(20, 20, 24) or WHITE;
            o.stroke.Transparency = on and 0 or 0.55;
        end;
    end;
    trove:Add(task.spawn(function() while task.wait(0.1) do pcall(refreshOrbs) end end));

    local mb = combat:AddRightGroupbox('mobile buttons', 'smartphone'); do
        mb:AddLabel('round buttons you can drag anywhere. tap one to turn that feature on or off.', true);
        mb:AddToggle('zc_orbs', { Text = 'show buttons', Default = false, Callback = function(v) ZC.orb.enable = v end });
        local labels = {}; for _, d in ORBS do labels[#labels + 1] = d.label end;
        mb:AddDropdown('zc_orb_list', { Text = 'buttons', Values = labels, Multi = true, AllowNull = true, Default = { 'SILENT', 'AIM', 'TRIGGER' }, Callback = function(v) ZC.orb.list = v or {} end });
        mb:AddSlider('zc_orb_size', { Text = 'size', Default = 58, Min = 40, Max = 100, Rounding = 0, Suffix = 'px', Callback = function(v) ZC.orb.size = v end });
        mb:AddSlider('zc_orb_alpha', { Text = 'transparency', Default = 0.15, Min = 0, Max = 0.9, Rounding = 2, Callback = function(v) ZC.orb.alpha = v end });
        mb:AddButton({ Text = 'reset positions', Func = function()
            for _, o in orbs do o.btn.Position = o.home end;
            Library:Notify('Button positions reset.', 2);
        end });
    end;

    Library:OnUnload(function()
        ZC.silent.enable, ZC.aim.enable, ZC.trig.enable, ZC.rage.enable, ZC.aa.enable, ZC.aa.floor = false, false, false, false, false, false;
        rageTarget = nil; restore();
    end);
end)();
-- ===== end ZRHUB combat =====

local PredictionService = {}
do
    function PredictionService:Init()
        self.enabled = false;
        self.multiplier = 1.2;
        self.velocity = Vector3.new(0, 0, 0);
        self.acceleration = Vector3.new(0, 0, 0);
        self.lastposition = nil;
        self.lasttime = 0;
        self.velbuffer = {};
        self.posbuffer = {};
        self.maxvelsamples = 15;
        self.maxpossamples = 5;
    end;

    function PredictionService:Update(target)
        if not self.enabled or not target or not target.Character then
            self.velocity = Vector3.new(0, 0, 0);
            self.acceleration = Vector3.new(0, 0, 0);
            self.lastposition = nil;
            self.velbuffer = {};
            self.posbuffer = {};
            return
        end;

        local root = target.Character:FindFirstChild("HumanoidRootPart");
        if not root then return end;

        local now = tick();
        local dt = now - self.lasttime;

        if dt > 0 and dt < 0.1 then
            local currentpos = root.Position;

            table.insert(self.posbuffer, 1, {
                position = currentpos,
                time = now
            });

            if #self.posbuffer > self.maxpossamples then
                table.remove(self.posbuffer);
            end;

            if self.lastposition then
                local instantvel = (currentpos - self.lastposition) / dt;

                if self.velocity.Magnitude > 0.1 then
                    local instantaccel = (instantvel - self.velocity) / dt;
                    self.acceleration = self.acceleration:Lerp(instantaccel, 0.5);
                end;

                table.insert(self.velbuffer, 1, {
                    velocity = instantvel,
                    time = now,
                    dt = dt
                });

                if #self.velbuffer > self.maxvelsamples then
                    table.remove(self.velbuffer);
                end;

                if #self.velbuffer > 0 then
                    local weightedsum = Vector3.new(0, 0, 0);
                    local totalweight = 0;

                    for i, entry in next, self.velbuffer do
                        local weight = math.exp(-(i - 1) * 0.3);
                        weightedsum = weightedsum + (entry.velocity * weight);
                        totalweight = totalweight + weight;
                    end;

                    self.velocity = weightedsum / totalweight;
                else
                    self.velocity = instantvel;
                end;
            end;

            self.lastposition = currentpos;
            self.lasttime = now;
        end;
    end;

    function PredictionService:Predict(targetpart, origin)
        if not self.enabled or not targetpart then
            return targetpart.Position;
        end;

        local basepos = targetpart.Position;
        local distance = (basepos - origin).Magnitude;

        local ping = 0;
        pcall(function()
            ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() / 1000;
        end);

        local bulletspeed = 3000;
        local traveltime = distance / bulletspeed;
        local speed = self.velocity.Magnitude;

        local adaptivemult = 1.0;
        if speed > 150 then
            adaptivemult = 1.5 + math.min((speed - 150) / 300, 1.0);
        elseif speed > 80 then
            adaptivemult = 1.3;
        elseif speed > 40 then
            adaptivemult = 1.1;
        elseif speed < 10 then
            adaptivemult = 0.7;
        end;

        local totaltime = (traveltime + ping) * self.multiplier * adaptivemult;
        local predicted = basepos + (self.velocity * totaltime);

        if self.acceleration.Magnitude > 5 and speed > 50 then
            predicted = predicted + self.acceleration * (totaltime * totaltime * 0.5);
        end;

        if #self.posbuffer >= 3 then
            local jittersum = Vector3.new(0, 0, 0);
            for i = 1, math.min(3, #self.posbuffer - 1) do
                jittersum = jittersum + (self.posbuffer[i].position - self.posbuffer[i + 1].position);
            end;
            local avgjitter = jittersum / math.min(3, #self.posbuffer - 1);
            if avgjitter.Magnitude > 2 then
                predicted = predicted + (avgjitter * 0.3);
            end;
        end;

        if math.abs(self.velocity.Y) > 5 then
            predicted = predicted + Vector3.new(0, self.velocity.Y * totaltime * 0.15, 0);
        end;

        return predicted;
    end;

    PredictionService:Init();
end;

local DesyncService = {}
do
    function DesyncService:Init()
        self.active = false;
        self.connection = nil;
        self.server = nil;
        self.client = nil;
        self.angle = 0;
        self.speed = 9000;
        self.fighter = fighter_controller.LocalFighter;

        local ref = camera_controller.Update;
        camera_controller.Update = function(...)
            if self.active and self.fighter and self.fighter.Entity.RootPart and self.client then
                self.fighter.Entity.RootPart.CFrame = self.client;
            end;
            return ref(...);
        end;
    end;

    function DesyncService:Start(target)
        if self.active then return end;
        if not local_player.Character then return end;
        if not self.fighter or not self.fighter.Entity.RootPart then return end;

        self.active = true;
        self.connection = run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(dt)
            if not self.active then
                if self.connection then
                    self.connection:Disconnect();
                    self.connection = nil;
                end;
                return
            end;

            if not target or not target.Character or not target.Character:FindFirstChild('HumanoidRootPart') or not self.fighter or not self.fighter.Entity.RootPart then
                if self.connection then
                    self.connection:Disconnect();
                    self.connection = nil;
                end;
                if self.client and self.fighter and self.fighter.Entity.RootPart then
                    self.fighter.Entity.RootPart.CFrame = self.client;
                end;
                self.active = false;
                self.client = nil;
                self.server = nil;
                return
            end;

            self.client = self.fighter.Entity.RootPart.CFrame;

            local item = self.fighter.EquippedItem;
            if not item then return end;

            local targetPos = target.Character.HumanoidRootPart.Position;

            if is_deflecting(target) or has_riot(target) then
            self.server = Vector3.new(0, 2^26, 0);
            return
            end;

            if item.Name == "Slingshot" then
                self.server = Vector3.new(0, 2^26, 0);
            else
                self.server = targetPos + Vector3.new(ELI.ragebot.x, ELI.ragebot.y, ELI.ragebot.z);
            end;

            self.fighter.Entity.RootPart.CFrame = CFrame.new(self.server);
        end));
    end;

    function DesyncService:Stop()
        if not self.active then return end;
        if self.connection then
            self.connection:Disconnect();
            self.connection = nil;
        end;
        if self.client and self.fighter and self.fighter.Entity.RootPart then
            self.fighter.Entity.RootPart.CFrame = self.client;
        end;
        self.active = false;
        self.server = nil;
        self.client = nil;
    end;

    DesyncService:Init();
end

do
    local POOL_SIZE = 32;
    local pool = {};
    local throwables = {
        ["grenade"] = true, ["molotov"] = true, ["flashbang"] = true,
        ["smoke grenade"] = true, ["satchel"] = true, ["jump pad"] = true,
        ["war horn"] = true, ["flare gun"] = true,
    };

    local function getPart(i)
        local p = pool[i];
        if p and p.Parent then return p end;
        p = Instance.new("Part");
        p.Anchored = true;
        p.CanCollide = false;
        p.CanQuery = false;
        p.CanTouch = false;
        p.Shape = Enum.PartType.Ball;
        p.Size = Vector3.new(0.4, 0.4, 0.4);
        p.Material = Enum.Material.Neon;
        p.Parent = workspace;
        pool[i] = p;
        return p;
    end;

    local function hideFrom(n)
        for i = n, POOL_SIZE do
            local p = pool[i];
            if p then p.Transparency = 1 end;
        end;
    end;

    local function clearPool()
        for i, p in eli_pairs(pool) do
            pcall(function() p:Destroy() end);
            pool[i] = nil;
        end;
    end;

    local function computeArc(startPos, velocity, gravity, dt, steps, params)
        local points = { startPos };
        local pos = startPos;
        local vel = velocity;
        for _ = 1, steps do
            local nextPos = pos + vel * dt + gravity * (0.5 * dt * dt);
            local hit = params and workspace:Raycast(pos, nextPos - pos, params);
            if hit then
                points[#points + 1] = hit.Position;
                return points;
            end;
            points[#points + 1] = nextPos;
            pos = nextPos;
            vel = vel + gravity * dt;
        end;
        return points;
    end;

    trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
        local cfg = ELI.trajectory;
        if not cfg.enable then
            hideFrom(1);
            return
        end;

        local fighter = fighter_controller.LocalFighter;
        local item = fighter and fighter.EquippedItem;
        local name = item and item.Name;
        local show = cfg.all_weapons or (name ~= nil and throwables[string.lower(name)] == true);
        if not show then
            hideFrom(1);
            return
        end;

        local origin = camera.CFrame.Position;
        local velocity = camera.CFrame.LookVector * cfg.speed + Vector3.new(0, cfg.arc_up, 0);
        local gravity = Vector3.new(0, -workspace.Gravity, 0);

        local params = RaycastParams.new();
        params.FilterType = Enum.RaycastFilterType.Exclude;
        params.FilterDescendantsInstances = { local_player.Character };

        local points = computeArc(origin, velocity, gravity, 0.07, POOL_SIZE - 1, params);
        for i = 1, #points do
            local p = getPart(i);
            p.Position = points[i];
            p.Color = cfg.color;
            p.Transparency = 0;
        end;
        hideFrom(#points + 1);
    end)));

    trove:Add(clearPool);
end;

local RagebotService = {}
do
    function RagebotService:Init()
        self.active = false;
        self.debounce = false;
        self.lastShot = os.clock();
        self.connection = nil;
    end;

    function RagebotService:IsValid(player)
        if not (player
            and player.Character
            and player.Character:FindFirstChild("Humanoid")
            and player.Character.Humanoid.Health > 0
            and player:GetAttribute('EnvironmentID') == local_player:GetAttribute('EnvironmentID')) then
            return false;
        end;

        if ELI.ragebot.ffa_mode then
            return true;
        end;

        return local_player:GetAttribute('TeamID') ~= player:GetAttribute('TeamID');
    end;

    function RagebotService:GetClosest()
        local closest, best = nil, math.huge;

        for _, player in next, players:GetPlayers() do
            if player ~= local_player and self:IsValid(player) then
                local rootpos = player.Character.HumanoidRootPart.Position;
                local mag = local_player:DistanceFromCharacter(rootpos);

                if mag < best then
                    closest, best = player, mag;
                end;
            end;
        end;

        return closest;
    end;

    function RagebotService:FireWeapon(target)
        if not target or not target.Character then return end;

        local fighter = fighter_controller.LocalFighter;
        if not fighter then return end;

        local item = fighter.EquippedItem;
        if not item then return end;
        if is_deflecting(target) or has_riot(target) then
            return
        end;
        local head = target.Character:FindFirstChild('HitboxHead')
            or target.Character:FindFirstChild('HitboxTorso')
            or target.Character:FindFirstChild('HumanoidRootPart');
        if not head then return end;

        local character = local_player.Character;
        if not character or not character:FindFirstChild('HumanoidRootPart') then return end;

        local shootPos = DesyncService.active and DesyncService.server or character.HumanoidRootPart.Position;

        local aimPos = head.Position;

        if ELI.ragebot.prediction then
            local troot = target.Character:FindFirstChild('HumanoidRootPart');
            if troot then
                local ping = 0.05;
                pcall(function() ping = local_player:GetNetworkPing() end);
                local lead = math.clamp(ping, 0, 0.4) * (ELI.ragebot.prediction_amount or 1);
                aimPos = aimPos + troot.AssemblyLinearVelocity * lead;
            end;
        end;

        local data = {
            [utf8.char(1)] = {
                [utf8.char(0)] = utility:EncodeCFrame(CFrame.new(shootPos, aimPos)),
                [utf8.char(1)] = utility:EncodeCFrame(CFrame.new(shootPos, aimPos)),
                [utf8.char(2)] = head,
                [utf8.char(1)] = utility:EncodeCFrame(CFrame.new(shootPos, aimPos)),
            },
        };

        replicated_storage.Remotes.Replication.Fighter.UseItem:FireServer(item:Get('ObjectID'), enum_lib:ToEnum('StartShooting'), data, nil);
    end;

    function RagebotService:ProjectileHandler()
        workspace.DescendantAdded:Connect(function(child)
            if not ELI.ragebot.enable then return end;

            if child:IsA('BasePart') or child:IsA('Model') then
                if child.Name == "Slingshot" or child.Name == "CoreProjectile" or child.Name == "OuterProjectile" then
                    task.spawn(function()
                        task.wait(0.03);

                        local proj = child:IsA('BasePart') and child or child:FindFirstChildWhichIsA('BasePart');
                        if not proj then return end;

                        proj.CanTouch = true;

                        for i = 1, 45 do
                            if not ELI.ragebot.enable then break end;

                            local target = self:GetClosest();
                            if target and target.Character then
                                local hitpart = target.Character:FindFirstChild('HitboxHead') or target.Character:FindFirstChild('HumanoidRootPart');

                                if hitpart and hitpart:IsA("BasePart")
                                    and hitpart.Parent
                                    and proj.Parent
                                    and hitpart:IsDescendantOf(workspace)
                                    and proj:IsDescendantOf(workspace)
                                then
                                    pcall(firetouchinterest, hitpart, proj, 0);
                                    pcall(firetouchinterest, hitpart, proj, 1);
                                end;
                            end;
                            task.wait();
                        end;
                    end);
                end;
            end;
        end);
    end;

    function RagebotService:Start()
        if self.connection then return end;

        self.connection = run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
            if not ELI.ragebot.enable then
                self:Stop();
                return
            end;

            local target = self:GetClosest();
            if not target then DesyncService:Stop() return end;

            local fighter = fighter_controller.LocalFighter;
            if not fighter then DesyncService:Stop() return end;

            local item = fighter.EquippedItem;
            if not item then DesyncService:Stop() return end;

            local target_fighter = fighter_controller:GetFighter(target);
            if not target_fighter then DesyncService:Stop() return end;

            local viewmodel = item.ViewModel;
            if not viewmodel then DesyncService:Stop() return end;
            local target_entity = target_fighter.Entity;
            if not target_entity or target_entity:Get('IsInvincible') then DesyncService:Stop() return end;

            if item:Get('Ammo') and item:Get('Ammo') > 0 and not viewmodel:IsAnimationPlaying('Reload') then
                if self.debounce == false then
                    self.debounce = os.clock() + 0.5;
                    return
                end;

                if typeof(self.debounce) == 'number' and os.clock() < self.debounce then
                    return
                end;

                if typeof(self.debounce) == 'number' then
                    self.debounce = true;
                end;

                DesyncService:Start(target);

                if not target.Character then return end;

                if DesyncService.server then
                    self.lastShot = os.clock();
                    self:FireWeapon(target);
                end;
            else
                if not viewmodel:IsAnimationPlaying('Reload') then
                    setthreadidentity(2);
                    item:Input('StartReloading');
                    setthreadidentity(7);
                end;
            end;
        end));
    end;

    function RagebotService:Stop()
        if self.connection then
            self.connection:Disconnect();
            self.connection = nil;
        end;
        self.debounce = false;
        DesyncService:Stop();
    end;

    RagebotService:Init();
    RagebotService:ProjectileHandler();
end;


do
    local opt_tab = Tabs.optimizations;
    local function apply(kind) pcall(function() getgenv().ZRHUB_apply_opt(kind) end) end;

    local boost_box = opt_tab:AddLeftGroupbox('fps boost', 'gauge');

    boost_box:AddToggle('opt_no_particles', {
        Text = 'remove particles & effects',
        Default = false,
        Callback = function(v)
            ELI.optimizations.no_particles = v;
            apply('particles');
        end
    });

    boost_box:AddToggle('opt_no_shadows', {
        Text = 'disable shadows',
        Default = false,
        Callback = function(v)
            ELI.optimizations.no_shadows = v;
            apply('shadows');
        end
    });

    boost_box:AddToggle('opt_no_postfx', {
        Text = 'disable post processing',
        Default = false,
        Callback = function(v)
            ELI.optimizations.no_postfx = v;
            apply('postfx');
        end
    });

    boost_box:AddToggle('opt_low_quality', {
        Text = 'low render quality',
        Default = false,
        Callback = function(v)
            ELI.optimizations.low_quality = v;
            apply('quality');
        end
    });

    boost_box:AddToggle('opt_no_atmosphere', {
        Text = 'disable atmosphere & clouds',
        Default = false,
        Callback = function(v)
            ELI.optimizations.no_atmosphere = v;
            apply('atmosphere');
        end
    });

    boost_box:AddToggle('opt_no_textures', {
        Text = 'remove textures',
        Default = false,
        Callback = function(v)
            ELI.optimizations.no_textures = v;
            apply('textures');
        end
    });

    boost_box:AddButton('quick boost (all)', function()
        Toggles.opt_no_particles:SetValue(true);
        Toggles.opt_no_shadows:SetValue(true);
        Toggles.opt_no_postfx:SetValue(true);
        Toggles.opt_low_quality:SetValue(true);
        Toggles.opt_no_atmosphere:SetValue(true);
        Library:Notify('Applied fps boost', 3);
    end);

    local fr_box = opt_tab:AddRightGroupbox('frame rate', 'activity');

    fr_box:AddToggle('opt_fps_cap_enable', {
        Text = 'limit fps',
        Default = false,
        Callback = function(v)
            ELI.optimizations.fps_cap_enable = v;
            apply('fpscap');
            if v and not setfpscap then
                Library:Notify('your executor has no setfpscap, to unlock fps past 60 use the fflags injector below then rejoin', 8);
            end;
        end
    });

    fr_box:AddSlider('opt_fps_cap', {
        Text = 'fps limit',
        Default = 60,
        Min = 30,
        Max = 240,
        Rounding = 0,
        Callback = function(v)
            ELI.optimizations.fps_cap = v;
            apply('fpscap');
        end
    });

    fr_box:AddLabel('this caps fps where setfpscap is supported, on mobile roblox is locked to 60 by the engine, raising this slider will not go past 60, to truly unlock use the fflags injector then fully rejoin', true);

    local ff_box = opt_tab:AddRightGroupbox('fflags injector', 'flag');

    ff_box:AddLabel('how to use', false);
    ff_box:AddLabel('1 tap "inject fps boost fflags"', true);
    ff_box:AddLabel('2 it applies live if your executor supports it and always saves them to the ZRHUB fflags file', true);
    ff_box:AddLabel('3 if it only saved, open your executor fastflags editor and import that file (or paste it in)', true);
    ff_box:AddLabel('4 fully close and rejoin roblox to apply', true);
    ff_box:AddLabel('this unlocks fps past 60 and forces low graphics for a big fps gain, paste your own flags in the box for custom ones', true);
    ff_box:AddDivider();

    local exec_label = ff_box:AddLabel('detecting your executor', true)
    do
        local name = '';
        local fn = identifyexecutor or getexecutorname;
        if fn then
            local ok, n = pcall(fn);
            if ok and n then name = tostring(n) end;
        end;
        local key = string.lower(name);

        local known = {
            'delta', 'codex', 'cryptic', 'fluxus', 'arceus', 'hydrogen', 'vega', 'trigon',
            'evon', 'electron', 'mercury', 'nihon', 'cloud', 'sirhurt', 'krnl',
            'wave', 'solara', 'xeno', 'velocity', 'seliware', 'zenith', 'ronix', 'synapse',
            'bytebreaker', 'potassium', 'volt', 'awp', 'swift', 'bunni', 'isabelle', 'jjsploit',
            'nezur', 'comet', 'argon', 'matcha', 'nihon', 'valex', 'assembly',
            'macsploit', 'opiumware', 'nirvana', 'hydrogen',
        };
        local overrides = {
            delta = 'tap the floating delta icon > settings (gear) > fastflags, paste or import the json then save',
            fluxus = 'open settings > fastflags manager, paste or import the json then save',
            codex = 'open menu > settings > fastflags editor, paste or import the json',
            cryptic = 'open menu > settings > fastflags, paste or import the json',
            macsploit = 'open the macsploit menu > settings > fastflags, paste the json',
            arceus = 'open menu > settings > fastflags, paste or import the json',
        };
        local base = 'open its settings > fastflags editor, paste or import the ZRHUB fflags file then save';

        local matched;
        for _, k in eli_ipairs(known) do
            if key ~= '' and string.find(key, k, 1, true) then
                matched = k;
                break;
            end;
        end;

        local guide;
        if name == '' then
            guide = 'could not auto detect your executor, open its fastflags or config editor, import the ZRHUB fflags file then fully rejoin roblox';
        else
            local steps = (matched and overrides[matched]) or base;
            guide = 'detected ' .. string.lower(name) .. ', ' .. steps .. ' then fully rejoin roblox';
        end;
        pcall(function() exec_label:SetText(guide) end);
    end;

    local function do_inject(json)
        local injector = getgenv().ZRHUB_inject_fflags;
        if not injector then
            Library:Notify('fflags injector not ready', 4);
            return
        end;
        local res = injector(json);
        if not res or not res.ok then
            Library:Notify('fflags: ' .. ((res and res.reason) or 'failed'), 4);
            return
        end;
        if res.live and res.applied > 0 then
            Library:Notify(string.format('fflags applied %d/%d live - rejoin to fully apply', res.applied, res.total), 6);
        elseif res.saved then
            Library:Notify('fflags saved to ZRHUB/fflags.json - import in your executor & rejoin', 7);
        else
            Library:Notify('your executor cannot set fflags from a script', 5);
        end;
    end;

    ff_box:AddButton('inject fps boost fflags', function()
        do_inject(nil);
    end);

    ff_box:AddInput('opt_fflag_custom', {
        Text = 'custom fflags json',
        Default = '',
        Placeholder = 'paste fflags json here',
    });

    ff_box:AddButton('inject custom fflags', function()
        local v = Options.opt_fflag_custom and Options.opt_fflag_custom.Value or '';
        do_inject(v);
    end);

    ff_box:AddButton('save preset to file', function()
        if not writefile then
            Library:Notify('no writefile support', 4);
            return
        end;
        pcall(function()
            if makefolder and isfolder and not isfolder('ZRHUB') then makefolder('ZRHUB') end;
            writefile('ZRHUB/fflags.json', getgenv().ZRHUB_fflag_preset or '{}');
        end);
        Library:Notify('saved preset to ZRHUB/fflags.json', 5);
    end);
end;

local visuals_tab = Tabs.visualstab; do

    local viewmodel_thing = visuals_tab:AddLeftTabbox(); do
        local viewmodel_tab = viewmodel_thing:AddTab('viewmodel'); do

            local vm_material_names = getgenv().ZRHUB_materials.names;

            local function build_vm_chams_section(tab, key, chams_label, is_arms)
                local prefix = 'vm_' .. key;
                local vm = ELI.viewmodel_chams;

                tab:AddToggle(prefix .. '_chams_enable', {
                    Text = chams_label,
                    Default = false,
                    Callback = function(v)
                        vm[key .. '_chams'].enable = v;
                        Options[prefix .. '_chams_material']:SetVisible(v);
                        Options[prefix .. '_chams_transparency']:SetVisible(v);
                        if is_arms then Options[prefix .. '_chams_invisible']:SetVisible(v) end;
                    end;
                }):AddColorPicker(prefix .. '_chams_color', {
                    Title = 'color',
                    Default = Color3.fromRGB(255, 255, 255),
                    Callback = function(v)
                        vm[key .. '_chams'].color = v;
                    end;
                });

                tab:AddDropdown(prefix .. '_chams_material', {
                    Text = 'material',
                    Values = vm_material_names,
                    Default = 'Neon',
                    Visible = false,
                    Callback = function(v)
                        vm[key .. '_chams'].material = v;
                    end;
                });

                tab:AddSlider(prefix .. '_chams_transparency', {
                    Text = 'transparency',
                    Default = 0, Min = 0, Max = 1, Rounding = 2, Visible = false,
                    Callback = function(v)
                        vm[key .. '_chams'].transparency = v;
                    end;
                });

                if is_arms then
                    tab:AddToggle(prefix .. '_chams_invisible', {
                        Text = 'invisible arms',
                        Default = false,
                        Visible = false,
                        Callback = function(v)
                            vm.arm_chams.invisible = v;
                        end;
                    });
                end;

                tab:AddToggle(prefix .. '_highlight_enable', {
                    Text = is_arms and 'arm highlight' or 'weapon highlight',
                    Default = false,
                    Callback = function(v)
                        vm[key .. '_highlight'].enable = v;
                        Options[prefix .. '_highlight_fill']:SetVisible(v);
                        Options[prefix .. '_highlight_outline']:SetVisible(v);
                    end;
                }):AddColorPicker(prefix .. '_highlight_color', {
                    Title = 'fill color',
                    Default = Color3.fromRGB(255, 255, 255),
                    Callback = function(v)
                        vm[key .. '_highlight'].color = v;
                    end;
                }):AddColorPicker(prefix .. '_highlight_outline_color', {
                    Title = 'outline color',
                    Default = Color3.fromRGB(255, 255, 255),
                    Callback = function(v)
                        vm[key .. '_highlight'].outline_color = v;
                    end;
                });

                tab:AddSlider(prefix .. '_highlight_fill', {
                    Text = 'fill transparency',
                    Default = 0.5, Min = 0, Max = 1, Rounding = 2, Visible = false,
                    Callback = function(v)
                        vm[key .. '_highlight'].transparency = v;
                    end;
                });

                tab:AddSlider(prefix .. '_highlight_outline', {
                    Text = 'outline transparency',
                    Default = 0, Min = 0, Max = 1, Rounding = 2, Visible = false,
                    Callback = function(v)
                        vm[key .. '_highlight'].outline_transparency = v;
                    end;
                });
            end;

            local weapon_chams_tab = viewmodel_thing:AddTab('weapon');
            build_vm_chams_section(weapon_chams_tab, 'weapon', 'weapon chams', false);

            local arm_chams_tab = viewmodel_thing:AddTab('arms');
            build_vm_chams_section(arm_chams_tab, 'arm', 'arm chams', true);

            viewmodel_tab:AddToggle('viewmodel_offsets', {
                Text = 'viewmodel override',
                Default = false,
                Callback = function(v)
                    ELI.viewmodel_offsets.enable = v;
                    Options.viewmodel_offset_x:SetVisible(v);
                    Options.viewmodel_offset_y:SetVisible(v);
                    Options.viewmodel_offset_z:SetVisible(v);
                    if v then
                        for i, vm in next, item_lib.ViewModels do
                            if vm.RootPartOffset then
                                oldoffsets[i] = vm.RootPartOffset;
                            end;
                        end;
                    else
                        for i, vm in next, item_lib.ViewModels do
                            if oldoffsets[i] then
                                vm.RootPartOffset = oldoffsets[i];
                            end;
                        end;
                        oldoffsets = {};
                    end;
                end;
            });

            viewmodel_tab:AddSlider('viewmodel_offset_x', {
                Text = 'x',
                Default = 0,
                Min = -5,
                Max = 5,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.viewmodel_offsets.x = v;
                end;
            });

            viewmodel_tab:AddSlider('viewmodel_offset_y', {
                Text = 'y',
                Default = 0,
                Min = -5,
                Max = 5,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.viewmodel_offsets.y = v;
                end;
            });

            viewmodel_tab:AddSlider('viewmodel_offset_z', {
                Text = 'z',
                Default = 0,
                Min = -5,
                Max = 5,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.viewmodel_offsets.z = v;
                end;
            });

            viewmodel_tab:AddToggle('bullet_tracers_enable', {
                Text = 'bullet tracers',
                Default = false,
                Callback = function(v)
                    ELI.bullet_tracers.enable = v;
                    Options.bullet_tracers_texture:SetVisible(v);
                    Options.bullet_tracers_speed:SetVisible(v);
                    Options.bullet_tracers_lifetime:SetVisible(v);
                    Options.bullet_tracers_width0:SetVisible(v);
                    Options.bullet_tracers_width1:SetVisible(v);
                    Options.bullet_tracers_position_lerp_speed:SetVisible(v);
                    Options.bullet_tracers_spring_expand:SetVisible(v);
                    Options.bullet_tracers_expand_speed:SetVisible(v and ELI.bullet_tracers.spring_expand);
                    Options.bullet_tracers_expand_damper:SetVisible(v and ELI.bullet_tracers.spring_expand);
                end;
            }):AddColorPicker('bullet_tracers_color_start', {
                Title = 'color start',
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.bullet_tracers.color_start = v;
                end;
            }):AddColorPicker('bullet_tracers_color_end', {
                Title = 'color end',
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.bullet_tracers.color_end = v;
                end;
            });

            viewmodel_tab:AddToggle('bullet_tracers_curve', {
                Text = 'curve around walls',
                Default = false,
                Callback = function(v)
                    ELI.bullet_tracers.curve_around = v;
                    Options.bullet_tracers_curve_height:SetVisible(v);
                end
            });

            viewmodel_tab:AddToggle('bullet_tracers_through_walls', {
                Text = 'show through walls',
                Default = false,
                Callback = function(v)
                    ELI.bullet_tracers.through_walls = v;
                end
            });

            viewmodel_tab:AddSlider('bullet_tracers_curve_height', {
                Text = 'curve height',
                Default = 14,
                Min = 2,
                Max = 60,
                Rounding = 0,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.curve_height = v;
                end
            });

            viewmodel_tab:AddDropdown('bullet_tracers_texture', {
                Values = {"beam", "lightning", "heartrate", "chain", "glitch", "swirl", "neon", "arrow1", "bullets1", "bullets2", "curve1", "curve2", "curve3", "curve4", "curve5", "curve6", "dna", "dna2", "dna3", "dna4", "dna5", "dna6", "dna7", "glow1", "laser1", "laser2", "laser3", "laser4", "laser5", "laser6", "line1", "line2", "line3", "line4", "line5", "none (solid)", "pattern1", "pattern2", "pattern3", "pattern4", "ray1", "ray2", "ray3"},
                Default = 2,
                Multi = false,
                Text = 'texture',
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.texture = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_speed', {
                Text = 'speed',
                Default = 3,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.speed = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_lifetime', {
                Text = 'lifetime',
                Default = 1.5,
                Min = 0.10,
                Max = 5,
                Rounding = 1,
                Suffix = 's',
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.life_time = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_position_lerp_speed', {
                Text = 'position lerp',
                Default = 0,
                Min = 0,
                Max = 3,
                Rounding = 1,
                Suffix = 's',
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.position_lerp_speed = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_width0', {
                Text = 'width start',
                Default = 0.35,
                Min = 0,
                Max = 2,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.width0 = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_width1', {
                Text = 'width end',
                Default = 0.15,
                Min = 0,
                Max = 2,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.width1 = v;
                end;
            });

            viewmodel_tab:AddToggle('bullet_tracers_spring_expand', {
                Text = 'spring expand',
                Default = false,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.spring_expand = v;
                    Options.bullet_tracers_expand_speed:SetVisible(v);
                    Options.bullet_tracers_expand_damper:SetVisible(v);
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_expand_speed', {
                Text = 'expand speed',
                Default = 12,
                Min = 1,
                Max = 40,
                Rounding = 1,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.expand_speed = v;
                end;
            });

            viewmodel_tab:AddSlider('bullet_tracers_expand_damper', {
                Text = 'expand damper',
                Default = 0.6,
                Min = 0.1,
                Max = 1,
                Rounding = 2,
                Visible = false,
                Callback = function(v)
                    ELI.bullet_tracers.expand_damper = v;
                end;
            });

        end;

local target_hud_box = visuals_tab:AddLeftGroupbox('target hud', 'target'); do

    target_hud_box:AddToggle('target_hud_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.target_hud.enable = v;
            G2L["2"]["Visible"] = false;
        end;
    });

    target_hud_box:AddDropdown('target_hud_method', {
        Values = {"silent aim", "aimbot"},
        Default = "",
        Multi = false,
        Text = 'target method',
        Callback = function(v)
            ELI.target_hud.target_method = v;
        end;
    });

    target_hud_box:AddDropdown('target_hud_position', {
        Values = {"static", "center", "gunpoint", "target"},
        Default = "static",
        Multi = false,
        Text = 'position',
        Callback = function(v)
            ELI.target_hud.position_mode = v;
        end;
    });

    target_hud_box:AddSlider('target_hud_offset_x', {
        Text = 'offset x',
        Default = 0,
        Min = -500,
        Max = 500,
        Rounding = 0,
        Callback = function(v)
            ELI.target_hud.offset_x = v;
        end;
    });

    target_hud_box:AddSlider('target_hud_offset_y', {
        Text = 'offset y',
        Default = 0,
        Min = -500,
        Max = 500,
        Rounding = 0,
        Callback = function(v)
            ELI.target_hud.offset_y = v;
        end;
    });

    target_hud_box:AddSlider('target_hud_scale', {
        Text = 'size',
        Default = 1,
        Min = 0.5,
        Max = 2.5,
        Rounding = 2,
        Callback = function(v)
            ELI.target_hud.scale = v;
        end;
    });

end;

local disable_anims_tab = visuals_tab:AddLeftGroupbox('disable animation', 'pause'); do
    disable_anims_tab:AddToggle('disable_anims_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.disable_anims.enable = v;
        end;
    });

    disable_anims_tab:AddDropdown('disable_anims_select', {
        Values = {"bobbing", "landing", "sway", "equip", "inspect", "sliding", "shoot", "impulse", "aim", "sprint", "attack", "charge", "reload", "throw"},
        Default = {},
        Multi = true,
        Text = 'types',
        Callback = function(v)
            local converted = {};
            for k, val in next, v do
                converted[#converted + 1] = type(k) == "number" and val or k;
            end;
            ELI.disable_anims.select = converted;
        end;
    });
end;

local motion_blur_tab = visuals_tab:AddLeftGroupbox('motion blur', 'wind'); do
    motion_blur_tab:AddToggle('motion_blur_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.motion_blur.enable = v;
        end;
    });

    motion_blur_tab:AddSlider('motion_blur_intensity', {
        Text = 'intensity',
        Default = 0.5,
        Min = 0,
        Max = 1,
        Rounding = 2,
        Callback = function(v)
            ELI.motion_blur.intensity = v;
        end;
    });

    motion_blur_tab:AddSlider('motion_blur_sensitivity', {
        Text = 'sensitivity',
        Default = 1,
        Min = 0.1,
        Max = 3,
        Rounding = 2,
        Callback = function(v)
            ELI.motion_blur.sensitivity = v;
        end;
    });
end

do
    local function spawnDeathEffect(pos)
        local cfg = ELI.death_effects;
        pcall(function()
            if cfg.type == "Explosion" then
                local e = Instance.new("Explosion");
                e.Position = pos;
                e.BlastRadius = 0;
                e.BlastPressure = 0;
                e.DestroyJointRadiusPercent = 0;
                e.Parent = workspace;
                return
            end;

            local part = Instance.new("Part");
            part.Anchored = true;
            part.CanCollide = false;
            part.CanQuery = false;
            part.CanTouch = false;
            part.Transparency = 1;
            part.Size = Vector3.new(1, 1, 1);
            part.CFrame = CFrame.new(pos);
            part.Parent = workspace;

            local att = Instance.new("Attachment");
            att.Parent = part;

            local emitter = Instance.new("ParticleEmitter");
            emitter.Color = ColorSequence.new(cfg.color);
            emitter.Lifetime = NumberRange.new(0.4, 0.9);
            emitter.Speed = NumberRange.new(12, 28);
            emitter.Rate = 0;
            emitter.SpreadAngle = Vector2.new(180, 180);
            emitter.Rotation = NumberRange.new(0, 360);
            emitter.Size = NumberSequence.new(1.5);
            if cfg.type == "Fire" then
                emitter.Texture = "rbxasset://textures/particles/fire_main.dds";
            elseif cfg.type == "Sparkles" then
                emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
                emitter.LightEmission = 1;
            else
                emitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
                emitter.LightEmission = 1;
            end;
            emitter.Parent = att;
            emitter:Emit(45);

            task.delay(1.3, function()
                pcall(function() part:Destroy() end);
            end);
        end);
    end;

    local function hookDeath(plr)
        plr.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid", 6);
            if not hum then return end;
            hum.Died:Connect(function()
                if not ELI.death_effects.enable then return end;
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head");
                if root then
                    spawnDeathEffect(root.Position);
                end;
            end);
        end);
    end;

    for _, plr in eli_ipairs(players:GetPlayers()) do
        hookDeath(plr);
    end;
    players.PlayerAdded:Connect(hookDeath);

    local death_tab = visuals_tab:AddLeftGroupbox('death effects', 'skull');
    death_tab:AddToggle('death_effects_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.death_effects.enable = v;
        end
    }):AddColorPicker('death_effects_color', {
        Title = 'color',
        Default = Color3.fromRGB(255, 40, 40),
        Callback = function(v)
            ELI.death_effects.color = v;
        end
    });
    death_tab:AddDropdown('death_effects_type', {
        Text = 'effect',
        Default = 'Explosion',
        Values = { 'Explosion', 'Fire', 'Sparkles', 'Neon Burst' },
        Callback = function(v)
            ELI.death_effects.type = v;
        end
    });

    local dmg_tab = visuals_tab:AddRightGroupbox('damage numbers', 'hash');
    dmg_tab:AddToggle('damage_numbers_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.damage_numbers.enable = v;
        end
    }):AddColorPicker('damage_numbers_color1', {
        Title = 'color 1',
        Default = Color3.fromRGB(255, 80, 80),
        Callback = function(v)
            ELI.damage_numbers.color1 = v;
        end
    }):AddColorPicker('damage_numbers_color2', {
        Title = 'color 2',
        Default = Color3.fromRGB(255, 210, 90),
        Callback = function(v)
            ELI.damage_numbers.color2 = v;
        end
    });
    dmg_tab:AddToggle('damage_numbers_remove_ingame', {
        Text = 'remove in game damage numbers',
        Default = false,
        Callback = function(v)
            ELI.damage_numbers.remove_ingame = v;
        end
    });
    dmg_tab:AddDropdown('damage_numbers_color_type', {
        Text = 'color type',
        Default = 'Gradient',
        Values = { 'Gradient', 'Solid', 'Rainbow' },
        Callback = function(v)
            ELI.damage_numbers.color_type = v;
        end
    });
    dmg_tab:AddDropdown('damage_numbers_font', {
        Text = 'font',
        Default = 'GothamBold',
        Values = {
            'GothamBold', 'GothamBlack', 'GothamMedium', 'Gotham',
            'SourceSansBold', 'SourceSansSemibold', 'Code', 'RobotoMono', 'RobotoCondensed',
            'Fantasy', 'Arcade', 'SciFi', 'Cartoon', 'Antique', 'Highway',
            'Bangers', 'Michroma', 'LuckiestGuy', 'PermanentMarker', 'Creepster',
            'FredokaOne', 'DenkOne', 'GrenzeGotisch', 'SpecialElite', 'Oswald',
            'Sarpanch', 'TitilliumWeb', 'Ubuntu', 'JosefinSans', 'Jura',
            'Kalam', 'IndieFlower', 'PatrickHand', 'AmaticSC', 'Merriweather',
            'Nunito', 'Fondamento', 'Bodoni', 'Garamond', 'BuilderSansExtraBold',
        },
        Callback = function(v)
            ELI.damage_numbers.font = v;
        end
    });
    dmg_tab:AddSlider('damage_numbers_text_size', {
        Text = 'text size',
        Default = 18,
        Min = 10,
        Max = 40,
        Rounding = 0,
        Callback = function(v)
            ELI.damage_numbers.text_size = v;
        end
    });
    dmg_tab:AddSlider('damage_numbers_rise', {
        Text = 'rise',
        Default = 42,
        Min = 0,
        Max = 120,
        Rounding = 0,
        Callback = function(v)
            ELI.damage_numbers.rise = v;
        end
    });
    dmg_tab:AddSlider('damage_numbers_duration', {
        Text = 'duration',
        Default = 0.8,
        Min = 0.2,
        Max = 3,
        Rounding = 2,
        Suffix = 's',
        Callback = function(v)
            ELI.damage_numbers.duration = v;
        end
    });

    local traj_tab = visuals_tab:AddLeftGroupbox('trajectory', 'trending-up');
    traj_tab:AddToggle('trajectory_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.trajectory.enable = v;
        end
    }):AddColorPicker('trajectory_color', {
        Title = 'color',
        Default = Color3.fromRGB(255, 40, 40),
        Callback = function(v)
            ELI.trajectory.color = v;
        end
    });
    traj_tab:AddToggle('trajectory_all_weapons', {
        Text = 'all weapons',
        Default = false,
        Callback = function(v)
            ELI.trajectory.all_weapons = v;
        end
    });
    traj_tab:AddSlider('trajectory_speed', {
        Text = 'throw speed',
        Default = 90,
        Min = 20,
        Max = 300,
        Rounding = 0,
        Callback = function(v)
            ELI.trajectory.speed = v;
        end
    });
    traj_tab:AddSlider('trajectory_arc_up', {
        Text = 'arc height',
        Default = 10,
        Min = 0,
        Max = 60,
        Rounding = 0,
        Callback = function(v)
            ELI.trajectory.arc_up = v;
        end
    });
end;

local viewmodel_custom_box = visuals_tab:AddLeftTabbox(); do
    local base_material_names = { "ForceField", "Neon", "Plastic", "SmoothPlastic", "Wood", "WoodPlanks", "Marble", "Slate" };

    local vmc_main = viewmodel_custom_box:AddTab('viewmodel'); do
        vmc_main:AddToggle('vmc_enable', {
            Text = 'enabled',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.enable = v;
            end;
        });
    end;

    local vmc_body = viewmodel_custom_box:AddTab('body'); do
        vmc_body:AddToggle('vmc_appearance', {
            Text = 'viewmodel appearance',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.appearance = v;
            end;
        });

        vmc_body:AddToggle('vmc_body_color', {
            Text = 'color',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.body.color_enable = v;
            end;
        }):AddColorPicker('vmc_body_color_pick', {
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                ELI.viewmodel_custom.body.color = v;
            end;
        });

        vmc_body:AddToggle('vmc_body_material', {
            Text = 'material',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.body.material_enable = v;
                Options.vmc_body_material_type:SetVisible(v);
            end;
        });

        vmc_body:AddDropdown('vmc_body_material_type', {
            Text = 'material',
            Values = base_material_names,
            Default = 'ForceField',
            Visible = false,
            Callback = function(v)
                ELI.viewmodel_custom.body.material = v;
            end;
        });

        vmc_body:AddToggle('vmc_body_disable_clothes', {
            Text = 'disable clothes',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.body.disable_clothes = v;
            end;
        });

        vmc_body:AddSlider('vmc_body_transparency', {
            Text = 'transparency',
            Default = 0,
            Min = 0,
            Max = 100,
            Rounding = 0,
            Suffix = '%',
            Callback = function(v)
                ELI.viewmodel_custom.body.transparency = v;
            end;
        });
    end;

    local vmc_item = viewmodel_custom_box:AddTab('item'); do
        vmc_item:AddToggle('vmc_item_color', {
            Text = 'color',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.item.color_enable = v;
            end;
        }):AddColorPicker('vmc_item_color_pick', {
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                ELI.viewmodel_custom.item.color = v;
            end;
        });

        vmc_item:AddToggle('vmc_item_material', {
            Text = 'material',
            Default = false,
            Callback = function(v)
                ELI.viewmodel_custom.item.material_enable = v;
                Options.vmc_item_material_type:SetVisible(v);
            end;
        });

        vmc_item:AddDropdown('vmc_item_material_type', {
            Text = 'material',
            Values = base_material_names,
            Default = 'ForceField',
            Visible = false,
            Callback = function(v)
                ELI.viewmodel_custom.item.material = v;
            end;
        });

        vmc_item:AddSlider('vmc_item_transparency', {
            Text = 'transparency',
            Default = 0,
            Min = 0,
            Max = 100,
            Rounding = 0,
            Suffix = '%',
            Callback = function(v)
                ELI.viewmodel_custom.item.transparency = v;
            end;
        });
    end;
end;

    local sound_tabs = Tabs.visualstab:AddRightTabbox(); do
        local custom_hitsounds_tab = sound_tabs:AddTab('hitsounds'); do
            custom_hitsounds_tab:AddToggle('hitsound_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.custom_hitsounds.enable = v;
                end;
            });

            custom_hitsounds_tab:AddToggle('disable_default_hitsound_enable', {
                Text = 'disable ingame hitsound',
                Default = false,
                Callback = function(v)
                    ELI.custom_hitsounds.remove_default_hitsound = v;
                end;
            });

            custom_hitsounds_tab:AddDropdown('hitsound_selected', {
                Values = {"windows xp", "minecraft bow", "neverlose", "steve", "among us", "bonk", "rust", "fatality", "hitmarker", "csgo", "minecraft success bow hit",
                'gamesense',},
                Default = "",
                Text = 'types',
                Callback = function(v)
                    ELI.custom_hitsounds.selected = v;
                end;
            });
            custom_hitsounds_tab:AddSlider('hitsound_volume', {
                Text = 'volume',
                Default = 3,
                Min = 0,
                Max = 5,
                Rounding = 1,
                Visible = true,
                Callback = function(v)
                    ELI.custom_hitsounds.volume = v;
                end;
            });
            custom_hitsounds_tab:AddSlider('hitsound_pitch', {
                Text = 'pitch',
                Default = 1,
                Min = 0.5,
                Max = 1.5,
                Rounding = 1,
                Visible = true,
                Callback = function(v)
                    ELI.custom_hitsounds.pitch = v;
                end;
            });
        end;
    end;

    local notify_hit_tab = Tabs.visualstab:AddRightGroupbox('hit notify', 'bell'); do
        notify_hit_tab:AddToggle('hit_notify_enable', {
            Text = 'enable',
            Default = false,
            Callback = function(v)
                ELI.hit_notify.enable = v;
            end;
        });

        notify_hit_tab:AddSlider('hit_notify_duration', {
            Text = 'duration',
            Default = 3,
            Min = 1,
            Max = 5,
            Rounding = 1,
            Suffix = 's',
            Visible = true,
            Callback = function(v)
                ELI.hit_notify.duration = v;
            end;
        });

        notify_hit_tab:AddInput('hit_notify_msg', {
            Text = 'message',
            Default = ELI.hit_notify.msg,
            ClearTextOnFocus = false,
            Callback = function(v)
                ELI.hit_notify.msg = v;
            end
        });

        notify_hit_tab:AddDivider();

        notify_hit_tab:AddLabel('hit_notify_formatting', {
            Text = "available formats:"
        });

        notify_hit_tab:AddLabel('hit_notify_formatting', {
            Text = "{target}, {damage}, {hitpart}",
            DoesWrap = true,
        });
    end;
end;

local world_tab = Tabs.worldtab; do
    local world_main_tab = world_tab:AddLeftTabbox(); do
        local color_correction_tab = world_main_tab:AddTab('color correction'); do
            color_correction_tab:AddToggle('world_fog', {
                Text = 'fog',
                Default = false,
                Callback = function(v)
                    ELI.world.fog = v;
                    if not v then
                        lighting.FogColor = world.fog_color;
                        lighting.FogStart = world.fog_start;
                        lighting.FogEnd = world.fog_end;
                    end;
                end
            }):AddColorPicker('fog_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.fog_color = v;
                end
            });

            color_correction_tab:AddSlider('fog_start', {
                Text = 'fog start',
                Default = 150,
                Min = 0,
                Max = 10000,
                Rounding = 0,
                Callback = function(v)
                    ELI.world.fog_start = v;
                end
            });

            color_correction_tab:AddSlider('fog_end', {
                Text = 'fog end',
                Default = 550,
                Min = 0,
                Max = 10000,
                Rounding = 0,
                Callback = function(v)
                    ELI.world.fog_end = v;
                end
            });

            color_correction_tab:AddDivider();

            color_correction_tab:AddToggle('world_ambient', {
                Text = 'ambient',
                Default = false,
                Callback = function(v)
                    ELI.world.ambient = v;
                    if not v then
                        lighting.Ambient = world.ambient;
                    end;
                end
            }):AddColorPicker('ambient_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.ambient_color = v;
                end
            });

            color_correction_tab:AddToggle('world_clock', {
                Text = 'clock time',
                Default = false,
                Callback = function(v)
                    ELI.world.clock = v;
                    if not v then
                        lighting.ClockTime = world.clock_time;
                    end;
                end
            });

            color_correction_tab:AddSlider('clock_time', {
                Text = 'time',
                Default = 14,
                Min = 0,
                Max = 24,
                Rounding = 1,
                Callback = function(v)
                    ELI.world.clock_time = v;
                end
            });

            color_correction_tab:AddToggle('world_brightness', {
                Text = 'brightness',
                Default = false,
                Callback = function(v)
                    ELI.world.brightness = v;
                    if not v then
                        lighting.Brightness = world.brightness;
                    end;
                end
            });

            color_correction_tab:AddSlider('brightness_level', {
                Text = 'level',
                Default = 1,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Callback = function(v)
                    ELI.world.brightness_level = v;
                end
            });

            color_correction_tab:AddToggle('world_exposure', {
                Text = 'exposure',
                Default = false,
                Callback = function(v)
                    ELI.world.exposure = v;
                    if not v then
                        lighting.ExposureCompensation = world.exposure;
                    end;
                end
            });

            color_correction_tab:AddSlider('exposure_level', {
                Text = 'compensation',
                Default = 0,
                Min = -10,
                Max = 10,
                Rounding = 1,
                Callback = function(v)
                    ELI.world.exposure_level = v;
                end
            });

            color_correction_tab:AddToggle('world_color_shift_top', {
                Text = 'color shift top',
                Default = false,
                Callback = function(v)
                    ELI.world.color_shift_top = v;
                    if not v then
                        lighting.ColorShift_Top = world.color_shift_top;
                    end;
                end
            }):AddColorPicker('color_shift_top_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.color_shift_top_color = v;
                end
            });

            color_correction_tab:AddToggle('world_color_shift_bottom', {
                Text = 'color shift bottom',
                Default = false,
                Callback = function(v)
                    ELI.world.color_shift_bottom = v;
                    if not v then
                        lighting.ColorShift_Bottom = world.color_shift_bottom;
                    end;
                end
            }):AddColorPicker('color_shift_bottom_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.color_shift_bottom_color = v;
                end
            });

            color_correction_tab:AddDivider();

            color_correction_tab:AddToggle('world_skybox', {
                Text = 'skybox',
                Default = false,
                Callback = function(v)
                    ELI.world.skybox = v;
                    skybox_changer:update_skybox();
                end
            });

            color_correction_tab:AddDropdown('world_skybox_selected', {
                Values = skybox_changer.elements,
                Default = 'Deep Space',
                Multi = false,
                Text = 'selected',
                Callback = function(v)
                    ELI.world.skybox_selected = v;
                    skybox_changer:update_skybox();
                end;
            });

            color_correction_tab:AddToggle('world_skybox_rotate', {
                Text = 'skybox rotator',
                Default = false,
                Callback = function(v)
                    ELI.world.skybox_rotate = v;
                end
            });

            color_correction_tab:AddSlider('world_skybox_rotate_speed', {
                Text = 'rotation speed',
                Default = 1,
                Min = 0,
                Max = 100,
                Rounding = 1,
                Callback = function(v)
                    ELI.world.skybox_rotate_speed = v;
                end
            });

            color_correction_tab:AddDropdown('world_skybox_rotate_direction', {
                Text = "direction",
                Values = {'Horizontal', 'Vertical', 'Diagonal'},
                Default = "Horizontal",
                Callback = function(v)
                    ELI.world.skybox_rotate_direction = v;
                end;
            });

            color_correction_tab:AddDropdown('world_skybox_rotate_method', {
                Text = "method",
                Values = {'Spin', 'Wave', 'Alternate'},
                Default = "Spin",
                Callback = function(v)
                    ELI.world.skybox_rotate_method = v;
                end;
            });

            color_correction_tab:AddDivider();

            color_correction_tab:AddToggle('world_skybox_remove_sun', {
                Text = 'remove sun',
                Default = false,
                Callback = function(v)
                    ELI.world.skybox_remove_sun = v;
                    skybox_changer:update_skybox();
                end
            });

            color_correction_tab:AddToggle('world_skybox_remove_moon', {
                Text = 'remove moon',
                Default = false,
                Callback = function(v)
                    ELI.world.skybox_remove_moon = v;
                    skybox_changer:update_skybox();
                end
            });

            color_correction_tab:AddToggle('world_skybox_remove_stars', {
                Text = 'remove stars',
                Default = false,
                Callback = function(v)
                    ELI.world.skybox_remove_stars = v;
                    skybox_changer:update_skybox();
                end
            });
        end;

        local weather_tab = world_tab:AddRightGroupbox('weather', 'cloud-rain'); do
            weather_tab:AddToggle('weather_enabled', {
                Text = "enable",
                Default = false,
                Callback = function(v)
                    ELI.weather.enable = v;
                end;
            }):AddColorPicker('weather_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.weather.color = v;
                end;
            });

            weather_tab:AddDropdown('weather_type', {
                Text = "type",
                Values = {'snow', 'rain', 'light rain'},
                Default = "snow",
                Callback = function(v)
                    ELI.weather.type = v;
                end;
            });

            weather_tab:AddSlider('weather_rate', {
                Text = 'rate',
                Default = 100,
                Min = 100,
                Max = 300,
                Rounding = 0,
                Callback = function(v)
                    ELI.weather.rate = v;
                end;
            });
        end;

        local atmosphere_tab = world_main_tab:AddTab('atmosphere'); do
            atmosphere_tab:AddToggle('world_atmosphere', {
                Text = 'atmosphere',
                Default = false,
                Callback = function(v)
                    ELI.world.atmosphere = v;
                    atmosphere_changer:update_atmosphere();
                end
            }):AddColorPicker('world_atmosphere_color', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.atmosphere_color = v;
                    atmosphere_changer:update_atmosphere();
                end
            }):AddColorPicker('world_atmosphere_decay', {
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(v)
                    ELI.world.atmosphere_decay = v;
                    atmosphere_changer:update_atmosphere();
                end
            });

            for _, property in next, atmosphere_changer.properties_list do
                atmosphere_tab:AddSlider('world_atmosphere_' .. property, {
                    Text = property,
                    Default = atmosphere_changer.properties[property],
                    Min = 0,
                    Max = property == 'density' and 1 or property == 'offset' and 1 or 10,
                    Rounding = 2,
                    Callback = function(v)
                        ELI.world['atmosphere_' .. property] = v;
                        atmosphere_changer:update_atmosphere();
                    end
                });
            end;
        end;
    end;

    local removals_tab = world_tab:AddRightGroupbox('world removals', 'eraser'); do

        removals_tab:AddToggle('anti_flashbang_enable', {
            Text = 'anti flashbang',
            Default = false,
            Callback = function(v)
                    if v then
                        flash1 = workspace.ChildAdded:Connect(function(v)
                            if v.Name == "FlashbangEffect" then
                                v:Destroy();
                            end;
                        end);
                        flash2 = local_player.PlayerGui.ChildAdded:Connect(function(v)
                            if v.Name == "FlashbangGui" then
                                v:Destroy();
                            end;
                        end);
                    else
                        if flash1 then flash1:Disconnect() end;
                        if flash2 then flash2:Disconnect() end;
                    end;
            end;
        });
    end;

    local texture_connection = nil;
    local texture_originals = {};
    local minecraft_textures = {};
    local minecraft_faces = {'Front', 'Back', 'Bottom', 'Top', 'Right', 'Left'};
    local minecraft_ids = {
        [Enum.Material.Wood] = '3258599312',
        [Enum.Material.WoodPlanks] = '8676581022',
        [Enum.Material.Brick] = '8558400252',
        [Enum.Material.Cobblestone] = '5003953441',
        [Enum.Material.Concrete] = '7341687607',
        [Enum.Material.DiamondPlate] = '6849247561',
        [Enum.Material.Fabric] = '118776397',
        [Enum.Material.Granite] = '4722586771',
        [Enum.Material.Grass] = '4722588177',
        [Enum.Material.Ice] = '3823766459',
        [Enum.Material.Marble] = '62967586',
        [Enum.Material.Metal] = '62967586',
        [Enum.Material.Sand] = '152572215',
    };

    local material_lookup = {};
    for _, material in eli_pairs(Enum.Material:GetEnumItems()) do
        material_lookup[string.lower(material.Name)] = material;
    end;

    local function resolve_material(name)
        return material_lookup[string.lower((name:gsub('%s+', '')))];
    end;

    local function is_texture_excluded(part)
        if ELI.textures.apply_to_viewmodel then
            return false;
        end;
        local node = part;
        while node and node ~= workspace do
            if node:IsA("Model") and node:FindFirstChildOfClass("Humanoid") then
                return true;
            end;
            node = node.Parent;
        end;
        local viewmodels = workspace:FindFirstChild("ViewModels");
        if viewmodels and part:IsDescendantOf(viewmodels) then
            return true;
        end;
        if camera and part:IsDescendantOf(camera) then
            return true;
        end;
        return false;
    end;

    local function clear_minecraft_texture(part)
        if minecraft_textures[part] then
            for _, tex in eli_pairs(minecraft_textures[part]) do
                if tex and tex.Parent then
                    tex:Destroy();
                end;
            end;
            minecraft_textures[part] = nil;
        end;
    end;

    local function apply_minecraft_texture(part, texture_id)
        clear_minecraft_texture(part);
        minecraft_textures[part] = {};
        for _, face_name in eli_pairs(minecraft_faces) do
            local texture = Instance.new('Texture');
            texture.Texture = 'rbxassetid://' .. texture_id;
            texture.Face = Enum.NormalId[face_name];
            texture.Color3 = part.Color;
            texture.Transparency = part.Transparency;
            texture.StudsPerTileU = 3;
            texture.StudsPerTileV = 3;
            texture.Parent = part;
            table.insert(minecraft_textures[part], texture);
        end;
    end;

    local function apply_texture(part)
        if not part:IsA('BasePart') then
            return
        end;
        if is_texture_excluded(part) then
            return
        end;
        if not texture_originals[part] then
            texture_originals[part] = {
                Material = part.Material,
                Color = part.Color,
            };
        end;
        local config = ELI.textures;
        part.Color = config.color;
        if config.material == 'Minecraft' then
            local source = texture_originals[part].Material;
            local id = minecraft_ids[source] or '5003953441';
            apply_minecraft_texture(part, id);
        else
            clear_minecraft_texture(part);
            local material = resolve_material(config.material);
            if material then
                part.Material = material;
            end;
        end;
    end;

    local function applyToExisting()
        for part in eli_pairs(texture_originals) do
            if part and part.Parent then
                apply_texture(part);
            end;
        end;
    end;

    local function enableTextures()
        for _, part in eli_pairs(workspace:GetDescendants()) do
            apply_texture(part);
        end;
        if texture_connection then
            texture_connection:Disconnect();
        end;
        texture_connection = workspace.DescendantAdded:Connect(function(part)
            if ELI.textures.enable then
                task.defer(apply_texture, part);
            end;
        end);
        trove:Add(texture_connection);
    end;

    local function disableTextures()
        if texture_connection then
            texture_connection:Disconnect();
            texture_connection = nil;
        end;
        for part, props in eli_pairs(texture_originals) do
            if part and part.Parent then
                pcall(function()
                    part.Material = props.Material;
                    part.Color = props.Color;
                end);
            end;
        end;
        for part in eli_pairs(minecraft_textures) do
            clear_minecraft_texture(part);
        end;
        table.clear(texture_originals);
    end;

    local textures_tab = world_tab:AddLeftGroupbox('world textures', 'image'); do
        textures_tab:AddToggle('textures_enable', {
            Text = 'enable',
            Default = false,
            Callback = function(v)
                ELI.textures.enable = v;
                if v then
                    enableTextures();
                else
                    disableTextures();
                end;
            end
        });

        textures_tab:AddDropdown('textures_material', {
            Values = {'Air', 'Asphalt', 'Basalt', 'Brick', 'Cardboard', 'Carpet', 'Ceramic Tiles', 'Clay Roof Tiles', 'Cobblestone', 'Concrete', 'Corroded Metal', 'Cracked Lava', 'Diamond Plate', 'Fabric', 'Foil', 'Forcefield', 'Glacier', 'Glass', 'Granite', 'Grass', 'Ground', 'Ice', 'Leafy Grass', 'Leather', 'Limestone', 'Marble', 'Metal', 'Minecraft', 'Mud', 'Neon', 'Pavement', 'Pebble', 'Plaster', 'Plastic', 'Rock', 'Roof Shingles', 'Rubber', 'Salt', 'Sand', 'Sandstone', 'Slate', 'Smooth Plastic', 'Snow', 'Water', 'Wood', 'Wood Planks'},
            Default = 'Brick',
            Multi = false,
            Text = 'material',
            Callback = function(v)
                ELI.textures.material = v;
                if ELI.textures.enable then
                    applyToExisting();
                end;
            end
        });

        textures_tab:AddLabel('texture color'):AddColorPicker('textures_color', {
            Default = Color3.fromRGB(244, 244, 244),
            Callback = function(v)
                ELI.textures.color = v;
                if ELI.textures.enable then
                    applyToExisting();
                end;
            end
        });

        textures_tab:AddToggle('textures_apply_to_viewmodel', {
            Text = 'apply to viewmodel',
            Default = false,
            Callback = function(v)
                ELI.textures.apply_to_viewmodel = v;
                if ELI.textures.enable then
                    disableTextures();
                    enableTextures();
                end;
            end
        });
    end;

    local shader_blur = Instance.new('BlurEffect');
    shader_blur.Name = 'ZRHUB_blur';
    shader_blur.Enabled = false;
    shader_blur.Size = 12;
    shader_blur.Parent = lighting;
    trove:Add(shader_blur);

    local shader_bloom = Instance.new('BloomEffect');
    shader_bloom.Name = 'ZRHUB_bloom';
    shader_bloom.Enabled = false;
    shader_bloom.Intensity = 1;
    shader_bloom.Size = 24;
    shader_bloom.Threshold = 0.9;
    shader_bloom.Parent = lighting;
    trove:Add(shader_bloom);

    local shader_dof = Instance.new('DepthOfFieldEffect');
    shader_dof.Name = 'ZRHUB_dof';
    shader_dof.Enabled = false;
    shader_dof.FocusDistance = 25;
    shader_dof.InFocusRadius = 10;
    shader_dof.NearIntensity = 0.15;
    shader_dof.FarIntensity = 0.15;
    shader_dof.Parent = lighting;
    trove:Add(shader_dof);

    local shader_sunrays = Instance.new('SunRaysEffect');
    shader_sunrays.Name = 'ZRHUB_sunrays';
    shader_sunrays.Enabled = false;
    shader_sunrays.Intensity = 0.25;
    shader_sunrays.Spread = 1;
    shader_sunrays.Parent = lighting;
    trove:Add(shader_sunrays);

    local shader_cc = Instance.new('ColorCorrectionEffect');
    shader_cc.Name = 'ZRHUB_cc';
    shader_cc.Enabled = false;
    shader_cc.Saturation = 0;
    shader_cc.Contrast = 0;
    shader_cc.TintColor = Color3.fromRGB(255, 255, 255);
    shader_cc.Parent = lighting;
    trove:Add(shader_cc);

    local shaders_tab = world_tab:AddLeftGroupbox('shaders', 'sparkles'); do
        shaders_tab:AddToggle('shader_blur', {
            Text = 'blur',
            Default = false,
            Callback = function(v)
                ELI.world.blur = v;
                shader_blur.Enabled = v;
            end
        });

        shaders_tab:AddSlider('shader_blur_size', {
            Text = 'blur size',
            Default = 12,
            Min = 0,
            Max = 56,
            Rounding = 0,
            Callback = function(v)
                ELI.world.blur_size = v;
                shader_blur.Size = v;
            end
        });

        shaders_tab:AddToggle('shader_bloom', {
            Text = 'bloom',
            Default = false,
            Callback = function(v)
                ELI.world.bloom = v;
                shader_bloom.Enabled = v;
            end
        });

        shaders_tab:AddSlider('shader_bloom_intensity', {
            Text = 'bloom intensity',
            Default = 1,
            Min = 0,
            Max = 5,
            Rounding = 2,
            Callback = function(v)
                ELI.world.bloom_intensity = v;
                shader_bloom.Intensity = v;
            end
        });

        shaders_tab:AddSlider('shader_bloom_size', {
            Text = 'bloom size',
            Default = 24,
            Min = 0,
            Max = 56,
            Rounding = 0,
            Callback = function(v)
                ELI.world.bloom_size = v;
                shader_bloom.Size = v;
            end
        });

        shaders_tab:AddSlider('shader_bloom_threshold', {
            Text = 'bloom threshold',
            Default = 0.9,
            Min = 0,
            Max = 2,
            Rounding = 2,
            Callback = function(v)
                ELI.world.bloom_threshold = v;
                shader_bloom.Threshold = v;
            end
        });

        shaders_tab:AddToggle('shader_dof', {
            Text = 'depth of field',
            Default = false,
            Callback = function(v)
                ELI.world.depth_of_field = v;
                shader_dof.Enabled = v;
            end
        });

        shaders_tab:AddSlider('shader_dof_focus', {
            Text = 'focus distance',
            Default = 25,
            Min = 0,
            Max = 500,
            Rounding = 0,
            Callback = function(v)
                ELI.world.dof_focus = v;
                shader_dof.FocusDistance = v;
            end
        });

        shaders_tab:AddSlider('shader_dof_intensity', {
            Text = 'blur intensity',
            Default = 0.15,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.dof_intensity = v;
                shader_dof.NearIntensity = v;
                shader_dof.FarIntensity = v;
            end
        });

        shaders_tab:AddToggle('shader_sun_rays', {
            Text = 'sun rays',
            Default = false,
            Callback = function(v)
                ELI.world.sun_rays = v;
                shader_sunrays.Enabled = v;
            end
        });

        shaders_tab:AddSlider('shader_sun_rays_intensity', {
            Text = 'rays intensity',
            Default = 0.25,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.sun_rays_intensity = v;
                shader_sunrays.Intensity = v;
            end
        });

        shaders_tab:AddSlider('shader_sun_rays_spread', {
            Text = 'rays spread',
            Default = 1,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.sun_rays_spread = v;
                shader_sunrays.Spread = v;
            end
        });

        shaders_tab:AddToggle('shader_saturation', {
            Text = 'color grading',
            Default = false,
            Callback = function(v)
                ELI.world.saturation = v;
                shader_cc.Enabled = v;
            end
        }):AddColorPicker('shader_tint', {
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                ELI.world.tint_color = v;
                shader_cc.TintColor = v;
            end
        });

        shaders_tab:AddSlider('shader_saturation_level', {
            Text = 'saturation',
            Default = 0,
            Min = -1,
            Max = 5,
            Rounding = 2,
            Callback = function(v)
                ELI.world.saturation_level = v;
                shader_cc.Saturation = v;
            end
        });

        shaders_tab:AddSlider('shader_contrast_level', {
            Text = 'contrast',
            Default = 0,
            Min = -1,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.contrast_level = v;
                shader_cc.Contrast = v;
            end
        });
    end;

    local quality_tab = world_tab:AddLeftGroupbox('quality', 'sliders-horizontal'); do
        local default_technology = lighting.Technology;
        local default_global_shadows = lighting.GlobalShadows;
        local default_env_diffuse = lighting.EnvironmentDiffuseScale;
        local default_env_specular = lighting.EnvironmentSpecularScale;
        local default_outdoor_ambient = lighting.OutdoorAmbient;

        quality_tab:AddDropdown('world_lighting_technology_mode', {
            Text = 'lighting technology',
            Values = { 'Legacy', 'Voxel', 'ShadowMap', 'Future' },
            Default = 'Future',
            Callback = function(v)
                ELI.world.lighting_technology_mode = v;
                if ELI.world.lighting_technology then
                    pcall(function()
                        lighting.Technology = Enum.Technology[v];
                    end);
                end;
            end
        });

        quality_tab:AddToggle('world_lighting_technology', {
            Text = 'apply lighting technology',
            Default = false,
            Callback = function(v)
                ELI.world.lighting_technology = v;
                pcall(function()
                    if v then
                        lighting.Technology = Enum.Technology[ELI.world.lighting_technology_mode];
                    else
                        lighting.Technology = default_technology;
                    end;
                end);
            end
        });

        quality_tab:AddToggle('world_global_shadows', {
            Text = 'global shadows',
            Default = true,
            Callback = function(v)
                ELI.world.global_shadows = v;
                pcall(function()
                    lighting.GlobalShadows = v;
                end);
            end
        });

        quality_tab:AddToggle('world_env_diffuse', {
            Text = 'environment diffuse',
            Default = false,
            Callback = function(v)
                ELI.world.env_diffuse = v;
                pcall(function()
                    lighting.EnvironmentDiffuseScale = v and ELI.world.env_diffuse_scale or default_env_diffuse;
                end);
            end
        });

        quality_tab:AddSlider('world_env_diffuse_scale', {
            Text = 'diffuse scale',
            Default = 1,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.env_diffuse_scale = v;
                if ELI.world.env_diffuse then
                    pcall(function()
                        lighting.EnvironmentDiffuseScale = v;
                    end);
                end;
            end
        });

        quality_tab:AddToggle('world_env_specular', {
            Text = 'environment specular',
            Default = false,
            Callback = function(v)
                ELI.world.env_specular = v;
                pcall(function()
                    lighting.EnvironmentSpecularScale = v and ELI.world.env_specular_scale or default_env_specular;
                end);
            end
        });

        quality_tab:AddSlider('world_env_specular_scale', {
            Text = 'specular scale',
            Default = 1,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.world.env_specular_scale = v;
                if ELI.world.env_specular then
                    pcall(function()
                        lighting.EnvironmentSpecularScale = v;
                    end);
                end;
            end
        });

        quality_tab:AddToggle('world_outdoor_ambient', {
            Text = 'outdoor ambient',
            Default = false,
            Callback = function(v)
                ELI.world.outdoor_ambient = v;
                pcall(function()
                    lighting.OutdoorAmbient = v and ELI.world.outdoor_ambient_color or default_outdoor_ambient;
                end);
            end
        }):AddColorPicker('world_outdoor_ambient_color', {
            Default = Color3.fromRGB(70, 70, 70),
            Callback = function(v)
                ELI.world.outdoor_ambient_color = v;
                if ELI.world.outdoor_ambient then
                    pcall(function()
                        lighting.OutdoorAmbient = v;
                    end);
                end;
            end
        });
    end;

local camera_tab = world_tab:AddRightGroupbox('camera', 'camera'); do
    local keybind_third_person_enable = false;
    camera_tab:AddToggle('third_person_enable', {
        Text = 'third person',
        Default = false,
        Callback = function(v)
            keybind_third_person_enable = v;
            ELI.third_person.enable = v;
            camera_controller:SetThirdPersonOverride(v);
        end;
    }):AddKeyPicker('third_person_keybind', {
        Default = '...',
        Text = 'third person',
        NoUI = false,
        EnableCheck = function()
            return ELI.third_person.enable;
        end,
        Callback = function(v)
            ELI.third_person.enable = keybind_third_person_enable and v or false;
            camera_controller:SetThirdPersonOverride(ELI.third_person.enable);
        end;
    });
    local old_camera_stretched_res = camera.CFrame;
    camera_tab:AddToggle('stretched_res_enable', {
        Text = 'stretched res',
        Default = false,
        Callback = function(v)
            ELI.stretched_res.enable = v;
            if not v then
                camera.CFrame = old_camera_stretched_res;
            end;
        end;
    });
    camera_tab:AddSlider('stretched_res_amount', {
        Text = 'amount',
        Default = 0.20,
        Min = 0.1,
        Max = 1,
        Rounding = 2,
        Callback = function(v)
            ELI.stretched_res.stretched_res_amount = v;
        end;
    });
    local old_camera_fov = camera.FieldOfView;
    camera_tab:AddToggle('fov_changer_enable', {
        Text = 'fov changer',
        Default = false,
        Callback = function(v)
            ELI.fov_changer.enable = v;
            if not v then
                camera.FieldOfView = old_camera_fov;
            end;
        end;
    });
    camera_tab:AddSlider('fov_changer_fov', {
        Text = 'fov',
        Default = 80,
        Min = 10,
        Max = 140,
        Rounding = 2,
        Callback = function(v)
            ELI.fov_changer.fov = v;
        end;
    });
end;

local esp_tab = Tabs.esptab; do
    local esp_groupbox = esp_tab:AddLeftGroupbox('esp', 'scan-eye'); do
        esp_groupbox:AddToggle('esp_enable', {
            Text = 'enable',
            Default = false,
            Callback = function(v)
                ELI.esp.enable = v;
            end
        });

        esp_groupbox:AddToggle('esp_team_check', {
            Text = 'team check',
            Default = true,
            Callback = function(v)
                ELI.esp.team_check = v;
            end
        });

        esp_groupbox:AddToggle('esp_box_enable', {
            Text = 'box',
            Default = false,
            Callback = function(v)
                ELI.esp.box.enable = v;
                Options.esp_box_thickness:SetVisible(v);
                Toggles.esp_glow_enable:SetVisible(v);
            end
        }):AddColorPicker('esp_box_color', {
            Title = 'box color',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.box.color = v;
            end
        }):AddColorPicker('esp_box_outline_color', {
            Title = 'outline color',
            Default = Color3.new(0, 0, 0),
            Callback = function(v)
                ELI.esp.box.outline = v;
            end
        }):AddColorPicker('esp_box_inline_color', {
            Title = 'inline color',
            Default = Color3.new(0, 0, 0),
            Callback = function(v)
                ELI.esp.box.inline = v;
            end
        });

        esp_groupbox:AddToggle('esp_glow_enable', {
            Text = 'glow box',
            Default = false,
            Visible = false,
            Callback = function(v)
                ELI.esp.glow.enable = v;
                Options.esp_glow_transparency:SetVisible(v);
            end
        }):AddColorPicker('esp_glow_color_start', {
            Title = 'glow start',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.glow.color_start = v;
            end
        }):AddColorPicker('esp_glow_color_end', {
            Title = 'glow end',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.glow.color_end = v;
            end
        });

        esp_groupbox:AddSlider('esp_glow_transparency', {
            Text = 'glow transparency',
            Default = 1,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Visible = false,
            Callback = function(v)
                ELI.esp.glow.transparency = v;
            end
        });

        esp_groupbox:AddSlider('esp_box_thickness', {
            Text = 'box thickness',
            Default = 1,
            Min = 1,
            Max = 5,
            Rounding = 0,
            Visible = false,
            Callback = function(v)
                ELI.esp.box.thickness = v;
            end
        });

        esp_groupbox:AddToggle('esp_name_enable', {
            Text = 'name',
            Default = false,
            Callback = function(v)
                ELI.esp.text.name.enable = v;
            end
        }):AddColorPicker('esp_name_color', {
            Title = 'name color',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.text.name.color = v;
            end
        });

        esp_groupbox:AddToggle('esp_studs_enable', {
            Text = 'distance',
            Default = false,
            Callback = function(v)
                ELI.esp.text.studs.enable = v;
            end
        }):AddColorPicker('esp_studs_color', {
            Title = 'distance color',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.text.studs.color = v;
            end
        });

        esp_groupbox:AddToggle('esp_tool_enable', {
            Text = 'weapon',
            Default = false,
            Callback = function(v)
                ELI.esp.text.tool.enable = v;
            end
        }):AddColorPicker('esp_tool_color', {
            Title = 'weapon color',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.text.tool.color = v;
            end
        });

        esp_groupbox:AddDropdown('esp_tool_position', {
            Text = 'weapon position',
            Default = 'right',
            Values = { 'top', 'bottom', 'right' },
            Callback = function(v)
                ELI.esp.text.tool.position = v;
            end
        });

        esp_groupbox:AddToggle('esp_filled_enable', {
            Text = 'filled',
            Default = false,
            Callback = function(v)
                ELI.esp.filled.enable = v;
                Options.esp_filled_transparency:SetVisible(v);
            end
        }):AddColorPicker('esp_filled_color_start', {
            Title = 'fill start',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.filled.color_start = v;
            end
        }):AddColorPicker('esp_filled_color_end', {
            Title = 'fill end',
            Default = Color3.new(1, 1, 1),
            Callback = function(v)
                ELI.esp.filled.color_end = v;
            end
        });

        esp_groupbox:AddToggle('esp_filled_hitflash', {
            Text = 'hit flash',
            Default = false,
            Callback = function(v)
                ELI.esp.filled.hit_flash = v;
            end
        }):AddColorPicker('esp_filled_hitcolor', {
            Title = 'hit color',
            Default = Color3.fromRGB(255, 40, 40),
            Callback = function(v)
                ELI.esp.filled.hit_color = v;
            end
        });

        esp_groupbox:AddToggle('esp_visible_enable', {
            Text = 'visible color',
            Default = false,
            Callback = function(v)
                ELI.esp.visible.enable = v;
            end
        }):AddColorPicker('esp_visible_color', {
            Title = 'visible color',
            Default = Color3.fromRGB(60, 255, 90),
            Callback = function(v)
                ELI.esp.visible.color = v;
            end
        });

        esp_groupbox:AddToggle('esp_highlight_enable', {
            Text = 'highlight',
            Default = false,
            Callback = function(v)
                ELI.esp.highlight.enable = v;
            end
        }):AddColorPicker('esp_highlight_fill', {
            Title = 'fill color',
            Default = Color3.fromRGB(255, 40, 40),
            Callback = function(v)
                ELI.esp.highlight.fill_color = v;
            end
        }):AddColorPicker('esp_highlight_outline', {
            Title = 'outline color',
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                ELI.esp.highlight.outline_color = v;
            end
        });

        esp_groupbox:AddSlider('esp_highlight_fill_transparency', {
            Text = 'highlight fill transparency',
            Default = 0.55,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.esp.highlight.fill_transparency = v;
            end
        });

        esp_groupbox:AddSlider('esp_highlight_outline_transparency', {
            Text = 'highlight outline transparency',
            Default = 0,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(v)
                ELI.esp.highlight.outline_transparency = v;
            end
        });

        esp_groupbox:AddSlider('esp_filled_transparency', {
            Text = 'fill transparency',
            Default = 0.75,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Visible = false,
            Callback = function(v)
                ELI.esp.filled.transparency = v;
            end
        });

        esp_groupbox:AddToggle('esp_filled_animated', {
            Text = 'animated fill',
            Default = false,
            Callback = function(v)
                ELI.esp.filled.animated = v;
                Options.esp_filled_rotation:SetVisible(v);
                Options.esp_filled_speed:SetVisible(v);
            end
        });

        esp_groupbox:AddSlider('esp_filled_rotation', {
            Text = 'fill rotation',
            Default = 90,
            Min = 0,
            Max = 360,
            Rounding = 0,
            Visible = false,
            Callback = function(v)
                ELI.esp.filled.rotation = v;
            end
        });

        esp_groupbox:AddSlider('esp_filled_speed', {
            Text = 'fill speed',
            Default = 2,
            Min = 0,
            Max = 10,
            Rounding = 1,
            Visible = false,
            Callback = function(v)
                ELI.esp.filled.speed = v;
            end
        });

        esp_groupbox:AddToggle('esp_health_enable', {
            Text = 'health bar',
            Default = false,
            Callback = function(v)
                ELI.esp.health.enable = v;
                Options.esp_health_width:SetVisible(v);
                Options.esp_health_gap:SetVisible(v);
            end
        }):AddColorPicker('esp_health_color_high', {
            Title = 'health top',
            Default = Color3.fromRGB(0, 255, 0),
            Callback = function(v)
                ELI.esp.health.color_high = v;
            end
        }):AddColorPicker('esp_health_color_mid', {
            Title = 'health mid',
            Default = Color3.fromRGB(255, 255, 0),
            Callback = function(v)
                ELI.esp.health.color_mid = v;
            end
        }):AddColorPicker('esp_health_color_low', {
            Title = 'health bot',
            Default = Color3.fromRGB(255, 0, 0),
            Callback = function(v)
                ELI.esp.health.color_low = v;
            end
        });

        esp_groupbox:AddSlider('esp_health_width', {
            Text = 'bar width',
            Default = 3,
            Min = 1,
            Max = 10,
            Rounding = 0,
            Visible = false,
            Callback = function(v)
                ELI.esp.health.width = v;
            end
        });

        esp_groupbox:AddSlider('esp_health_gap', {
            Text = 'bar gap',
            Default = 5,
            Min = 1,
            Max = 20,
            Rounding = 0,
            Visible = false,
            Callback = function(v)
                ELI.esp.health.gap = v;
            end
        });

        esp_groupbox:AddSlider('esp_text_size', {
            Text = 'text size',
            Default = 9,
            Min = 6,
            Max = 16,
            Rounding = 0,
            Callback = function(v)
                ELI.esp.text.size = v;
            end
        });

        esp_groupbox:AddToggle('esp_text_gradient', {
            Text = 'gradient text',
            Default = false,
            Callback = function(v)
                ELI.esp.text.gradient = v;
            end
        }):AddColorPicker('esp_text_gradient_color1', {
            Default = Color3.fromRGB(255, 40, 40),
            Title = 'color 1',
            Callback = function(v)
                ELI.esp.text.gradient_color1 = v;
            end
        }):AddColorPicker('esp_text_gradient_color2', {
            Default = Color3.fromRGB(255, 255, 255),
            Title = 'color 2',
            Callback = function(v)
                ELI.esp.text.gradient_color2 = v;
            end
        });

        esp_groupbox:AddToggle('esp_text_flow', {
            Text = 'flow animation',
            Default = false,
            Callback = function(v)
                ELI.esp.text.flow = v;
            end
        });

        esp_groupbox:AddSlider('esp_text_flow_speed', {
            Text = 'flow speed',
            Default = 1,
            Min = 0.1,
            Max = 5,
            Rounding = 1,
            Callback = function(v)
                ELI.esp.text.flow_speed = v;
            end
        });

        esp_groupbox:AddSlider('esp_max_dist', {
            Text = 'max distance',
            Default = 25000,
            Min = 100,
            Max = 25000,
            Rounding = 0,
            Suffix = 'studs',
            Callback = function(v)
                ELI.esp.max_dist = v;
            end
        });
    end;
end;

local esp_throwable_tab = Tabs.esptab:AddRightGroupbox('throwable esp', 'bomb'); do
    esp_throwable_tab:AddToggle('thrower_esp_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.thrower_esp.enable = v;
            Options.thrower_esp_select:SetVisible(v);
            Options.thrower_esp_font:SetVisible(v);
            Toggles.thrower_esp_name:SetVisible(v);
            Toggles.thrower_esp_distance:SetVisible(v);
            Toggles.thrower_esp_image:SetVisible(v);
        end;
    });

    esp_throwable_tab:AddToggle('thrower_esp_name', {
        Text = 'name',
        Default = false,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.name = v;
            Options.thrower_esp_name_size:SetVisible(v);
        end;
    }):AddColorPicker('thrower_esp_name_color', {
        Title = 'name color',
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(v)
            ELI.thrower_esp.name_color = v;
        end;
    });

    esp_throwable_tab:AddSlider('thrower_esp_name_size', {
        Text = 'name size',
        Default = 14,
        Min = 6,
        Max = 32,
        Rounding = 0,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.name_size = v;
        end;
    });

    esp_throwable_tab:AddToggle('thrower_esp_distance', {
        Text = 'distance',
        Default = false,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.distance = v;
            Options.thrower_esp_distance_size:SetVisible(v);
        end;
    }):AddColorPicker('thrower_esp_distance_color', {
        Title = 'distance color',
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(v)
            ELI.thrower_esp.distance_color = v;
        end;
    });

    esp_throwable_tab:AddSlider('thrower_esp_distance_size', {
        Text = 'distance size',
        Default = 12,
        Min = 6,
        Max = 32,
        Rounding = 0,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.distance_size = v;
        end;
    });

    esp_throwable_tab:AddToggle('thrower_esp_image', {
        Text = 'image',
        Default = false,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.image = v;
        end;
    });

    esp_throwable_tab:AddDropdown('thrower_esp_select', {
        Text = 'throwable whitelist',
        Values = { 'Grenade', 'Flashbang', 'Molotov', 'Satchel', 'Smoke Grenade', 'Subspace Tripmine' },
        Default = {},
        Multi = true,
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.thrower_select = v;
        end;
    });

    esp_throwable_tab:AddDropdown('thrower_esp_font', {
        Text = 'font',
        Values = font_indexes,
        Default = 'ProggyTiny',
        Visible = false,
        Callback = function(v)
            ELI.thrower_esp.font = v;

            for _, obj in next, thrower do
                obj.name:Destroy();
                obj.dist:Destroy();
                obj.icon:Destroy();
            end;

            table.clear(thrower);
        end;
    });
end;
local misc_tab = Tabs.misc_tab; do
    local auto_tabbox = Tabs.misc_tab:AddRightTabbox(); do
        local auto_vote_map = auto_tabbox:AddTab('auto vote map'); do
            auto_vote_map:AddToggle('auto_vote_map_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.auto_vote_map.enable = v;
                end;
            });

            auto_vote_map:AddDropdown('auto_vote_map', {
                Values = {"Arena", "Big Graveyard", "Docks", "Splash", "Bridge", "Crossroads", "Big Crossroads", "Big Backrooms", "Battleground", "Big Arena", "Construction", "Playground", "Onyx", "Graveyard", "Big Splash", "Big Onyx", "Backrooms", "Station", "Dimension",},
                Default = "",
                Multi = false,
                Text = 'map',
                Callback = function(v)
                    ELI.auto_vote_map.map = v;
                end;
            });
        end;
    end;

    local troll_tab = Tabs.misc_tab:AddLeftTabbox(); do
        local device_spoof_tab = troll_tab:AddTab('device spoof'); do
            device_spoof_tab:AddToggle('device_spoof_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.device_spoof.enable = v;
                end;
            });

            device_spoof_tab:AddDropdown('device_spoof_type', {
                Values = {'Touch', 'MouseKeyboard', 'Gamepad', 'VR'},
                Default = 2,
                Multi = false,
                Text = 'type',
                Callback = function(v)
                    ELI.device_spoof.type = v;
                end;
            });
        end;

        local sound_spammer_tab = troll_tab:AddTab('sound spammer'); do
            sound_spammer_tab:AddToggle('sound_spammer_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.sound_spammer.enable = v;
                end;
            });

            sound_spammer_tab:AddDropdown('sound_spammer_type', {
                Values = {'DoubleJump', 'Slide'},
                Default = 1,
                Multi = false,
                Text = 'sound type',
                Callback = function(v)
                    ELI.sound_spammer.type = v;
                end;
            });
        end;
    end;

    local spooftabthing = Tabs.misc_tab:AddRightTabbox(); do
        local streak_spoof = spooftabthing:AddTab('streak');

        streak_spoof:AddToggle('streak_spoof_enable', {
            Text = 'spoof',
            Default = false,
            Callback = function(v)
            ELI.spoof.streak.enable = v;
                if not v then
                    local_player:SetAttribute("StatisticDuelsWinStreak", spoof_old.streak);
                  end;
            end;
        });

    streak_spoof:AddInput('streak_spoof_text', {
    Default = '9',
    Numeric = true,

    Text = 'spoof',

    Callback = function(v)
        local n = tonumber(v);
        if n then
            ELI.spoof.streak.value = n;
        end;
    end
   });

     local level_spoof = spooftabthing:AddTab('level');
             level_spoof:AddToggle('level_spoof_enable', {
            Text = 'spoof',
            Default = false,
            Callback = function(v)
            ELI.spoof.level.enable = v;
                if not v then
                    local_player:SetAttribute("Level", spoof_old.level);
                  end;
            end;
        });

    level_spoof:AddInput('level_spoof_text', {
    Default = '9',
    Numeric = true,

    Text = 'spoof',

    Callback = function(v)
        local n = tonumber(v);
        if n then
            ELI.spoof.level.value = n;
        end;
    end
   });

    local rank_spoof = spooftabthing:AddTab('rank');
    rank_spoof:AddToggle('rank_spoof_enable', {
        Text = 'spoof (not working)';
        Default = false;
        Callback = function(v)
            ELI.rank_spoof.enable = v;
        end;
    });
    rank_spoof:AddDropdown('rank_spoof_value', {
        Values = { 'Bronze', 'Silver', 'Gold', 'Diamond', 'Onyx', 'Nemesis', 'Arch Nemesis' };
        Default = 7;
        Multi = false;
        Text = 'rank';
        Callback = function(v)
            ELI.rank_spoof.rank = v;
        end;
    });

    local elo_spoof = spooftabthing:AddTab('elo');
    elo_spoof:AddToggle('elo_spoof_enable', {
        Text = 'spoof (not working)';
        Default = false;
        Callback = function(v)
            ELI.elo_spoof.enable = v;
            if not v then
                pcall(function() local_player:SetAttribute("DisplayELO", spoof_old.elo); end);
            end;
        end;
    });
    elo_spoof:AddInput('elo_spoof_text', {
        Default = '60000';
        Numeric = true;
        Text = 'spoof';
        Callback = function(v)
            local n = tonumber(v);
            if n then ELI.elo_spoof.value = n; end;
        end;
    });

    local name_spoof = spooftabthing:AddTab('name');
    name_spoof:AddToggle('name_spoof_enable', {
        Text = 'spoof';
        Default = false;
        Callback = function(v)
            ELI.name_spoof.enable = v;
        end;
    });
    name_spoof:AddInput('name_spoof_display', {
        Default = '';
        Text = 'display name';
        Placeholder = 'display name';
        Callback = function(v)
            ELI.name_spoof.display = v or "";
        end;
    });
    name_spoof:AddInput('name_spoof_username', {
        Default = '';
        Text = 'username';
        Placeholder = 'username';
        Callback = function(v)
            ELI.name_spoof.username = v or "";
        end;
    });
    end;

    local utility_tab = Tabs.misc_tab:AddLeftTabbox(); do
        local auto_loadout_tab = utility_tab:AddTab('auto loadout'); do
            auto_loadout_tab:AddToggle('auto_loadout_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.auto_loadout.enable = v;
                end;
            });

            local ascending_classes = {'Primary', 'Secondary', 'Melee', 'Utility'};
            for i = 1, #ascending_classes do
                local class = ascending_classes[i];
                local items = sorted_item_list[class] or {};
                local slot = class_dir[class:lower()];
                auto_loadout_tab:AddDropdown('auto_loadout_class_' .. class:lower(), {
                    Values = items,
                    Default = ELI.auto_loadout.loadout[slot],
                    Multi = false,
                    Text = class:lower(),
                    Callback = function(v)
                        ELI.auto_loadout.loadout[slot] = v;
                    end;
                });
            end;
        end;

        local auto_queue_tab = utility_tab:AddTab('auto queue'); do
            auto_queue_tab:AddToggle('auto_queue_enable', {
                Text = 'enable',
                Default = false,
                Callback = function(v)
                    ELI.auto_queue.enable = v;
                    if not v then
                        clickedontheremote = false;
                        was_i_in_a_match = false;
                    end;
                end;
            });

            auto_queue_tab:AddDropdown('auto_queue_mode', {
                Values = {"1v1", "2v2", "3v3", "4v4", "5v5", "2v2_beginner",},
                Default = "",
                Multi = false,
                Text = 'queue mode',
                Callback = function(v)
                    ELI.auto_queue.queue_mode = v;
                end;
            });
        end;
    end;

    local arcade_server_tab = Tabs.misc_tab:AddRightGroupbox('arcade server', 'gamepad-2'); do
        arcade_server_tab:AddToggle('grab_drops_enable', {
            Text = 'grab drops',
            Default = false,
            Callback = function(v)
                ELI.arcade_server.grab_drops = v;
            end;
        });

        arcade_server_tab:AddToggle('auto_respawn_enable', {
            Text = 'auto respawn',
            Default = false,
            Callback = function(v)
                ELI.arcade_server.auto_respawn = v;
            end;
        });
    end;
end

do
local v555 = Tabs.misc_tab:AddRightGroupbox('cosmetics', 'palette');
local unlockAllInitialized = false;
getgenv().ZRHUB_cosmetic_state = getgenv().ZRHUB_cosmetic_state or {
    gui = nil,
    frame = nil,
    inner = nil,
    panel = nil,
    selectedWeapon = nil,
    selectedType = "Skin",
    anyModel = false,
    dismissedThisSession = true,
};

v555:AddToggle("AnySkinMode", {
    Text = "any skin",
    Default = getgenv().ZRHUB_cosmetic_state.anyModel or false,
    Callback = function(val)
        getgenv().ZRHUB_cosmetic_state.anyModel = val and true or false;
        local st = getgenv().ZRHUB_cosmetic_state;
        if st and st.refreshCosmetics then
            st.refreshCosmetics();
        end;
    end
});

local function syncCosmeticChangerVisibility()
    local st = getgenv().ZRHUB_cosmetic_state;
    if not st or not st.frame or not st.frame.Parent then return end;
    if not unlockAllInitialized then return end;
    local menuOpen = false;
    pcall(function()
        menuOpen = Library.MenuOpen;
    end);
    if not menuOpen then
        st.frame.Visible = false;
        return
    end;
    st.frame.Visible = not st.dismissedThisSession;
end;
getgenv().syncCosmeticChangerVisibility = syncCosmeticChangerVisibility;

local function openCosmeticChanger(showUi)
    if showUi == nil then showUi = true end;
    if unlockAllInitialized then
        if showUi then
            local st = getgenv().ZRHUB_cosmetic_state;
            if st then
                st.dismissedThisSession = false;
            end;
            syncCosmeticChangerVisibility();
        end;
        return
    end;
    unlockAllInitialized = true;
    local replicated_storage = game:GetService("ReplicatedStorage");
    local local_player = game:GetService("Players").LocalPlayer;
    local enum_library = require(replicated_storage.Modules.EnumLibrary);
    local cosmetic_lib = require(replicated_storage.Modules.CosmeticLibrary);
    local data_ctrl = require(local_player.PlayerScripts.Controllers.PlayerDataController);
    local rep_class = require(replicated_storage.Modules.ReplicatedClass);
    local item_library = require(replicated_storage.Modules.ItemLibrary);
    local equip_remote = replicated_storage.Remotes.Data.EquipCosmetic;
    local fav_remote = replicated_storage.Remotes.Data.FavoriteCosmetic;
    local equipped = {};
    local favorites = {};
    local current_weapon = nil;
    local viewing_profile = nil;
    local enabled = true;
    local unlockAllActive = false;
    local cosmeticNorm = function(s)
        if type(s) ~= "string" then return ""; end;
        return s:lower():gsub("[%s%-%_]+", "");
    end;
    local resolveEquippedWeaponName = function(weaponName, weapon_data)
        if not weaponName then return nil; end;
        if equipped[weaponName] then
            return weaponName;
        end;
        if weapon_data then
            for _, key in eli_ipairs({weapon_data.Name, weapon_data.Weapon, weapon_data.WeaponName}) do
                if key and equipped[key] then
                    return key;
                end;
            end;
        end;
        local norm = cosmeticNorm(weaponName);
        if norm ~= "" then
            for key in eli_pairs(equipped) do
                if cosmeticNorm(key) == norm then
                    return key;
                end;
            end;
        end;
        return nil;
    end;
    local clone_cosmetic = function(cosmetic_name, cosmetic_type, opts)
        local base = cosmetic_lib.Cosmetics[cosmetic_name];
        if not base then return nil end;
        local new_data = table.clone(base);
        new_data.Name = cosmetic_name;
        new_data.Type = new_data.Type or cosmetic_type;
        local ok, enum_val = pcall(enum_library.ToEnum, enum_library, cosmetic_name);
        if ok and enum_val then
            new_data.Enum = enum_val;
            new_data.ObjectID = new_data.ObjectID or enum_val;
        end;
        if opts and opts.inverted ~= nil then
            new_data.Inverted = opts.inverted;
        end;
        return new_data;
    end;
    local SKINS_FOLDER = "ZRHUB_skins";
    local SKINS_FILE = SKINS_FOLDER .. "/skins.json";
    local http_service = game:GetService("HttpService");
    local has_fs = isfolder and makefolder and writefile and readfile and isfile;
    local function ensureSkinsFolder()
        if not has_fs then return false end;
        local ok = pcall(function()
            if not isfolder(SKINS_FOLDER) then makefolder(SKINS_FOLDER) end;
        end);
        return ok;
    end;
    local save_pending = false;
    local function saveSkins()
        if not has_fs then return end;
        if save_pending then return end;
        save_pending = true;
        task.delay(0.15, function()
            save_pending = false;
            ensureSkinsFolder();
            local data = { equipped = {}, favorites = {} };
            for weapon, types in eli_pairs(equipped) do
                data.equipped[weapon] = {};
                for ctype, cdata in eli_pairs(types) do
                    data.equipped[weapon][ctype] = {
                        name = cdata.Name,
                        inverted = cdata.Inverted,
                    };
                end;
            end;
            for weapon, favs in eli_pairs(favorites) do
                data.favorites[weapon] = {};
                for cname, isFav in eli_pairs(favs) do
                    data.favorites[weapon][cname] = isFav and true or nil;
                end;
                if not next(data.favorites[weapon]) then
                    data.favorites[weapon] = nil;
                end;
            end;
            local ok, json = pcall(function() return http_service:JSONEncode(data) end);
            if ok and json then
                pcall(writefile, SKINS_FILE, json);
            end;
        end);
    end;
    local function loadSkins()
        if not has_fs then return end;
        if not isfile(SKINS_FILE) then return end;
        local ok, content = pcall(readfile, SKINS_FILE);
        if not ok or not content or content == "" then return end;
        local ok2, data = pcall(function() return http_service:JSONDecode(content) end);
        if not ok2 or type(data) ~= "table" then return end;
        if type(data.equipped) == "table" then
            for weapon, types in eli_pairs(data.equipped) do
                if type(types) == "table" then
                    equipped[weapon] = equipped[weapon] or {};
                    for ctype, ref in eli_pairs(types) do
                        if type(ref) == "table" and ref.name then
                            local cdata = clone_cosmetic(ref.name, ctype, { inverted = ref.inverted });
                            if cdata then
                                equipped[weapon][ctype] = cdata;
                            end;
                        end;
                    end;
                    if not next(equipped[weapon]) then
                        equipped[weapon] = nil;
                    end;
                end;
            end;
        end;
        if type(data.favorites) == "table" then
            for weapon, favs in eli_pairs(data.favorites) do
                if type(favs) == "table" then
                    favorites[weapon] = favorites[weapon] or {};
                    for cname, isFav in eli_pairs(favs) do
                        favorites[weapon][cname] = isFav and true or nil;
                    end;
                end;
            end;
        end;
    end;
    local old = data_ctrl.Get; data_ctrl.Get = function(self, data_key)
        local original = old(self, data_key);
        if not enabled then return original end;
        if data_key == "CosmeticInventory" then
            if not unlockAllActive then return original; end;
            local inv = original and table.clone(original) or {};
            for cosmetic_name, cosmetic_data in eli_pairs(cosmetic_lib.Cosmetics) do
                if inv[cosmetic_name] == nil
                    and not cosmetic_name:find("MISSING_")
                    and cosmetic_data.Type ~= "Finisher"
                then
                    inv[cosmetic_name] = true;
                end;
            end;
            return inv;
        end;
        if data_key == "FavoritedCosmetics" then
            local fav = original and table.clone(original) or {};
            for weapon_name, weapon_favs in eli_pairs(favorites) do
                fav[weapon_name] = fav[weapon_name] or {};
                for cosmetic_name, is_fav in eli_pairs(weapon_favs) do
                    fav[weapon_name][cosmetic_name] = is_fav;
                end;
            end;
            return fav;
        end;
        return original;
    end;
    local old = data_ctrl.GetWeaponData; data_ctrl.GetWeaponData = function(self, weapon_name)
        local weapon_data = old(self, weapon_name);
        if not weapon_data then return nil end;
        local final = table.clone(weapon_data);
        final.Name = weapon_name;
        if enabled then
            local equipped_name = resolveEquippedWeaponName(weapon_name, weapon_data);
            if equipped_name and equipped[equipped_name] then
                for cosmetic_type, cosmetic_data in eli_pairs(equipped[equipped_name]) do
                    final[cosmetic_type] = cosmetic_data;
                end;
            end;
        end;
        return final;
    end;
    local client_item_module = require(local_player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem);
    if client_item_module and client_item_module._CreateViewModel then
        local old = client_item_module._CreateViewModel; client_item_module._CreateViewModel = function(self, vm_ref)
            local weapon_name = self.Name;
            local weapon_owner = self.ClientFighter and self.ClientFighter.Player;
            current_weapon = (weapon_owner == local_player) and weapon_name or nil;
            local equipped_name = resolveEquippedWeaponName(weapon_name);
            if enabled and weapon_owner == local_player and equipped_name and equipped[equipped_name] and equipped[equipped_name].Skin and vm_ref then
                local data_key = self:ToEnum("Data");
                local skin_key = self:ToEnum("Skin");
                local name_key = self:ToEnum("Name");
                if vm_ref[data_key] then
                    vm_ref[data_key][skin_key] = equipped[equipped_name].Skin;
                    vm_ref[data_key][name_key] = equipped[equipped_name].Skin.Name;
                elseif vm_ref.Data then
                    vm_ref.Data.Skin = equipped[equipped_name].Skin;
                    vm_ref.Data.Name = equipped[equipped_name].Skin.Name;
                end;
            end;
            local result = old(self, vm_ref);
            current_weapon = nil;
            return result;
        end;
    end;
    local vm_module_path = local_player.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel");
    if vm_module_path then
        local client_vm = require(vm_module_path);
        if client_vm.GetWrap then
            local old = client_vm.GetWrap; client_vm.GetWrap = function(self)
                local weapon_name = self.ClientItem and self.ClientItem.Name;
                local weapon_owner = self.ClientItem and self.ClientItem.ClientFighter and self.ClientItem.ClientFighter.Player;
                local equipped_name = resolveEquippedWeaponName(weapon_name);
                if enabled and weapon_name and weapon_owner == local_player and equipped_name and equipped[equipped_name] and equipped[equipped_name].Wrap then
                    return equipped[equipped_name].Wrap;
                end;
                return old(self);
            end;
        end;
        local old = client_vm.new; client_vm.new = function(rep_data, client_item)
            local weapon_owner = client_item.ClientFighter and client_item.ClientFighter.Player;
            local weapon_name = current_weapon or client_item.Name;
            local equipped_name = resolveEquippedWeaponName(weapon_name);
            if enabled and weapon_owner == local_player and equipped_name and equipped[equipped_name] then
                local data_key = rep_class:ToEnum("Data");
                rep_data[data_key] = rep_data[data_key] or {};
                local eq = equipped[equipped_name];
                if eq.Skin then rep_data[data_key][rep_class:ToEnum("Skin")] = eq.Skin end;
                if eq.Wrap then rep_data[data_key][rep_class:ToEnum("Wrap")] = eq.Wrap end;
                if eq.Charm then rep_data[data_key][rep_class:ToEnum("Charm")] = eq.Charm end;
            end;
            local vm_obj = old(rep_data, client_item);
            if enabled and weapon_owner == local_player and equipped_name and equipped[equipped_name] and equipped[equipped_name].Wrap and vm_obj._UpdateWrap then
                vm_obj:_UpdateWrap();
                task.delay(0.1, function()
                    if not vm_obj._destroyed then vm_obj:_UpdateWrap() end;
                end);
            end;
            return vm_obj;
        end;
    end;
    local function resolveEquippedSkinImage(selfObj, weapon_data, high_res)
        if not weapon_data or not enabled then return nil end;
        local weapon_name = weapon_data.Name;
        local equipped_name = resolveEquippedWeaponName(weapon_name, weapon_data);
        if not (weapon_name and equipped_name and equipped[equipped_name] and equipped[equipped_name].Skin) then
            return nil;
        end;
        local skinName = equipped[equipped_name].Skin.Name;
        if not skinName then return nil end;
        local should_show = (weapon_data.Skin and weapon_data.Skin == equipped[equipped_name].Skin)
            or (viewing_profile == local_player)
            or (weapon_data.Weapon and weapon_data.Weapon == equipped_name)
            or (weapon_data.WeaponName and weapon_data.WeaponName == equipped_name)
            or (cosmeticNorm(weapon_data.Name) == cosmeticNorm(equipped_name));
        if not should_show then return nil end;
        local viewModels = selfObj and selfObj.ViewModels;
        local skin_info = viewModels and viewModels[skinName];
        if not skin_info then return nil end;
        return skin_info[high_res and "ImageHighResolution" or "Image"] or skin_info.Image;
    end;
    local old = item_library.GetViewModelImageFromWeaponData; item_library.GetViewModelImageFromWeaponData = function(self, weapon_data, high_res)
        local forced = resolveEquippedSkinImage(self, weapon_data, high_res);
        if forced then return forced end;
        return old(self, weapon_data, high_res);
    end;
    if item_library.GetImageFromWeaponData then
        local oldImg = item_library.GetImageFromWeaponData;
        item_library.GetImageFromWeaponData = function(self, weapon_data, high_res)
            local forced = resolveEquippedSkinImage(self, weapon_data, high_res);
            if forced then return forced end;
            return oldImg(self, weapon_data, high_res);
        end;
    end;
    if item_library.GetWeaponImageFromWeaponData then
        local oldWeaponImg = item_library.GetWeaponImageFromWeaponData;
        item_library.GetWeaponImageFromWeaponData = function(self, weapon_data, high_res)
            local forced = resolveEquippedSkinImage(self, weapon_data, high_res);
            if forced then return forced end;
            return oldWeaponImg(self, weapon_data, high_res);
        end;
    end;
    local view_profile = require(local_player.PlayerScripts.Modules.Pages.ViewProfile);
    if view_profile and view_profile.Fetch then
        local old = view_profile.Fetch; view_profile.Fetch = function(self, target_player)
            viewing_profile = target_player;
            return old(self, target_player);
        end;
    end;
    loadSkins();
    data_ctrl.CurrentData:Replicate("CosmeticInventory");
    data_ctrl.CurrentData:Replicate("WeaponInventory");
    data_ctrl.CurrentData:Replicate("FavoritedCosmetics");
    local uiState = getgenv().ZRHUB_cosmetic_state;
    local function makeThemeColor(which, fallback)
        if Library and Library[which] then return Library[which] end;
        return fallback;
    end;
    local uiFont = (Library and typeof(Library.Font) == 'EnumItem' and Library.Font) or Enum.Font.Code;
    local coreGui = game:GetService("CoreGui");
    local rs = game:GetService("RunService");
    local function destroyOld()
        if uiState.gui then
            pcall(function() uiState.gui:Destroy() end);
        end;
        uiState.gui = nil;
        uiState.frame = nil;
        uiState.inner = nil;
        uiState.panel = nil;
    end;
    destroyOld();
    local gui = Instance.new("ScreenGui");
    gui.Name = "ZRHUB_cosmetic_changer";
    gui.ResetOnSpawn = false;
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    gui.Parent = coreGui;
    local viewport = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(1280, 720);
    local outer = Instance.new("Frame");
    outer.Name = "CosmeticChangerOuter";
    outer.AnchorPoint = Vector2.new(0.5, 0.5);
    outer.Size = UDim2.fromOffset(math.clamp(math.floor(viewport.X * 0.86), 320, 700), math.clamp(math.floor(viewport.Y * 0.82), 300, 500));
    outer.Position = UDim2.fromScale(0.5, 0.5);
    outer.BorderSizePixel = 0;
    outer.BackgroundColor3 = Color3.new(0, 0, 0);
    outer.Parent = gui;
    outer.Active = true;
    outer.Draggable = true;
    local outerConstraint = Instance.new("UISizeConstraint");
    outerConstraint.MinSize = Vector2.new(300, 280);
    outerConstraint.MaxSize = viewport;
    outerConstraint.Parent = outer;

    local userInput = game:GetService("UserInputService");
    local resizer = Instance.new("TextButton");
    resizer.Name = "CosmeticResizer";
    resizer.Text = "";
    resizer.AutoButtonColor = false;
    resizer.AnchorPoint = Vector2.new(1, 1);
    resizer.Position = UDim2.new(1, -2, 1, -2);
    resizer.Size = UDim2.fromOffset(18, 18);
    resizer.BackgroundColor3 = Color3.fromRGB(0, 186, 255);
    resizer.BorderSizePixel = 0;
    resizer.Size = UDim2.fromOffset(14, 14);
    resizer.ZIndex = 50;
    resizer.Parent = outer;

    local resizing = false;
    local resizeStart = nil;
    local resizeStartSize = nil;
    resizer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true;
            resizeStart = input.Position;
            resizeStartSize = outer.AbsoluteSize;
        end;
    end);
    resizer.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false;
        end;
    end);
    userInput.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(input)
        if not resizing or not resizer.Parent then return end;
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
            local delta = input.Position - resizeStart;
            local newW = math.clamp(resizeStartSize.X + delta.X, 360, viewport.X);
            local newH = math.clamp(resizeStartSize.Y + delta.Y, 280, viewport.Y);
            outer.Size = UDim2.fromOffset(newW, newH);
        end;
    end));
    local inner = Instance.new("Frame");
    inner.Name = "CosmeticChangerInner";
    inner.Size = UDim2.new(1, -2, 1, -2);
    inner.Position = UDim2.fromOffset(1, 1);
    inner.BorderSizePixel = 0;
    inner.Parent = outer;
    local panel = Instance.new("Frame");
    panel.Name = "CosmeticChangerContent";
    panel.AnchorPoint = Vector2.new(0.5, 0.5);
    panel.Position = UDim2.fromScale(0.5, 0.5);
    panel.Size = UDim2.new(1, -2, 1, -2);
    panel.BorderSizePixel = 0;
    panel.ClipsDescendants = true;
    panel.Parent = inner;
    local top = Instance.new("Frame");
    top.Size = UDim2.new(1, 0, 0, 38);
    top.Position = UDim2.new(0, 0, 0, 0);
    top.BorderSizePixel = 0;
    top.Parent = panel;
    local accentBar = Instance.new("Frame");
    accentBar.Name = "CosmeticChangerAccent";
    accentBar.BorderSizePixel = 0;
    accentBar.Size = UDim2.new(1, 0, 0, 2);
    accentBar.Position = UDim2.new(0, 0, 0, 0);
    accentBar.ZIndex = 2;
    accentBar.Parent = panel;
    local title = Instance.new("TextLabel");
    title.BackgroundTransparency = 1;
    title.Size = UDim2.new(1, -80, 1, -2);
    title.Position = UDim2.new(0, 8, 0, 2);
    title.Font = uiFont;
    title.TextSize = 14;
    title.TextXAlignment = Enum.TextXAlignment.Left;
    title.Text = "Cosmetic Changer";
    title.Parent = top;
    pcall(function()
        Library:SetAccentTitle(title, 'Cosmetic Changer', 'Changer');
    end);
    local closeBtn = Instance.new("TextButton");
    closeBtn.AnchorPoint = Vector2.new(1, 0.5);
    closeBtn.Size = UDim2.fromOffset(24, 24);
    closeBtn.Position = UDim2.new(1, -8, 0.5, 1);
    closeBtn.Text = "X";
    closeBtn.Font = uiFont;
    closeBtn.TextSize = 14;
    closeBtn.AutoButtonColor = false;
    closeBtn.BackgroundTransparency = 1;
    closeBtn.Parent = top;
    closeBtn.MouseButton1Click:Connect(function()
        local st = getgenv().ZRHUB_cosmetic_state;
        if st then
            st.dismissedThisSession = true;
            if st.frame then
                st.frame.Visible = false;
            end;
        end;
    end);
    local FOOTER_H = 112;
    local GRID_COLS = 3;
    local GRID_GAP = 4;
    local GRID_PAD = 6;
    local GRID_LABEL_H = 14;
    local GRID_SELECT_BG = Color3.fromRGB(0, 0, 0);
    local leftHolder = Instance.new("Frame");
    leftHolder.Size = UDim2.new(0.46, -12, 1, -(40 + FOOTER_H));
    leftHolder.Position = UDim2.new(0, 10, 0, 40);
    leftHolder.BorderSizePixel = 0;
    leftHolder.Parent = panel;
    local rightHolder = Instance.new("Frame");
    rightHolder.Size = UDim2.new(0.54, -12, 1, -(40 + FOOTER_H));
    rightHolder.Position = UDim2.new(0.46, 2, 0, 40);
    rightHolder.BorderSizePixel = 0;
    rightHolder.Parent = panel;
    local function styleSearchBox(box)
        box.BorderSizePixel = 1;
        box.BorderMode = Enum.BorderMode.Inset;
        box.ClipsDescendants = true;
        local pad = Instance.new("UIPadding");
        pad.PaddingLeft = UDim.new(0, 8);
        pad.PaddingRight = UDim.new(0, 8);
        pad.Parent = box;
    end;
    local weaponSearch = Instance.new("TextBox");
    weaponSearch.Size = UDim2.new(1, -8, 0, 24);
    weaponSearch.Position = UDim2.new(0, 4, 0, 4);
    weaponSearch.ClearTextOnFocus = false;
    weaponSearch.Text = "";
    weaponSearch.PlaceholderText = "filter weapons...";
    weaponSearch.Font = uiFont;
    weaponSearch.TextSize = 13;
    weaponSearch.TextXAlignment = Enum.TextXAlignment.Left;
    weaponSearch.Parent = leftHolder;
    styleSearchBox(weaponSearch);
    local cosmeticSearch = Instance.new("TextBox");
    cosmeticSearch.Size = UDim2.new(1, -8, 0, 24);
    cosmeticSearch.Position = UDim2.new(0, 4, 0, 4);
    cosmeticSearch.ClearTextOnFocus = false;
    cosmeticSearch.Text = "";
    cosmeticSearch.PlaceholderText = "filter cosmetics...";
    cosmeticSearch.Font = uiFont;
    cosmeticSearch.TextSize = 13;
    cosmeticSearch.TextXAlignment = Enum.TextXAlignment.Left;
    cosmeticSearch.Parent = rightHolder;
    styleSearchBox(cosmeticSearch);
    local weaponFilterLbl = Instance.new("TextLabel");
    weaponFilterLbl.BackgroundTransparency = 1;
    weaponFilterLbl.Size = UDim2.new(1, -8, 0, 14);
    weaponFilterLbl.Position = UDim2.new(0, 4, 0, 2);
    weaponFilterLbl.Font = Enum.Font.Code;
    weaponFilterLbl.TextSize = 12;
    weaponFilterLbl.TextXAlignment = Enum.TextXAlignment.Left;
    weaponFilterLbl.Text = "weapon filter";
    weaponFilterLbl.Parent = leftHolder;
    weaponSearch.Position = UDim2.new(0, 4, 0, 18);
    local cosmeticFilterLbl = Instance.new("TextLabel");
    cosmeticFilterLbl.BackgroundTransparency = 1;
    cosmeticFilterLbl.Size = UDim2.new(1, -8, 0, 14);
    cosmeticFilterLbl.Position = UDim2.new(0, 4, 0, 2);
    cosmeticFilterLbl.Font = Enum.Font.Code;
    cosmeticFilterLbl.TextSize = 12;
    cosmeticFilterLbl.TextXAlignment = Enum.TextXAlignment.Left;
    cosmeticFilterLbl.Text = "cosmetic filter";
    cosmeticFilterLbl.Parent = rightHolder;
    cosmeticSearch.Position = UDim2.new(0, 4, 0, 18);
    local weaponList = Instance.new("ScrollingFrame");
    weaponList.Position = UDim2.new(0, 6, 0, 46);
    weaponList.Size = UDim2.new(1, -12, 1, -52);
    weaponList.CanvasSize = UDim2.fromOffset(0, 0);
    weaponList.ScrollBarThickness = 4;
    weaponList.ScrollBarImageTransparency = 0.35;
    weaponList.BorderSizePixel = 1;
    weaponList.BorderMode = Enum.BorderMode.Inset;
    weaponList.BackgroundTransparency = 0;
    weaponList.Parent = leftHolder;
    local wl = Instance.new("UIGridLayout", weaponList);
    wl.SortOrder = Enum.SortOrder.LayoutOrder;
    wl.FillDirectionMaxCells = 3;
    local wlPad = Instance.new("UIPadding", weaponList);
    wlPad.PaddingTop = UDim.new(0, GRID_PAD);
    wlPad.PaddingBottom = UDim.new(0, GRID_PAD);
    wlPad.PaddingLeft = UDim.new(0, GRID_PAD);
    wlPad.PaddingRight = UDim.new(0, GRID_PAD);
    local typeBar = Instance.new("Frame");
    typeBar.Size = UDim2.new(1, -12, 0, 28);
    typeBar.Position = UDim2.new(0, 6, 0, 46);
    typeBar.BackgroundTransparency = 1;
    typeBar.BorderSizePixel = 0;
    typeBar.Parent = rightHolder;
    local cosmeticList = Instance.new("ScrollingFrame");
    cosmeticList.Position = UDim2.new(0, 6, 0, 78);
    cosmeticList.Size = UDim2.new(1, -12, 1, -84);
    cosmeticList.CanvasSize = UDim2.fromOffset(0, 0);
    cosmeticList.ScrollBarThickness = 4;
    cosmeticList.ScrollBarImageTransparency = 0.35;
    cosmeticList.BorderSizePixel = 1;
    cosmeticList.BorderMode = Enum.BorderMode.Inset;
    cosmeticList.Parent = rightHolder;
    local cl = Instance.new("UIGridLayout", cosmeticList);
    cl.SortOrder = Enum.SortOrder.LayoutOrder;
    cl.FillDirectionMaxCells = 3;
    local clPad = Instance.new("UIPadding", cosmeticList);
    clPad.PaddingTop = UDim.new(0, GRID_PAD);
    clPad.PaddingBottom = UDim.new(0, GRID_PAD);
    clPad.PaddingLeft = UDim.new(0, GRID_PAD);
    clPad.PaddingRight = UDim.new(0, GRID_PAD);
    local bottomBar = Instance.new("Frame");
    bottomBar.Name = "CosmeticBottomBar";
    bottomBar.Size = UDim2.new(1, 0, 0, FOOTER_H);
    bottomBar.Position = UDim2.new(0, 0, 1, -FOOTER_H);
    bottomBar.BackgroundTransparency = 1;
    bottomBar.BorderSizePixel = 0;
    bottomBar.Parent = panel;
    local bottomDivider = Instance.new("Frame");
    bottomDivider.Name = "BottomDivider";
    bottomDivider.Size = UDim2.new(1, -20, 0, 1);
    bottomDivider.Position = UDim2.new(0, 10, 0, 4);
    bottomDivider.BorderSizePixel = 0;
    bottomDivider.BackgroundTransparency = 0.5;
    bottomDivider.Parent = bottomBar;
    local skinHint = Instance.new("TextLabel");
    skinHint.Name = "SkinHint";
    skinHint.BackgroundTransparency = 1;
    skinHint.Size = UDim2.fromOffset(168, 46);
    skinHint.Position = UDim2.fromOffset(12, 8);
    skinHint.Font = Enum.Font.Code;
    skinHint.TextSize = 13;
    skinHint.TextXAlignment = Enum.TextXAlignment.Left;
    skinHint.TextYAlignment = Enum.TextYAlignment.Center;
    skinHint.TextWrapped = true;
    skinHint.Text = "right click weapon to remove skin";
    skinHint.Parent = bottomBar;
    local wrapToggleRow = Instance.new("Frame");
    wrapToggleRow.Name = "WrapToggleRow";
    wrapToggleRow.Size = UDim2.fromOffset(176, 50);
    wrapToggleRow.Position = UDim2.fromOffset(188, 6);
    wrapToggleRow.BackgroundTransparency = 1;
    wrapToggleRow.Visible = false;
    wrapToggleRow.Parent = bottomBar;
    local wrapToggleLayout = Instance.new("UIListLayout", wrapToggleRow);
    wrapToggleLayout.FillDirection = Enum.FillDirection.Horizontal;
    wrapToggleLayout.Padding = UDim.new(0, 16);
    wrapToggleLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    wrapToggleLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    wrapToggleLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    local actionRow = Instance.new("Frame");
    actionRow.Name = "ActionRow";
    actionRow.AnchorPoint = Vector2.new(1, 1);
    actionRow.Size = UDim2.fromOffset(340, 30);
    actionRow.Position = UDim2.new(1, -12, 1, -10);
    actionRow.BackgroundTransparency = 1;
    actionRow.Parent = bottomBar;
    local actionLayout = Instance.new("UIListLayout", actionRow);
    actionLayout.FillDirection = Enum.FillDirection.Horizontal;
    actionLayout.Padding = UDim.new(0, 8);
    actionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    actionLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    local applyBtn = Instance.new("TextButton");
    applyBtn.Name = "ApplyBtn";
    applyBtn.Size = UDim2.fromOffset(72, 28);
    applyBtn.Text = "apply";
    applyBtn.Font = Enum.Font.Code;
    applyBtn.TextSize = 12;
    applyBtn.BorderSizePixel = 1;
    applyBtn.AutoButtonColor = false;
    applyBtn.Parent = actionRow;
    local fallback = Instance.new("TextButton");
    fallback.Name = "UnlockAllBtn";
    fallback.Size = UDim2.fromOffset(88, 28);
    fallback.Text = "unlock all";
    fallback.Font = Enum.Font.Code;
    fallback.TextSize = 12;
    fallback.BorderSizePixel = 1;
    fallback.AutoButtonColor = false;
    fallback.Parent = actionRow;
    fallback.MouseButton1Click:Connect(function()
        unlockAllActive = true;
        pcall(function()
            data_ctrl.CurrentData:Replicate("CosmeticInventory");
            data_ctrl.CurrentData:Replicate("WeaponInventory");
            data_ctrl.CurrentData:Replicate("FavoritedCosmetics");
        end);
    end);
    local function getWeapons()
        local out, seen = {}, {};
        local function addWeapon(name)
            if type(name) ~= "string" then return end;
            name = name:gsub("^%s+", ""):gsub("%s+$", "");
            if name == "" then return end;
            if not seen[name] then
                seen[name] = true;
                table.insert(out, name);
            end;
        end;
        local function harvestTable(tbl)
            if type(tbl) ~= "table" then return end;
            for k, v in eli_pairs(tbl) do
                if type(k) == "string" then
                    addWeapon(k);
                end;
                if type(v) == "table" then
                    addWeapon(v.Name);
                    addWeapon(v.Weapon);
                    addWeapon(v.WeaponName);
                elseif type(v) == "string" then
                    addWeapon(v);
                end;
            end;
        end;
        local weaponInv = data_ctrl and data_ctrl.Get and data_ctrl:Get("WeaponInventory");
        harvestTable(weaponInv);
        harvestTable(equipped);
        harvestTable(favorites);
        if item_library then
            harvestTable(item_library.Weapons);
            harvestTable(item_library.WeaponData);
            harvestTable(item_library.Items);
            harvestTable(item_library.Guns);
        end;
        pcall(function()
            local mods = local_player.PlayerScripts:FindFirstChild("Modules");
            local vmFolder = mods and mods:FindFirstChild("ViewModels");
            if not vmFolder then return end;
            for _, mod in eli_ipairs(vmFolder:GetChildren()) do
                addWeapon((mod.Name:gsub("^Base", "")));
            end;
        end);
        for _, cdata in eli_pairs(cosmetic_lib.Cosmetics or {}) do
            if type(cdata) == "table" and type(cdata.Weapons) == "table" then
                for _, wn in eli_ipairs(cdata.Weapons) do
                    addWeapon(wn);
                end;
            end;
        end;
        table.sort(out);
        return out;
    end;
    local weaponSkinSeedRaw = {
        ["Assault Rifle"] = {"AKEY-47", "AUG", "Gingerbread AUG", "Tommy Gun", "AK-47", "Boneclaw Rifle", "Glorious Assault Rifle", "Phoenix Rifle", "10B Visits"},
        ["Battle Axe"] = {"Ban Axe", "Nordic Axe", "Cerulean Axe", "Balloon Axe", "Mimic Axe", "Street Sign", "The Shred", "Glorious Battle Axe", "Keyttle Axe"},
        ["Burst Rifle"] = {"Keyst Rifle", "Spectral Burst", "Pine Burst", "Glorious Burst Rifle", "Pixel Burst", "Electro Rifle", "Electro Burst", "FAMAS", "Aqua Burst"},
        Chainsaw = {"Glorious Chainsaw", "Buzzsaw", "Festive Chainsaw", "Handsaws", "Mega Drill", "Blobsaw"},
        Bow = {"Key Bow", "Raven Bow", "Dream Bow", "Glorious Bow", "Bat Bow", "Compound Bow", "Beloved Bow", "Balloon Bow", "Frostbite Bow"},
        Crossbow = {"Glorious Crossbow", "Crossbone", "Pixel Crossbow", "Arch Crossbow", "Harpoon Crossbow", "Violin Crossbow", "Frostbite Crossbow"},
        Daggers = {"Aces", "Bat daggers", "Toaster", "Cookies", "Keynais", "Paper Planes", "Crystal Daggers", "Broken Hearts", "Glorious Daggers", "Shurikans", "Pumpkin Claws"},
        ["Energy Rifle"] = {"Hacker Rifle", "Apex Rifle", "Glorious Energy Rifle", "New Year Energy Rifle", "Void Rifle", "Soul Rifle", "Hydro Rifle"},
        ["Energy Pistols"] = {"Hacker Pistols", "Hyperlaser Guns", "New Year Energy Pistols", "Hydro Pistols", "Soul Pistols", "Void Pistols", "Glorious Energy Pistols", "Apex Pistols"},
        Exogun = {"Wondergun", "Ray Gun", "Exogourd", "Repulsor", "Glorious Exogun", "Midnight Festive Exogun", "Singularity"},
        Fists = {"Festive Fists", "Spy Gloves", "Fists of Hurt", "Brass Knuckles", "Boxing Gloves", "Pumpkin Claws", "Fist", "Glorious Fists"},
        Flamethrower = {"Rainbowthrower", "Extinguisher", "Keythrower", "Snowblower", "Lamethrower", "Glitterthrower", "Glorious Flamethrower", "Pixel Flamethrower", "Jack O'Thrower"},
        ["Flare Gun"] = {"Vexed Flare Gun", "Wrapped Flare Gun", "Banana Flare Gun", "Banana Flare", "Glorious Flare Gun", "Firework Gun", "Dynamite Gun"},
        ["Freeze Ray"] = {"Gum Ray", "Glorious Freeze Ray", "Spider Ray", "Temporal Ray", "Bubble Ray", "Wrapped Freeze Ray"},
        Grenade = {"Glorious Grenade", "Water balloon", "Water Balloon", "Dynamite", "Whoopee Cushion", "Jingle Grenade", "Keynade", "Frozen Grenade", "Cuddle Bomb", "Soul Grenade"},
        ["Grenade Launcher"] = {"Uranium Launcher", "Swashbuckler", "Balloon Launcher", "Skull Launcher", "Snowball Launcher", "Gearnade Launcher", "Firework Launcher", "Pumpkin Launcher", "Pencil Launcher", "Glorious Grenade Launcher"},
        Gunblade = {"Elf's Gunblade", "Hyper Gunblade", "Glorious Gunblade", "Boneblade", "Keyblade", "Crude Gunblade", "Gunsaw"},
        Handgun = {"Towerstone Handgun", "Blaster", "Stealth Handgun", "Gingerbread Handgun", "Pumpkin Handgun", "Gumball Handgun", "Hand Gun", "Glorious Handgun", "Pixel Handgun", "Warp Handgun"},
        Katana = {"Pixel Katana", "Evil Tridant", "Devil's Trident", "Linked Sword", "New Year Katana", "Glorious Katana", "Crystal Katana", "Stellar Katana", "Keytana", "Saber", "Lightning Bolt", "Arch Katana", "Thunderbolt Katana"},
        Knife = {"Balisong", "Machete", "Chancla", "Keyrambit", "Candy Cane", "Caladblog", "Glorious Knife", "Keylisong", "Armature.001", "pencil", "Karambit"},
        Minigun = {"Fighter Jet", "Wrapped Minigun", "Pumpkin Minigun", "Glorious Minigun", "Pixel Minigun", "Lazergun 3000", "Lasergun 3000"},
        ["Riot Shield"] = {"Tombstone Shield", "Masterpiece", "Door", "Glorious Riot Shield", "Sled", "Energy Shield"},
        Molotov = {"Arch Molotov", "Coffee", "Lava Lamp", "Torch", "Hot Coals", "Vexed Candle", "Glorious Molotov"},
        ["Paintball Gun"] = {"Slime Gun", "Ketchup Gun", "Glorious Paintball Gun", "Boba Gun", "Snowball Gun", "Brain Gun", "Paintballoon Gun"},
        Revolver = {"Peppermint sheriff", "Peppermint Sheriff", "Desert Eagle", "Deagle", "Boneclaw Revolver", "Glorious Revolver", "Keyvolver", "Sheriff", "Peppergun"},
        RPG = {"Rocket launcher", "Rocket Launcher", "Spaceship launcher", "Spaceship Launcher", "Firework Launcher", "Pencil Launcher", "RPKEY", "RPKey", "Squid Launcher", "Pumpkin Launcher", "Glorious RPG"},
        Scythe = {"Scythe of Death", "Anchor", "ZRHUB Scythe", "Keythe", "Bat Scythe", "Cryo Scythe", "Crystal Scythe", "Glorious Scythe", "Bug Net"},
        Shorty = {"Shorty", "Lovely Shorty", "Demon Shorty", "Not So Shorty", "Balloon Shorty", "Too Shorty", "Glorious Shorty", "Wrapped Shorty"},
        Shotgun = {"Broomstick", "Wrapped Shotgun", "Hyper Shotgun", "Balloon Shotgun", "Cactus Shotgun", "Glorious Shotgun", "Shotkey", "Witch Shotgun"},
        Slingshot = {"Lucky Horseshoe", "Reindeer Slingshot", "Keyshot", "Boneshot", "Stick", "Glorious Slingshot", "Harp", "Goalpost"},
        ["Smoke Grenade"] = {"Hourglass", "SnowGlobe", "Snowglobe", "Glorious Smoke Grenade", "Emoji Cloud", "Eyeball", "Balence", "Balance"},
        Sniper = {"Keyper", "Gingerbread Sniper", "Glorious Sniper", "Hyper Sniper", "Event Horizon", "Eyething Sniper", "Pixel Sniper"},
        ["Subspace Tripmine"] = {"Dev-in-the-Box", "Glorious subspace Tripmine", "Glorious Subspace Tripmine", "Pot o'Keys", "Trick or Treat", "DIY Tripmine", "Spring", "Don't Press"},
        Spray = {"Pine spray", "Pine Spray", "Glorious Spray", "Spray Bottle", "Nail Gun", "Lovely Spray", "Boneclaw Spray", "Key Spray"},
        Trowel = {"Pumpkin Carver", "Paintbrush", "Glorious Trowl", "Glorious Trowel", "Plastic Shovel", "Garden Shovel", "Snow Shovel"},
        Uzi = {"Glorious Uzi", "Keyzi", "Money Gun", "Pine Uzi", "Water Uzi", "Water Gun", "Electro Uzi", "Arch Uzi", "Demon Uzi"},
        Flashbang = {"Lightbulb", "Pixel Flashbang", "Glorious Flashbang", "Skullbang", "Camera", "Disco Ball", "Shiny Star", "Shining Star"},
        Medkit = {"Glorious Medkit", "Bucket of Candy", "Box of Chocolates", "Breifcase", "Briefcase", "Laptop", "Medkitty", "Milk&cookies", "Sandwich"},
        ["Jump Pad"] = {"Bounce House", "Shady Chicken Sandwich", "Trampoline", "Spider Web", "Glorious Jump Pad", "Jolly Man"},
        ["War Horn"] = {"Trumpet", "Boneclaw Horn", "Megaphone", "Mammoth Horn", "Air Horn", "Glorious Air Horn", "Glorious War Horn"},
        Permafrost = {"Ice Permafrost", "Snowman Permafrost", "Glorious Permafrost"},
        Distortion = {"Plasma Distortion", "Electropunk Distortion", "Sleighstortion", "Glorious Distortion", "Magma Distortion", "Cyber Distortion", "Experimental D15"},
        Satchel = {"Pizza Box", "Suspicious Gift", "Advanced Satchel", "Notebook Satchel", "Potion Satchel", "Glorious Satchel", "Bag o'Money"},
        Warper = {"Frost Warper", "Hotel Bell", "Arcane Warper", "Electropunk Warper", "Glitter Warper", "Experiment W4", "Glorious Warper"},
        Warpstone = {"Electropunk Warpstone", "Glorious Warpstone", "Warpbone", "Unstable Warpstone", "Cyber Warpstone", "Warpeye", "Warpstar", "Teleport Disc"},
        Maul = {"Glorious Maul", "Sleigh Maul", "Ban Hammer", "Ice Maul"},
        Spear = {"Giant Pencil", "Glorious Spear", "Studio Light"},
        Grappler = {"Lasso", "Glorious Grappler"},
    };
    local weaponSkinSeed = {};
    for weaponName, skinList in eli_pairs(weaponSkinSeedRaw) do
        local wn = cosmeticNorm(weaponName);
        weaponSkinSeed[wn] = weaponSkinSeed[wn] or {};
        if type(skinList) == "table" then
            for _, skinName in eli_ipairs(skinList) do
                local sn = cosmeticNorm(skinName);
                if sn ~= "" then
                    weaponSkinSeed[wn][sn] = true;
                end;
            end;
        end;
    end;
    pcall(function()
        local mods = local_player.PlayerScripts:FindFirstChild("Modules");
        local vmFolder = mods and mods:FindFirstChild("ViewModels");
        if not vmFolder then return end;
        for _, mod in eli_ipairs(vmFolder:GetChildren()) do
            local weaponName = (mod.Name:gsub("^Base", ""));
            local wn = cosmeticNorm(weaponName);
            if wn ~= "" then
                weaponSkinSeed[wn] = weaponSkinSeed[wn] or {};
                for _, skin in eli_ipairs(mod:GetChildren()) do
                    local sn = cosmeticNorm(skin.Name);
                    if sn ~= "" then
                        weaponSkinSeed[wn][sn] = true;
                    end;
                end;
            end;
        end;
    end);
    local function getCosmeticsFor(weaponName, cosmeticType)
        local results = {};
        cosmeticType = cosmeticType or "Skin";
        local weaponNorm = cosmeticNorm(weaponName);
        local seededList = weaponSkinSeed[weaponNorm];
        local function matchesWeapon(cdata)
            local st = getgenv().ZRHUB_cosmetic_state;
            if st and st.anyModel then
                return true;
            end;
            if type(cdata) ~= "table" then return false end;
            if cosmeticType == "Skin" and seededList then
                local n = cosmeticNorm(cdata.Name);
                if n == "" then return false end;
                return seededList[n] == true;
            end;
            local hasRestriction = false;
            local lists = { cdata.Weapons, cdata.WeaponList, cdata.AllowedWeapons, cdata.WhitelistWeapons };
            for _, list in eli_ipairs(lists) do
                if type(list) == "table" then
                    hasRestriction = true;
                    for _, wn in eli_ipairs(list) do
                        if cosmeticNorm(wn) == weaponNorm then
                            return true;
                        end;
                    end;
                end;
            end;
            if cosmeticNorm(cdata.Weapon) == weaponNorm or cosmeticNorm(cdata.WeaponName) == weaponNorm or cosmeticNorm(cdata.Gun) == weaponNorm then
                return true;
            end;
            if (cosmeticType == "Wrap" or cosmeticType == "Charm") and not hasRestriction then
                return true;
            end;
            return false;
        end;
        for cname, cdata in eli_pairs(cosmetic_lib.Cosmetics or {}) do
            if type(cname) == "string" and type(cdata) == "table" and cdata.Type == cosmeticType and not cname:find("MISSING_") then
                cdata.Name = cdata.Name or cname;
                if matchesWeapon(cdata) then
                    table.insert(results, cname);
                end;
            end;
        end;
        table.sort(results);
        return results;
    end;
    local typeButtons = {};
    local function addTypeButton(typeName, order)
        local btn = Instance.new("TextButton");
        btn.Size = UDim2.fromOffset(74, 26);
        btn.Position = UDim2.new(0, (order - 1) * 78, 0, 1);
        btn.Text = typeName:lower();
        btn.Font = uiFont;
        btn.TextSize = 12;
        btn.AutoButtonColor = false;
        btn.BorderSizePixel = 1;
        btn.BorderMode = Enum.BorderMode.Inset;
        btn.Parent = typeBar;
        btn.MouseButton1Click:Connect(function()
            uiState.selectedType = typeName;
            if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
        end);
        typeButtons[typeName] = btn;
    end;
    addTypeButton("Skin", 1);
    addTypeButton("Wrap", 2);
    addTypeButton("Charm", 3);
    uiState.pendingWrapOpts = uiState.pendingWrapOpts or {};
    local wrapOptionToggles = {};
    local function getActiveWrapName(weaponName)
        if not weaponName then return nil end;
        local pending = uiState.pendingCosmetics and uiState.pendingCosmetics[weaponName];
        if pending and pending.Wrap and pending.Wrap ~= "" then
            return pending.Wrap;
        end;
        local eq = equipped[weaponName] and equipped[weaponName].Wrap;
        return eq and eq.Name or nil;
    end;
    local function getWrapEquipOptions(weaponName)
        uiState.pendingWrapOpts[weaponName] = uiState.pendingWrapOpts[weaponName] or {};
        local pend = uiState.pendingWrapOpts[weaponName];
        if pend.inverted ~= nil then
            return { IsInverted = pend.inverted == true };
        end;
        local wrap = equipped[weaponName] and equipped[weaponName].Wrap;
        return { IsInverted = wrap and wrap.Inverted == true or false };
    end;
    local function fireEquipCosmetic(weaponName, ctype, cname, extraOpts)
        extraOpts = extraOpts or {};
        if ctype == "Wrap" then
            local wrapOpts = getWrapEquipOptions(weaponName);
            extraOpts.IsInverted = wrapOpts.IsInverted;
        end;
        equipped[weaponName] = equipped[weaponName] or {};
        if not cname or cname == "None" or cname == "" then
            equipped[weaponName][ctype] = nil;
            if not next(equipped[weaponName]) then
                equipped[weaponName] = nil;
            end;
        else
            local cosmetic_data = clone_cosmetic(cname, ctype, { inverted = extraOpts.IsInverted });
            if cosmetic_data then
                equipped[weaponName][ctype] = cosmetic_data;
            end;
        end;
        saveSkins();
        pcall(function()
            data_ctrl.CurrentData:Replicate("CosmeticInventory");
            data_ctrl.CurrentData:Replicate("WeaponInventory");
            data_ctrl.CurrentData:Replicate("FavoritedCosmetics");
        end);
    end;
    local function styleThemedToggle(toggleData, isOn)
        local main = toggleData.main;
        local accent = toggleData.accent;
        local font = toggleData.font;
        local outline = toggleData.outline;
        if not main or not accent then
            return
        end;
        toggleData.container.BackgroundTransparency = 1;
        toggleData.label.TextColor3 = font;
        toggleData.switch.BackgroundColor3 = isOn and accent or main;
        toggleData.switch.BorderColor3 = isOn and accent or outline;
    end;
    local function syncWrapOptionToggles()
        for key, toggleData in eli_pairs(wrapOptionToggles) do
            local isOn = false;
            local weaponName = uiState.selectedWeapon;
            local wrapName = getActiveWrapName(weaponName);
            if key == "Inverted" and weaponName then
                local pend = uiState.pendingWrapOpts[weaponName];
                if pend and pend.inverted ~= nil then
                    isOn = pend.inverted == true;
                elseif equipped[weaponName] and equipped[weaponName].Wrap then
                    isOn = equipped[weaponName].Wrap.Inverted == true;
                end;
            elseif key == "Favorited" and weaponName and wrapName then
                isOn = favorites[weaponName] and favorites[weaponName][wrapName] == true;
            end;
            toggleData.isOn = isOn;
            styleThemedToggle(toggleData, isOn);
        end;
    end;
    local function syncWrapOptionsBar()
        local ctype = uiState.selectedType or "Skin";
        local show = ctype == "Wrap" and uiState.selectedWeapon ~= nil;
        wrapToggleRow.Visible = show;
        if show then
            syncWrapOptionToggles();
        end;
    end;
    local function makeThemedToggle(optionKey, labelText, layoutOrder)
        local container = Instance.new("TextButton");
        container.Name = optionKey .. "Toggle";
        container.Size = UDim2.fromOffset(96, 18);
        container.LayoutOrder = layoutOrder or 1;
        container.Text = "";
        container.AutoButtonColor = false;
        container.BackgroundTransparency = 1;
        container.BorderSizePixel = 0;
        container.Parent = wrapToggleRow;
        local switch = Instance.new("Frame");
        switch.Name = "Switch";
        switch.Size = UDim2.fromOffset(13, 13);
        switch.Position = UDim2.new(0, 0, 0.5, -7);
        switch.BorderSizePixel = 1;
        switch.BorderMode = Enum.BorderMode.Inset;
        switch.Parent = container;
        local lbl = Instance.new("TextLabel");
        lbl.BackgroundTransparency = 1;
        lbl.Size = UDim2.new(1, -19, 1, 0);
        lbl.Position = UDim2.fromOffset(19, 0);
        lbl.Font = uiFont;
        lbl.TextSize = 12;
        lbl.TextXAlignment = Enum.TextXAlignment.Left;
        lbl.TextYAlignment = Enum.TextYAlignment.Center;
        lbl.Text = string.lower(labelText);
        lbl.Parent = container;
        local toggleData = {
            container = container,
            label = lbl,
            switch = switch,
            isOn = false,
        };
        wrapOptionToggles[optionKey] = toggleData;
        container.MouseButton1Click:Connect(function()
            local weaponName = uiState.selectedWeapon;
            if not weaponName then return end;
            local wrapName = getActiveWrapName(weaponName);
            local checked = not toggleData.isOn;
            toggleData.isOn = checked;
            styleThemedToggle(toggleData, checked);
            if optionKey == "Inverted" then
                uiState.pendingWrapOpts[weaponName] = uiState.pendingWrapOpts[weaponName] or {};
                uiState.pendingWrapOpts[weaponName].inverted = checked;
                if wrapName and wrapName ~= "" then
                    pcall(function()
                        fireEquipCosmetic(weaponName, "Wrap", wrapName, { IsInverted = checked });
                    end);
                end;
            elseif optionKey == "Favorited" then
                if wrapName and wrapName ~= "" then
                    favorites[weaponName] = favorites[weaponName] or {};
                    favorites[weaponName][wrapName] = checked or nil;
                    saveSkins();
                    pcall(function()
                        data_ctrl.CurrentData:Replicate("FavoritedCosmetics");
                    end);
                end;
            end;
        end);
        return toggleData;
    end;
    makeThemedToggle("Inverted", "inverted", 1);
    makeThemedToggle("Favorited", "favorited", 2);
    local styleCosmeticActionButton;
    task.defer(function()
        pcall(function() if styleCosmeticActionButton then styleCosmeticActionButton(fallback) end end);
        pcall(function() if styleCosmeticActionButton then styleCosmeticActionButton(applyBtn) end end);
    end);
    local weaponImageCache = {};
    local cosmeticImageCache = {};
    local function clearChildren(sf)
        for _, c in eli_ipairs(sf:GetChildren()) do
            if not c:IsA("UIGridLayout") and not c:IsA("UIListLayout") and not c:IsA("UIPadding") then
                c:Destroy();
            end;
        end;
    end;
    local function resizeGridCanvas(sf, gridLayout)
        task.defer(function()
            if sf and gridLayout and gridLayout.Parent then
                local pad = sf:FindFirstChildOfClass("UIPadding");
                local extra = GRID_PAD * 2;
                if pad then
                    extra = pad.PaddingTop.Offset + pad.PaddingBottom.Offset;
                end;
                sf.CanvasSize = UDim2.fromOffset(0, gridLayout.AbsoluteContentSize.Y + extra);
            end;
        end);
    end;
    local function fitGridToFrame(sf, gridLayout)
        if not sf or not gridLayout then return end;
        local pad = sf:FindFirstChildOfClass("UIPadding");
        local padX = pad and (pad.PaddingLeft.Offset + pad.PaddingRight.Offset) or GRID_PAD * 2;
        local scrollInset = sf.ScrollBarThickness + 2;
        local innerW = math.max(sf.AbsoluteSize.X - padX - scrollInset, 72);
        local totalGap = GRID_GAP * (GRID_COLS - 1);
        local cellW = math.floor((innerW - totalGap) / GRID_COLS);
        cellW = math.max(cellW, 52);
        local cellH = cellW + GRID_LABEL_H;
        gridLayout.CellSize = UDim2.fromOffset(cellW, cellH);
        gridLayout.CellPadding = UDim2.fromOffset(GRID_GAP, GRID_GAP);
    end;
    local function getSkinImageId(skinName, highRes)
        if not skinName or skinName == "" then return "" end;
        local vm = item_library.ViewModels and item_library.ViewModels[skinName];
        if type(vm) == "table" then
            return vm[highRes and "ImageHighResolution" or "Image"] or vm.Image or "";
        end;
        local cdata = cosmetic_lib.Cosmetics and cosmetic_lib.Cosmetics[skinName];
        if type(cdata) == "table" then
            return cdata.Image or cdata.Icon or cdata.Thumbnail or "";
        end;
        return "";
    end;
    local function getWeaponSkinName(weaponName, weapon_data)
        local preview = uiState and uiState.previewSkin;
        if preview and preview.weapon == weaponName and preview.name then
            return preview.name;
        end;
        local equipped_name = resolveEquippedWeaponName(weaponName, weapon_data);
        if equipped_name and equipped[equipped_name] and equipped[equipped_name].Skin and equipped[equipped_name].Skin.Name then
            return equipped[equipped_name].Skin.Name;
        end;
        local pending = uiState.pendingCosmetics and uiState.pendingCosmetics[weaponName];
        if pending and pending.Skin and pending.Skin ~= "" then
            return pending.Skin;
        end;
        return nil;
    end;
    local function buildWeaponDataForImage(weaponName)
        local wd;
        pcall(function()
            wd = data_ctrl:GetWeaponData(weaponName);
        end);
        if type(wd) ~= "table" then
            wd = { Name = weaponName, Weapon = weaponName, WeaponName = weaponName };
        else
            wd = table.clone(wd);
            wd.Name = weaponName;
        end;
        local skinName = getWeaponSkinName(weaponName, wd);
        if skinName and skinName ~= "" then
            local skinData = clone_cosmetic(skinName, "Skin");
            if skinData then
                wd.Skin = skinData;
            end;
        end;
        return wd;
    end;
    local function resolveWeaponImage(weaponName)
        local wd = buildWeaponDataForImage(weaponName);
        local skinName = getWeaponSkinName(weaponName, wd) or "";
        local cacheKey = weaponName .. "\0" .. skinName;
        if weaponImageCache[cacheKey] ~= nil then
            return weaponImageCache[cacheKey];
        end;
        local imageId = "";
        pcall(function()
            if item_library.GetViewModelImageFromWeaponData then
                imageId = item_library:GetViewModelImageFromWeaponData(wd, true) or "";
            end;
            if imageId == "" and item_library.GetWeaponImageFromWeaponData then
                imageId = item_library:GetWeaponImageFromWeaponData(wd, true) or "";
            end;
            if imageId == "" and item_library.GetImageFromWeaponData then
                imageId = item_library:GetImageFromWeaponData(wd, true) or "";
            end;
            if imageId == "" and item_library.GetWeaponImage then
                imageId = item_library:GetWeaponImage(weaponName, true) or "";
            end;
        end);
        if imageId == "" and skinName ~= "" then
            imageId = getSkinImageId(skinName, true);
        end;
        if imageId == "" then
            local wn = cosmeticNorm(weaponName);
            for _, cdata in eli_pairs(cosmetic_lib.Cosmetics or {}) do
                if type(cdata) == "table" and cdata.Image and cdata.Type == "Skin" then
                    if type(cdata.Weapons) == "table" then
                        for _, w in eli_ipairs(cdata.Weapons) do
                            if cosmeticNorm(w) == wn then
                                imageId = cdata.Image;
                                break;
                            end;
                        end;
                    end;
                    if imageId ~= "" then break end;
                end;
            end;
        end;
        weaponImageCache[cacheKey] = imageId;
        return imageId;
    end;
    local function resolveCosmeticImage(cname, cosmeticType)
        cosmeticType = cosmeticType or "Skin";
        local cacheKey = cname .. "\0" .. cosmeticType;
        if cosmeticImageCache[cacheKey] ~= nil then
            return cosmeticImageCache[cacheKey];
        end;
        local imageId = "";
        local base = cosmetic_lib.Cosmetics and cosmetic_lib.Cosmetics[cname];
        if type(base) == "table" then
            imageId = base.Image or base.Icon or base.Thumbnail or base.TextureId or base.PreviewImage or base.WrapImage or base.ItemImage or "";
        end;
        if imageId == "" and cosmeticType == "Wrap" then
            imageId = getSkinImageId(cname, true);
        end;
        if imageId == "" and cosmeticType == "Wrap" and uiState.selectedWeapon then
            pcall(function()
                local wd = buildWeaponDataForImage(uiState.selectedWeapon);
                local wrapData = clone_cosmetic(cname, "Wrap");
                if wrapData then
                    wd.Wrap = wrapData;
                    local pend = uiState.pendingWrapOpts and uiState.pendingWrapOpts[uiState.selectedWeapon];
                    if pend and pend.inverted ~= nil then
                        wrapData.Inverted = pend.inverted;
                    end;
                end;
                if item_library.GetViewModelImageFromWeaponData then
                    imageId = item_library:GetViewModelImageFromWeaponData(wd, true) or "";
                end;
                if imageId == "" and item_library.GetWeaponImageFromWeaponData then
                    imageId = item_library:GetWeaponImageFromWeaponData(wd, true) or "";
                end;
            end);
        end;
        cosmeticImageCache[cacheKey] = imageId;
        return imageId;
    end;
    local function makeGridTile(parent, displayName, imageId, isActive, palette, onActivated, onRightClick)
        local main, _, font, outline, _, _, _, inactiveText = palette();
        local _, accent = palette();
        local tile = Instance.new("TextButton");
        tile.Text = "";
        tile.AutoButtonColor = false;
        tile.BackgroundColor3 = isActive and GRID_SELECT_BG or main;
        tile.BackgroundTransparency = 0;
        tile.BorderSizePixel = 1;
        tile.BorderMode = Enum.BorderMode.Inset;
        tile.BorderColor3 = isActive and accent or outline;
        tile.Parent = parent;
        local iconHolder = Instance.new("Frame");
        iconHolder.Name = "IconHolder";
        iconHolder.BackgroundTransparency = 1;
        iconHolder.Size = UDim2.new(1, -6, 1, -(GRID_LABEL_H + 4));
        iconHolder.Position = UDim2.fromOffset(3, 3);
        iconHolder.Parent = tile;
        local icon = Instance.new("ImageLabel");
        icon.Name = "Icon";
        icon.BackgroundTransparency = 1;
        icon.Size = UDim2.new(1, 0, 1, 0);
        icon.ScaleType = Enum.ScaleType.Fit;
        icon.Image = (imageId and imageId ~= "") and imageId or "";
        icon.Parent = iconHolder;
        local lbl = Instance.new("TextLabel");
        lbl.BackgroundTransparency = 1;
        lbl.Size = UDim2.new(1, -4, 0, GRID_LABEL_H);
        lbl.Position = UDim2.new(0, 2, 1, -(GRID_LABEL_H + 2));
        lbl.Font = Enum.Font.Code;
        lbl.TextSize = 8;
        lbl.TextWrapped = true;
        lbl.TextXAlignment = Enum.TextXAlignment.Center;
        lbl.TextYAlignment = Enum.TextYAlignment.Top;
        lbl.Text = string.lower(displayName or "");
        lbl.TextColor3 = isActive and font or inactiveText;
        lbl.Parent = tile;
        tile.MouseButton1Click:Connect(onActivated);
        if onRightClick then
            tile.MouseButton2Click:Connect(onRightClick);
        end;
        return tile;
    end;
    fitGridToFrame(weaponList, wl);
    fitGridToFrame(cosmeticList, cl);
    weaponList:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        fitGridToFrame(weaponList, wl);
        resizeGridCanvas(weaponList, wl);
    end);
    cosmeticList:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        fitGridToFrame(cosmeticList, cl);
        resizeGridCanvas(cosmeticList, cl);
    end);
    uiState.pendingCosmetics = uiState.pendingCosmetics or {};
    local function getUiPalette()
        local main = makeThemeColor("MainColor", Color3.fromRGB(30, 30, 30));
        local accent = makeThemeColor("AccentColor", Color3.fromRGB(107, 72, 255));
        local font = makeThemeColor("FontColor", Color3.fromRGB(235, 235, 235));
        local outline = makeThemeColor("OutlineColor", Color3.fromRGB(60, 60, 60));
        local inactiveText = Color3.new(math.clamp(font.R * 0.85, 0, 1), math.clamp(font.G * 0.85, 0, 1), math.clamp(font.B * 0.85, 0, 1));
        local activeBg = accent;
        local activeBorder = accent;
        local activeText = font;
        local activeBgTransparency = 0;
        return main, accent, font, outline, activeBg, activeBorder, activeText, inactiveText, activeBgTransparency;
    end;
    styleCosmeticActionButton = function(btn)
        if not btn then return end;
        local main, accent, font, outline = getUiPalette();
        btn.AutoButtonColor = false;
        btn.BorderSizePixel = 1;
        btn.BorderMode = Enum.BorderMode.Inset;
        btn.BackgroundColor3 = main;
        btn.BackgroundTransparency = 0;
        btn.BorderColor3 = outline;
        btn.TextColor3 = font;
        btn.Font = uiFont;
    end;
    uiState.previewSkin = uiState.previewSkin or nil;
    uiState.refreshWeapons = function()
        table.clear(weaponImageCache);
        fitGridToFrame(weaponList, wl);
        clearChildren(weaponList);
        local filter = string.lower(weaponSearch.Text or "");
        for _, w in eli_ipairs(getWeapons()) do
            if filter == "" or string.find(string.lower(w), filter, 1, true) then
                local isActive = uiState.selectedWeapon == w;
                makeGridTile(weaponList, w, resolveWeaponImage(w), isActive, getUiPalette, function()
                    uiState.selectedWeapon = w;
                    uiState.previewSkin = nil;
                    uiState.pendingCosmetics[w] = uiState.pendingCosmetics[w] or {};
                    if uiState.refreshWeapons then uiState.refreshWeapons() end;
                    if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
                    if syncWrapOptionsBar then syncWrapOptionsBar() end;
                end, function()
                    local ctype = uiState.selectedType or "Skin";
                    uiState.pendingCosmetics[w] = uiState.pendingCosmetics[w] or {};
                    uiState.pendingCosmetics[w][ctype] = nil;
                    pcall(function()
                        fireEquipCosmetic(w, ctype, "", {});
                    end);
                    uiState.previewSkin = nil;
                    task.defer(function()
                        if uiState.refreshWeapons then uiState.refreshWeapons() end;
                        if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
                    end);
                end);
            end;
        end;
        resizeGridCanvas(weaponList, wl);
    end;
    uiState.refreshCosmetics = function()
        table.clear(cosmeticImageCache);
        fitGridToFrame(cosmeticList, cl);
        clearChildren(cosmeticList);
        local selectedWeapon = uiState.selectedWeapon;
        if not selectedWeapon then
            local t = Instance.new("TextLabel");
            t.BackgroundTransparency = 1;
            t.Size = UDim2.new(1, -4, 0, 20);
            t.Text = "select a weapon first";
            t.Font = Enum.Font.Code;
            t.TextSize = 13;
            t.Parent = cosmeticList;
            return
        end;
        local filter = string.lower(cosmeticSearch.Text or "");
        local ctype = uiState.selectedType or "Skin";
        local main, _, _, outline, activeBg, activeBorder, activeText, inactiveText, activeBgTransparency = getUiPalette();
        local equippedName = equipped[selectedWeapon] and equipped[selectedWeapon][ctype] and equipped[selectedWeapon][ctype].Name;
        uiState.pendingCosmetics[selectedWeapon] = uiState.pendingCosmetics[selectedWeapon] or {};
        local pendingName = uiState.pendingCosmetics[selectedWeapon][ctype];
        for _, cname in eli_ipairs(getCosmeticsFor(selectedWeapon, ctype)) do
            if filter == "" or string.find(string.lower(cname), filter, 1, true) then
                local isActive = (equippedName == cname) or (pendingName == cname);
                makeGridTile(cosmeticList, cname, resolveCosmeticImage(cname, ctype), isActive, getUiPalette, function()
                    uiState.pendingCosmetics[selectedWeapon][ctype] = cname;
                    if ctype == "Skin" then
                        uiState.previewSkin = { weapon = selectedWeapon, name = cname };
                        if uiState.refreshWeapons then uiState.refreshWeapons() end;
                    end;
                    if ctype == "Wrap" then
                        uiState.pendingWrapOpts[selectedWeapon] = uiState.pendingWrapOpts[selectedWeapon] or {};
                        if uiState.pendingWrapOpts[selectedWeapon].inverted == nil then
                            local eqWrap = equipped[selectedWeapon] and equipped[selectedWeapon].Wrap;
                            uiState.pendingWrapOpts[selectedWeapon].inverted = eqWrap and eqWrap.Inverted == true or false;
                        end;
                    end;
                    pcall(function()
                        fireEquipCosmetic(selectedWeapon, ctype, cname, {});
                    end);
                    task.delay(0.05, function()
                        if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
                        if ctype == "Skin" and uiState.refreshWeapons then uiState.refreshWeapons() end;
                        if syncWrapOptionsBar then syncWrapOptionsBar() end;
                    end);
                end);
            end;
        end;
        resizeGridCanvas(cosmeticList, cl);
        local mainTab, accentTab, _, outlineTab, _, _, _, inactiveTextTab = getUiPalette();
        for tn, b in eli_pairs(typeButtons) do
            local active = tn == ctype;
            b.TextTransparency = active and 0 or 0.15;
            b.BackgroundColor3 = mainTab;
            b.BackgroundTransparency = 0;
            b.BorderColor3 = active and accentTab or outlineTab;
            b.TextColor3 = active and accentTab or inactiveTextTab;
        end;
        if syncWrapOptionsBar then syncWrapOptionsBar() end;
    end;
    applyBtn.MouseButton1Click:Connect(function()
        local selectedWeapon = uiState.selectedWeapon;
        local ctype = uiState.selectedType or "Skin";
        if not selectedWeapon then return end;
        local pendingByWeapon = uiState.pendingCosmetics[selectedWeapon];
        local cname = pendingByWeapon and pendingByWeapon[ctype];
        if not cname then return end;
        pcall(function()
            fireEquipCosmetic(selectedWeapon, ctype, cname, {});
        end);
        task.delay(0.05, function()
            if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
            if uiState.refreshWeapons then uiState.refreshWeapons() end;
            if syncWrapOptionsBar then syncWrapOptionsBar() end;
        end);
    end);
    weaponSearch:GetPropertyChangedSignal("Text"):Connect(function()
        if uiState.refreshWeapons then uiState.refreshWeapons() end;
    end);
    cosmeticSearch:GetPropertyChangedSignal("Text"):Connect(function()
        if uiState.refreshCosmetics then uiState.refreshCosmetics() end;
    end);
    uiState.gui = gui;
    uiState.frame = outer;
    uiState.inner = inner;
    uiState.panel = panel;
    uiState.accentBar = accentBar;
    uiState.selectedWeapon = uiState.selectedWeapon or nil;
    uiState.selectedType = uiState.selectedType or "Skin";
    uiState.dismissedThisSession = not showUi;
    uiState.refreshWeapons();
    uiState.refreshCosmetics();
    syncCosmeticChangerVisibility();
    local function applyCosmeticUiTheme()
        local main = makeThemeColor("MainColor", Color3.fromRGB(30, 30, 30));
        local bg = makeThemeColor("BackgroundColor", Color3.fromRGB(22, 22, 22));
        local accent = makeThemeColor("AccentColor", Color3.fromRGB(107, 72, 255));
        local font = makeThemeColor("FontColor", Color3.fromRGB(235, 235, 235));
        local outline = makeThemeColor("OutlineColor", Color3.fromRGB(60, 60, 60));
        outer.BackgroundColor3 = Color3.new(0, 0, 0);
        inner.BackgroundColor3 = main;
        panel.BackgroundColor3 = bg;
        if uiState.accentBar then
            uiState.accentBar.BackgroundColor3 = accent;
        end;
        resizer.BackgroundColor3 = accent;
        top.BackgroundColor3 = main;
        title.TextColor3 = font;
        closeBtn.BackgroundColor3 = main;
        closeBtn.TextColor3 = font;
        leftHolder.BackgroundColor3 = bg;
        rightHolder.BackgroundColor3 = bg;
        weaponSearch.BackgroundColor3 = main;
        weaponSearch.TextColor3 = font;
        weaponSearch.PlaceholderColor3 = Color3.new(font.R * 0.7, font.G * 0.7, font.B * 0.7);
        weaponSearch.BorderColor3 = outline;
        cosmeticSearch.BackgroundColor3 = main;
        cosmeticSearch.TextColor3 = font;
        cosmeticSearch.PlaceholderColor3 = Color3.new(font.R * 0.7, font.G * 0.7, font.B * 0.7);
        cosmeticSearch.BorderColor3 = outline;
        weaponList.BackgroundColor3 = main;
        weaponList.BorderColor3 = outline;
        cosmeticList.BackgroundColor3 = main;
        cosmeticList.BorderColor3 = outline;
        local ctypeNow = uiState.selectedType or "Skin";
        for tn, b in eli_pairs(typeButtons) do
            local active = tn == ctypeNow;
            b.BackgroundColor3 = main;
            b.BackgroundTransparency = 0;
            b.BorderColor3 = active and accent or outline;
            b.TextColor3 = active and accent or Color3.new(font.R * 0.85, font.G * 0.85, font.B * 0.85);
        end;
        bottomDivider.BackgroundColor3 = outline;
        skinHint.TextColor3 = Color3.new(font.R * 0.88, font.G * 0.88, font.B * 0.88);
        for _, key in eli_ipairs({ "Inverted", "Favorited" }) do
            local toggleData = wrapOptionToggles[key];
            if toggleData then
                toggleData.main = main;
                toggleData.accent = accent;
                toggleData.font = font;
                toggleData.outline = outline;
                styleThemedToggle(toggleData, toggleData.isOn == true);
            end;
        end;
        styleCosmeticActionButton(fallback);
        styleCosmeticActionButton(applyBtn);
        for _, d in eli_ipairs(panel:GetDescendants()) do
            if d:IsA("TextButton") and d ~= fallback and d ~= applyBtn then
                local skipBtn = d.Parent == weaponList or d.Parent == cosmeticList or d:IsDescendantOf(wrapToggleRow);
                if not skipBtn then
                    for _, tabBtn in eli_pairs(typeButtons) do
                        if d == tabBtn then
                            skipBtn = true;
                            break;
                        end;
                    end;
                end;
                if not skipBtn then
                    d.BorderColor3 = outline;
                    d.TextColor3 = font;
                    d.BackgroundColor3 = main;
                end;
            elseif d:IsA("TextLabel") and not d:IsDescendantOf(weaponList) and not d:IsDescendantOf(cosmeticList) then
                d.TextColor3 = font;
            end;
        end;
    end;
    applyCosmeticUiTheme();
    getgenv().ZRHUB_apply_cosmetic_theme = applyCosmeticUiTheme;
end;

v555:AddButton("cosmetic changer", function()
    openCosmeticChanger(true);
end);
task.defer(function()
    pcall(function()
        openCosmeticChanger(false);
    end);
end);
end

;(function()
    local spoof_box = Tabs.misc_tab:AddLeftTabbox();
    local localTab = spoof_box:AddTab("local");
    local otherTab = spoof_box:AddTab("other");

    local http = game:GetService("HttpService");

    ELI.profile = ELI.profile or {};
    local prof = ELI.profile;
    if prof.spoof_local == nil then prof.spoof_local = false end;
    if prof.spoof_local_name == nil then prof.spoof_local_name = "" end;
    if prof.spoof_other == nil then prof.spoof_other = false end;
    if prof.spoof_other_name == nil then prof.spoof_other_name = "" end;

    local userCache = {};

    local function fetchUser(username)
        if not username or username == "" then return nil end;
        if userCache[username] then return userCache[username] end;
        local id;
        local ok = pcall(function()
            id = players:GetUserIdFromNameAsync(username);
        end);
        if not ok or not id then return nil end;
        local data = { id = id, name = username, displayName = username };
        pcall(function()
            local raw = game:HttpGet("https://users.roblox.com/v1/users/" .. tostring(id), true);
            local dec = http:JSONDecode(raw);
            if type(dec) == "table" and dec.id then
                data = { id = dec.id, name = dec.name, displayName = dec.displayName };
            end;
        end);
        userCache[username] = data;
        return data;
    end;

    local function applyIdentity(player, data)
        pcall(function() player.Name = data.name end);
        pcall(function() player.UserId = data.id end);
        pcall(function() player.CharacterAppearanceId = data.id end);
        pcall(function() player.DisplayName = data.displayName end);
        local char = player.Character;
        if char then
            pcall(function() char.Name = data.name end);
            local h = char:FindFirstChildOfClass("Humanoid");
            if h then
                pcall(function()
                    h.DisplayName = data.displayName;
                    local old = h.DisplayDistanceType;
                    h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                    h.DisplayDistanceType = old;
                end);
            end;
        end;
    end;

    local function applyAppearance(player, victimId)
        local character = player.Character;
        if not character then return end;
        local humanoid = character:FindFirstChildOfClass("Humanoid");
        if not humanoid then return end;
        local ok, appearance = pcall(function() return players:GetCharacterAppearanceAsync(victimId) end);
        if not ok or not appearance then return end;
        for _, v in eli_pairs(character:GetChildren()) do
            if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic") then
                v:Destroy();
            end;
        end;
        for _, v in eli_pairs(appearance:GetChildren()) do
            if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                v.Parent = character;
            elseif v:IsA("Accessory") then
                pcall(function() humanoid:AddAccessory(v) end);
            end;
        end;
        pcall(function() appearance:Destroy() end);
        local targetHead = character:FindFirstChild("Head");
        if targetHead then
            pcall(function()
                local json = game:HttpGet("https://avatar.roblox.com/v1/users/" .. tostring(victimId) .. "/avatar", true);
                local info = http:JSONDecode(json);
                local faceId, hasDynamic = nil, false;
                for _, asset in eli_pairs(info.assets or {}) do
                    if asset.assetType then
                        if asset.assetType.id == 18 then
                            faceId = asset.id;
                        elseif asset.assetType.id == 79 then
                            hasDynamic = true;
                        end;
                    end;
                end;
                if faceId then
                    local tex;
                    local objs = game:GetObjects("rbxassetid://" .. tostring(faceId));
                    for _, obj in eli_pairs(objs) do
                        if obj:IsA("Decal") then
                            tex = obj.Texture;
                        else
                            for _, ch in eli_pairs(obj:GetDescendants()) do
                                if ch:IsA("Decal") then
                                    tex = ch.Texture;
                                    break;
                                end;
                            end;
                        end;
                        if tex then break end;
                    end;
                    if tex then
                        local face = targetHead:FindFirstChild("face");
                        if face then
                            face.Texture = tex;
                        else
                            local nf = Instance.new("Decal");
                            nf.Name = "face";
                            nf.Texture = tex;
                            nf.Parent = targetHead;
                        end;
                    end;
                elseif not hasDynamic then
                    if targetHead:FindFirstChild("face") then targetHead.face:Destroy() end;
                    targetHead.Transparency = 1;
                    local mesh = targetHead:FindFirstChildOfClass("SpecialMesh");
                    if mesh then mesh.Scale = Vector3.new(0, 0, 0) end;
                end;
            end);
        end;
    end;

    local applied = {};

    local function spoofPlayer(player, username)
        task.spawn(function()
            local data = fetchUser(username);
            if not data then return end;
            applied[player] = data;
            applyIdentity(player, data);
            applyAppearance(player, data.id);
        end);
    end;

    local function doLocal()
        if not prof.spoof_local or prof.spoof_local_name == "" then return end;
        spoofPlayer(local_player, prof.spoof_local_name);
    end;

    local function doOtherPlayer(plr)
        if not prof.spoof_other or prof.spoof_other_name == "" then return end;
        if plr == local_player then return end;
        spoofPlayer(plr, prof.spoof_other_name);
    end;

    local function doOtherAll()
        for _, plr in eli_ipairs(players:GetPlayers()) do
            doOtherPlayer(plr);
        end;
    end;

    localTab:AddToggle("SpoofLocal", {
        Text = "local",
        Default = false,
        Callback = function(val)
            prof.spoof_local = val;
            if val then doLocal() end;
        end
    });

    local localNameStamp = 0;
    localTab:AddInput("SpoofLocalName", {
        Text = "name",
        Default = "",
        Placeholder = "username...",
        Callback = function(val)
            prof.spoof_local_name = val or "";
            localNameStamp = tick();
            local stamp = localNameStamp;
            task.delay(0.6, function()
                if stamp == localNameStamp and prof.spoof_local then
                    doLocal();
                end;
            end);
        end
    });

    otherTab:AddToggle("SpoofOther", {
        Text = "other",
        Default = false,
        Callback = function(val)
            prof.spoof_other = val;
            if val then doOtherAll() end;
        end
    });

    local otherNameStamp = 0;
    otherTab:AddInput("SpoofOtherName", {
        Text = "name",
        Default = "",
        Placeholder = "username...",
        Callback = function(val)
            prof.spoof_other_name = val or "";
            otherNameStamp = tick();
            local stamp = otherNameStamp;
            task.delay(0.6, function()
                if stamp == otherNameStamp and prof.spoof_other then
                    doOtherAll();
                end;
            end);
        end
    });

    trove:Add(local_player.CharacterAdded:Connect(function()
        task.wait(0.5);
        doLocal();
    end));

    local function hookOther(plr)
        trove:Add(plr.CharacterAdded:Connect(function()
            task.wait(0.5);
            doOtherPlayer(plr);
        end));
    end;

    for _, plr in eli_ipairs(players:GetPlayers()) do
        if plr ~= local_player then
            hookOther(plr);
        end;
    end;

    trove:Add(players.PlayerAdded:Connect(function(plr)
        hookOther(plr);
        doOtherPlayer(plr);
    end));

    local lastReapply = 0;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        local now = tick();
        if now - lastReapply < 1 then return end;
        lastReapply = now;
        if prof.spoof_local and prof.spoof_local_name ~= "" and applied[local_player] then
            applyIdentity(local_player, applied[local_player]);
        end;
        if prof.spoof_other and prof.spoof_other_name ~= "" then
            for _, plr in eli_ipairs(players:GetPlayers()) do
                if plr ~= local_player and applied[plr] then
                    applyIdentity(plr, applied[plr]);
                end;
            end;
        end;
    end)));
end)()

;(function()
    local cfg = ELI;
    local material_presets = getgenv().ZRHUB_materials.presets;
    local material_preset_names = getgenv().ZRHUB_materials.names;
    local enhance_box = Tabs.visualstab:AddLeftTabbox();
    local chams_tab = enhance_box:AddTab("chams");
    local crosshair_tab = Tabs.visualstab:AddRightTabbox();

    local highlights = {};
    local body_parts = {};

    local function drop_highlight(plr)
        if highlights[plr] then
            pcall(function() highlights[plr]:Destroy() end);
            highlights[plr] = nil;
        end;
    end;

    local function restore_body(plr)
        local saved = body_parts[plr];
        if not saved then return end;
        for part, props in eli_pairs(saved) do
            if part.Parent then
                part.Material = props.material;
                part.Color = props.color;
                part.Reflectance = props.reflectance;
                part.Transparency = props.transparency;
                for tex, transparency in eli_pairs(props.textures) do
                    if tex.Parent then tex.Transparency = transparency end;
                end;
            end;
        end;
        body_parts[plr] = nil;
    end;

    local function drop_chams(plr)
        drop_highlight(plr);
        restore_body(plr);
    end;

    local function clear_chams()
        for plr in eli_pairs(highlights) do drop_highlight(plr) end;
        for plr in eli_pairs(body_parts) do restore_body(plr) end;
    end;

    local function apply_highlight(plr, char)
        local hl = highlights[plr];
        if not hl or not hl.Parent then
            hl = Instance.new("Highlight");
            hl.Name = "ZRHUB_chams";
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            highlights[plr] = hl;
            hl.Parent = char;
        end;
        hl.Adornee = char;
        hl.FillColor = cfg.chams.fill_color;
        hl.FillTransparency = cfg.chams.fill_transparency;
        hl.OutlineColor = cfg.chams.outline_color;
        hl.OutlineTransparency = cfg.chams.outline_transparency;
    end;

    local function apply_body(plr, char)
        local preset = material_presets[cfg.chams.material] or material_presets.Neon;
        local saved = body_parts[plr];
        if not saved then
            saved = {};
            body_parts[plr] = saved;
        end;
        local transparency = preset.transparency or 0;
        if cfg.chams.ghost then transparency = math.max(transparency, 0.55) end;
        for _, part in eli_ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 then
                if not saved[part] then
                    local textures = {};
                    for _, tex in eli_ipairs(part:GetChildren()) do
                        if tex:IsA("Decal") or tex:IsA("Texture") then
                            textures[tex] = tex.Transparency;
                        end;
                    end;
                    saved[part] = {
                        material = part.Material,
                        color = part.Color,
                        reflectance = part.Reflectance,
                        transparency = part.Transparency,
                        textures = textures,
                    };
                end;
                part.Material = preset.material;
                part.Color = cfg.chams.fill_color;
                part.Reflectance = preset.reflectance or 0;
                part.Transparency = transparency;
                if cfg.chams.strip_textures then
                    for tex in eli_pairs(saved[part].textures) do
                        if tex.Parent then tex.Transparency = 1 end;
                    end;
                end;
            end;
        end;
    end;

    local function apply_chams(plr)
        if plr == local_player then return end;
        local char = plr.Character;
        if not char then return drop_chams(plr) end;
        local humanoid = char:FindFirstChildOfClass("Humanoid");
        if not humanoid or humanoid.Health <= 0 then
            return drop_chams(plr);
        end;
        if cfg.chams.team_check and plr:GetAttribute("TeamID") == local_player:GetAttribute("TeamID") then
            return drop_chams(plr);
        end;
        if cfg.chams.mode == "chams" then
            drop_highlight(plr);
            apply_body(plr, char);
        else
            restore_body(plr);
            apply_highlight(plr, char);
        end;
    end;

    local chams_last = 0;
    trove:Add(run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        if not cfg.chams.enable then
            if next(highlights) or next(body_parts) then clear_chams() end;
            return
        end;
        local now = tick();
        if now - chams_last < 0.2 then return end;
        chams_last = now;
        for _, plr in eli_ipairs(players:GetPlayers()) do
            apply_chams(plr);
        end;
        for plr in eli_pairs(highlights) do
            if not plr.Parent then drop_highlight(plr) end;
        end;
        for plr in eli_pairs(body_parts) do
            if not plr.Parent then body_parts[plr] = nil end;
        end;
    end)));
    trove:Add(clear_chams);

    local function sync_chams_visibility()
        local body_mode = cfg.chams.mode == "chams";
        Options.ChamsMaterial:SetVisible(body_mode);
        Options.ChamsStripTextures:SetVisible(body_mode);
        Options.ChamsGhost:SetVisible(body_mode);
    end;

    chams_tab:AddToggle("ChamsEnable", {
        Text = "enable",
        Default = false,
        Callback = function(v)
            cfg.chams.enable = v;
            if not v then clear_chams() end;
        end
    });

    chams_tab:AddToggle("ChamsTeamCheck", {
        Text = "team check",
        Default = false,
        Callback = function(v)
            cfg.chams.team_check = v;
        end
    });

    chams_tab:AddDropdown("ChamsMode", {
        Text = "type",
        Default = "highlight",
        Values = { "highlight", "chams" },
        Callback = function(v)
            clear_chams();
            cfg.chams.mode = v;
            sync_chams_visibility();
        end
    });

    chams_tab:AddLabel("fill"):AddColorPicker("ChamsFill", {
        Default = Color3.fromRGB(0, 170, 255),
        Transparency = 0.5,
        Callback = function(color, transparency)
            cfg.chams.fill_color = color;
            cfg.chams.fill_transparency = transparency or cfg.chams.fill_transparency;
        end
    });

    chams_tab:AddLabel("outline"):AddColorPicker("ChamsOutline", {
        Default = Color3.fromRGB(255, 255, 255),
        Transparency = 0,
        Callback = function(color, transparency)
            cfg.chams.outline_color = color;
            cfg.chams.outline_transparency = transparency or cfg.chams.outline_transparency;
        end
    });

    chams_tab:AddDropdown("ChamsMaterial", {
        Text = "material",
        Default = "Neon",
        Values = material_preset_names,
        Visible = false,
        Callback = function(v)
            cfg.chams.material = v;
        end
    });

    chams_tab:AddToggle("ChamsStripTextures", {
        Text = "strip textures",
        Default = false,
        Visible = false,
        Callback = function(v)
            cfg.chams.strip_textures = v;
        end
    });

    chams_tab:AddToggle("ChamsGhost", {
        Text = "ghost",
        Default = false,
        Visible = false,
        Callback = function(v)
            cfg.chams.ghost = v;
        end
    });

    local ch_lines, ch_line_outlines = {}, {};
    for i = 1, 4 do
        local outline = Drawing.new("Line");
        outline.Visible = false;
        outline.Thickness = 3;
        outline.Transparency = 1;
        outline.Color = Color3.new(0, 0, 0);
        ch_line_outlines[i] = outline;

        local l = Drawing.new("Line");
        l.Visible = false;
        l.Thickness = 1;
        l.Transparency = 1;
        ch_lines[i] = l;
    end;
    local ch_ring_outline = Drawing.new("Circle");
    ch_ring_outline.Filled = false;
    ch_ring_outline.NumSides = 48;
    ch_ring_outline.Thickness = 3;
    ch_ring_outline.Transparency = 1;
    ch_ring_outline.Color = Color3.new(0, 0, 0);
    ch_ring_outline.Visible = false;
    local ch_ring = Drawing.new("Circle");
    ch_ring.Filled = false;
    ch_ring.NumSides = 48;
    ch_ring.Thickness = 1;
    ch_ring.Transparency = 1;
    ch_ring.Visible = false;
    local ch_dot_outline = Drawing.new("Circle");
    ch_dot_outline.Filled = true;
    ch_dot_outline.NumSides = 24;
    ch_dot_outline.Radius = 1;
    ch_dot_outline.Transparency = 1;
    ch_dot_outline.Color = Color3.new(0, 0, 0);
    ch_dot_outline.Visible = false;
    local ch_dot = Drawing.new("Circle");
    ch_dot.Filled = true;
    ch_dot.NumSides = 24;
    ch_dot.Radius = 1;
    ch_dot.Transparency = 1;
    ch_dot.Visible = false;

    local ch_text_gui = Instance.new("ScreenGui");
    ch_text_gui.Name = "ZRHUB_crosshair_text";
    ch_text_gui.ResetOnSpawn = false;
    ch_text_gui.IgnoreGuiInset = true;
    ch_text_gui.DisplayOrder = 999;
    ch_text_gui.Parent = gethui();
    local ch_text = Instance.new("TextLabel");
    ch_text.BackgroundTransparency = 1;
    ch_text.AnchorPoint = Vector2.new(0.5, 0);
    ch_text.Size = UDim2.fromOffset(0, 0);
    ch_text.AutomaticSize = Enum.AutomaticSize.XY;
    ch_text.TextXAlignment = Enum.TextXAlignment.Center;
    ch_text.Visible = false;
    ch_text.Parent = ch_text_gui;

    local ch_text_fonts = {};
    local function ch_get_font(name)
        if ch_text_fonts[name] then return ch_text_fonts[name] end;
        local font;
        if name == "Inconsolata" then
            local ok, f = pcall(Font.fromName, "Inconsolata");
            font = ok and f or Font.fromEnum(Enum.Font.Code);
        elseif name == "UI" then
            font = Font.fromEnum(Enum.Font.GothamMedium);
        elseif name == "System" then
            font = Font.fromEnum(Enum.Font.SourceSans);
        elseif name == "Monospace" then
            font = Font.fromEnum(Enum.Font.RobotoMono);
        else
            font = Font.fromEnum(Enum.Font.Code);
        end;
        ch_text_fonts[name] = font;
        return font;
    end;

    local function hide_ch_lines()
        for i = 1, 4 do
            ch_lines[i].Visible = false;
            ch_line_outlines[i].Visible = false;
        end;
    end;
    local function hide_crosshair()
        hide_ch_lines();
        ch_ring.Visible = false;
        ch_ring_outline.Visible = false;
        ch_dot.Visible = false;
        ch_dot_outline.Visible = false;
        ch_text.Visible = false;
    end;

    local ch_spin = 0;
    local ch_clock = 0;

    local function ch_anchor()
        local c = cfg.crosshair;
        if c.follow_target then
            if c.follow_source == "gunpoint" and GetMuzzlePos then
                local mp = GetMuzzlePos();
                if mp then return mp end;
            else
                local t = (getclosest and getclosest()) or (getclosest2 and getclosest2());
                if t and t.Character then
                    local part = t.Character:FindFirstChild(ELI.targeting.part) or t.Character:FindFirstChild("HumanoidRootPart");
                    if part then
                        local sp, on = camera:WorldToViewportPoint(part.Position);
                        if on then return Vector2.new(sp.X, sp.Y) end;
                    end;
                end;
            end;
        end;
        local vp = camera.ViewportSize;
        return Vector2.new(vp.X / 2, vp.Y / 2);
    end;

    local function ch_arms(style, gap, length)
        if style == "t" then
            return {
                { Vector2.new(0, gap), Vector2.new(0, gap + length), "bottom_line" },
                { Vector2.new(-gap, 0), Vector2.new(-gap - length, 0), "left_line" },
                { Vector2.new(gap, 0), Vector2.new(gap + length, 0), "right_line" },
            };
        elseif style == "x" then
            local d = 0.70710678;
            return {
                { Vector2.new(-d, -d) * gap, Vector2.new(-d, -d) * (gap + length), "top_line" },
                { Vector2.new(d, d) * gap, Vector2.new(d, d) * (gap + length), "bottom_line" },
                { Vector2.new(-d, d) * gap, Vector2.new(-d, d) * (gap + length), "left_line" },
                { Vector2.new(d, -d) * gap, Vector2.new(d, -d) * (gap + length), "right_line" },
            };
        end;
        return {
            { Vector2.new(0, -gap), Vector2.new(0, -gap - length), "top_line" },
            { Vector2.new(0, gap), Vector2.new(0, gap + length), "bottom_line" },
            { Vector2.new(-gap, 0), Vector2.new(-gap - length, 0), "left_line" },
            { Vector2.new(gap, 0), Vector2.new(gap + length, 0), "right_line" },
        };
    end;

    local function local_speed()
        local char = local_player.Character;
        local root = char and char:FindFirstChild("HumanoidRootPart");
        if not root then return 0 end;
        local vel = root.AssemblyLinearVelocity;
        return Vector2.new(vel.X, vel.Z).Magnitude;
    end;

    trove:Add(run_service.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(dt)
        local c = cfg.crosshair;
        if not c.enable then
            hide_crosshair();
            return
        end;

        ch_clock += dt;
        if c.rotating then
            ch_spin = (ch_spin + c.rotating_speed * dt) % 360;
        end;
        local rad = math.rad(c.rotation + (c.rotating and ch_spin or 0));
        local cosv, sinv = math.cos(rad), math.sin(rad);

        local anchor = ch_anchor();

        local length = c.length;
        local gap = c.gap;
        if c.animation then
            local wave = (math.sin(ch_clock * c.animation_speed) + 1) * 0.5;
            if c.animation_mode == "breathe" then
                gap = gap + wave * length * 0.6;
            else
                length = length * (0.55 + wave * 0.45);
            end;
        end;
        if c.spread then
            gap = gap + math.clamp(local_speed() * 0.12 * c.spread_scale, 0, 60);
        end;

        local color = c.color;
        if c.fade then
            color = c.color:Lerp(c.fade_color, (math.sin(ch_clock * 1.5) + 1) * 0.5);
        end;
        local transparency = 1;
        if c.shimmer then
            transparency = 0.45 + (math.sin(ch_clock * c.shimmer_speed) + 1) * 0.5 * 0.55;
        end;
        local thick = c.thickness;

        if c.style == "circle" then
            hide_ch_lines();
            ch_dot.Visible = false;
            ch_dot_outline.Visible = false;
            if c.outline then
                ch_ring_outline.Position = anchor;
                ch_ring_outline.Radius = length;
                ch_ring_outline.Color = c.outline_color;
                ch_ring_outline.Thickness = thick + 2;
                ch_ring_outline.Transparency = transparency;
                ch_ring_outline.Visible = true;
            else
                ch_ring_outline.Visible = false;
            end;
            ch_ring.Position = anchor;
            ch_ring.Radius = length;
            ch_ring.Color = color;
            ch_ring.Thickness = thick;
            ch_ring.Transparency = transparency;
            ch_ring.Visible = true;
        elseif c.style == "dot" then
            hide_ch_lines();
            ch_ring.Visible = false;
            ch_ring_outline.Visible = false;
        else
            ch_ring.Visible = false;
            ch_ring_outline.Visible = false;
            local arms = ch_arms(c.style, gap, length);
            for i = 1, 4 do
                local arm = arms[i];
                local l = ch_lines[i];
                local o = ch_line_outlines[i];
                if c.lines and arm and c[arm[3]] then
                    local f, t = arm[1], arm[2];
                    local fr = Vector2.new(f.X * cosv - f.Y * sinv, f.X * sinv + f.Y * cosv);
                    local tr = Vector2.new(t.X * cosv - t.Y * sinv, t.X * sinv + t.Y * cosv);
                    local from = anchor + fr;
                    local to = anchor + tr;
                    if c.outline then
                        o.From = from;
                        o.To = to;
                        o.Color = c.outline_color;
                        o.Thickness = thick + 2;
                        o.Transparency = transparency;
                        o.Visible = true;
                    else
                        o.Visible = false;
                    end;
                    l.From = from;
                    l.To = to;
                    l.Color = color;
                    l.Thickness = thick;
                    l.Transparency = transparency;
                    l.Visible = true;
                else
                    l.Visible = false;
                    o.Visible = false;
                end;
            end;
        end;

        if c.dot or c.style == "dot" then
            local radius = math.max(thick, 1);
            if c.outline then
                ch_dot_outline.Position = anchor;
                ch_dot_outline.Color = c.outline_color;
                ch_dot_outline.Radius = radius + 1;
                ch_dot_outline.Transparency = transparency;
                ch_dot_outline.Visible = true;
            else
                ch_dot_outline.Visible = false;
            end;
            ch_dot.Position = anchor;
            ch_dot.Color = color;
            ch_dot.Radius = radius;
            ch_dot.Transparency = transparency;
            ch_dot.Visible = true;
        else
            ch_dot.Visible = false;
            ch_dot_outline.Visible = false;
        end;

        if c.text_enable and c.text_content ~= "" then
            local text_color = c.text_color;
            if c.text_animation then
                text_color = Color3.fromHSV((ch_clock * 0.15) % 1, 0.65, 1);
            end;
            ch_text.Text = c.text_content;
            ch_text.FontFace = ch_get_font(c.text_font);
            ch_text.TextSize = c.text_size;
            ch_text.TextColor3 = text_color;
            ch_text.TextStrokeTransparency = c.text_outline and 0 or 1;
            ch_text.Position = UDim2.fromOffset(anchor.X, anchor.Y + gap + length + c.text_offset);
            ch_text.Visible = true;
        else
            ch_text.Visible = false;
        end;
    end)));

    trove:Add(function()
        hide_crosshair();
        for i = 1, 4 do
            pcall(function() ch_lines[i]:Remove() end);
            pcall(function() ch_line_outlines[i]:Remove() end);
        end;
        pcall(function() ch_ring:Remove() end);
        pcall(function() ch_ring_outline:Remove() end);
        pcall(function() ch_dot:Remove() end);
        pcall(function() ch_dot_outline:Remove() end);
        pcall(function() ch_text_gui:Destroy() end);
    end);

    local crosshair_box = crosshair_tab:AddTab("crosshair"); do
        crosshair_box:AddToggle("CrosshairEnable", {
            Text = "enabled",
            Default = false,
            Callback = function(v)
                cfg.crosshair.enable = v;
            end
        }):AddColorPicker("CrosshairColor", {
            Default = Color3.fromRGB(0, 255, 170),
            Callback = function(v)
                cfg.crosshair.color = v;
            end
        });

        crosshair_box:AddDropdown("CrosshairStyle", {
            Text = "style",
            Default = "cross",
            Values = { "cross", "t", "x", "circle", "dot" },
            Callback = function(v)
                cfg.crosshair.style = v;
            end
        });

        crosshair_box:AddToggle("CrosshairLines", {
            Text = "lines",
            Default = true,
            Callback = function(v)
                cfg.crosshair.lines = v;
            end
        });

        crosshair_box:AddSlider("CrosshairRotation", {
            Text = "rotation",
            Default = 0,
            Min = 0,
            Max = 360,
            Rounding = 0,
            Suffix = "°",
            Callback = function(v)
                cfg.crosshair.rotation = v;
            end
        });

        crosshair_box:AddSlider("CrosshairLength", {
            Text = "length",
            Default = 6,
            Min = 0,
            Max = 40,
            Rounding = 0,
            Callback = function(v)
                cfg.crosshair.length = v;
            end
        });

        crosshair_box:AddSlider("CrosshairThickness", {
            Text = "thickness",
            Default = 1,
            Min = 1,
            Max = 6,
            Rounding = 0,
            Callback = function(v)
                cfg.crosshair.thickness = v;
            end
        });

        crosshair_box:AddSlider("CrosshairGap", {
            Text = "gap",
            Default = 3,
            Min = 0,
            Max = 20,
            Rounding = 0,
            Callback = function(v)
                cfg.crosshair.gap = v;
            end
        });

        crosshair_box:AddToggle("CrosshairOutline", {
            Text = "outline",
            Default = false,
            Callback = function(v)
                cfg.crosshair.outline = v;
            end
        }):AddColorPicker("CrosshairOutlineColor", {
            Default = Color3.fromRGB(0, 0, 0),
            Callback = function(v)
                cfg.crosshair.outline_color = v;
            end
        });

        crosshair_box:AddToggle("CrosshairTopLine", {
            Text = "top line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.top_line = v;
            end
        });

        crosshair_box:AddToggle("CrosshairBottomLine", {
            Text = "bottom line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.bottom_line = v;
            end
        });
    end;

    local lines_box = crosshair_tab:AddTab("lines"); do
        lines_box:AddToggle("CrosshairDot", {
            Text = "center dot",
            Default = false,
            Callback = function(v)
                cfg.crosshair.dot = v;
            end
        });

        lines_box:AddToggle("CrosshairLineOutline", {
            Text = "outline",
            Default = false,
            Callback = function(v)
                cfg.crosshair.outline = v;
            end
        });

        lines_box:AddToggle("CrosshairTop", {
            Text = "top line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.top_line = v;
            end
        });

        lines_box:AddToggle("CrosshairBottom", {
            Text = "bottom line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.bottom_line = v;
            end
        });

        lines_box:AddToggle("CrosshairLeft", {
            Text = "left line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.left_line = v;
            end
        });

        lines_box:AddToggle("CrosshairRight", {
            Text = "right line",
            Default = true,
            Callback = function(v)
                cfg.crosshair.right_line = v;
            end
        });
    end;

    local effects_box = crosshair_tab:AddTab("effects"); do
        effects_box:AddToggle("CrosshairRotating", {
            Text = "rotating",
            Default = false,
            Callback = function(v)
                cfg.crosshair.rotating = v;
            end
        });

        effects_box:AddSlider("CrosshairRotatingSpeed", {
            Text = "speed",
            Default = 120,
            Min = 0,
            Max = 720,
            Rounding = 0,
            Suffix = "°/s",
            Callback = function(v)
                cfg.crosshair.rotating_speed = v;
            end
        });

        effects_box:AddToggle("CrosshairSpread", {
            Text = "spread",
            Default = false,
            Callback = function(v)
                cfg.crosshair.spread = v;
            end
        });

        effects_box:AddSlider("CrosshairSpreadScale", {
            Text = "spread scale",
            Default = 1,
            Min = 0,
            Max = 4,
            Rounding = 2,
            Callback = function(v)
                cfg.crosshair.spread_scale = v;
            end
        });

        effects_box:AddToggle("CrosshairAnimation", {
            Text = "animation",
            Default = false,
            Callback = function(v)
                cfg.crosshair.animation = v;
            end
        });

        effects_box:AddDropdown("CrosshairAnimationMode", {
            Text = "mode",
            Default = "pulse",
            Values = { "pulse", "breathe" },
            Callback = function(v)
                cfg.crosshair.animation_mode = v;
            end
        });

        effects_box:AddSlider("CrosshairAnimationSpeed", {
            Text = "speed",
            Default = 3,
            Min = 0.1,
            Max = 12,
            Rounding = 1,
            Callback = function(v)
                cfg.crosshair.animation_speed = v;
            end
        });

        effects_box:AddToggle("CrosshairFade", {
            Text = "fade color",
            Default = false,
            Callback = function(v)
                cfg.crosshair.fade = v;
            end
        }):AddColorPicker("CrosshairFadeColor", {
            Default = Color3.fromRGB(255, 0, 170),
            Callback = function(v)
                cfg.crosshair.fade_color = v;
            end
        });

        effects_box:AddToggle("CrosshairFollowTarget", {
            Text = "follow target",
            Default = false,
            Callback = function(v)
                cfg.crosshair.follow_target = v;
            end
        });

        effects_box:AddDropdown("CrosshairFollowSource", {
            Text = "follow source",
            Default = "target",
            Values = { "target", "gunpoint" },
            Callback = function(v)
                cfg.crosshair.follow_source = v;
            end
        });

        effects_box:AddToggle("CrosshairShimmer", {
            Text = "shimmer",
            Default = false,
            Callback = function(v)
                cfg.crosshair.shimmer = v;
            end
        });

        effects_box:AddSlider("CrosshairShimmerSpeed", {
            Text = "shimmer speed",
            Default = 4,
            Min = 0.1,
            Max = 12,
            Rounding = 1,
            Callback = function(v)
                cfg.crosshair.shimmer_speed = v;
            end
        });
    end;

    local text_box = crosshair_tab:AddTab("text"); do
        text_box:AddToggle("CrosshairTextEnable", {
            Text = "enabled",
            Default = false,
            Callback = function(v)
                cfg.crosshair.text_enable = v;
            end
        }):AddColorPicker("CrosshairTextColor", {
            Default = Color3.fromRGB(255, 255, 255),
            Callback = function(v)
                cfg.crosshair.text_color = v;
            end
        });

        text_box:AddInput("CrosshairTextContent", {
            Text = "content",
            Default = "ZRHUB",
            ClearTextOnFocus = false,
            Callback = function(v)
                cfg.crosshair.text_content = v;
            end
        });

        text_box:AddDropdown("CrosshairTextFont", {
            Text = "font",
            Default = "Plex",
            Values = { "UI", "System", "Plex", "Monospace", "Inconsolata" },
            Callback = function(v)
                cfg.crosshair.text_font = v;
            end
        });

        text_box:AddSlider("CrosshairTextSize", {
            Text = "size",
            Default = 16,
            Min = 8,
            Max = 48,
            Rounding = 0,
            Callback = function(v)
                cfg.crosshair.text_size = v;
            end
        });

        text_box:AddSlider("CrosshairTextOffset", {
            Text = "offset",
            Default = 18,
            Min = 0,
            Max = 120,
            Rounding = 0,
            Callback = function(v)
                cfg.crosshair.text_offset = v;
            end
        });

        text_box:AddToggle("CrosshairTextOutline", {
            Text = "outline",
            Default = true,
            Callback = function(v)
                cfg.crosshair.text_outline = v;
            end
        });

        text_box:AddToggle("CrosshairTextAnimation", {
            Text = "animation",
            Default = false,
            Callback = function(v)
                cfg.crosshair.text_animation = v;
            end
        });
    end;
end)();

local character_tab = Tabs.character_tab; do
    local movement_tab = Tabs.character_tab:AddRightGroupbox('movement', 'footprints'); do
        keybind_slide_boost_enable = false;
        keybind_infinite_double_jump_enable = false;

        keybind_walkspeed_enable = false;
        movement_tab:AddToggle('walkspeed_enable', {
            Text = 'walkspeed',
            Default = false,
            Callback = function(v)
                keybind_walkspeed_enable = v;
                ELI.walkspeed.enable = v;
            end;
        }):AddKeyPicker('walkspeed_keybind', {
            Default = '',
            Text = 'walkspeed',
            NoUI = false,
            EnableCheck = function()
                return ELI.walkspeed.enable;
            end,
            Callback = function(v)
                ELI.walkspeed.enable = keybind_walkspeed_enable and v or false;
            end;
        });

        movement_tab:AddSlider('walkspeed_multiplier', {
            Text = 'multiplier',
            Default = 1.5,
            Min = 1,
            Max = 10,
            Rounding = 2,
            Suffix = 'x',
            Callback = function(v)
                ELI.walkspeed.multiplier = v;
            end;
        });

        movement_tab:AddToggle('infinite_double_jump_enable', {
            Text = 'infinite double jump',
            Default = false,
            Callback = function(v)
                keybind_infinite_double_jump_enable = v;
                ELI.infinite_double_jump.enable = v;
            end;
        }):AddKeyPicker('infinite_double_jump_keybind', {
            Default = '',
            Text = 'infinite double jump',
            NoUI = false,
            EnableCheck = function()
                return ELI.infinite_double_jump.enable;
            end,
            Callback = function(v)
                ELI.infinite_double_jump.enable = keybind_infinite_double_jump_enable and v or false;
            end;
        });

        movement_tab:AddToggle('slide_boost_enable', {
            Text = 'slide boost',
            Default = false,
            Callback = function(v)
                keybind_slide_boost_enable = v;
                ELI.slide_boost.enable = v;
            end;
        }):AddKeyPicker('slide_boost_keybind', {
            Default = '',
            Text = 'slide boost',
            NoUI = false,
            EnableCheck = function()
                return ELI.slide_boost.enable;
            end,
            Callback = function(v)
                ELI.slide_boost.enable = keybind_slide_boost_enable and v or false;
            end;
        });

        movement_tab:AddToggle('double_jump_height_enable', {
            Text = 'double jump height',
            Default = false,
            Callback = function(v)
                ELI.double_jump_height.enable = v;
                if not v then
                    mechanics_controller._original_jump_power = old_jump_fist;
                end;
            end;
        });
        movement_tab:AddSlider('slide_boost_spped', {
            Text = 'height',
            Default = 50,
            Min = 1,
            Max = 150,
            Rounding = 1,
            Callback = function(v)
                ELI.double_jump_height.height = v;
            end;
        });

        movement_tab:AddToggle('auto_slide_enable', {
            Text = 'auto slide',
            Default = false,
            Callback = function(v)
                ELI.auto_slide.enable = v;
            end;
        });
    end;
end;

local character_tab1 = Tabs.character_tab:AddLeftGroupbox('character', 'user');

-- fly (anchored root + up/down buttons)
(function()
    local Players = game:GetService("Players");
    local RunService = game:GetService("RunService");
    local TweenService = game:GetService("TweenService");
    local UIS = game:GetService("UserInputService");
    local LocalPlayer = Players.LocalPlayer;

    local isFlying = false;
    local toggleOn = false;
    local flightSpeed = 50;
    local verticalMove = 0;
    local flyConnections = {};

    local FlyGui = Instance.new("ScreenGui");
    FlyGui.Name = "ZRFlyGui";
    FlyGui.ResetOnSpawn = false;
    FlyGui.Enabled = false;
    FlyGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(0, 75, 0, 155);
    Frame.Position = UDim2.new(0.88, 0, 0.55, 0);
    Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18);
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.Active = true;
    Frame.Parent = FlyGui;
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 16);
    local FrameStroke = Instance.new("UIStroke", Frame);
    FrameStroke.Color = Color3.fromRGB(70, 70, 100);
    FrameStroke.Thickness = 1.5;

    local Label = Instance.new("TextLabel", Frame);
    Label.Size = UDim2.new(1, 0, 0, 22);
    Label.Position = UDim2.new(0, 0, 0, 8);
    Label.BackgroundTransparency = 1;
    Label.Text = "ALTITUDE";
    Label.TextColor3 = Color3.fromRGB(140, 140, 170);
    Label.Font = Enum.Font.GothamBold;
    Label.TextSize = 9;

    local Divider = Instance.new("Frame", Frame);
    Divider.Size = UDim2.new(0.7, 0, 0, 1);
    Divider.Position = UDim2.new(0.15, 0, 0, 30);
    Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 90);
    Divider.BorderSizePixel = 0;

    local function makeBtn(symbol, yPos)
        local Btn = Instance.new("TextButton", Frame);
        Btn.Size = UDim2.new(0, 52, 0, 52);
        Btn.Position = UDim2.new(0.5, -26, 0, yPos);
        Btn.Text = symbol;
        Btn.TextSize = 24;
        Btn.Font = Enum.Font.GothamBold;
        Btn.TextColor3 = Color3.fromRGB(210, 210, 255);
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40);
        Btn.BorderSizePixel = 0;
        Btn.AutoButtonColor = false;
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12);
        local stroke = Instance.new("UIStroke", Btn);
        stroke.Color = Color3.fromRGB(70, 70, 110);
        stroke.Thickness = 1.2;
        return Btn, stroke;
    end;

    local UpBtn, UpStroke = makeBtn("▲", 36);
    local DownBtn, DownStroke = makeBtn("▼", 96);

    local function setupBtn(btn, stroke, dirValue)
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                verticalMove = dirValue;
                TweenService:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(55, 55, 100) }):Play();
                TweenService:Create(stroke, TweenInfo.new(0.12), { Color = Color3.fromRGB(130, 130, 220) }):Play();
            end;
        end);
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                verticalMove = 0;
                TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(25, 25, 40) }):Play();
                TweenService:Create(stroke, TweenInfo.new(0.15), { Color = Color3.fromRGB(70, 70, 110) }):Play();
            end;
        end);
    end;
    setupBtn(UpBtn, UpStroke, 1);
    setupBtn(DownBtn, DownStroke, -1);

    local dragging, dragStart, startPos = false, nil, nil;
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Frame.Position;
        end;
    end);
    Frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false;
        end;
    end);
    local dragConn = UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart;
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
        end;
    end);

    local function stopFlying()
        isFlying = false;
        local char = LocalPlayer.Character;
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart");
            local humanoid = char:FindFirstChild("Humanoid");
            if hrp then hrp.Anchored = false; hrp.Velocity = Vector3.zero end;
            if humanoid then humanoid.PlatformStand = false end;
        end;
        for _, conn in pairs(flyConnections) do conn:Disconnect() end;
        flyConnections = {};
        verticalMove = 0;
        FlyGui.Enabled = false;
    end;

    local function startFlying()
        if isFlying then return end;
        local char = LocalPlayer.Character;
        if not char then return end;
        local hrp = char:FindFirstChild("HumanoidRootPart");
        local humanoid = char:FindFirstChild("Humanoid");
        if not hrp or not humanoid then return end;
        isFlying = true;
        hrp.Anchored = true;
        humanoid.PlatformStand = true;

        local conn = RunService.RenderStepped:Connect(function(deltaTime)
            if not isFlying or not hrp.Parent then return end;
            local cam = workspace.CurrentCamera;
            local moveDir = humanoid.MoveDirection;
            local vert = verticalMove;
            if UIS:IsKeyDown(Enum.KeyCode.Space) then vert = 1 elseif UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vert = -1 end;
            local horizontalShift = moveDir * flightSpeed * deltaTime;
            local verticalShift = Vector3.yAxis * (vert * flightSpeed * deltaTime);
            hrp.CFrame = CFrame.new(hrp.Position + horizontalShift + verticalShift) * cam.CFrame.Rotation;
        end);
        table.insert(flyConnections, conn);
        FlyGui.Enabled = true;
    end;

    local keyOn = true;
    local function apply()
        if toggleOn and keyOn then startFlying() else stopFlying() end;
    end;

    local charConn = LocalPlayer.CharacterAdded:Connect(function()
        stopFlying();
        if toggleOn and keyOn then
            task.wait(1);
            apply();
        end;
    end);

    ELI.fly.enable = false; -- old fly stays off

    character_tab1:AddToggle('fly_enable', {
        Text = 'fly',
        Default = false,
        Callback = function(v)
            toggleOn = v;
            apply();
        end;
    }):AddKeyPicker('fly_keybind', {
        Default = 'None',
        Text = 'fly',
        Mode = 'Toggle',
        Callback = function(v)
            keyOn = v and true or false;
            apply();
        end;
    });
    keyOn = true;

    character_tab1:AddSlider('fly_speed_value', {
        Text = 'fly speed',
        Default = 50,
        Min = 10,
        Max = 200,
        Rounding = 0,
        Callback = function(v)
            flightSpeed = v;
        end;
    });

    Library:OnUnload(function()
        toggleOn = false;
        stopFlying();
        pcall(function() dragConn:Disconnect() end);
        pcall(function() charConn:Disconnect() end);
        pcall(function() FlyGui:Destroy() end);
    end);
end)();

character_tab1:AddToggle('slide_boost_enable', {
        Text = 'slide boost',
        Default = false,
        Callback = function(v)
            keybind_slide_boost_enable = v;
            ELI.slide_boost.enable = v;
        end;
        }):AddKeyPicker('slide_boost_keybind', {
            Default = '',
            Text = 'slide boost',
            NoUI = false,
            EnableCheck = function()
                return ELI.slide_boost.enable;
            end,
            Callback = function(v)
                ELI.slide_boost.enable = keybind_slide_boost_enable and v or false;
            end;
        });

                character_tab1:AddSlider('slide_boost_spped', {
            Text = 'speed',
            Default = 60,
            Min = 1,
            Max = 100,
            Rounding = 0,
            Callback = function(v)
                ELI.slide_boost.speed = v;
            end;
        });

local anim_tab = Tabs.character_tab:AddLeftGroupbox('emote player', 'smile'); do
    anim_tab:AddToggle('animation_enable', {
        Text = 'enable',
        Default = false,
        Callback = function(v)
            ELI.animation.enable = v;
        end
    });

    anim_tab:AddDropdown('animation_droadsa', {
        Text = 'emote',
        Values = {'Meditate','Orbit','Floss','OJ','Kicking Feet','Take the L','Hype',},
        Default = 1,
        Callback = function(v)
            ELI.animation.select_animation = v;
        end
    });

    anim_tab:AddInput('animation_custom_id', {
        Text = 'custom id',
        Default = '',
        Placeholder = 'id..',
        Callback = function(v)
            ELI.animation.custom_id = v;
        end
    });

    anim_tab:AddSlider('animation_speed', {
        Text = 'speed',
        Default = 2,
        Min = 0.1,
        Max = 10,
        Rounding = 1,
        Callback = function(v)
            ELI.animation.speed = v;
        end
    });
end;

local animasdads;
local anim_last_id = "";
local anim_last_speed = 0;

local function stopCustomAnimation()
    if animasdads then
        pcall(function() animasdads:Stop() end);
        animasdads = nil;
    end;
    anim_last_id = "";
end;

run_service.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
    local ok = pcall(function()
        if not ELI.animation.enable then
            stopCustomAnimation();
            return;
        end;

        local character = local_player.Character;
        if not character then stopCustomAnimation(); return; end;
        local humanoid = character:FindFirstChildOfClass("Humanoid");
        if not humanoid then stopCustomAnimation(); return; end;
        local animator = humanoid:FindFirstChildOfClass("Animator");
        if not animator then stopCustomAnimation(); return; end;

        if animasdads and not animasdads.IsPlaying then
            animasdads = nil;
            anim_last_id = "";
        end;

        local id = theanimationsd[ELI.animation.select_animation];
        if not id then return; end;
        local speed = ELI.animation.speed;

        if id ~= anim_last_id then
            if animasdads then pcall(function() animasdads:Stop() end); animasdads = nil; end;
            anim_last_id = id;

            local anim;
            local okObjects, objects = pcall(function()
                return game:GetObjects("rbxassetid://" .. id);
            end);
            if okObjects and objects and objects[1] then
                anim = objects[1];
            else
                anim = Instance.new("Animation");
                anim.AnimationId = "rbxassetid://" .. id;
            end;

            local okLoad, track = pcall(function()
                return animator:LoadAnimation(anim);
            end);
            if not okLoad or not track then
                anim_last_id = "";
                return;
            end;

            animasdads = track;
            pcall(function()
                animasdads.Priority = Enum.AnimationPriority.Action4;
                animasdads:Play();
                animasdads:AdjustSpeed(speed);
            end);
            anim_last_speed = speed;
        end;

        if animasdads and speed ~= anim_last_speed then
            pcall(function() animasdads:AdjustSpeed(speed) end);
            anim_last_speed = speed;
        end;
    end);
    if not ok then
        anim_last_id = "";
    end;
end));

local settings_tab = Tabs['UI Settings']; do
    local menu = Tabs['UI Settings']:AddLeftGroupbox('menu', 'menu'); do
        menu:AddLabel("menu bind"):AddKeyPicker("MenuKeybind", {
            Default = "RightShift";
            NoUI = true;
            Text = "menu keybind";
        });

        if Options.MenuKeybind then
            Library.ToggleKeybind = Options.MenuKeybind;
            Library.MenuBindPickers = Library.MenuBindPickers or {};
            table.insert(Library.MenuBindPickers, Options.MenuKeybind);
        end;

        menu:AddToggle('menu_blur', {
            Text = 'blur effect',
            Default = true,
            Callback = function(v)
                Toggles.MenuBlurToggle = Toggles.MenuBlurToggle or { Value = v };
                Toggles.MenuBlurToggle.Value = v;
                pcall(function() Library:UpdateMenuBlur() end);
            end;
        });

        menu:AddToggle('show_keybind_menu', {
            Text = 'show keybind menu',
            Default = true,
            Callback = function(v)
                if Library.KeybindOverlay and Library.KeybindOverlay.SetVisible then
                    Library.KeybindOverlay:SetVisible(v);
                elseif Library.KeybindOverlay and Library.KeybindOverlay.Outer then
                    Library.KeybindOverlay.Outer.Visible = v;
                end;
            end
        });

        menu:AddButton('unload', function()
            Library:Unload();
        end);
    end;

-- (auto load removed)

do
    ELI.notifications = ELI.notifications or {
        force_color = false,
        color = Color3.fromRGB(96, 132, 220),
        side = "Bottom",
        alignment = "Center",
        transparency = 0,
        x = 50,
        y = 90,
    };
    local NConfig = ELI.notifications;

    local function GetNotifyArea()
        return Library.NotificationArea;
    end;

    local function ApplyNotifySettings()
        if NConfig.side == "Left" then
            Library.NotifySide = "Left";
        elseif NConfig.side == "Right" then
            Library.NotifySide = "Right";
        else
            Library.NotifySide = "Right";
        end;

        local Area = GetNotifyArea();
        if not Area then return end;

        local AlignMap = {
            Left = Enum.HorizontalAlignment.Left,
            Center = Enum.HorizontalAlignment.Center,
            Right = Enum.HorizontalAlignment.Right,
        };

        local X = math.clamp((NConfig.x or 50) / 100, 0, 1);
        local Y = math.clamp((NConfig.y or 90) / 100, 0, 1);

        if NConfig.side == "Top" then
            Area.AnchorPoint = Vector2.new(0.5, 0);
        elseif NConfig.side == "Left" then
            Area.AnchorPoint = Vector2.new(0, 0.5);
        elseif NConfig.side == "Right" then
            Area.AnchorPoint = Vector2.new(1, 0.5);
        else
            Area.AnchorPoint = Vector2.new(0.5, 1);
        end;

        Area.Position = UDim2.fromScale(X, Y);

        local Layout = Area:FindFirstChildOfClass("UIListLayout");
        if Layout then
            Layout.HorizontalAlignment = AlignMap[NConfig.alignment] or Enum.HorizontalAlignment.Center;
            Layout.VerticalAlignment = (NConfig.side == "Top") and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Bottom;
        end;
    end;

    local function StyleNotification()
        local Area = GetNotifyArea();
        if not Area then return end;

        for _, Outer in eli_ipairs(Area:GetChildren()) do
            if Outer:IsA("GuiObject") and not Outer:GetAttribute("ZRHUBStyled") then
                Outer:SetAttribute("ZRHUBStyled", true);

                if NConfig.force_color and NConfig.color then
                    for _, Child in eli_ipairs(Outer:GetDescendants()) do
                        if Child:IsA("Frame") then
                            local Reg = Library.RegistryMap[Child];
                            if Reg and Reg.Properties and Reg.Properties.BackgroundColor3 == "AccentColor" then
                                Library:RemoveFromRegistry(Child);
                                Child.BackgroundColor3 = NConfig.color;
                            end;
                        end;
                    end;
                end;

                local Visible = 1 - math.clamp((NConfig.transparency or 0) / 100, 0, 1);
                if Visible < 1 then
                    local function Fade(Object)
                        if Object:IsA("GuiObject") and Object.BackgroundTransparency < 1 then
                            Object.BackgroundTransparency = 1 - (1 - Object.BackgroundTransparency) * Visible;
                        end;
                    end;
                    Fade(Outer);
                    for _, Object in eli_ipairs(Outer:GetDescendants()) do
                        Fade(Object);
                    end;
                end;
            end;
        end;
    end;

    if not Library.__ZRHUBNotifyHooked then
        Library.__ZRHUBNotifyHooked = true;
        Library.__ZRHUBOldNotify = Library.Notify;

        function Library:Notify(...)
            if getgenv().silent_load then
                return setmetatable({}, {
                    __index = function()
                        return function() end;
                    end,
                });
            end;

            ApplyNotifySettings();
            local Data = Library.__ZRHUBOldNotify(self, ...);
            task.defer(StyleNotification);
            return Data;
        end;
    end;

    ApplyNotifySettings();
end

do
    local NConfig = ELI.notifications;

    local function ApplyNotifySettings()
        if NConfig.side == "Left" then
            Library.NotifySide = "Left";
        elseif NConfig.side == "Right" then
            Library.NotifySide = "Right";
        else
            Library.NotifySide = "Right";
        end;

        local Area = Library.NotificationArea;

        if not Area then return end;

        local AlignMap = {
            Left = Enum.HorizontalAlignment.Left,
            Center = Enum.HorizontalAlignment.Center,
            Right = Enum.HorizontalAlignment.Right,
        };

        local X = math.clamp((NConfig.x or 50) / 100, 0, 1);
        local Y = math.clamp((NConfig.y or 90) / 100, 0, 1);

        if NConfig.side == "Top" then
            Area.AnchorPoint = Vector2.new(0.5, 0);
        elseif NConfig.side == "Left" then
            Area.AnchorPoint = Vector2.new(0, 0.5);
        elseif NConfig.side == "Right" then
            Area.AnchorPoint = Vector2.new(1, 0.5);
        else
            Area.AnchorPoint = Vector2.new(0.5, 1);
        end;

        Area.Position = UDim2.fromScale(X, Y);

        local Layout = Area:FindFirstChildOfClass("UIListLayout");
        if Layout then
            Layout.HorizontalAlignment = AlignMap[NConfig.alignment] or Enum.HorizontalAlignment.Center;
            Layout.VerticalAlignment = (NConfig.side == "Top") and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Bottom;
        end;
    end

    do
        local notifications = Tabs['UI Settings']:AddRightGroupbox('notifications', 'bell-ring');

    notifications:AddToggle('notify_force_color', {
        Text = 'force color',
        Default = false,
        Callback = function(v)
            NConfig.force_color = v;
        end,
    }):AddColorPicker('notify_color', {
        Default = NConfig.color,
        Title = 'notification color',
        Callback = function(Color)
            NConfig.color = Color;
        end,
    });

    notifications:AddSlider('notify_x', {
        Text = 'position x',
        Default = NConfig.x,
        Min = 0,
        Max = 100,
        Rounding = 0,
        Suffix = '%',
        Callback = function(v)
            NConfig.x = v;
            ApplyNotifySettings();
        end,
    });

    notifications:AddSlider('notify_y', {
        Text = 'position y',
        Default = NConfig.y,
        Min = 0,
        Max = 100,
        Rounding = 0,
        Suffix = '%',
        Callback = function(v)
            NConfig.y = v;
            ApplyNotifySettings();
        end,
    });

    notifications:AddSlider('notify_transparency', {
        Text = 'transparency',
        Default = NConfig.transparency,
        Min = 0,
        Max = 100,
        Rounding = 0,
        Suffix = '%',
        Callback = function(v)
            NConfig.transparency = v;
        end,
    });

    notifications:AddDropdown('notify_alignment', {
        Text = 'alignment',
        Values = { 'Left', 'Center', 'Right' },
        Default = NConfig.alignment,
        Callback = function(v)
            NConfig.alignment = v;
            ApplyNotifySettings();
        end,
    });

    notifications:AddDropdown('notify_side', {
        Text = 'position',
        Values = { 'Top', 'Bottom', 'Left', 'Right' },
        Default = NConfig.side,
        Callback = function(v)
            NConfig.side = v;
            ApplyNotifySettings();
        end,
    });

    notifications:AddButton('send notification', function()
        Library:Notify('This is a test notification.', 5);
    end);

    ApplyNotifySettings();
    end;
end;

Library.ToggleKeybind = Options.MenuKeybind;

ThemeManager:SetLibrary(Library);
SaveManager:SetLibrary(Library);
SaveManager:IgnoreThemeSettings();
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' });
ThemeManager:SetFolder('ZRHUB');
SaveManager:SetFolder('ZRHUB/rivals');
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
ThemeManager:ApplyTheme("Jester")
pcall(ZR_AddOpenButton)

do
    local CreditsBox = Tabs.Credits:AddLeftGroupbox("Credits", "user")
    CreditsBox:AddLabel("Made by tung zo1os", true)
    CreditsBox:AddButton({
        Text = "Copy Discord Link",
        Func = function()
            pcall(setclipboard, "https://discord.gg/TCuMcKy9j4")
            Library:Notify({ Title = "Copied!", Description = "Discord link copied.", Time = 3 })
        end,
    })
end


;(function()
    local BRAND_ACCENT = Color3.fromHex('001EFF');

    local function detach(overlay)
        if not overlay or not Library.Overlays then return end;
        for i = #Library.Overlays, 1, -1 do
            if Library.Overlays[i] == overlay then
                table.remove(Library.Overlays, i);
            end;
        end;
    end;

    local function makeWidget(factory, cfg)
        local ok, overlay = pcall(factory, Library, cfg or { Visible = false });
        if not ok or type(overlay) ~= 'table' then return nil end;
        detach(overlay);
        return overlay;
    end;

    local function setWidgetVisible(overlay, v)
        if not overlay then return end;
        if overlay.SetVisible then
            pcall(function() overlay:SetVisible(v) end);
        elseif overlay.Outer then
            overlay.Outer.Visible = v;
            overlay.Visible = v;
        end;
        pcall(function() Library:UpdateOverlayGlow(overlay) end);
    end;

    local RadarWidget    = makeWidget(Library.CreateRadarOverlay,         { Visible = false });
    local PlayerWidget   = makeWidget(Library.CreatePlayerListOverlay,    { Visible = false, Position = UDim2.fromOffset(230, 40) });
    local VelocityWidget = makeWidget(Library.CreateVelocityGraphOverlay, { Visible = false });
    local KeybindWidget  = makeWidget(Library.CreateKeybindsOverlay,      { Visible = false });
    local TargetWidget   = makeWidget(Library.CreateClosestPlayerOverlay, { Visible = false });

    local AppearanceWidget;
    pcall(function()
        AppearanceWidget = nil;
        detach(AppearanceWidget);
    end);

    getgenv().ZRHUB_widgets = {
        Radar = RadarWidget,
        PlayerList = PlayerWidget,
        Velocity = VelocityWidget,
        Keybind = KeybindWidget,
        ClosestPlayer = TargetWidget,
        Appearance = AppearanceWidget,
        Watermark = Library.Watermark and { Outer = Library.Watermark } or nil,
    };

    pcall(function()
        local box = Tabs['UI Settings']:AddLeftGroupbox('widgets', 'layout-dashboard');
        box:AddToggle('WidgetWatermark', {
            Text = 'watermark'; Default = false;
            Callback = function(v) pcall(function() Library:SetWatermarkVisibility(v) end) end;
        });
        box:AddToggle('WidgetAppearance', {
            Text = 'appearance'; Default = false;
            Callback = function(v) setWidgetVisible(AppearanceWidget, v) end;
        });
        box:AddToggle('WidgetRadar', {
            Text = 'radar'; Default = false;
            Callback = function(v) setWidgetVisible(RadarWidget, v) end;
        });
        box:AddToggle('WidgetPlayerList', {
            Text = 'player list'; Default = false;
            Callback = function(v) setWidgetVisible(PlayerWidget, v) end;
        });
        box:AddToggle('WidgetVelocity', {
            Text = 'velocity'; Default = false;
            Callback = function(v) setWidgetVisible(VelocityWidget, v) end;
        });
        box:AddToggle('WidgetClosestPlayer', {
            Text = 'closest player'; Default = false;
            Callback = function(v) setWidgetVisible(TargetWidget, v) end;
        });

        local wmbox = Tabs['UI Settings']:AddRightGroupbox('watermark', 'stamp');
        wmbox:AddToggle('WatermarkFps', {
            Text = 'show fps'; Default = true;
            Callback = function(v)
                getgenv().ZRHUB_wm = getgenv().ZRHUB_wm or {};
                getgenv().ZRHUB_wm.fps = v;
            end;
        });
        wmbox:AddToggle('WatermarkPing', {
            Text = 'show ping'; Default = true;
            Callback = function(v)
                getgenv().ZRHUB_wm = getgenv().ZRHUB_wm or {};
                getgenv().ZRHUB_wm.ping = v;
            end;
        });
        wmbox:AddToggle('WatermarkTime', {
            Text = 'show time'; Default = true;
            Callback = function(v)
                getgenv().ZRHUB_wm = getgenv().ZRHUB_wm or {};
                getgenv().ZRHUB_wm.time = v;
            end;
        });
        wmbox:AddToggle('WatermarkExecutor', {
            Text = 'show executor'; Default = false;
            Callback = function(v)
                getgenv().ZRHUB_wm = getgenv().ZRHUB_wm or {};
                getgenv().ZRHUB_wm.executor = v;
            end;
        });
    end);


    pcall(function()
        local holder = Window and Window.Holder;
        if not holder or holder:FindFirstChild('ZRHUBMainResizer') then return end;
        local uis = game:GetService('UserInputService');
        local handle = Instance.new('Frame');
        handle.Name = 'ZRHUBMainResizer';
        handle.AnchorPoint = Vector2.new(1, 1);
        handle.Position = UDim2.new(1, 0, 1, 0);
        handle.Size = UDim2.fromOffset(12, 12);
        handle.BackgroundTransparency = 1;
        handle.BorderSizePixel = 0;
        handle.ZIndex = 9999;
        handle.Active = true;
        handle.Parent = holder;
        local dragging, startPos, startSize = false, nil, nil;
        local isTouchUi = uis.TouchEnabled and not uis.MouseEnabled;
        local minResizeW = isTouchUi and 320 or 480;
        local minResizeH = isTouchUi and 260 or 360;
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true;
                startPos = input.Position;
                startSize = holder.AbsoluteSize;
            end;
        end);
        uis.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - startPos;
                holder.Size = UDim2.fromOffset(
                    math.max(minResizeW, startSize.X + d.X),
                    math.max(minResizeH, startSize.Y + d.Y)
                );
            end;
        end));
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false;
            end;
        end);
    end);

    pcall(function() Library:SetOverlayGlowColor(Library.AccentColor) end);
    local function widgetToggleOn(idx)
        local t = Toggles and Toggles[idx];
        return t ~= nil and t.Value == true;
    end;
    pcall(function() Library:SetWatermarkVisibility(widgetToggleOn('WidgetWatermark')) end);
    setWidgetVisible(RadarWidget, widgetToggleOn('WidgetRadar'));
    setWidgetVisible(PlayerWidget, widgetToggleOn('WidgetPlayerList'));
    setWidgetVisible(VelocityWidget, widgetToggleOn('WidgetVelocity'));
    setWidgetVisible(KeybindWidget, false);
    setWidgetVisible(TargetWidget, widgetToggleOn('WidgetClosestPlayer'));
    setWidgetVisible(AppearanceWidget, widgetToggleOn('WidgetAppearance'));
end)();



end;
end;
end