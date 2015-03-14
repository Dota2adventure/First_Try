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

function ToggleAbilityPassive( event )
	local caster = event.caster
	local ability = event.ability
	local level = ability:GetLevel() 
	local ability_index = ability:GetSpecialValueFor("AbilityIndex")
	local ability_name = ability:GetAbilityName()


	-- Has been used, switch to active
	if caster:GetAbilityByIndex( ability_index ):IsPassive() then

		-- Swap abilities
		caster:SwapAbilities( ability_name .."_passive", ability_name , false, true)		

		-- Start Cooldown
		local new_ability_handle = caster:FindAbilityByName( ability_name )
		local cd = new_ability_handle:GetCooldown( level - 1 )
		new_ability_handle:EndCooldown() 
		new_ability_handle:StartCooldown(cd)		

	-- Has been activated switch to passive
	else

		-- Swap abilities
		caster:SwapAbilities( ability_name , ability_name .."_passive" , false, true)		
		
		local new_ability_handle = caster:FindAbilityByName( ability_name .."_passive" )
		new_ability_handle:SetLevel(level)
	end
end

--[[Author: Pizzalol
	Date: 09.02.2015.
	Forces the target to attack the caster]]
function Taunt( keys )
	local caster = keys.caster
	local target = keys.target

	-- Clear the force attack target
	target:SetForceAttackTarget(nil)

	-- Give the attack order if the caster is alive
	-- otherwise forces the target to sit and do nothing
	if caster:IsAlive() then
		local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster:entindex()
		}

		ExecuteOrderFromTable(order)
	else
		target:Stop()
	end

	-- Set the force attack target to be the caster
	target:SetForceAttackTarget(caster)
end

-- Clears the force attack target upon expiration
function TauntEnd( keys )
	local target = keys.target

	target:SetForceAttackTarget(nil)
end