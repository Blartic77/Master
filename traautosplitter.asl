// Autosplitter script for TRA (v5.0) by NextLevelMemes, using apel's v1.0 load remover. Special thanks to Cadarev for figuring out how to prevent the same autosplit from happening twice. Also huge thanks BryNu for thoroughly testing it, and thanks to Taeruhs, Didi and Dayo/Clay for helping me to test it too.    
// Note that the default (NBJ) splits are based on specific routes/paths based on the latest top speedrun of that category. If you're using different shortcuts, remember to untick the splits in the layout settings. 
// For a guide on how to use this autosplitter (and for troubleshooting too) please refer to this guide: https://www.speedrun.com/tra/guide/7dxat
// The splits files for different categories can be found here: https://www.speedrun.com/tra/resources

state("tra")
{
	bool Loading : 0x412C64;
	float RegionID : 0x49BF74, 0xC, 0x104, 0x6DB, 0x389; 
	byte AreaLabel : 0x1D06EA, 0x7E; 
	float HP : 0x861EB8, 0x1C; 
	float IGT : 0x55A50, 0x6D8;
	uint IGTStoryPlusIL : 0x48F370, 0x2C;
    uint IGTStoryOnly : 0x438330, 0x1DFC;
	float xCoord : 0x417DEC, 0x14;
	float yCoord : 0x417DEC, 0x10;
	float zCoord : 0x417DEC, 0x18;
	float HeadZ : 0x467AC, 0x18;  
	float BossHP : 0x55234, 0x28; 
	byte SumArtifactsRelics : 0x4923C4, 0x44; 
	uint IsMenu : 0xF7464, 0x20; 
	byte IsCutscene : 0x1D40DC, 0xB;
	float levelcount : 0x553A8, 0x80;
	float SMedPack : 0x28B5, 0xB8;
	float MedPack : 0x28B5, 0xC0;
	byte DontCheat1 : 0x2625F4, 0x394;
	byte DontCheat2 : 0x8F0F7, 0xD; 
	byte DontCheat3 : 0x8F67A, 0x2; 
	byte IsDeath : 0x25B94, 0x407; 
	byte IsDeath2 : 0x85D24, 0x3;
	byte MidasDeath : 0x1B21F8, 0x3;
	string8 SaveTime : 0x34CAC8, 0x574, 0xC, 0x40, 0x3C, 0x190, 0x24, 0x188, 0x94; 
	uint Inventory2 : 0x12E64F, 0x201; 
	float GateZ : 0x417E2C, 0x18;
	string10 GameStart : 0x1F9678, 0x1AD;
	string4 Load : 0x1F9678, 0x201;
	string3 Quit : 0x1F9678, 0x1C9;
	string4 Header : 0x1F9678, 0x81;
	string3 RCM : 0x1F9678, 0x239;
}

init
{
    print("Checking your bank account...please standby");
	print("Money transfer successful. Thank you sucker!");
    refreshRate = 30;
	vars.ZeroSaveLoad = false;
	vars.LoadEnded = false;
	vars.NewGame = false;
	vars.LoadMenu = false;
	vars.ManorReset = false;
}

update
{
	if(old.SaveTime == "00:00:00" && current.SaveTime != "00:00:00")
	{
	vars.ZeroSaveLoad = true;
	}
	if((old.Load == "Load" && current.Load != "Load" && current.IsMenu >= 1)||(current.IGT == 1 && old.IGT == 0)||(current.Quit == "Yes" && old.Quit != "Yes" && current.IsMenu == 2))
	{
	vars.ZeroSaveLoad = false;
	}
	if(!current.Loading && old.Loading)
	{
	vars.LoadEnded = true;
	}
	if((current.Loading && !old.Loading)||(old.Load == "Load" && current.Load != "Load" && current.IsMenu >= 1)||(current.IGT == 1 && old.IGT == 0)||(current.Quit == "Yes" && old.Quit != "Yes" && current.IsMenu == 2))
	{
	vars.LoadEnded = false;
	}
	if(current.IsMenu == 0 && old.IsMenu == 2 && current.GameStart == "Start Game")
	{
	vars.NewGame = true;
	}
	if((current.GameStart == "Start Game" && old.GameStart != "Start Game")||(old.Load == "Load" && current.Load != "Load" && current.IsMenu >= 1)||(current.IGT == 1 && old.IGT == 0)||(current.Quit == "Yes" && old.Quit != "Yes" && current.IsMenu == 2))
	{
	vars.NewGame = false;
	}
	if(old.Load == "Load" && current.Load != "Load" && current.IsMenu == 2 && current.IsCutscene == 0)
	{
	vars.LoadMenu = true;
	}
	if((current.Load == "Load" && old.Load != "Load" && current.IsMenu == 1 && current.IsCutscene == 0)||(current.IGT == (old.IGT + 1) && current.IGT > old.IGT)||(current.Quit == "Yes" && old.Quit != "Yes" && current.IsMenu == 2))
	{
	vars.LoadMenu = false;
	}
	if(current.Load != "Rest" && old.Load == "Rest" && current.levelcount == 0 && current.IsMenu >=1)
	{
	vars.ManorReset = true;
	}
	if((old.Load != "Rest" && current.Load == "Rest" && current.IsMenu == 1)||(current.levelcount == 0 && current.IGT == 1 && old.IGT == 0)||(current.Quit == "Yes" && old.Quit != "Yes" && current.IsMenu == 2))
	{
	vars.ManorReset = false;
	}
}

start
{
	if(current.levelcount == 0)
	   {
	   if(current.IsCutscene == 0 && vars.LoadEnded && current.IGTStoryPlusIL == 0 && current.HeadZ != 0 && (old.HeadZ == 0||old.IsCutscene == 1) && settings["PlayManor"])
           {
           vars.LaraWasHere.Clear();
           return true;
           }   
	   if(!current.Loading && old.Loading && current.IGTStoryPlusIL == 0 && settings["LoadManor"])
           {
           vars.LaraWasHere.Clear();
           return true;
           }	   
	   }
	if(vars.NewGame)
	   {
	   if(current.levelcount == 1 && current.GateZ > 3300 && current.IsCutscene == 0 && vars.LoadEnded && current.IGTStoryPlusIL == 0 && old.IsCutscene == 1 && settings["PlayCaves"])
           {
           vars.LaraWasHere.Clear();
           return true;
           }	
       if(current.levelcount == 1 && current.GateZ > 3300 && current.IsCutscene == 1 && !current.Loading && old.Loading && current.IGTStoryPlusIL == 0 && settings["LoadCaves"])
           {
           vars.LaraWasHere.Clear();
           return true;
           }	   
	   }
	if(!vars.NewGame)
	   {
	   if(current.levelcount == 1 && !current.Loading && old.Loading && current.IGTStoryPlusIL == 0 && settings["PlayCaves"])                                
	       {
           vars.LaraWasHere.Clear();
           return true;
           }   
	   }
}

split
{
//Peru:
    if(current.AreaLabel == 2 && old.AreaLabel == 1 && current.RegionID == 1 && !vars.LaraWasHere.Contains("MountainCaves1") && settings["MountainCaves1"])
	{
		vars.LaraWasHere.Add("MountainCaves1");
		return true;
	}   
	if(current.AreaLabel == 7 && old.AreaLabel == 6 && current.RegionID == 1 && !vars.LaraWasHere.Contains("MountainCaves2") && settings["MountainCaves2"])
    {
		vars.LaraWasHere.Add("MountainCaves2");
		return true;
	}   
    if(current.AreaLabel == 8 && old.AreaLabel == 7 && current.RegionID == 1 && !vars.LaraWasHere.Contains("VilcabambaWarp") && settings["VilcabambaWarp"])
	{
		vars.LaraWasHere.Add("VilcabambaWarp");
		return true;
	} 
	if(current.AreaLabel == 23 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TheLostValley") && current.levelcount > old.levelcount && settings["TheLostValley"])
    {
		vars.LaraWasHere.Add("TheLostValley");
		return true;
	}  
	if(current.AreaLabel == 16 && old.AreaLabel == 11 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TombOfQualopec1") && settings["TombOfQualopec1"])
    {
		vars.LaraWasHere.Add("TombOfQualopec1");
		return true;
	}  
	if(((current.AreaLabel == 17)||(current.AreaLabel == 18)) && current.IsCutscene == 0 && old.IsCutscene == 1 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TombOfQualopec2") && settings["TombOfQualopec2"])
    {
		vars.LaraWasHere.Add("TombOfQualopec2");
		return true;
	}  

//Greece:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 2 && !vars.LaraWasHere.Contains("StFrancisFolly1") && settings["StFrancisFolly1"])
    {
		vars.LaraWasHere.Add("StFrancisFolly1");
		return true;
	}   
    if(current.AreaLabel == 3 && old.AreaLabel == 2 && current.RegionID == 2 && !vars.LaraWasHere.Contains("StFrancisFolly2") && settings["StFrancisFolly2"])
    {
		vars.LaraWasHere.Add("StFrancisFolly2");
		return true;
	}  
	if(current.AreaLabel == 31 && old.AreaLabel == 3 && current.RegionID == 2 && !vars.LaraWasHere.Contains("TheColiseum") && (settings["TheColiseum"]||settings["BTGSFF"]))
    {
		vars.LaraWasHere.Add("TheColiseum");
		return true;
	} 
    if(current.AreaLabel == 18 && current.RegionID == 2 && !vars.LaraWasHere.Contains("MidasPalace") && current.levelcount > old.levelcount && settings["MidasPalace"])
    {
		vars.LaraWasHere.Add("MidasPalace");
		return true;
	} 
	if(current.AreaLabel == 27 && current.HeadZ >= 0 && old.HeadZ < 0 && current.RegionID == 2 && !vars.LaraWasHere.Contains("TombOfTihocan1") && (settings["TombOfTihocan1"]||settings["BTGMidas"]))
    {
		vars.LaraWasHere.Add("TombOfTihocan1");
		return true;
	} 
	if(current.RegionID == 2 && current.BossHP == 40000 && old.IsCutscene == 1 && current.IsCutscene == 0 && !vars.LaraWasHere.Contains("TombOfTihocan2") && settings["TombOfTihocan2"])
    {
		vars.LaraWasHere.Add("TombOfTihocan2");
		return true;
	} 
	   
//Egypt:
    if(current.RegionID == 3 && old.RegionID != 3 && !vars.LaraWasHere.Contains("TempleOfKhamoon") && settings["TempleOfKhamoon"])
    {
		vars.LaraWasHere.Add("TempleOfKhamoon");
		return true;
	} 
	if(current.AreaLabel == 20 && old.AreaLabel != 20 && current.RegionID == 3 && !vars.LaraWasHere.Contains("SanctuaryOfTheScion1") && (settings["SanctuaryOfTheScion1"]||settings["BTGTemple"]))
    {
		vars.LaraWasHere.Add("SanctuaryOfTheScion1");
		return true;
	} 
    if(current.AreaLabel == 22 && old.AreaLabel != 22 && current.RegionID == 3 && !vars.LaraWasHere.Contains("SanctuaryOfTheScion2") && settings["SanctuaryOfTheScion2"])
    {
		vars.LaraWasHere.Add("SanctuaryOfTheScion2");
		return true;
	} 
	   
//Atlantis:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 4 && !vars.LaraWasHere.Contains("NatlasMines1") && settings["NatlasMines1"])
    {
		vars.LaraWasHere.Add("NatlasMines1");
		return true;
	}
	if(current.AreaLabel == 5 && old.AreaLabel == 2 && current.RegionID == 4 && !vars.LaraWasHere.Contains("NatlasMines2") && settings["NatlasMines2"])
    {
		vars.LaraWasHere.Add("NatlasMines2");
		return true;
	}
    if(current.AreaLabel == 11 && old.AreaLabel == 10 && current.RegionID == 4 && !vars.LaraWasHere.Contains("TheGreatPyramid1") && settings["TheGreatPyramid1"])
    {
		vars.LaraWasHere.Add("TheGreatPyramid1");
		return true;
	}  
	if(current.AreaLabel == 14 && old.AreaLabel == 13 && current.RegionID == 4 && !vars.LaraWasHere.Contains("TheGreatPyramid2") && settings["TheGreatPyramid2"])
    {
		vars.LaraWasHere.Add("TheGreatPyramid2");
		return true;
	}  
	if(current.AreaLabel == 17 && old.AreaLabel == 16 && current.RegionID == 4 && !vars.LaraWasHere.Contains("TheFinalConflict1") && settings["TheFinalConflict1"])
    {
		vars.LaraWasHere.Add("TheFinalConflict1");
		return true;
	} 
	if(current.AreaLabel == 19 && current.RegionID == 4 && current.BossHP == 5600 && old.BossHP != 5600 && !vars.LaraWasHere.Contains("TheFinalConflict2") && settings["TheFinalConflict2"])
    {
		vars.LaraWasHere.Add("TheFinalConflict2");
		return true;
	} 
	if(current.AreaLabel == 19 && current.BossHP == 3200 && current.RegionID == 4 && old.IsCutscene == 1 && current.IsCutscene == 0 && !vars.LaraWasHere.Contains("TheFinalConflict3") && settings["TheFinalConflict3"])
    {
		vars.LaraWasHere.Add("TheFinalConflict3");
		return true;
	} 
	if(current.AreaLabel == 19 && current.RegionID == 4 && settings["TheFinalConflict4"] && current.levelcount > old.levelcount && !vars.LaraWasHere.Contains("TheFinalConflict4"))
    {
		vars.LaraWasHere.Add("TheFinalConflict4");
		return true;
	} 
	
//100%:
	if(settings["Artifacts"])
	   {
	   if(current.SumArtifactsRelics > old.SumArtifactsRelics)
	   return true;
	   if((current.levelcount > old.levelcount && current.AreaLabel >= 19 && current.RegionID >= 4)||(current.AreaLabel == 19 && current.RegionID == 4 && current.Header == "EXIT" && old.Header == "Cont"))
	   return true;
	   }
	if(settings["Chapter"] && current.RegionID > old.RegionID && !vars.LoadMenu)
	return true;
	   
//By Level:
    if(settings["Level"] && current.levelcount > old.levelcount && !vars.LoadMenu && current.IsMenu >= 1)
	   return true;	
	if(settings["Level"] && current.levelcount == 0 && current.AreaLabel >= 14 && current.AreaLabel < 16 && current.IsMenu == 0 && old.IsMenu == 2)
	   return true;
	   
//By Level - Alt + F4 compatible splits at the end of each level based on glitchless runs (some of these split slightly earlier/later due to having different conditions other than the level endscreen):   
    //Caves:
	if((settings["CavesEndAltF4"]||settings["BTGCaves"]) && current.AreaLabel == 7 && current.RegionID == 1 && current.yCoord < -15000 && old.yCoord >= -15000 && current.HeadZ < 1000 && !vars.LaraWasHere.Contains("CavesEnd"))
	{
		vars.LaraWasHere.Add("CavesEnd");
		return true;
	} 
	//Vilcabamba:
	if((settings["VilcaEndAltF4"]||settings["BTGVilca"]) && current.AreaLabel == 23 && current.RegionID == 1 && current.xCoord > -350 && old.xCoord <= -350 && current.HeadZ > 0 && current.yCoord > -1000 && !vars.LaraWasHere.Contains("VilcaEnd"))
	{
		vars.LaraWasHere.Add("VilcaEnd");
		return true;
	} 
	//Valley:
	if((settings["ValleyEndAltF4"]||settings["BTGValley"]) && current.AreaLabel == 16 && old.AreaLabel != 16 && current.RegionID == 1 && !vars.LaraWasHere.Contains("ValleyEnd"))
	{
		vars.LaraWasHere.Add("ValleyEnd");
		return true;
	} 
	//Qualopec:
	if((settings["QualoEndAltF4"]||settings["BTGQualopec"]) && current.RegionID == 2 && old.RegionID != 2 && !vars.LoadMenu && !vars.LaraWasHere.Contains("QualopecEnd"))
	{
		vars.LaraWasHere.Add("QualopecEnd");
		return true;
	} 
	//SFF:
	if(current.RegionID == 2 && current.AreaLabel == 3 && current.IsCutscene == 0 && old.IsCutscene == 1 && current.GateZ >= -9722 && !vars.LaraWasHere.Contains("SFFEnd") && settings["SFFEndAltF4"])
	{
		vars.LaraWasHere.Add("SFFEnd");
		return true;
	} 
	//Coliseum:
	if((settings["ColiseumEndAltF4"]||settings["BTGColiseum"]) && current.AreaLabel == 18 && current.RegionID == 2 && current.xCoord < 2925 && old.xCoord >= 2925 && !vars.LaraWasHere.Contains("ColiseumEnd"))
	{
		vars.LaraWasHere.Add("ColiseumEnd");
		return true;
	}
	//Midas:	   
    if(settings["MidasEndAltF4"] && current.IsCutscene == 1 && old.Inventory2 == 1684827975 && (current.Inventory2 == 4161536||current.Inventory2 == 4294656) && current.AreaLabel == 18 && current.RegionID == 2 && !vars.LaraWasHere.Contains("MidasEnd"))
	{
		vars.LaraWasHere.Add("MidasEnd");
		return true;
	} 
	//Tihocan:
	if((settings["TihocanEndAltF4"]||settings["BTGTihocan"]) && !vars.LoadMenu && current.RegionID == 3 && old.RegionID != 3 && !vars.LaraWasHere.Contains("TihocanEnd"))
	{
		vars.LaraWasHere.Add("TihocanEnd");
		return true;
	} 
	//Temple:
	if(settings["TempleEndAltF4"] && current.AreaLabel == 10 && current.RegionID == 3 && current.xCoord >=7000 && old.xCoord < 7000 && current.yCoord >= -840 && current.yCoord < 950 && !vars.LaraWasHere.Contains("TempleEnd"))
	{
		vars.LaraWasHere.Add("TempleEnd");
		return true;
	}
	//Obelisk:
	if(settings["ObeliskEndAltF4"] && current.IsCutscene == 1 && current.IsMenu < 2 && old.IsMenu == 2 && current.RegionID == 3 && !vars.LaraWasHere.Contains("ObeliskEnd"))
	{
		vars.LaraWasHere.Add("ObeliskEnd");
		return true;
	}
	//Sanctuary:
	if((settings["SanctuaryEndAltF4"]||settings["BTGSanctuary"]) && !vars.LoadMenu && current.RegionID == 4 && old.RegionID != 4 && !vars.LaraWasHere.Contains("SanctuaryEnd"))
	{
		vars.LaraWasHere.Add("SanctuaryEnd");
		return true;
	} 
	//Mines:
	if(current.RegionID == 4 && current.AreaLabel == 10 && current.IsCutscene == 0 && old.IsCutscene == 1 && current.GateZ >= 5759 && !vars.LaraWasHere.Contains("MinesEnd") && (settings["MinesEndAltF4"]||settings["BTGMines"]))
	{
		vars.LaraWasHere.Add("MinesEnd");
		return true;
	} 
	//Pyramid:
	if(current.AreaLabel == 17 && current.IsCutscene == 0 && old.IsCutscene == 1 && current.RegionID == 4 && !vars.LaraWasHere.Contains("PyramidEnd") && (settings["PyramidEndAltF4"]||settings["BTGPyramid"]))
    {
		vars.LaraWasHere.Add("PyramidEnd");
		return true;
	} 
	//Conflict:
	if(current.AreaLabel == 19 && current.RegionID == 4 && current.IsMenu < 2 && old.IsMenu == 2 && current.zCoord < -1000 && !vars.LaraWasHere.Contains("ConflictEnd") && (settings["ConflictEndAltF4"]||settings["BTGConflict"]))
    {
		vars.LaraWasHere.Add("ConflictEnd");
		return true;
	}
	
//NBJ Alt + F4:
    if(current.AreaLabel == 23 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TheLostValleyAltF4") && current.xCoord > -350 && old.xCoord <= -350 && current.HeadZ > 0 && current.yCoord > -1000 && settings["OtherNBJChecks"])
    {
		vars.LaraWasHere.Add("TheLostValleyAltF4");
		return true;
	}  
	if(current.AreaLabel == 18 && current.RegionID == 2  && !vars.LaraWasHere.Contains("MidasPalaceAltF4") && current.AreaLabel == 18 && current.RegionID == 2 && current.xCoord < 2925 && old.xCoord >= 2925 && settings["OtherNBJChecks"])
    {
		vars.LaraWasHere.Add("MidasPalaceAltF4"); 
		return true;
	} 
	if(!vars.LaraWasHere.Contains("TheFinalConflictAltF4") && settings["OtherNBJChecks"] && current.AreaLabel == 19 && current.RegionID == 4 && current.IsMenu < 2 && old.IsMenu == 2 && current.zCoord < -1000)
    {
		vars.LaraWasHere.Add("TheFinalConflictAltF4");
		return true;
	} 
}

reset
{
   if((((current.IGT < old.IGT  && !current.Loading)||(current.IGTStoryPlusIL < old.IGTStoryPlusIL  && !current.Loading))||(current.HP > old.HP && current.SMedPack == old.SMedPack && current.MedPack == old.MedPack && !current.Loading)||((current.HeadZ > (50 + old.HeadZ)) && ((current.IGT == old.IGT)||(current.IGTStoryPlusIL == old.IGTStoryPlusIL)) && current.DontCheat1 == 1 && ((current.DontCheat2 == 0)||(current.DontCheat3 == 1)))) && settings["Cheats"])
   {
   vars.LaraWasHere.Clear();
   return true;
   }
   if(vars.ZeroSaveLoad && current.Loading && !old.Loading && current.levelcount == 1 && current.IGTStoryOnly == 0 && settings["Load"])
   {
   vars.LaraWasHere.Clear();
   return true;
   }
   if(settings["Death"] && ((current.IsDeath == 5 && old.IsDeath != 5 && !current.Loading)||((current.IsDeath2 >=67 && old.IsDeath < 67)||(current.MidasDeath == 67 && old.MidasDeath != 67 && current.AreaLabel == 18 && current.RegionID == 2))))
   {
   vars.LaraWasHere.Clear();
   return true;
   }
   if(settings["RManor"] && vars.ManorReset && current.RCM == "Yes" && current.IsMenu < old.IsMenu && old.IsMenu == 2)
   {
   vars.LaraWasHere.Clear();
   return true;
   }
}

isLoading
{       
    return current.Loading;
}

startup
{   
	vars.LaraWasHere = new List<string>();
	
    settings.Add("Main", true, "Autostarts when:");
	settings.SetToolTip("Main", "Tick an option to start the timer when:");
	
	  settings.Add("PlayCaves",true, "When you gain control of Lara in Caves", "Main");
	  settings.SetToolTip("PlayCaves", "Starts the timer in Caves when you gain control of Lara.");
	  settings.Add("PlayManor", true, "When you gain control of Lara in the Croft Manor", "Main");
	  settings.SetToolTip("PlayManor", "Starts the timer in the Croft Manor when you gain control of Lara.");
	  settings.Add("LoadCaves",false, "Only when the first cutscene in Caves starts", "Main");
	  settings.SetToolTip("LoadCaves", "Starts the timer in Caves a bit before Lara can move.");
	  settings.Add("LoadManor", false, "Only when the first cutscene in the Croft Manor starts", "Main");
	  settings.SetToolTip("LoadManor", "Starts the timer in the Croft Manor a bit before Lara can move.");
	
	settings.Add("Main2", true, "Autoresets when:");
	settings.SetToolTip("Main2", "Tick an option to autoreset the timer when that condition is satisfied.");
	
	  settings.Add("Cheats",false, "Uncheated Engine (beta)", "Main2");
	  settings.SetToolTip("Cheats", "Prevents some forms of hacking/cheating during runs. Thought for live verifications.");
	  settings.Add("Death", false, "Lara dies", "Main2");
	  settings.SetToolTip("Death", "A bit slower for QTEs and scripted deaths, but works regardless.");
	  settings.Add("Load", true, "Loading your 00:00:00 file", "Main2");
	  settings.SetToolTip("Load", "Resets when loading a file in Caves with an IGT of 0.");
	  settings.Add("RManor", false, "Restarting Croft Manor (for 100% runs)", "Main2");
	  settings.SetToolTip("RManor", "Resets when restarting the Croft Manor.");
	
	settings.Add("Main3", true, "Any% No Bug Jump. Untick if you're running 100%. Autosplits at:");
	settings.SetToolTip("Main3", "Untick the option as a whole, custom splits won't work yet");
	
	  settings.Add("Peru", true, "Peru", "Main3");
	  settings.Add("MountainCaves1",true, "Mountain Caves - Inside", "Peru");
	  settings.SetToolTip("MountainCaves1", "Splits once you get in the ruins.");
	  settings.Add("MountainCaves2",true, "Mountain Caves - Last Room", "Peru");
	  settings.SetToolTip("MountainCaves2", "Splits upon entering the last room.");
	  settings.Add("VilcabambaWarp",true, "Vilcabamba Warp", "Peru");
	  settings.SetToolTip("VilcabambaWarp", "Splits when you're OoB and trigger the checkpoint.");
	  settings.Add("TheLostValley",true, "The Lost Valley", "Peru");
	  settings.SetToolTip("TheLostValley", "Splits when you reach The Lost Valley.");
	  settings.Add("TombOfQualopec1",true, "Tomb Of Qualopec - Way in", "Peru");
	  settings.SetToolTip("TombOfQualopec1", "Splits when you finish The Lost Valley.");
	  settings.Add("TombOfQualopec2",true, "Tomb Of Qualopec - Way out", "Peru");
	  settings.SetToolTip("TombOfQualopec2", "Splits after the cutscene in Qualopec's throne room.");
	
	  settings.Add("Greece", true, "Greece", "Main3");
	  settings.Add("StFrancisFolly1",true, "St. Francis Folly - Entrance", "Greece");
	  settings.SetToolTip("StFrancisFolly1", "Splits once you get in the monastery.");
	  settings.Add("StFrancisFolly2",true, "St. Francis Folly - Vertical Room", "Greece");
	  settings.SetToolTip("StFrancisFolly2", "Splits upon entering the vertical room.");
	  settings.Add("TheColiseum",true, "The Coliseum", "Greece");
	  settings.SetToolTip("TheColiseum", "Splits once you get past St. Francis Folly.");
	  settings.Add("MidasPalace",true, "Midas' Palace", "Greece");
	  settings.SetToolTip("MidasPalace", "Splits when you're about to enter Midas' Palace.");
	  settings.Add("TombOfTihocan1",true, "Tomb Of Tihocan", "Greece");
	  settings.SetToolTip("TombOfTihocan1", "Splits once you get near the tomb's first room.");
	  settings.Add("TombOfTihocan2",true, "Centaur fight", "Greece");
	  settings.SetToolTip("TombOfTihocan2", "Splits when you're about to reach Tihocan's tomb.");
	
	  settings.Add("Egypt", true, "Egypt", "Main3");
	  settings.Add("TempleOfKhamoon",true, "Temple Of Khamoon", "Egypt");
	  settings.SetToolTip("TempleOfKhamoon", "Splits as soon as you start the level.");
	  settings.Add("SanctuaryOfTheScion1",true, "Sanctuary Of The Scion - Entrance", "Egypt");
	  settings.SetToolTip("SanctuaryOfTheScion1", "Splits upon entering the level.");
	  settings.Add("SanctuaryOfTheScion2",true, "Sanctuary Of The Scion - First Half", "Egypt");
	  settings.SetToolTip("SanctuaryOfTheScion2", "Splits upon entering the Sphinx's room.");
	
	  settings.Add("Atlantis", true, "Atlantis", "Main3");
	  settings.Add("NatlasMines1",true, "Natla's Mines - Entrance", "Atlantis");
	  settings.SetToolTip("NatlasMines1", "Splits as soon as the level starts.");
	  settings.Add("NatlasMines2",true, "Natla's Mines - First Half", "Atlantis");
	  settings.SetToolTip("NatlasMines2", "Splits upon entering the lava room.");
	  settings.Add("TheGreatPyramid1",true, "The Great Pyramid - Entrance", "Atlantis");
	  settings.SetToolTip("TheGreatPyramid1", "Splits shortly after you enter the Pyramid.");
	  settings.Add("TheGreatPyramid2",true, "The Great Pyramid - Top of the Pyramid", "Atlantis");
	  settings.SetToolTip("TheGreatPyramid2", "Splits when you're on top of the Pyramid.");
	  settings.Add("TheFinalConflict1",true, "The Final Conflict", "Atlantis");
	  settings.SetToolTip("TheFinalConflict1", "Splits as soon as the level starts.");
	  settings.Add("TheFinalConflict2",true, "The Final Conflict - Natla fight 1", "Atlantis");
	  settings.SetToolTip("TheFinalConflict2", "Splits when the cutscene starts.");
	  settings.Add("TheFinalConflict3",true, "The Final Conflict - Natla fight 2", "Atlantis");
	  settings.SetToolTip("TheFinalConflict3", "Splits when the 2nd phase starts.");
	  settings.Add("TheFinalConflict4",true, "The Final Conflict - Ending", "Atlantis");
	  settings.SetToolTip("TheFinalConflict4", "Autosplits after getting the last endscreen.");
	
	settings.Add("Main4", false, "100%. Untick if you're running Any% No BJ. Autosplits whenever you pick up an artifact/relic or end a chapter");
	settings.SetToolTip("Main4", "Tick splitting at the end of each chapter/region if you feel like it's going to help you");
	
	  settings.Add("100%", false, "100%", "Main4");
	  settings.Add("Artifacts",false, "Autosplits when picking up artifacts and relics, regardless of level. Includes final split", "100%");
	  settings.SetToolTip("Artifacts", "Thought for 100% runs that load saves from different levels to prevent unwanted splits");
	  settings.Add("Chapter",false, "Autosplits when you complete a chapter/region (Peru/Greece/Egypt)", "100%");
	  settings.SetToolTip("Chapter", "Not needed but might help some runners");
	
	settings.Add("Main5", false, "By level. Autosplits whenever an endscreen shows up");
	settings.SetToolTip("Main5", "Splits after each level");
	
	  settings.Add("By Level", false, "By Level", "Main5");
	  settings.Add("Level",false, "Autosplits whenever you finish a level, ignoring level changes when loading a save", "By Level");
	  settings.SetToolTip("Level", "For those who want custom splits for any category");
	  
	settings.Add("Main6", false, "Alt + F4");
	settings.SetToolTip("Main6", "If you use Alt + F4 for endscreens check one of the following categories instead:");
	  
	  settings.Add("Glitchless (not allowed now, don't tick this)", false, "Glitchless (not allowed now, don't tick this)", "Main6");
	  settings.Add("CavesEndAltF4",false, "At the end of Caves.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("CavesEndAltF4", "Splits when you reach the stairs at the end of the level.");
	  settings.Add("VilcaEndAltF4",false, "At the end of Vilcabamba.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("VilcaEndAltF4", "Splits when you reach the Lost Valley's entrance.");
	  settings.Add("ValleyEndAltF4",false, "At the end of The Lost Valley.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("ValleyEndAltF4", "Splits when you enter Qualopec's Tomb.");
	  settings.Add("QualoEndAltF4",false, "At the end of Qualopec.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("QualoEndAltF4", "Splits once all the cutscenes after Qualopec end.");
	  settings.Add("SFFEndAltF4",false, "At the end of St. Francis Folly.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("SFFEndAltF4", "Splits once you use all four keys.");
	  settings.Add("ColiseumEndAltF4",false, "At the end of the Coliseum.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("ColiseumEndAltF4", "Splits once you reach the entrance of Midas' Palace.");
	  settings.Add("MidasEndAltF4",false, "At the end of Midas' Palace.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("MidasEndAltF4", "Splits once you use all three Gold Bars.");
	  settings.Add("TihocanEndAltF4",false, "At the end of Tihocan.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("TihocanEndAltF4", "Splits once all the cutscenes after Tihocan end.");
	  settings.Add("TempleEndAltF4",false, "At the end of Khamoon's Temple.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("TempleEndAltF4", "Splits once you enter the Obelisk room.");
	  settings.Add("ObeliskEndAltF4",false, "At the end of Khamoon's Obelisk.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("ObeliskEndAltF4", "Splits once all the items have been used.");
	  settings.Add("SanctuaryEndAltF4",false, "At the end of Sanctuary.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("SanctuaryEndAltF4", "Splits once all the cutscenes and QTE after Sanctuary end.");
	  settings.Add("MinesEndAltF4",false, "At the end of Mines.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("MinesEndAltF4", "Splits once the switch for the last door has been used.");
	  settings.Add("PyramidEndAltF4",false, "At the end of the Pyramid.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("PyramidEndAltF4", "Splits once the Torso boss fight starts.");
	  settings.Add("ConflictEndAltF4",false, "At the end of the Final Conflict.", "Glitchless (not allowed now, don't tick this)");
	  settings.SetToolTip("ConflictEndAltF4", "Splits once you've beaten the game.");
	  
	  settings.Add("NBJ", false, "NBJ", "Main6");
	  settings.Add("OtherNBJChecks",false, "Alternative for Alt+F4 NBJ runners at the end of Vilcabamba/Coliseum/Final Conflict", "NBJ");
	  settings.SetToolTip("OtherNBJChecks", "Remember to uncheck only the respective NBJ levels if you check this!");
	  
	  settings.Add("BTG", false, "BTG", "Main6");
	  settings.Add("BTGCaves",false, "At the end of Caves", "BTG");
	  settings.SetToolTip("BTGCaves", "Splits when you reach Vilcabamba's stairs, before the bear.");
	  settings.Add("BTGVilca",false, "At the end of Vilcabamba", "BTG");
	  settings.SetToolTip("BTGVilca", "Splits when you reach the entrance of The Lost Valley.");
	  settings.Add("BTGValley",false, "At the end of the Lost Valley", "BTG");
	  settings.SetToolTip("BTGValley", "Splits when you reach the entrance of Qualopec's Tomb.");
	  settings.Add("BTGQualopec",false, "At the end of Qualopec", "BTG");
	  settings.SetToolTip("BTGQualopec", "Splits once all the cutscenes after Qualopec end.");
	  settings.Add("BTGSFF",false, "At the end of SFF", "BTG");
	  settings.SetToolTip("BTGSFF", "Splits once you get past SFF's gate.");
	  settings.Add("BTGColiseum",false, "At the end of The Coliseum", "BTG");
	  settings.SetToolTip("BTGColiseum", "Splits once you get to Midas' Palace entrance.");
	  settings.Add("BTGMidas",false, "At the entrance of Tihocan's Tomb", "BTG");
	  settings.SetToolTip("BTGMidas", "Splits once you get to the small box room.");
	  settings.Add("BTGTihocan",false, "At the end of Tihocan", "BTG");
	  settings.SetToolTip("BTGTihocan", "Splits once all the cutscenes after Tihocan end.");
	  settings.Add("BTGTemple",false, "At the Sanctuary's entrance", "BTG");
	  settings.SetToolTip("BTGTemple", "Splits once you enter the Sanctuary, past the big doors.");
	  settings.Add("BTGSanctuary",false, "At the end of Sanctuary", "BTG");
	  settings.SetToolTip("BTGSanctuary", "Splits once all the cutscenes and QTE after Sanctuary end.");
	  settings.Add("BTGMines",false, "At the end of Mines", "BTG");
	  settings.SetToolTip("BTGMines", "Splits once the switch for the last door has been used.");
	  settings.Add("BTGPyramid",false, "At the start of the Final Conflict", "BTG");
	  settings.SetToolTip("BTGPyramid", "Splits once the Torso boss fight starts.");
	  settings.Add("BTGConflict",false, "At the end of the Final Conflict", "BTG");
	  settings.SetToolTip("BTGConflict", "Splits once the game has been beaten.");
}
