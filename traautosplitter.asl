// TRA Auto Splitter Script v4.0 by NextLevelMemes, using apel's v.1 as base. Special thanks to Cadarev for figuring out how to prevent the same autosplit from happening twice, and to Taeruhs and BryNu for helping me to further test it.
// Known issues:
//     -NBJ splits are based on specific routes/paths. If you're using different shortcuts, remember to untick the splits in the layout settings. 
//     -The autosplit for The Lost Valley (after triggering Vilcabamba's endscreen) can cause Lara to stop rolling/airwalking. To prevent this leave crouch/direction keys unpressed for a moment, quickly pressing them again before Lara stops rolling.

state("tra")
{
	float RegionID : 0x49BF74, 0xC, 0x104, 0x6DB, 0x389; 
	byte AreaLabel : 0x1D06EA, 0x7E; 
	float HP : 0x861EB8, 0x1C; 
	float IGT : 0x861E3C, 0x3F8;
	uint IGTStoryPlusIL : 0x48F370, 0x2C;
    uint IGTStoryOnly : 0x4923C4, 0x1A4;
    bool isTitle : 0x4645C0; 
    bool isLoading : 0x412C64;
    bool isPaused : 0x4B68F0;
	float zCoord : 0x467AC, 0x18;  
	float BossHP : 0x55234, 0x28; 
	byte SumArtifactsRelics : 0x4923C4, 0x44; 
	uint IsMenu : 0xF7464, 0x20; 
	byte IsCutscene : 0x1D3ED9, 0x3;
	float levelcount : 0x553A8, 0x80;
	float SMedPack : 0x28B5, 0xB8;
	float MedPack : 0x28B5, 0xC0;
	byte DontCheat1 : 0x2625F4, 0x394;
	byte DontCheat2 : 0x8F0F7, 0xD; 
	byte DontCheat3 : 0x8F67A, 0x2; 
	byte IsDeath : 0x25B94, 0x407; 
	byte IsDeath2 : 0x85D24, 0x3;
	byte MidasDeath : 0x1B21F8, 0x3;
	string8 SaveTime : 0x465CB0, 0x40, 0x950, 0x230; 
}

init
{
    print("Checking your bank account...please standby");
	print("Money transfer successful. Thank you sucker!");
    refreshRate = 30;
    vars.isFirstLoad = true;
    vars.isNewGame = false;
}

update
{
    if(current.isTitle) 
    {
        vars.isFirstLoad = false;
        vars.isNewGame = true;
    }
    if(current.isPaused) 
    {
        vars.isNewGame = true;
    }
}

start
{
    if((current.RegionID == 0||current.RegionID == 1) && current.IGTStoryPlusIL == 0 && current.AreaLabel == 1 && current.IsCutscene == 0 && (current.zCoord >= 367 && current.zCoord < 378) && current.IsMenu == 0)                              
	{
		vars.LaraWasHere.Clear();
		return true;
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
	if(current.AreaLabel == 23 && current.levelcount > old.levelcount && current.RegionID == 1 && !vars.LaraWasHere.Contains("TheLostValley") && settings["TheLostValley"])
    {
		vars.LaraWasHere.Add("TheLostValley");
		return true;
	}  
	if(current.AreaLabel == 16 && old.AreaLabel == 11 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TombOfQualopec1") && settings["TombOfQualopec1"])
    {
		vars.LaraWasHere.Add("TombOfQualopec1");
		return true;
	}  
	if(current.AreaLabel == 17 && old.AreaLabel == 18 && current.RegionID == 1 && !vars.LaraWasHere.Contains("TombOfQualopec2") && settings["TombOfQualopec2"])
    {
		vars.LaraWasHere.Add("TombOfQualopec2");
		return true;
	}  

//Greece:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 2 && !vars.LaraWasHere.Contains("StFrancisFolly1") && settings["StFrancisFolly1"])
    {
		vars.LaraWasHere.Add("StFrancisFolly11");
		return true;
	}   
    if(current.AreaLabel == 3 && old.AreaLabel == 2 && current.RegionID == 2 && !vars.LaraWasHere.Contains("StFrancisFolly2") && settings["StFrancisFolly2"])
    {
		vars.LaraWasHere.Add("StFrancisFolly12");
		return true;
	}  
	if(current.AreaLabel == 31 && old.AreaLabel == 3 && current.RegionID == 2 && !vars.LaraWasHere.Contains("TheColiseum") && settings["TheColiseum"])
    {
		vars.LaraWasHere.Add("TheColiseum");
		return true;
	} 
    if(current.AreaLabel == 18 && current.levelcount > old.levelcount && current.RegionID == 2 && !vars.LaraWasHere.Contains("MidasPalace") && settings["MidasPalace"])
    {
		vars.LaraWasHere.Add("MidasPalace");
		return true;
	} 
	if(current.AreaLabel == 27 && current.zCoord >= 0 && old.zCoord < 0 && current.RegionID == 2 && !vars.LaraWasHere.Contains("TombOfTihocan1") && settings["TombOfTihocan1"])
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
	if(current.AreaLabel == 20 && old.AreaLabel != 20 && current.RegionID == 3 && !vars.LaraWasHere.Contains("SanctuaryOfTheScion1") && settings["SanctuaryOfTheScion1"])
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
	if(current.AreaLabel == 19 && current.levelcount > old.levelcount && current.RegionID == 4 && !vars.LaraWasHere.Contains("TheFinalConflict4") && settings["TheFinalConflict4"])
    {
		vars.LaraWasHere.Add("TheFinalConflict4");
		return true;
	} 
	
//100%:
	if((settings["Artifacts"] && (current.SumArtifactsRelics > old.SumArtifactsRelics))||(settings["Chapter"] && (current.RegionID > old.RegionID)))
	   return true;
	if(current.levelcount > old.levelcount && current.AreaLabel >= 19 && current.RegionID >= 4 && (settings["Artifacts"]||settings["Chapter"]))
       return true;	
	   
//By Level:
    if(settings["Level"] && current.levelcount > old.levelcount)
	   return true;	  
	     
}

reset
{
   if((((current.IGT < old.IGT)||(current.IGTStoryPlusIL < old.IGTStoryPlusIL))||(current.HP > old.HP && current.SMedPack == old.SMedPack && current.MedPack == old.MedPack)||((current.zCoord > (50 + old.zCoord)) && ((current.IGT == old.IGT)||(current.IGTStoryPlusIL == old.IGTStoryPlusIL)) && current.DontCheat1 == 1 && ((current.DontCheat2 == 0)||(current.DontCheat3 == 1)))) && settings["Cheats"])
   return true;
   if(current.SaveTime == "00:00:00" && ((current.IsMenu == 3 && old.IsMenu == 2)||(current.IsMenu == 4 && old.IsMenu == 3)) && settings["Load"])
   return true;
   if(settings["Death"] && ((current.IsDeath == 5 && old.IsDeath != 5 && !current.IsLoading)||((current.IsDeath2 >=67 && old.IsDeath < 67)||(current.MidasDeath == 67 && old.MidasDeath != 67 && current.AreaLabel == 18 && current.RegionID == 2))))
   return true;
}

isLoading
{
    return current.isLoading;
}

startup
{   
	vars.LaraWasHere = new List<string>();
	
    settings.Add("Main", true, "Autoresets when:");
	settings.SetToolTip("Main", "Tick an option to autoreset the timer when that condition is satisfied.");
	
	  settings.Add("Cheats",false, "Uncheated Engine (beta)", "Main");
	  settings.SetToolTip("Cheats", "Prevents some forms of hacking/cheating during runs. Thought for live verifications.");
	  settings.Add("Death", false, "Lara dies", "Main");
	  settings.SetToolTip("Death", "A bit slower for QTEs and scripted deaths, but works regardless.");
	  settings.Add("Load", true, "Loading your 00:00:00 file", "Main");
	  settings.SetToolTip("Load", "Resets when loading a file in Caves with an IGT of 0.");
	
	settings.Add("Main2", true, "Any% No Bug Jump. Untick if you're running 100%. Autosplits at:");
	settings.SetToolTip("Main2", "Untick the option as a whole, custom splits won't work yet");
	
	  settings.Add("Peru", true, "Peru", "Main2");
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
	  settings.SetToolTip("TombOfQualopec2", "Splits after Qualopec's cutscene.");
	
	  settings.Add("Greece", true, "Greece", "Main2");
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
	
	  settings.Add("Egypt", true, "Egypt", "Main2");
	  settings.Add("TempleOfKhamoon",true, "Temple Of Khamoon", "Egypt");
	  settings.SetToolTip("TempleOfKhamoon", "Splits as soon as you start the level.");
	  settings.Add("SanctuaryOfTheScion1",true, "Sanctuary Of The Scion - Entrance", "Egypt");
	  settings.SetToolTip("SanctuaryOfTheScion1", "Splits upon entering the level.");
	  settings.Add("SanctuaryOfTheScion2",true, "Sanctuary Of The Scion - First Half", "Egypt");
	  settings.SetToolTip("SanctuaryOfTheScion2", "Splits upon entering the Sphinx's room.");
	
	  settings.Add("Atlantis", true, "Atlantis", "Main2");
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
	  settings.SetToolTip("TheFinalConflict4", "Autosplits after skipping the last cutscene.");
	
	settings.Add("Main3", false, "100%. Untick if you're running Any% No BJ. Autosplits whenever you pick up an artifact/relic or end a chapter");
	settings.SetToolTip("Main3", "Tick splitting at the end of each chapter/region if you feel like it's going to help you");
	
	  settings.Add("100", false, "100", "Main3");
	  settings.Add("Artifacts",false, "Autosplits when picking up artifacts and relics", "100");
	  settings.SetToolTip("Artifacts", "No reason not to tick this if running 100%");
	  settings.Add("Chapter",false, "Autosplits when you complete a chapter/region", "100");
	  settings.SetToolTip("Chapter", "Not needed but might help some runners");
	
	settings.Add("Main4", false, "By level. Autosplits whenever an endscreen shows up");
	settings.SetToolTip("Main4", "Splits after each level");
	
	  settings.Add("By level", false, "By level", "Main4");
	  settings.Add("Level",false, "Autosplits whenever you finish a level", "By level");
	  settings.SetToolTip("Level", "For those who want custom splits for any category");
}
