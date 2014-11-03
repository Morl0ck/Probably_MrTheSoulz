--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	mtsStart:message("\124cff9482C9*MTS-\124cffFF7D0ADruid/Feral-\124cff9482C9Loaded*")
	
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

  	--	keybinds
  		{ "Ursol's Vortex", {"modifier.shift", "target.exists"}, "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", {"modifier.shift", "target.exists"}, "target" },
	  	{ "Typhoon", {"modifier.alt", "target.exists"}, "target" },
	  	{ "Mass Entanglement", "modifier.shift" },

  	-- Auto Targets
		{ "/target [target=focustarget, harm, nodead]", { "@mtsLib.getConfig('mtsconfDruidFeral_AutoTarget')", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy [noexists]", { "@mtsLib.getConfig('mtsconfDruidFeral_AutoTarget')", "!target.exists" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "@mtsLib.getConfig('mtsconfDruidFeral_AutoTarget')", "target.exists", "target.dead" }}, -- target enemire if current is dead.

  	-- Survival
	  	{ "Renewal", "@mtsLib.Compare('health','mtsconfDruidFeral_Renewal','player')" }, -- Renewal
	  	{ "Cenarion Ward", "@mtsLib.Compare('health','mtsconfDruidFeral_CenarionWard','player')" }, -- Cenarion Ward
	  	{ "61336", "@mtsLib.Compare('health','mtsconfDruidFeral_SurvivalInstincts','player')" }, -- Survival Instincts
	  	{ "5185", { "@mtsLib.Compare('health','mtsconfDruidFeral_HealingTouch','player')", "player.buff(Predatory Swiftness)" }}, -- Healing Touch

  	--Interrupts
	  	{ "106839", { "target.casting", "modifier.interrupt" }, "target"},	-- Skull Bash
	  	{ "5211", "modifier.interrupt", "target" }, -- Mighty Bash

  	{{-- Cat && MotW
  		{ "/cancelaura Cat Form", { -- Cancel player form
  			"player.form > 0",  -- Is in any fom
  			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
  			"!player.buff(5215)" }},-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form
  		{ "768", { -- catform
  			"player.form != 2", -- Stop if cat
  			"!modifier.lalt", -- Stop if pressing left alt
  			"!player.buff(5215)"}}, -- Not in Stealth
  	},"@mtsLib.getConfig('mtsconfDruidFeral_Buffs')"},

  	-- buffs
  		{ "52610", { "!player.buff(52610)", "!player.buff(174544)", "player.combopoints <= 2" }, "target"}, -- Savage Roar
  		{ "770", { "!target.debuff(770)", "!player.spell(106707).exists" }, "target", "!player.buff(5215)" }, -- Faerie Fire
		{ "5217", "@mtsLib.Compare('energy','mtsconfDruidFeral_TigersFury','player')"}, -- Tiger's Fury

  	--Cooldowns
	  	{ "106737", { "player.spell(106737).charges > 2", "!modifier.last(106737)", "player.spell(106737).exists" }}, --Force of Nature
	  	{ "106951", "modifier.cooldowns" }, -- Beserk
	  	{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
	  	{ "102543", "modifier.cooldowns" }, -- incarnation
  	
	-- Proc's
  		{ "106830", "player.buff(Omen of Clarity)", "target" }, -- Free Thrash

	{{-- can use FH

		-- AoE smart
			{ "106785", "player.area(8).enemies >= 4" }, -- Swipe // FireHack
			{ "106830", "player.area(8).enemies >= 4", "target" }, -- Tharsh

	}, {"player.firehack", "@mtsLib.getConfig('mtsconf_Firehack')"}},


	-- AoE
		{ "106785", "modifier.multitarget"}, -- Swipe
		{ "106830", "modifier.multitarget", "target" }, -- Tharsh

	{{ -- Dont use in aoe
	-- dots
		{ "1822", "target.debuff(155722).duration <= 4", "target" }, -- 
		{ "1079", { -- Rip // bellow 25% if target does not have debuff
			"target.health < 25", 
			"!target.debuff(1079)", -- stop if target as rip debuff
			"player.combopoints = 5" }, "target"},
		{ "1079", { -- Rip
			"target.health > 25", 
			"target.debuff(1079).duration <= 7", 
			"player.combopoints = 5" }, "target"},
		{ "106830", "target.debuff(106830).duration <= 1.5", "target" }, -- Tharsh

	-- rotation
	    { "22568", { "target.health < 25", "target.debuff(1079).duration < 5" }, "target"}, -- Ferocious Bite to refresh Rip when target at <= 25% health.
	    { "22568", { "target.debuff(1079)", "target.health < 30", "player.combopoints = 5" }, "target"},-- Ferocious Bite // Target Health is less then 25%
	    { "22568", { "player.combopoints = 5", "target.debuff(1079).duration > 5", "player.buff(52610).duration > 5" }, "target"}, -- Ferocious Bite // Max Combo and Rip or Savage do not need refreshed
	      	
	    -- Shred // Combo Point Building Rotation
	    	{ "5221", "player.buff(Clearcasting)", "target"  }, -- Shred
	    	{ "5221", "player.buff(Berserk)", "target"  }, -- Shred 
	    	{ "5221", "player.combopoints < 5", "target" }, -- Shred
	}, "!modifier.multitarget" },
  
}

local outCombat = {
	
	--	keybinds
	  	{ "Ursol's Vortex", {"modifier.shift", "target.exists"}, "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", {"modifier.control", "target.exists"}, "target" },
	  	{ "Typhoon", {"modifier.alt", "target.exists"}, "target" },
	  	{ "Mass Entanglement", "modifier.shift" },

	-- buff
		{{-- Cat ANd MotW
			{ "/cancelaura Cat Form", { -- Cancel player form
	  			"player.form > 0",  -- Is in any fom
	  			"!player.buff(20217).any", -- kings
				"!player.buff(115921).any", -- Legacy of the Emperor
				"!player.buff(1126).any",   -- Mark of the Wild
				"!player.buff(90363).any",  -- embrace of the Shale Spider
				"!player.buff(69378).any",  -- Blessing of Forgotten Kings
	  			"!player.buff(5215)"}}, -- Not in Stealth
			{ "1126", {  -- Mark of the Wild
				"!player.buff(20217).any", -- kings
				"!player.buff(115921).any", -- Legacy of the Emperor
				"!player.buff(1126).any",   -- Mark of the Wild
				"!player.buff(90363).any",  -- embrace of the Shale Spider
				"!player.buff(69378).any",  -- Blessing of Forgotten Kings
				"!player.buff(5215)",-- Not in Stealth
				"player.form = 0"}},  -- Player not in form
			{ "768", { -- catform
	  			"player.form != 2", -- Stop if cat
	  			"!modifier.lalt", -- Stop if pressing left alt
	  			"!player.buff(5215)"}}, -- Not in Stealth
	  	}, "@mtsLib.getConfig('mtsconfDruidFeral_Buffs')" },
  		{ "5215", { -- Stealth
  			"player.form = 2", -- If cat
  			"!player.buff(5215)", -- Not in Stealth
  			"@mtsLib.getConfig('mtsconfDruidFeral_Prowl')"}},

}

ProbablyEngine.rotation.register_custom(103, mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Feral|r]", inCombat, outCombat, exeOnLoad)


