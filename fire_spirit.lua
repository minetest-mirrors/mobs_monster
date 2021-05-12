
local S = mobs.intllib

-- Fire Spirit

mobs:register_mob("mobs_monster:fire_spirit", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 4,
	hp_min = 25,
	hp_max = 45,
	armor = 100,
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	visual_scale = {x = 0.5, y = 0.5, z = 0.5},
	visual = "sprite",
	textures = {
		{"mobs_fire_spirit.png"}
	},
	glow = 14,
	blood_texture = "fire_basic_flame.png",
	immune_to = {
		{"all"}
	},
	makes_footstep_sound = false,
	sounds = {
		random = "fire_fire",
		damage = "fire_extinguish_flame",
		death = "fire_extinguish_flame"
	},
	view_range = 14,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "fireflies:firefly", chance = 2, min = 1, max = 1}
	},
	water_damage = 1,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	fall_damage = false,
	fear_height = 8,
	animation = {},

	on_die = function(self, pos)

		mobs:effect(pos, 20, "tnt_smoke.png", 3, 5, 2, 0.5, nil, false)

		self.object:remove()
	end,

	do_custom = function(self, dtime)

		self.flame_timer = (self.flame_timer or 0) + dtime

		if self.flame_timer < 0.5 then
			return
		end

		self.flame_timer = 0

		local pos = self.object:get_pos()

		-- pos, amount, texture, min_size, max_size, radius, gravity, glow, fall
		mobs:effect(pos, 5, "fire_basic_flame.png", 1, 2, 0.5, 0.5, 14, nil)

	end
})

--[[
if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "mobs_monster:dirt_monster",
	nodes = {"default:dirt_with_grass", "ethereal:gray_dirt", "ethereal:dry_dirt"},
	min_light = 0,
	max_light = 7,
	chance = 6000,
	active_object_count = 2,
	min_height = 0,
	day_toggle = false,
})
end
]]

mobs:register_egg("mobs_monster:fire_spirit", S("Fire Spirit"), "fire_basic_flame.png", 1)
