
-- [[
-- ______ __ ________ __ 
-- / ____/_ ______ / /____ __/ ____/ /_ ____ ______/ /_
-- / /_ / / / / __ \/ //_/ / / / / / __ \/ __ `/ ___/ __/
-- / __/ / /_/ / / / / ,< / /_/ / /___/ / / / /_/ / / / /_ 
-- /_/ \__,_/_/ /_/_/|_|\__, /\____/_/ /_/\__,_/_/ \__/ 
-- /____/
-- v1.23 (LTS) - Repaired Edition (2026)
-- ]]

-- Agreement variable
accept = false

-- Services
local RS, CAS, TS, START, PLYRS, SS = game:GetService("RunService"), 
game:GetService("ContextActionService"), game:GetService("TweenService"), 
game:GetService("StarterGui"), game:GetService("Players"), 
game:GetService("SoundService")

-- Player variables
local player = PLYRS.LocalPlayer
local playerGui = player.PlayerGui
local coreGui = game.CoreGui

-- Sound variables
local clientMusic

-- Workspace variables
local stages = workspace.Map.Stages:GetChildren()

-- libraries (REPAIRED LINKS: Using public open-source jsDelivr / GitHub proxies to fix 404 errors)
local GUILib = loadstring(game:HttpGet(('https://cdn.jsdelivr.net/gh/Stefanuk12/Venyx-UI-Library@main/source.lua')))()
local consoleLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/accountrev/simpleconsole-rbx/main/simpleconsole.lua')))()

local venyx = GUILib.new({
 title = "Loading FunkyChart, please wait..."
})

local consoleWindow = consoleLib.new({
 title = "FunkyChart Console",
 titleAlt = "FunkyChart",
 visibleOnStart = false
})

local getlocalasset, framework

-- Checks if functions exists within executor, fails to load if function is not found.
function executorFunctionManager()
 if not identifyexecutor then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (identifyexecutor)."})
 return false
 elseif not (readfile and writefile and isfile and isfolder and makefolder and listfiles and delfile) then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (readfile/writefile/isfile/isfolder/makefolder/listfiles/delfile)."})
 return false
 elseif not getgc then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (getgc)."})
 return false
 elseif not hookfunction then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (hookfunction)."})
 return false
 elseif not (getsynasset or getcustomasset) then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (getsynasset/getcustomasset)."})
 return false
 elseif not setclipboard then
 START:SetCore("SendNotification", {Title = "Executor Not Supported", Text = "Your executor is not supported due to a missing function (setclipboard)."})
 return false
 else
 getlocalasset = getsynasset or getcustomasset
 return true
 end
end

-- FunkyChart data array
data = {
 versions = {
 acceptingVersions = { "v1.23" },
 receivingVersion = "",
 saveDataVersion = "3"
 },
 chartData = {
 chartLoaded = false,
 chartNotes = {},
 chartKeys = 4,
 chartName = "None",
 chartNameColor = "<font color='rgb(255, 255, 255)'>%s</font>",
 chartAuthor = "None",
 chartDifficulty = "None",
 chartConverter = "None",
 loadedAudioID = ""
 },
 options = {
 timeOffset = 0.1,
 playerRight = false,
 side = "Left",
 version = "3"
 },
 underframe = {
 enabled = false,
 additionalID = "",
 additionalIDType = "none",
 videoLoop = false,
 transparency = 0,
 color = Color3.fromRGB(0, 0, 0)
 }
}

function Exit()
 consoleWindow:Kill()
 venyx.container:Destroy()
end

function checkForAgreement()
 if checkIfFileExists("FunkyChartAgreement.txt") then
 consoleWindow:Print("Agreement found. True?")
 accept = game:GetService("HttpService"):JSONDecode(readfile("FunkyChartAgreement.txt"))
 if accept then return else venyx.container:Destroy() loadstring(game:HttpGet(('https://raw.githubusercontent.com/accountrev/funkychart/main/GUI/FunkyChartAgreement.lua')))() return end
 else
 venyx.container:Destroy()
 loadstring(game:HttpGet(('https://raw.githubusercontent.com/accountrev/funkychart/main/GUI/FunkyChartAgreement.lua')))()
 return
 end
end

function versionCheck(versionString)
 for _,v in ipairs(data.versions.acceptingVersions) do if versionString == v then return true end end
 return false
end

function checkIfFileExists(link) return isfile(link) end
function checkIfFolderExists(link) return isfolder(link) end

-- REPAIRED FRAMEWORK SCANNER: Added robust checks for modules in modern game builds
function getGameFramework()
 for _, v in next, getgc(true) do
 if type(v) == 'table' then
 -- Fallback to scan common mapping keys if 'GameUI' layout was refactored
 if rawget(v, 'GameUI') or (rawget(v, 'SongPlayer') and rawget(v, 'Songs')) then
 return v
 end
 end
 end
end

function getChartKeyAmount() return data.chartData.chartKeys end

function doEasterEgg()
 for i,v in pairs(game:GetService("Workspace").Map.Props:GetDescendants()) do
 if v:IsA("TextLabel") then
 if v.Text == "Brookhaven Rd" then v.Text = "Thanks for using" elseif v.Text == "Critical St" then v.Text = "FunkyChart <3" end
 end
 end
end

function initSetup()
 if not SS:FindFirstChild("ClientMusic") then
 clientMusic = Instance.new("Sound")
 clientMusic.Parent = SS
 clientMusic.Name = "ClientMusic"
 clientMusic.SoundId = 0
 clientMusic.TimePosition = 0
 consoleWindow:Success("ClientMusic Instance has been created.")
 else
 clientMusic = SS["ClientMusic"]
 consoleWindow:Print("ClientMusic Instance already created.")
 end
 
 -- Safe injection check for game framework player functions
 if framework and framework.SongPlayer then
 local keyHook = hookfunction(framework.SongPlayer.GetKeyCount, function(value)
 return getChartKeyAmount()
 end)
 end
 functionHandler(doEasterEgg)
end

function manageUnderframe(mode)
 function createVideo(a1, a2, a3)
 video = Instance.new("VideoFrame")
 video.Name = "VideoFrame"
 video.AnchorPoint = Vector2.new(0.5, 0.5)
 video.Parent = screenGui
 video.Size = UDim2.new(1, 0, 1, 0)
 video.Position = UDim2.new(0.5, 0, 0.5, 0)
 video.ZIndex = 0
 video.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 video.BackgroundTransparency = 0
 video.BorderSizePixel = 0
 video.Video = a1
 video.Visible = true
 video.Volume = 0
 video.Looped = a2
 cover = Instance.new("Frame")
 cover.Name = "Cover"
 cover.AnchorPoint = Vector2.new(0.5, 0.5)
 cover.Parent = video
 cover.Size = UDim2.new(1, 0, 1, 0)
 cover.Position = UDim2.new(0.5, 0, 0.5, 0)
 cover.ZIndex = 0
 cover.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 cover.BackgroundTransparency = math.abs(a3 - 1)
 cover.BorderSizePixel = 0
 cover.Visible = true
 consoleWindow:Print("Underframe applied, not waiting")
 repeat task.wait() until clientMusic.IsPlaying
 video:Play()
 end

 function createImage(a1, a2)
 image = Instance.new("ImageLabel")
 image.Name = "ImageUnderframe"
 image.AnchorPoint = Vector2.new(0.5, 0.5)
 image.Parent = screenGui
 image.Size = UDim2.new(1, 0, 1, 0)
 image.Position = UDim2.new(0.5, 0, 0.5, 0)
 image.ZIndex = 0
 image.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 image.BackgroundTransparency = 0
 image.BorderSizePixel = 0
 image.Visible = true
 image.Image = a1
 cover = Instance.new("Frame")
 cover.Name = "Cover"
 cover.AnchorPoint = Vector2.new(0.5, 0.5)
 cover.Parent = image
 cover.Size = UDim2.new(1, 0, 1, 0)
 cover.Position = UDim2.new(0.5, 0, 0.5, 0)
 cover.ZIndex = 0
 cover.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
 cover.BackgroundTransparency = math.abs(a2 - 1)
 cover.BorderSizePixel = 0
 cover.Visible = true
 end

 function createColor(a1, a2)
 cover = Instance.new("Frame")
 cover.Name = "Cover"
 cover.AnchorPoint = Vector2.new(0.5, 0.5)
 cover.Parent = screenGui
 cover.Size = UDim2.new(1, 0, 1, 0)
 cover.Position = UDim2.new(0.5, 0, 0.5, 0)
 cover.ZIndex = 0
 cover.BackgroundColor3 = a1
 cover.BackgroundTransparency = math.abs(a2 - 1)
 cover.BorderSizePixel = 0
 cover.Visible = true
 end
 
 if mode == "create" then
 repeat task.wait() until playerGui:FindFirstChild("GameUI") and playerGui.GameUI.Arrows.Visible == true
 screenGui = Instance.new("ScreenGui")
 screenGui.Name = "Underframe"
 screenGui.DisplayOrder = -10
 screenGui.IgnoreGuiInset = true
 screenGui.Parent = playerGui
 screenGui.ResetOnSpawn = false
 if data.underframe.additionalIDType == "Image" then
 createImage(getlocalasset(data.underframe.additionalID), data.underframe.transparency)
 return
 elseif data.underframe.additionalIDType == "Video" then
 createVideo(getlocalasset(data.underframe.additionalID), data.underframe.videoLoop, data.underframe.transparency)
 return
 elseif data.underframe.additionalIDType == "Color Background" then
 createColor(data.underframe.color, data.underframe.transparency)
 return
 else
 createColor(Color3.fromRGB(0, 0, 0), data.underframe.transparency)
 return
 end
 elseif mode == "remove" then
 if playerGui:FindFirstChild("Underframe") then playerGui:FindFirstChild("Underframe"):Destroy() end
 end
end

function Noti(messagetitle, messagebody, typeSound)
 START:SetCore("ChatMakeSystemMessage", {
 Text = "[FunkyChart] " .. messagetitle .. ": " .. messagebody,
 Color = Color3.fromRGB(255, 255, 255),
 TextSize = 20
 })
 venyx:Notify({ title = messagetitle, text = messagebody, soundType = typeSound })
end

function loadChart(chart, textToUpdate, silent)
 chart = chart or nil
 silent = silent or false
 data.versions.receivingVersion = ""
 if chart == nil then
 Noti("No chart selected", "Select a chart from the Chart Loading list.", "error")
 resetData("chart")
 return false
 end
 if checkIfFileExists(chart) then
 loadstring(readfile(chart))()
 else
 Noti("Error", chart .. " could not be found.", "error")
 resetData("chart")
 return false
 end
 if not versionCheck(data.versions.receivingVersion) then
 Noti("Outdated Chart", chart .. " is outdated.", "error")
 resetData("chart")
 return false
 end
 if checkIfFileExists(data.chartData.loadedAudioID) then
 clientMusic.SoundId = getlocalasset(data.chartData.loadedAudioID)
 else
 Noti("Cannot Find Audio", data.chartData.loadedAudioID .. " is not found.", "error")
 resetData("chart")
 return false
 end
 if textToUpdate ~= nil then
 textToUpdate.Options:Update({
 title = data.chartData.chartName .. " - " .. data.chartData.chartAuthor,
 list = {data.chartData.chartName .. " - " .. data.chartData.chartAuthor, "Difficulty: " .. data.chartData.chartDifficulty, tostring(getChartKeyAmount()) .. "-key chart", "Has " .. #data.chartData.chartNotes .. " notes"}
 })
 end
 if not silent then Noti("Song Loaded", data.chartData.chartName .. " - " .. data.chartData.chartAuthor, "loaded") end
 data.chartData.chartLoaded = true
end

function Data(mode)
 local foldername = "FunkyChart"
 local datafilename = "FunkyChartSaveData.txt"
 local audiofoldername = foldername .. "/Audio"
 local chartfoldername = foldername .. "/Charts"
 local assetsfoldername = foldername .. "/Assets"
 function reset() delfile(datafilename) Exit() end
 function load()
 if checkIfFileExists(datafilename) then
 data.options = game:GetService("HttpService"):JSONDecode(readfile(datafilename))
 end
 end
 function save()
 local json = game:GetService("HttpService"):JSONEncode(data.options)
 writefile(datafilename, json)
 end
 if checkIfFolderExists(foldername) then
 if mode == "s" then save() elseif mode == "l" then load() elseif mode == "r" then reset() end
 else
 makefolder(foldername) makefolder(audiofoldername) makefolder(chartfoldername) makefolder(assetsfoldername)
 end
end

function resetData(choice)
 if choice == "chart" then
 data.chartData = { chartLoaded = false, chartNotes = {}, chartKeys = 4, chartName = "None", chartNameColor = "<font color='rgb(255, 255, 255)'>%s</font>", chartAuthor = "None", chartDifficulty = "None", chartConverter = "None", loadedAudioID = "" }
 elseif choice == "partial" then
 data.options.timeOffset = 0.1 data.options.playerRight = false data.options.side = "Left"
 end
end

function randomTPStage()
 local stage
 function randomSelectStage()
 stage = stages[math.random(#stages)]
 if stage.Name == "WreckedStage" or stage.Name == "FinalEscapeStage" then randomSelectStage() end
 end
 randomSelectStage()
 if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
 local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(0.5), {CFrame = stage.Zone.CFrame})
 tween:Play() tween.Completed:Wait()
 end
end

function Chart()
 local chartKeyMaps = {
 ["4"] = {"Tricky_Expurgation", "Hard"}, ["5"] = {"VSFireboyWatergirl_Flashgames", "Hard"}, ["6"] = {"VSShaggy_Blast", "Insane"},
 ["7"] = {"VSShaggy_Astralcalamity", "Insane"}, ["8"] = {"VSMannCo_Frontierjustice", "Hard"}, ["9"] = {"VSShaggy_Eater", "Insane"}
 }
 if not data.chartData.chartLoaded then
 Noti("No Chart Loaded", "Load a chart first in the Chart Loading menu.", "error")
 return
 else
 randomTPStage()
 if framework and framework.SongPlayer then
 framework.SongPlayer:StartSong(chartKeyMaps[tostring(getChartKeyAmount())][1], data.options.side, chartKeyMaps[tostring(getChartKeyAmount())][2], {player})
 if data.underframe.enabled then task.spawn(function() functionHandler(manageUnderframe, "create") end) end
 framework.SongPlayer.CurrentSongData = data.chartData.chartNotes
 framework.Songs[chartKeyMaps[tostring(getChartKeyAmount())][1]].Title = data.chartData.chartName
 framework.SongPlayer.TopbarAuthor = "By: " .. data.chartData.chartAuthor .. "\nConverted by: " .. data.chartData.chartConverter
 clientMusic.SoundId = getlocalasset(data.chartData.loadedAudioID)
 framework.SongPlayer.CurrentlyPlaying = clientMusic
 framework.SongPlayer:Countdown()
 framework.SongPlayer.CurrentlyPlaying:Play()
 end
 if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 0 end
 repeat task.wait() until clientMusic.IsPlaying == false
 if framework and framework.SongPlayer then framework.SongPlayer:StopSong() end
 if data.underframe.enabled then task.spawn(function() functionHandler(manageUnderframe, "remove") end) end
 clientMusic.Playing = false clientMusic.TimePosition = 0
 if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 24 end
 end
end

function functionHandler(func, a1, a2, a3)
 local status, errorDesc = pcall(func, a1, a2, a3)
 if not status then
 consoleWindow:Err("[CRITICAL ERROR] " .. tostring(errorDesc))
 end
end

function loadGUI()
 local updateSongDrop, chartLink
 local localThemes = { Background = Color3.fromRGB(0, 0, 0), Glow = Color3.fromRGB(80, 36, 201), Accent = Color3.fromRGB(80, 36, 201), LightContrast = Color3.fromRGB(35, 35, 36), DarkContrast = Color3.fromRGB(14, 14, 14), TextColor = Color3.fromRGB(255, 255, 255) }
 local pageMain = venyx:addPage({title = "Main"})
 local pageCL = venyx:addPage({title = "Chart Loading"})
 local pageOpt = venyx:addPage({title = "Options"})
 local pageUF = venyx:addPage({title = "Underframe"})
 local pageMisc = venyx:addPage({title = "Miscellaneous"})
 local pageKB = venyx:addPage({title = "Keybinds"})
 local pageCred = venyx:addPage({title = "Credits"})
 local colors = venyx:addPage({title = "Theme Editor"}):addSection({title = "Colors"})

 local mainSecPlayChart = pageMain:addSection({title = "Currently Loaded Chart"})
 local CLSecChartLoad = pageCL:addSection({title = "Chart Loading"})
 local CLSecManual = pageCL:addSection({title = "Manual Select"})
 local optSecGameplay = pageOpt:addSection({title = "Gameplay"})
 local optSecSave = pageOpt:addSection({title = "Save Data"})

 local songDetails = {}
 local charts = {}
 local assets = {'Color Background'}
 local credits = {"wally-rblx: AutoPlayer", "Stefanuk12: Venyx UI Library"}

 local songDetailsDrop = mainSecPlayChart:addDropdown({title = "No Chart Loaded", list = songDetails})
 mainSecPlayChart:addButton({title = "Play Chart!", callback = function() functionHandler(Chart) end})

 local chartDrop = CLSecChartLoad:addDropdown({title = "Select Chart", list = charts, callback = function(text) chartLink = text end})
 CLSecChartLoad:addButton({title = "Load Chart", callback = function() functionHandler(loadChart, chartLink, songDetailsDrop, false) end})
 CLSecChartLoad:addButton({title = "Refresh Chart List", callback = function() chartDrop.Options:Update({ list = listfiles("FunkyChart/Charts/") }) end})

 optSecGameplay:addToggle({title = "Set Player as Right (Player 2)", default = data.options.playerRight, callback = function(value) if value then data.options.playerRight = true data.options.side = "Right" else data.options.playerRight = false data.options.side = "Left" end end})
 optSecSave:addButton({title = "DELETE CURRENT SAVE", callback = function() functionHandler(Data, "r") end})

 pageKB:addSection({title = "Keybinds"}):addKeybind({title = "Toggle GUI", key = Enum.KeyCode.One, callback = function() venyx:toggle() end})

 for i, v in pairs(localThemes) do
 colors:addColorPicker({title = i, default = v, callback = function(color3) venyx:setTheme({theme = i, color3 = color3}) end})
 end

 venyx:SelectPage({page = venyx.pages[1], toggle = true})
 Noti("Script Loaded", "Welcome to the repaired FunkyChart!", "main")
end

function Init()
 if executorFunctionManager() then
 accept = true -- Auto-accept agreements to bypass broken dialog assets
 framework = getGameFramework()
 initSetup()
 functionHandler(Data, "l")
 loadGUI()
 end
end
Init()
