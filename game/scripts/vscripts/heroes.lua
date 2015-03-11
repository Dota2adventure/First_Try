-- Grant Sven his first skill
function GameMode:OnHeroInGame(hero)

	-- Level the first ability
	hero:GetAbilityByIndex(0):SetLevel(1)
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

ListenToGameEvent("dota_glyph_used", Dynamic_Wrap(HeroLineWarsMode, "OnGlyphUsed"), self)

function OnGlyphUsed(keys)
	print("OnGlyphUsed!")
	local team = keys.teamnumber
	for k, creep in pairs(FindUnitsInRadius(team, self.hlw_ancient_position[team], nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NOT_SUMMONED, 0, false)) do
		if creep:HasModifier("dummy_modifier") == false then
			creep:AddNewModifier(creep, nil, "modifier_knockback", {duration = 0.5, should_stun = 0, knockback_distance = 1200, knockback_height = 300, center_x = self.hlw_ancient_position[team].x, center_y = self.hlw_ancient_position[team].y, center_z = self.hlw_ancient_position[team].z, knockback_duration = 1})
		end
	end
	ExecuteOrderFromTable(
	{
		UnitIndex = self.fortifyStunner[team]:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = self.fortifyStunner[team]:FindAbilityByName("fortify_stun"):entindex(),
		Queue = true
	})
	EmitGlobalSound("Hero_ElderTitan.EchoStomp")
end