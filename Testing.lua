getgenv().VALUE_SETTINGS = {
    Distance = 7, --<number>
    Start = {
        AutoFarm = true,
        AutoQuest = true
    },
    Mob = {
        "Bandit|0",
        "Pirate|20"
    } --<string> MobName|LvPlayer|QuestArgument
}




print("-----------")



local GetingLevel = function()
    return game.Players.LocalPlayer.Data.Level.Value
end
local KangFindNearest = function(Object,Path)
    if Path:FindFirstChild(Object) then
        local ObjectName = tostring(Object);
        local ObjectNearest;
        local NearestList = {};
        for _, NewPath in pairs(Path:GetChildren()) do
            --if NewPath.ClassName == "Forder" then
                for i,v in pairs(NewPath:GetChildren()) do
                    if v.Name == ObjectName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid").Health > 0 then
                        table.insert(NearestList,v)
                    end
                end
            --end
        end
        if NearestList[1] ~= nil then
            ObjectNearest = NearestList[1]
        end
        if ObjectNearest ~= nil then
            for i,v in pairs(NearestList) do
                if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude <= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - ObjectNearest:FindFirstChild("HumanoidRootPart").Position).magnitude then
                    ObjectNearest = v
                end
            end
        end
        return ObjectNearest
    end
end

local GetingQuest = function(QuestName)
    if not game.Players.LocalPlayer:FindFirstChild("Quest") and getgenv().VALUE_SETTINGS.Start.AutoQuest then
      game.ReplicatedStroage.Remote.Geral:FireServer("Quest", tostring(QuestName))
      return 
    end
    return true
end

spawn(function()
    while wait() do
        pcall(function()
            local Data = function()
                local LastSelect
                local LastLevel = GetingLevel()
                for i, v in pairs(getgenv().VALUE_SETTINGS.Mob) do
                    local FoundLevel = string.match(v, "%d+")
                    if tonumber(LastLevel) >= tonumber(FoundLevel) then
                        LastSelect = v
                    end
                end
            return LastSelect:split("|")
            end
            local LastData = Data()
            print(unpack(LastData))
            if getgenv().VALUE_SETTINGS.Start.AutoFarm then
                print(1)
                if GetingQuest(LastData[1]) then
                    print(2)
                    print(KangFindNearest(tostring(LastData[1]), game.workspace.Game.Characters)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = KangFindNearest(tostring(LastData[1]), game.workspace.Game.Characters).HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * tostring(getgenv().VALUE_SETTINGS.Distance)
                    print(3)
                end
            end
        end)
    end
end)
