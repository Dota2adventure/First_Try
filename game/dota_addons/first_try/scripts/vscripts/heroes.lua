-- Grant the fighter his starting equipment
function GameMode:OnHeroInGame(hero)

	-- Fighter = Sven
	if hero:GetUnitName() == "npc_dota_hero_sven" then
		-- These lines will create an item and add it to the player, effectively ensuring they start with the item
		local item = CreateItem("item_chainmail", hero, hero)
		local item2 = CreateItem("item_broadsword", hero, hero)
		
		hero:AddItem(item)
		hero:AddItem(item2) 
		print('Items added')
	end

	-- Level the first ability
	-- hero:GetAbilityByIndex(0):SetLevel(1)
end

function teleport( keys )
	local point = keys.target_points[1]
	local caster = keys.caster
	FindClearSpaceForUnit( caster, point, false )
end


--[[Author: Pizzalol
	Date: 07.01.2015.
	Moves the caster to the target location and checks height]]
function bullrush( keys )
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin() 
	local target_point = keys.target_points[1]
	local ability = keys.ability
	local speed = ability:GetLevelSpecialValueFor("speed", (ability:GetLevel() - 1)) * 0.03

	local distance = (target_point - caster_location):Length2D()
	local direction = (target_point - caster_location):Normalized()
	local traveled_distance = 0

	-- Moving the caster
	Timers:CreateTimer(0, function()
		if traveled_distance < distance then
			caster_location = caster_location + direction * speed
			caster:SetAbsOrigin(caster_location)
			traveled_distance = traveled_distance + speed
			return 0.03
		else
			FindClearSpaceForUnit(caster, caster_location, false)
		end

	end)

end

function StrToDamage( keys )

	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local str_caster = caster:GetStrength()
	local str_damage = ability:GetLevelSpecialValueFor("str_damage", (ability:GetLevel() -1)) 
	

	local damage_table = {}

	damage_table.attacker = caster
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.ability = ability
	damage_table.victim = target

	damage_table.damage = str_caster * str_damage

	ApplyDamage(damage_table)

end

function UpgradeAbility(hero,ability)
	
	if path1+path2 > 4 then
		print("ERROR: Max lvl 5 per ability")
		return 
	end

	-- Need table with oriname, path1, path2

	-- Old name
	local ability_old_name = ability:GetAbilityName() 

	-- Set new names
	local ability_new_name = oriname..path1..path2

	-- Add, Swap, Find Handle, Set Level and Remove the old ability
	hero:AddAbility(ability_new_name)
	hero:SwapAbilities(ability_old_name, ability_new_name, false, true)
	local new_ability_handle = hero:FindAbilityByName(ability_new_name)
	new_ability_handle:SetLevel(1)
	print("Upgraded "..ability_old_name.." to "..ability_new_name)
	hero:RemoveAbility(ability_old_name)

end