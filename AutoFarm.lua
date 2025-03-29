--[[ Its Hub V3 - Auto Farm Melhorado Blox Fruits Feito por Its ]]

-- Serviços local Players = game:GetService("Players") local Player = Players.LocalPlayer local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variáveis local autoFarmOn = false

-- Função para pegar a missão correta def getQuest() local level = Player.Data.Level.Value local quests = { {level = 1, npc = "Bandit Quest Giver", quest = "Bandit"}, {level = 10, npc = "Monkey Quest Giver", quest = "Monkey"}, {level = 50, npc = "Desert Quest Giver", quest = "Desert Bandit"} }

for _, quest in ipairs(quests) do
    if level >= quest.level then
        return quest
    end
end
return nil

end

-- Função para interagir com NPC local function talkToNPC(npcName) local npc = game.Workspace.NPCs:FindFirstChild(npcName) if npc then Player.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame wait(0.5) ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", npcName) end end

-- Função para encontrar NPC inimigo local function getEnemy() for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid").Health > 0 then return enemy end end return nil end

-- Auto Farm Loop spawn(function() while true do wait() if autoFarmOn then local quest = getQuest() if quest then talkToNPC(quest.npc) end

local enemy = getEnemy()
        if enemy then
            repeat
                wait()
                Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack")
            until not enemy or enemy.Humanoid.Health <= 0 or not autoFarmOn
        end
    end
end

end)

-- Ativar/Desativar Auto Farm local function toggleAutoFarm() autoFarmOn = not autoFarmOn end

