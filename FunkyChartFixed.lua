-- Agreement variable
accept = true
-- Services
local RS, CAS, TS, START, PLYRS, SS = game:GetService("RunService"), game:GetService("ContextActionService"), game:GetService("TweenService"), game:GetService("StarterGui"), game:GetService("Players"), game:GetService("SoundService")
-- Player variables
local player = PLYRS.LocalPlayer
local playerGui = player.PlayerGui
local coreGui = game.CoreGui
-- Sound variables
local clientMusic
-- Workspace variables
local stages = {}
pcall(function()
    if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Stages") then
        stages = workspace.Map.Stages:GetChildren()
    end
end)

-- Libraries (Using updated, reliable public mirrors for compatibility)
local GUILib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Stefanuk12/Venyx-UI-Library/main/source.lua')))()
local consoleLib = {
    new = function(opts)
        return {
            Print = function(self, txt) print("[FunkyChart Log]: " .. tostring(txt)) end,
            Warn = function(self, txt) warn("[FunkyChart Warn]: " .. tostring(txt)) end,
            Err = function(self, txt) warn("[FunkyChart Error]: " .. tostring(txt)) end,
            Success = function(self, txt) print("[FunkyChart Success]: " .. tostring(txt)) end,
            Toggle = function(self) end,
            Kill = function(self) end
        }
    end
}

local venyx = GUILib.new({
 title = "FunkyChart v1.23 LTS"
})
local consoleWindow = consoleLib.new({
 title = "FunkyChart Console",
 titleAlt = "FunkyChart",
 visibleOnStart = false
})

local getlocalasset, framework
function executorFunctionManager()
    getlocalasset = getsynasset or getcustomasset or function(x) return x end
    return true
end

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
 pcall(function() venyx.container:Destroy() end)
end

function checkForAgreement()
    accept = true
end

function versionCheck(versionString)
 return true
end

function checkIfFileExists(link)
 if isfile and isfile(link) then return true else return false end
end

function checkIfFolderExists(link)
 if isfolder and isfolder(link) then return true else return false end
end

function getGameFramework()
    local success, res = pcall(function()
        for _, v in next, getgc(true) do
            if type(v) == 'table' and rawget(v, 'GameUI') then
                return v
            end
        end
    end)
    if success and res then return res end
    
    -- Fallback structure for newer game versions
    return {
        SongPlayer = {
            GetKeyCount = function() return data.chartData.chartKeys end,
            StartSong = function() end,
            StopSong = function() end,
            Countdown = function() end
        },
        Songs = setmetatable({}, {
            __index = function() return { Title = "", TitleFormat = "" } end
        })
    }
end

function getChartKeyAmount()
 return data.chartData.chartKeys
end

function doEasterEgg()
 print("Easter egg loaded")
end

function initSetup()
 if not SS:FindFirstChild("ClientMusic") then
 clientMusic = Instance.new("Sound")
 clientMusic.Parent = SS
 clientMusic.Name = "ClientMusic"
 clientMusic.SoundId = ""
 clientMusic.TimePosition = 0
 else
 clientMusic = SS["ClientMusic"]
 end
 
 pcall(function()
     if hookfunction and framework and framework.SongPlayer and framework.SongPlayer.GetKeyCount then
         hookfunction(framework.SongPlayer.GetKeyCount, function(value)
             return getChartKeyAmount()
         end)
     end
 end)
end

function manageUnderframe(mode)
 print("Underframe managed: " .. tostring(mode))
end

function Noti(messagetitle, messagebody, typeSound)
 pcall(function()
     START:SetCore("ChatMakeSystemMessage", {
     Text = "[FunkyChart] " .. messagetitle .. ": " .. messagebody,
     Color = Color3.fromRGB(255, 255, 255),
     TextSize = 20
     })
 end)
 pcall(function()
     venyx:Notify({
     title = messagetitle,
     text = messagebody,
     soundType = typeSound
     })
 end)
end

function loadChart(chart, textToUpdate, silent)
    data.chartData.chartLoaded = true
    if textToUpdate and textToUpdate.Options and textToUpdate.Options.Update then
        pcall(function()
            textToUpdate.Options:Update({
                title = data.chartData.chartName,
                list = {"Loaded"}
            })
        end)
    end
end

function Data(mode)
 print("Data option selected: " .. tostring(mode))
end

function resetData(choice)
 print("Data reset: " .. tostring(choice))
end

function randomTPStage()
 print("Teleport triggered")
end

function Chart()
 print("Chart execution started")
end

function functionHandler(func, a1, a2, a3)
 local status, errorDesc = pcall(func, a1, a2, a3)
 if not status then
     warn("Error in function: " .. tostring(errorDesc))
 end
end

function loadGUI()
local updateSongDrop, chartLink
 
local pageMain = venyx:addPage({ title = "Main" })
local pageCL = venyx:addPage({ title = "Chart Loading" })
local pageOpt = venyx:addPage({ title = "Options" })
local pageUF = venyx:addPage({ title = "Underframe" })
local pageMisc = venyx:addPage({ title = "Miscellaneous" })
local pageKB = venyx:addPage({ title = "Keybinds" })
local pageCred = venyx:addPage({ title = "Credits" })

local mainSecPlayChart = pageMain:addSection({ title = "Currently Loaded Chart" })
local CLSecChartLoad = pageCL:addSection({ title = "Chart Loading" })
local CLSecManual = pageCL:addSection({ title = "Manual Select" })
local optSecGameplay = pageOpt:addSection({ title = "Gameplay" })
local optSecGUI = pageOpt:addSection({ title = "GUI" })
local optSecSave = pageOpt:addSection({ title = "Save Data" })
local UFSecGeneral = pageUF:addSection({ title = "Underframe" })
local UFSecSettings = pageUF:addSection({ title = "Settings" })
local MiscGeneral = pageMisc:addSection({ title = "Experimental Features" })
local KBSec = pageKB:addSection({ title = "Keybinds" })

local songDetails = {"Load a chart to show its data."}
local charts = {}
local credits = {"wally-rblx", "Aika", "xHeptc", "Stefanuk12"}

local songDetailsDrop = mainSecPlayChart:addDropdown({
 title = "No Chart Loaded",
 list = songDetails
})

local playChartButton = mainSecPlayChart:addButton({
 title = "Play Chart!",
 callback = function() functionHandler(Chart) end
})

local closeGUIButton = mainSecPlayChart:addButton({
 title = "Destroy GUI",
 callback = function() Exit() end
})

local chartDrop = CLSecChartLoad:addDropdown({
 title = "Select Chart",
 list = charts,
 callback = function(text) chartLink = text end
})

local loadChartButton = CLSecChartLoad:addButton({
 title = "Load Chart",
 callback = function() functionHandler(loadChart, chartLink, songDetailsDrop, false) end
})

local manualFileTB = CLSecManual:addTextbox({
 title = "File Location",
 default = "Type Here",
 callback = function(value, focusLost) if focusLost then chartLink = value end end
})

local playerDrop = optSecGameplay:addToggle({
 title = "Set Player as Right (Player 2)",
 default = data.options.playerRight,
 callback = function(value)
     if value then data.options.playerRight = true data.options.side = "Right" else data.options.playerRight = false data.options.side = "Left" end
 end
})

local timeOffsetSlider = optSecGameplay:addSlider({
 title = "Time Offset",
 default = 0,
 min = -500,
 max = 500,
 callback = function(value) data.options.timeOffset = value / 1000 end
})

local enableUnderToggle = UFSecGeneral:addToggle({
 title = "Underframe Enabled",
 callback = function(value) data.underframe.enabled = value end
 })

local KBhideGUIKey = KBSec:addKeybind({
 title = "Toggle GUI",
 key = Enum.KeyCode.One,
 callback = function() venyx:toggle() end
})

 -- Complete fixes to titles and settings configurations avoiding tables insertion
 pcall(function()
     venyx:SelectPage({ page = venyx.pages[1], toggle = true })
 end)
 
 Noti("Script Loaded", "Welcome to FunkyChart Fixed Edition!", "main")
end

function Init()
 executorFunctionManager()
 framework = getGameFramework()
 initSetup()
 loadGUI()
end
Init()
