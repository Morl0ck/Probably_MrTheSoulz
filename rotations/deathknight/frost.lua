--[[ ///---INFO---////
// DK Frost //
!Originaly made by PCMD!
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]
local _darkSimSpells = {
-- siege of orgrimmar
"Froststorm Bolt","Arcane Shock","Rage of the Empress","Chain Lightning",
-- pvp
"Hex","Mind Control","Cyclone","Polymorph","Pyroblast","Tranquility","Divine Hymn","Hymn of Hope","Ring of Frost","Entangling Roots"
}

function DarkSimUnit(unit)
	for index,spellName in pairs(_darkSimSpells) do
		if ProbablyEngine.condition["casting"](unit, spellName) then return true end
	end
		return false
end

ProbablyEngine.condition.register('twohand', function(target)
  return IsEquippedItemType("Two-Hand")
end)

ProbablyEngine.condition.register('onehand', function(target)
  return IsEquippedItemType("One-Hand")
end)

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('run', 'Interface\\Icons\\Inv_boots_plate_dungeonplate_c_05.png', 'Enable Unholy Presence Outside of Combat', 'Enable/Disable Unholy Presence Outside of Combat \nMakes you run/fly faster when outside of combat.')
	mtsStart:message("\124cff9482C9*MTS-\124cffC41F3BDeathKnight/Frost\124cff9482C9-Loaded*")
	ProbablyEngine.toggle.create( 'GUI', 'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 'Open/Close GUIs','Toggle GUIs', (function() mts_ClassGUI() mts_ConfigGUI() end) )     mts_showLive()

end

local inCombat = {

	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay
	
	-- Presence
		{ "48266", "player.seal != 2" }, -- frost

	-- Buffs
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter

	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },

	--Auto target
		{ "/cleartarget", {
			"toggle.autotarget",
			(function() return UnitIsFriend("player","target") end)
			}},
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- items
		{ "#5512", "player.health < 70"}, --healthstone
	
	{{-- Blood Tap

	   	{ "Blood Tap", "player.runes(unholy).count = 0" },
	    { "Blood Tap", "player.runes(frost).count = 0" },
	   	{ "Blood Tap", "player.runes(death).count = 0" },

	} , { "player.buff(Blood Charge).count >= 5", "player.runes(death).count = 0" }},

	-- Def cooldowns // heals
		{ "48792", { "toggle.defcd", "player.health <= 40" }, "player')" }, -- Icebound Fortitude
		{ "48743", { "toggle.defcd", "player.health <= 50" }}, -- Death Pact
		{ "49039", { "toggle.defcd", "player.state.fear", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //fear
		{ "49039", { "toggle.defcd", "player.state.sleep", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //sleep
		{ "49039", { "toggle.defcd", "player.state.charm", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //charm
		{ "108196", { "toggle.defcd","player.health < 60" }},-- Death Siphon

	-- Cooldowns
		--{ "61999", { "modifier.cooldowns", "player.health <= 30" }, "mouseover" }, -- Raise Ally
		{ "47568", { "modifier.cooldowns", "player.runes(death).count < 1", "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runicpower < 30" }}, -- Empower Rune Weapon
		{ "51271", "modifier.cooldowns" }, -- Pilar of frost
		{ "115989", { "modifier.cooldowns","target.debuff(55095)" }}, -- Unholy Blight
		{ "115989", { "modifier.cooldowns","target.debuff(55078)" }}, -- Unholy Blight
		{ "#gloves"},

	-- Interrupts
		{ "47528", { "target.interruptsAt(50)", "modifier.interrupts" }, "target" }, -- Mind freeze
		{ "47476", { "target.interruptsAt(50)", "modifier.interrupts", "!player.modifier.last(47528)"}, "target" }, -- Strangulate
		{ "108194", { "target.interruptsAt(50)", "!modifier.last(47528)" }, "target" }, -- Asphyxiate

	-- Spell Steal
		{ "77606", function() return DarkSimUnit('target') end, "target" }, -- Dark Simulacrum
		{ "77606",function() return DarkSimUnit('focus') end, "focus" },  -- Dark Simulacrum

	-- Plague Leech
		{ "123693", {
			"target.debuff(55095)",-- Target With Frost Fever
			"target.debuff(55078)",-- Target With Blood Plague
			"player.runes(unholy).count = 0",-- With 0 Unholy Runes
			"player.runes(frost).count = 0",-- With 0 Frost Runes
			"player.runes(death).count = 0",-- With 0 Death Runes
			"!modifier.last"}}, 

	-- Diseases
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "45462", "target.debuff(55078).duration < 2", "target" }, -- Plague Strike
		{ "45477", "target.debuff(55095).duration < 2", "target" }, -- Icy Touch
		{ "48721", { -- Blood Boil // blod
			"player.runes(blood).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},
		{ "48721", {  -- Blood Boil // death
			"player.runes(death).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},


	{{-- 1hand

		-- AoE
	      	{ "50842", { "modifier.last(Outbreak)", "modifier.multitarget" }}, -- blood boil
	      	{ "50842", {"modifier.last(Plague Strike)", "modifier.multitarget" }}, -- blood boil
	      	{ "49184", "modifier.multitarget", "target" }, -- Howling Blast
	      	{ "49143", {"player.runicpower >= 75", "modifier.multitarget"}, "target" }, -- Frost Strike
	      	{ "45462", { "player.runes(unholy).count = 2", "player.spell(Death and Decay).cooldown", "modifier.multitarget" }}, -- Plague Strike
      		{ "49143", "modifier.multitarget" },-- Frost Strike

		 -- Single Target
			{ "49143", "player.buff(Killing Machine)" },-- Frost Strike
	      	{ "49143", "player.runicpower > 88" },-- Frost Strike
	      	{ "49184", "player.runes(death).count > 1" },-- Howling Blast
	      	{ "49184", "player.runes(frost).count > 1" },-- Howling Blast
	      	{ "114866", "target.health < 35" },--Soul Reaper
	      	{ "49184", "player.buff(Freezing Fog)" }, -- Howling Blast
	      	{ "49143", "player.runicpower > 76" },-- Frost Strike
	     	{ "49998", "player.buff(Dark Succor)" }, -- Death Strike
	      	{ "49998", "player.health <= 65" }, -- Death Strike
	      	{ "49020", { "player.runes(unholy).count > 0", "!player.buff(Killing Machine)" }, "target" }, -- Obliterate
	      	{ "49184" },--Howling Blast
	      	{ "49143", "player.runicpower >= 40" },-- Frost Strike
	     
	 }, "player.onehand" },

	{{-- 2Hand

		
	    -- AoE
	      	{ "45529", { "player.buff(Blood Charge).count >= 5", "!player.runes(blood).count == 2", "!player.runes(frost).count == 2", "!player.runes(unholy).count == 2", "modifier.multitarget" }}, -- Blood Tap
	      	{ "49184", "modifier.multitarget", "target" }, -- Howling Blast
	      	{ "49143", {"player.runicpower >= 75", "modifier.multitarget" }, "target" },-- Frost Strike
	      	{ "45462", { "player.runes(unholy).count = 2", "player.spell(Death and Decay).cooldown", "modifier.multitarget" }, "target" }, -- Plague Strike
	      	{ "49143", "modifier.multitarget", "target" },-- Frost Strike

    
	    -- Single Target
	      	{ "130735", "target.health < 35" }, -- Soul Reaper
	      	{ "49184", "player.buff(Freezing Fog)" }, -- Howling Blast
	      	
	      	 -- If player less then 65% health
	        	{ "49998", {"player.buff(Killing Machine)", "player.health < 65"}, "target" }, -- Death Strike
	        	{ "49998", {"player.runicpower <= 75", "player.health < 65"}, "target" }, -- Death Strike
		    
		     -- If player more then 65% health
		        { "49020", {"player.buff(Killing Machine)", "player.health > 65"}, "target" }, -- Obliterate
		    	{ "49020", {"player.runicpower <= 75", "player.health > 65"}, "target" }, -- Obliterate

	      	{ "45529", "player.buff(Blood Charge).count >= 5" }, -- Blood Tap
	      	{ "49143", "!player.buff(Killing Machine)" }, -- Frost Strike
	      	{ "49143", "player.spell(Obliterate).cooldown >= 4" }, -- Frost Strike

	}, "player.twohand" },
  
}

local outCombat = {

	-- Keybinds
		{ "42650", {"modifier.alt", "target.exits"} }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- Buffs
		{ "48266", { "player.seal != 2 ", "!toggle.run" }}, -- frost
		{ "48265", { "player.seal != 3", "toggle.run" }}, -- unholy // moves faster out of combat...
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
  
}

ProbablyEngine.rotation.register_custom(251, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Frost|r]", inCombat, outCombat, exeOnLoad)