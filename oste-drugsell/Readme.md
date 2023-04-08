## oste Drugsell
This is my first script, it's nothing fancy but thought I'd share it anyway.
If any bugs are found it would be nice to get feedback on my discord.

Some of the things you see in the preview are in Danish, but this has been changed in the script.

## Installation Guide

-- qb-core/shared/items

	["packagedweed"]				 = {["name"] = "packagedweed", 					["label"] = "2g Weed", 		    		["weight"] = 100, 		["type"] = "item", 		["image"] = "weed_baggy.png", 			["unique"] = false, 	  ["useable"] = true, 	["shouldClose"] = false,	   ["combinable"] = nil,   ["description"] = ""},


-- qb-target/init

Config.Peds = {
    {
        model = `a_m_m_hillbilly_02`,
        coords = vector4(50.12, -1453.75, 29.31, 53.06),
        invincible = true,
        blockevents = true,
        minusOne = true,
        freeze = true,
        weapon = {
            name = `weapon_bat`,
            ammo = 0,
            hidden = false,
        },
        target = {
            options = {
                {
                    type = "client",
                    event = "oste-drugsell:client:weed:delivery",
                    icon = "fas fa-box-open",
                    label = "Deliver Weed",
                },
            },
            distance = 1.5
        }
    }
}