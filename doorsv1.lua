local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Durk | Doors", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local isSpeedControlled = false
local currentSpeed = 16
local doorsDefaultSpeed = 12 -- Velocidade padrão do DOORS
local toggleObject -- Para armazenar o objeto do Toggle

-- Função para ajustar a velocidade continuamente
local function adjustSpeed()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    while true do
        if isSpeedControlled then
            humanoid.WalkSpeed = currentSpeed -- Aplica a velocidade do slider
        else
            humanoid.WalkSpeed = doorsDefaultSpeed -- Velocidade padrão do DOORS quando desativado
        end
        wait(0.1) -- Pequeno intervalo para não sobrecarregar
    end
end

-- Inicia o ajuste contínuo de velocidade
spawn(adjustSpeed)

-- Função para alternar rapidamente o Toggle
local function toggleSpeedControl()
    if toggleObject then
        toggleObject:Set(false) -- Desliga o Toggle
        wait(0.1) -- Pequeno intervalo
        toggleObject:Set(true) -- Liga o Toggle novamente
    end
end

-- Slider para ajustar a velocidade
Tab:AddSlider({
    Name = "Velocidade",
    Min = 1,
    Max = 3,
    Default = 1,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "valor",
    Callback = function(Value)
        -- Atualiza a velocidade baseada no slider
        if Value == 1 then
            currentSpeed = 16 -- Velocidade mínima
        elseif Value == 2 then
            currentSpeed = 25 -- Velocidade intermediária
        elseif Value == 3 then
            currentSpeed = 35 -- Velocidade máxima
        end

        print("Velocidade ajustada para: " .. currentSpeed)

        -- Desliga e liga rapidamente o Toggle para aplicar a mudança de velocidade
        if isSpeedControlled then
            toggleSpeedControl()
        end
    end
})

-- Toggle para ativar/desativar o controle de velocidade
toggleObject = Tab:AddToggle({
    Name = "Ativar velocidade",
    Default = false,
    Callback = function(Value)
        isSpeedControlled = Value

        if isSpeedControlled then
            print("Controle de velocidade ativado. Velocidade: " .. currentSpeed)
        else
            -- Quando o Toggle é desativado, a velocidade volta para a velocidade padrão do DOORS
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")

            humanoid.WalkSpeed = doorsDefaultSpeed
            print("Controle de velocidade desativado. Velocidade padrão do DOORS: " .. doorsDefaultSpeed)
        end
    end
})

