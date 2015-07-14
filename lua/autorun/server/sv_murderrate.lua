


local PettyPoliceTable = {"Civil Protection"}
--local PettyPoliceBasePay = 100

local ModeratePoliceTable = {"Civil Protection Chief"}
--local ModeratePoliceBasePay = 250

local MajorPoliceTable = {"S.W.A.T."}
--local MajorPoliceBasePay = 250

local WeaponTable = {}
local PeacefulWeapon = "weapon_cs_glock"

WeaponTable[1] = "weapon_cs_glock"
WeaponTable[2] = "weapon_cs_deagle"
WeaponTable[3] = "weapon_cs_deagle"
WeaponTable[4] = "weapon_cs_m3"
WeaponTable[5] = "weapon_cs_m3"
WeaponTable[6] = "weapon_cs_mp5"
WeaponTable[7] = "weapon_cs_mp5"
WeaponTable[8] = "weapon_cs_m4a1"
WeaponTable[9] = "weapon_cs_m4a1"
WeaponTable[10] = "weapon_cs_sig552"
WeaponTable[11] = "weapon_cs_sig552"
WeaponTable[12] = "weapon_cs_para"

local MurderStats = {}

local CheckTime = 60*10

function DarkRPMurderPlayerDeath(victim,weapon,attacker)

	if victim ~= attacker then
		
		local Time = RealTime()
		table.Add(MurderStats, {RealTime()} )
		print("Adding Murder States...")
	
	end

end

hook.Add("PlayerDeath","DarkRPMurder: PlayerDeath",DarkRPMurderPlayerDeath)

local NextTick = 0

function DarkRPMurderUpdate()

	if NextTick <= CurTime() then
	
		for k,v in pairs(MurderStats) do
		
			if v <= RealTime() - CheckTime then
				table.remove(MurderStats,v)
			end
			
		end
	
		print("Murders in the last " .. string.NiceTime(CheckTime) .. ": " .. table.Count(MurderStats))
	
		NextTick = CurTime() + 30
	end

end

hook.Add("Think","DarkRPMurder: Think",DarkRPMurderUpdate)

function DarkRPMurderSpawn(ply)

	if table.HasValue(PettyPoliceTable,team.GetName(ply:Team())) then
	
		print("YOU'RE A COP")
		

		local WeaponToGive
	
		if table.Count(MurderStats) == 0 then
			print("Peaceful")
			WeaponToGive = PeacefulWeapon
		elseif table.Count(MurderStats) > table.Count(WeaponTable) then
			print("SHITS GOING DOWN")
			WeaponToGive = WeaponTable[table.Count(WeaponTable)]
		else
			print("HOLY SHIT")
			WeaponToGive = WeaponTable[table.Count(MurderStats)]
		end

		print(WeaponToGive)
		
		if WeaponToGive then
			timer.Simple(1, function()
				ply:Give(WeaponToGive)
			end)
		end
		
	elseif table.HasValue(ModeratePoliceTable,team.GetName(ply:Team())) then
	
		local WeaponToGive
	
		if table.Count(MurderStats) + 2 > table.Count(WeaponTable) then
			WeaponToGive = WeaponTable[table.Count(WeaponTable)]
		else
			WeaponToGive = WeaponTable[table.Count(MurderStats) + 2]
		end

		if WeaponToGive then
			timer.Simple(1, function()
				ply:Give(WeaponToGive)
			end)
		end
		

	
	elseif table.HasValue(MajorPoliceTable,team.GetName(ply:Team())) then
	
		local WeaponToGive
	
		if table.Count(MurderStats) + 4 > table.Count(WeaponTable) then
			WeaponToGive = WeaponTable[table.Count(WeaponTable)]
		else
			WeaponToGive = WeaponTable[table.Count(MurderStats) + 4]
		end
		
		if WeaponToGive then
			timer.Simple(1, function()
				ply:Give(WeaponToGive)
			end)
		end
		
	end

end

hook.Add("PlayerSpawn","DarkRPMurder: Spawn",DarkRPMurderSpawn)