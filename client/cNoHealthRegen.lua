class("NoHealthRegen")

function NoHealthRegen:__init()
  helpItem = {}
  helpItem.name = "NoHealthRegen"
  helpItem.text = "A script that disables the natural health regeneration in Just Cause 2."
  
  lastHealth = 0
  
  Events:Fire("HelpAddItem", helpItem)
  
  Events:Subscribe("ModuleUnload", self, self.Unload)
  Events:Subscribe("PostTick", self, self.Main)
end

function NoHealthRegen:Unload()
  Events:Fire("HelpRemoveItem", helpItem.name)
end

function NoHealthRegen:Main()
  changeHealth = LocalPlayer:GetHealth() - lastHealth
  if changeHealth < 0.003 and changeHealth > 0.001 then
    Network:Send("NaturalRegen", {["Player"] = LocalPlayer, ["ChangeTo"] = lastHealth})
  end
  lastHealth = LocalPlayer:GetHealth()
end

NoHealthRegen = NoHealthRegen()