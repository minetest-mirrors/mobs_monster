
-- translation and custom stone monster types

local S = core.get_translator("mobs_monster")

local stone_types = {

	{	nodes = {"default:desert_stone"},
		skins = {"mobs_stone_monster3.png"},
		drops = {
			{name = "default:desert_cobble", chance = 1, min = 0, max = 2},
			{name = "default:iron_lump", chance = 5, min = 0, max = 2},
			{name = "default:gold_lump", chance = 5, min = 0, max = 2}
		}
	},

	{	nodes = {"default:sandstone"},
		skins = {"mobs_stone_monster4.png"},
		drops = {
			{name = "default:sandstone", chance = 1, min = 0, max = 2},
			{name = "default:tin_lump", chance = 5, min = 0, max = 2},
			{name = "default:copper_lump", chance = 5, min = 0, max = 2}
		}
	}
}

-- Stone Monster by PilzAdam

mobs:register_mob("mobs_monster:stone_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 3,
	hp_min = 12,
	hp_max = 35,
	armor = 80,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_stone_monster.png"},
		{"mobs_stone_monster2.png"} -- by AMMOnym
	},
	makes_footstep_sound = true,
	sounds = {random = "mobs_stonemonster"},
	walk_velocity = 1,
	run_velocity = 2,
	jump_height = 0,
	stepheight = 1.1,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "default:cobble", chance = 1, min = 0, max = 2},
		{name = "default:coal_lump", chance = 3, min = 0, max = 2},
		{name = "default:iron_lump", chance = 5, min = 0, max = 2}
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15, speed_run = 15,
		stand_start = 0, stand_end = 14,
		walk_start = 15, walk_end = 38,
		run_start = 40, run_end = 63,
		punch_start = 40, punch_end = 63
	},
	immune_to = {
		{"default:pick_wood", 0}, -- wooden pick doesnt hurt stone monster
		{"default:pick_stone", 4}, -- picks deal more damage to stone monster
		{"default:pick_bronze", 5},
		{"default:pick_steel", 5},
		{"default:pick_mese", 6},
		{"default:pick_diamond", 7}
	},

	-- check surrounding nodes and spawn a specific spider
	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1
		local tmp

		for n = 1, #stone_types do

			tmp = stone_types[n]

			if core.find_node_near(pos, 1, tmp.nodes) then

				self.base_texture = tmp.skins
				self.object:set_properties({textures = tmp.skins})

				if tmp.drops then self.drops = tmp.drops end

				return true
			end
		end

		return true -- run only once, false/nil runs every activation
	end
})

-- where to spawn

if not mobs.custom_spawn_monster then

	mobs:spawn({
		name = "mobs_monster:stone_monster",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone",
				"default:permafrost_with_stones"},
		max_light = 7,
		chance = 7000,
		max_height = 0
	})
end

-- spawn egg

mobs:register_egg("mobs_monster:stone_monster", S("Stone Monster"), "default_stone.png", 1)

-- compatibility with older mobs mod

mobs:alias_mob("mobs:stone_monster", "mobs_monster:stone_monster")
