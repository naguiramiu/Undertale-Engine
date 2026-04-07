function declare_armors()
{
	global.armors = 
	{
		error: new create_armor(
		e_armorid.error,
		{
			name: "Error!"	
		}),
		orange_armor: new create_armor(
		e_armorid.orange_armor,
		{
			name: "Orange"	
		},
		1, 5, 0),
		wolf_armor: new create_armor(
		e_armorid.wolf_armor,
		{
			name: "Wolf Armor"	
		},
		2, 9, 2),
		purple_armor: new create_armor(
		e_armorid.purple_armor,
		{
			name: "Purple"	
		},
		2, 4, 0
		),
		green_armor: new create_armor(
		e_armorid.green_armor,
		{
			name: "Green"	
		},
		0, 4, 2
		)
	}
}

function declare_weapons()
{
	global.weapons = 
	{
		error: new create_weapon(
		e_weaponid.error,
		{
			name: "Error!"	
		},
		e_weapontype.glove),
		
		default_glove: new create_weapon(
		e_weaponid.default_glove,
		{
			name: "Gloves"	
		},
		e_weapontype.glove,
		3, 2, 0
		),
		
		default_melee: new create_weapon(
		e_weaponid.default_melee,
		{
			name: "Melee"	
		},
		e_weapontype.melee,
		6, 0, 0
		),
		
		default_axe: new create_weapon(
		e_weaponid.default_axe,
		{
			name: "Default Axe"	
		},
		e_weapontype.axe,
		4, 0, 1
		),
		
		default_scarf: new create_weapon(
		e_weaponid.default_scarf,
		{
			name: "Scarf"	
		},
		e_weapontype.scarf,
		2, 2, 4
		)
	}
}