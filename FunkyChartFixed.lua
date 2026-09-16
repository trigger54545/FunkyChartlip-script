-- FunkyChart v1.23 (LTS) - Completely Clean & Patched UI Mirror Version
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
local clientMusic

-- Workspace variables
local stages = workspace.Map.Stages:GetChildren()

-- Libraries (Updated with functional Venyx UI mirror link. SimpleConsole removed completely)
local GUILib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/refs/heads/main/source2.lua')))()

local venyx = GUILib.new({
 title = "Loading FunkyChart, please wait..."
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

-- FunkyChart data configurations
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

-- Exits FunkyChart
function Exit()
 venyx.container:Destroy()
end

-- Checks if the agreement was accepted.
function checkForAgreement()
 if checkIfFileExists("FunkyChartAgreement.txt") then
 accept = game:GetService("HttpService"):JSONDecode(readfile("FunkyChartAgreement.txt"))
 if accept then
 return
 else
 venyx.container:Destroy()
 loadstring(game:HttpGet(('https://raw.githubusercontent.com/accountrev/funkychart/main/GUI/FunkyChartAgreement.lua')))()
 return
 end
 else
 venyx.container:Destroy()
 loadstring(game:HttpGet(('https://raw.githubusercontent.com/accountrev/funkychart/main/GUI/FunkyChartAgreement.lua')))()
 return
 end
end

function versionCheck(versionString)
 for _,v in ipairs(data.versions.acceptingVersions) do
 if versionString == v then
 return true
 end
 end
 return false
end

function checkIfFileExists(link) return isfile(link) end
function checkIfFolderExists(link) return isfolder(link) end

-- Framework safe getter
function getGameFramework()
 for _, v in next, getgc(true) do
 if type(v) == 'table' and rawget(v, 'GameUI') then
 return v
 end
 end
end

function getChartKeyAmount() return data.chartData.chartKeys end

function doEasterEgg()
 for i,v in pairs(game:GetService("Workspace").Map.Props:GetDescendants()) do
 if v:IsA("TextLabel") then
 if v.Text == "Brookhaven Rd" then
 v.Text = "Thanks for using"
 elseif v.Text == "Critical St" then
 v.Text = "FunkyChart <3"
 end
 end
 end
end

-- Initializes FunkyChart setup.
function initSetup()
 framework = getGameFramework()
 if not framework then
 START:SetCore("SendNotification", {Title = "Framework Error", Text = "Could not hook the rhythm game framework layer."})
 return
 end

 if not SS:FindFirstChild("ClientMusic") then
 clientMusic = Instance.new("Sound")
 clientMusic.Parent = SS
 clientMusic.Name = "ClientMusic"
 clientMusic.SoundId = 0
 clientMusic.TimePosition = 0
 else
 clientMusic = SS["ClientMusic"]
 end
 
 local keyHook = hookfunction(framework.SongPlayer.GetKeyCount, function(value)
 return getChartKeyAmount()
 end)
 doEasterEgg()
end

-- Underframe setup
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
 repeat task.wait() until playerGui.GameUI.Arrows.Visible == true
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
 if playerGui:FindFirstChild("Underframe") then
 playerGui:FindFirstChild("Underframe"):Destroy()
 end
 end
end

function Noti(messagetitle, messagebody, typeSound)
 START:SetCore("ChatMakeSystemMessage", {
 Text = "[FunkyChart] " .. messagetitle .. ": " .. messagebody,
 Color = Color3.fromRGB(255, 255, 255),
 TextSize = 20
 })
 venyx:Notify({
 title = messagetitle,
 text = messagebody,
 soundType = typeSound
 })
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
 if data.underframe.enabled then
 if not checkIfFileExists(data.underframe.additionalID) then
 Noti("Additional ID Not Found", data.underframe.additionalID .. " skipped.", "error")
 data.underframe.additionalIDType = "none"
 end
 end
 if textToUpdate ~= nil then
 textToUpdate.Options:Update({
 title = data.chartData.chartName .. " - " .. data.chartData.chartAuthor,
 list = {data.chartData.chartName .. " - " .. data.chartData.chartAuthor, "Difficulty: " .. data.chartData.chartDifficulty, tostring(getChartKeyAmount()) .. "-key chart", "Has " .. #data.chartData.chartNotes .. " notes", "Underframe = " .. tostring(data.underframe.enabled)}
 })
 end
 if not silent then
 Noti("Song Loaded", data.chartData.chartName .. " - " .. data.chartData.chartAuthor, "loaded")
 end
 data.chartData.chartLoaded = true
end

function Data(mode)
 local foldername = "FunkyChart"
 local datafilename = "FunkyChartSaveData.txt"
 local audiofoldername = foldername .. "/Audio"
 local chartfoldername = foldername .. "/Charts"
 local assetsfoldername = foldername .. "/Assets"
 function reset()
 delfile(datafilename)
 Noti("Save Data Deleted", "FunkyChart will now be closed. Please re-execute.", "main")
 Exit()
 end
 function load()
 if checkIfFileExists(datafilename) then
 data.options = game:GetService("HttpService"):JSONDecode(readfile(datafilename))
 if data.options.version ~= data.versions.saveDataVersion then
 Noti("Old Save Data", "Your save data was not up to date. Resetting.", "error")
 reset()
 return
 else
 Noti("Save Data Loaded", "Welcome back " .. player.Name .. ".", "main")
 end
 else
 Noti("Save Data Not Found", "Load a chart to create your save data.", "main")
 end
 end
 function save()
 local json = game:GetService("HttpService"):JSONEncode(data.options)
 writefile(datafilename, json)
 Noti("Save Data Saved", "Your Options data has been saved!", "main")
 end
 if checkIfFolderExists(foldername) then
 if checkIfFolderExists(audiofoldername) then makefolder(foldername) end
 if checkIfFolderExists(chartfoldername) then makefolder(chartfoldername) end
 if checkIfFolderExists(assetsfoldername) then makefolder(assetsfoldername) end
 if mode == "s" then save()
 elseif mode == "l" then load()
 elseif mode == "r" then reset() end
 else
 makefolder(foldername)
 makefolder(audiofoldername)
 makefolder(chartfoldername)
 makefolder(assetsfoldername)
 Noti("First time?", "Looks like you don't have any save data.", "main")
 end
end

function resetData(choice)
 if choice == "chart" then
 data.chartData = {
 chartLoaded = false, chartNotes = {}, chartKeys = 4, chartName = "None",
 chartNameColor = "<font color='rgb(255, 255, 255)'>%s</font>",
 chartAuthor = "None", chartDifficulty = "None", chartConverter = "None", loadedAudioID = ""
 }
 elseif choice == "partial" then
 data.options.timeOffset = 0.1
 data.options.playerRight = false
 data.options.side = "Left"
 end
end

function randomTPStage()
 local stage
 function randomSelectStage()
 stage = stages[math.random(#stages)]
 if stage.Name == "WreckedStage" or stage.Name == "FinalEscapeStage" then randomSelectStage() end
 end
 randomSelectStage()
 local tween = TS:Create(player.Character.HumanoidRootPart, TweenInfo.new(0.5), {CFrame = stage.Zone.CFrame})
 tween:Play()
 tween.Completed:Wait()
end

function Chart()
 local chartKeyMaps = {
 ["4"] = {"Tricky_Expurgation", "Hard"}, ["5"] = {"VSFireboyWatergirl_Flashgames", "Hard"},
 ["6"] = {"VSShaggy_Blast", "Insane"}, ["7"] = {"VSShaggy_Astralcalamity", "Insane"},
 ["8"] = {"VSMannCo_Frontierjustice", "Hard"}, ["9"] = {"VSShaggy_Eater", "Insane"}
 }
 if not data.chartData.chartLoaded then
 Noti("No Chart Loaded", "Load a chart first in the Chart Loading menu.", "error")
 return
 else
 randomTPStage()
 Noti("Now Playing", data.chartData.chartName .. " - " .. data.chartData.chartAuthor, "loaded")
 framework.SongPlayer:StartSong(chartKeyMaps[tostring(getChartKeyAmount())], data.options.side, chartKeyMaps[tostring(getChartKeyAmount())], {player})
 if data.underframe.enabled then
 task.spawn(function() manageUnderframe("create") end)
 end
 framework.SongPlayer.CurrentSongData = data.chartData.chartNotes
 framework.Songs[chartKeyMaps[tostring(getChartKeyAmount())]].Title = data.chartData.chartName
 framework.Songs[chartKeyMaps[tostring(getChartKeyAmount())]].TitleFormat = data.chartData.chartNameColor
 framework.SongPlayer.TopbarAuthor = "By: " .. data.chartData.chartAuthor .. "
Converted by: " .. data.chartData.chartConverter
 framework.SongPlayer.TopbarDifficulty = data.chartData.chartDifficulty
 framework.SongPlayer.CountDown = true
 clientMusic.SoundId = getlocalasset(data.chartData.loadedAudioID)
 framework.SongPlayer.CurrentlyPlaying = clientMusic
 framework.SongPlayer:Countdown()
 framework.SongPlayer.CurrentlyPlaying:Play()
 player.Character.Humanoid.WalkSpeed = 0
 repeat task.wait() until clientMusic.IsPlaying == false or framework.SongPlayer.CurrentSongData == nil
 if clientMusic.IsPlaying == false then framework.SongPlayer:StopSong() end
 if data.underframe.enabled then
 task.spawn(function() manageUnderframe("remove") end)
 end
 clientMusic.Playing = false
 clientMusic.TimePosition = 0
 player.Character.Humanoid.WalkSpeed = 24
 end
end

function functionHandler(func, a1, a2, a3)
 local status, errorDesc = pcall(func, a1, a2, a3)
 if not status then
 Noti("A critical error occured!", tostring(errorDesc), "error")
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
 local pageTheme = venyx:addPage({title = "Theme Editor"})
 
 local mainSecPlayChart = pageMain:addSection({title = "Currently Loaded Chart"})
 local CLSecChartLoad = pageCL:addSection({title = "Chart Loading"})
 local CLSecManual = pageCL:addSection({title = "Manual Select"})
 local optSecGameplay = pageOpt:addSection({title = "Gameplay"})
 local optSecGUI = pageOpt:addSection({title = "GUI"})
 local optSecSave = pageOpt:addSection({title = "Save Data"})
 local UFSecGeneral = pageUF:addSection({title = "Underframe"})
 local UFSecSettings = pageUF:addSection({title = "Settings"})
 local MiscGeneral = pageMisc:addSection({title = "Experimental Options"})
 local KBSec = pageKB:addSection({title = "Keybinds"})
 local credSec = pageCred:addSection({title = "Thanks to..."})
 local colors = pageTheme:addSection({title = "Colors"})

 local songDetails = {}
 local charts = {}
 local assets = {'Color Background'}
 local credits = {"wally-rblx: AutoPlayer", "Stefanuk12: Venyx UI Library"}
 local splashes = {"Created by accountrevived", "Best script ever made", "Thanks for supporting FunkyChart"}

 local songDetailsDrop = mainSecPlayChart:addDropdown({title = "No Chart Loaded", list = songDetails})
 
 mainSecPlayChart:addButton({title = "Play Chart!", callback = function() functionHandler(Chart) end})
 mainSecPlayChart:addButton({title = "Load Auto-player", callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/funky-friday-autoplay/main/main.lua'))() end})
 mainSecPlayChart:addButton({title = "Destroy GUI", callback = function() Exit() end})

 local chartDrop = CLSecChartLoad:addDropdown({title = "Select Chart", list = charts, callback = function(text) chartLink = text end})
 CLSecChartLoad:addButton({title = "Load Chart", callback = function() functionHandler(loadChart, chartLink, songDetailsDrop, false) end})
 CLSecChartLoad:addButton({title = "Refresh Chart List", callback = function() chartDrop.Options:Update({ list = listfiles("FunkyChart/Charts/") }) end})

 CLSecManual:addTextbox({title = "File Location", default = "Type Here", callback = function(value, focusLost) if focusLost then chartLink = value end end})
 CLSecManual:addButton({title = "Load Chart", callback = function() functionHandler(loadChart, chartLink, songDetailsDrop, false) end})

 optSecGameplay:addToggle({title = "Set Player as Right (Player 2)", default = data.options.playerRight, callback = function(value) if value then data.options.playerRight = true data.options.side = "Right" else data.options.playerRight = false data.options.side = "Left" end end})
 optSecGameplay:addSlider({title = "Time Offset", default = 0, min = -500, max = 500, callback = function(value) data.options.timeOffset = value / 1000 end})
 optSecGameplay:addButton({title = "Apply To Chart", callback = function() functionHandler(loadChart, chartLink, songDetailsDrop, true) functionHandler(Data, "s") Noti("Changes Applied", "Time Offset applied.", "loaded") end})
 optSecGameplay:addButton({title = "Reset to Default", callback = function() resetData("partial") functionHandler(loadChart, chartLink, songDetailsDrop, true) end})

 optSecGUI:addSlider({title = "Title Size", default = 72, min = 0, max = 500, callback = function(value) playerGui.GameUI.TopbarLabel.Size = UDim2.new(0.4, 0, 0, value) end})
 optSecGUI:addButton({title = "Reset Size to Default (72)", callback = function() playerGui.GameUI.TopbarLabel.Size = UDim2.new(0.4, 0, 0, 72) end})
 optSecSave:addButton({title = "DELETE CURRENT SAVE", callback = function() functionHandler(Data, "r") end})

 UFSecGeneral:addToggle({title = "Underframe Enabled", callback = function(value) data.underframe.enabled = value end})
 local UFSelectDrop = UFSecGeneral:addDropdown({title = "Select Asset", list = assets, callback = function(text) data.underframe.additionalID = text extension = string.lower(data.underframe.additionalID:match("^.+(%..+)$") or "") if string.match(extension, ".mp4") or string.match(extension, ".webm") then data.underframe.additionalIDType = 'Video' elseif string.match(extension,".png") or string.match(extension, ".jpg") then data.underframe.additionalIDType = 'Image' else data.underframe.additionalIDType = 'Color Background' end end})
 
 UFSecSettings:addSlider({title = "Transparency (%)", default = 0, min = 0, max = 100, callback = function(value) data.underframe.transparency = value / 100 end})
 UFSecSettings:addColorPicker({title = "Set Color Background's Color", default = Color3.fromRGB(0, 0, 0), callback = function(color3) data.underframe.color = color3 end})
 UFSecSettings:addToggle({title = "Video Looping", callback = function(value) data.underframe.videoLoop = value end})
 UFSecSettings:addButton({title = "Refresh Assets List", callback = function() UFSelectDrop.Options:Update({ list = {'None', table.unpack(listfiles("FunkyChart/Assets/"))} }) end})

 MiscGeneral:addButton({title = "Custom Title", callback = function() local title = playerGui.GameUI.TopbarLabel title.AnchorPoint = Vector2.new(0, 1) title.BackgroundTransparency = 0 title.BackgroundColor3 = Color3.fromRGB(0, 0, 0) title.BorderSizePixel = 0 title.Font = Enum.Font.GothamBlack title.LineHeight = 1.2 title.Position = UDim2.new(0, 0, 1, 0) title.TextXAlignment = Enum.TextXAlignment.Left title.ZIndex = 1 end})
 MiscGeneral:addDropdown({title = "Key Amount", list = {"4", "5", "6", "7", "8", "9"}, callback = function(text) data.chartData.chartKeys = tonumber(text) end})
 MiscGeneral:addButton({title = "Extract Current Chart", callback = function() writefile("ExtractedChart.txt", game:GetService("HttpService"):JSONEncode(framework.SongPlayer.CurrentSongData)) end})

 KBSec:addKeybind({title = "Toggle GUI", key = Enum.KeyCode.One, callback = function() venyx:toggle() end})
 KBSec:addKeybind({title = "Stop Song", key = Enum.KeyCode.Two, callback = function() clientMusic.Playing = false end})

 credSec:addDropdown({default = "Thanks to...", list = credits, callback = function(text) if text == credits then setclipboard("https://github.com/wally-rblx/funky-friday-autoplay") end end})

 for i, v in pairs(localThemes) do
 colors:addColorPicker({title = i, default = v, callback = function(color3) venyx:setTheme({theme = i, color3 = color3}) end})
 end

 venyx:SelectPage({page = venyx.pages[1], toggle = true})
 chartDrop.Options:Update({ list = listfiles("FunkyChart/Charts/") })
 UFSelectDrop.Options:Update({ list = {'None', table.unpack(listfiles("FunkyChart/Assets/"))} })
 songDetailsDrop.Options:Update({ title = "No Chart Loaded", list = {"Load a chart to show its data."} })
 
 venyx:Notify({title = "Script Loaded", text = "Welcome to FunkyChart!", soundType = "main"})
end

function Init()
 if executorFunctionManager() then
 framework = getGameFramework()
 initSetup()
 Data("l")
 loadGUI()
 end
end
Init()
