// TRA Auto Splitter Script v3.0 by NextLevelMemes, using apel's v.1 as base. 
// Known issues:
//     -Splits are based on specific routes/paths. They're consistent, but your placement of Lara might or might not trigger some checkpoints that refresh the area label, or you might use a different route that causes different values for other variables and accidentally cause an autosplit. So keep this in mind. 
//     -DON'T tick autoreset for lava-based deaths if you're unsure/lazy about testing it first. It might end up causing unwanted autoresets in Atlantis, and I won't be held responsible for it. Also, I could not create an autoreset for every single lava death, it's too unreliable to make.
//     -If you restart during the Centaurs boss fight without having done any damage to them, the Centaur split might not work at all. This is because their last HP value is stored until your next boss fight, and it will prevent said autosplit from happenning. To solve this, load any other boss fight (wait for 1 second after the HP bar is shown). Then you can redo the fight again and it will autosplit correctly.
//     -If you select all reset options but have a "strange death" like getting hit by Qualopec's boulder or getting trapped + killed at the same slope, the timer will not autoreset. This is because these deaths are not HP dependant and finding reliable variables for those is actually hard.
//     -Autoresets that depend on Lara falling somewhere have a chance of not working at times: this is because the game did not refresh the Z coordinate in time.
//     -The autosplit for The Lost Valley (after triggering Vilcabamba's endscreen) can cause Lara to stop rolling/airwalking. To prevent this leave crouch/direction keys unpressed for a moment, quickly pressing them again before Lara stops the roll.
//     -The autostart function might work weirdly if starting a new profile. To prevent this, save in Caves with an IGT of 0 or download the save from speedrun.com (resources section).

state("tra")
{
	float RegionID : 0x49BF74, 0xC, 0x104, 0x6DB, 0x389; 
	byte AreaLabel : 0x1D06EA, 0x7E; 
	uint AreaLabel2 : 0x1D3DB4, 0x50; 
	float HP : 0x861EB8, 0x1C; 
	float IGT : 0x861E3C, 0x3F8; 
    bool isTitle : 0x4645C0; 
    bool isLoading : 0x412C64;
    bool isPaused : 0x4B68F0;
	float xCoord : 0x467AC, 0x14; 
	float yCoord : 0x467AC, 0x10; 
	float zCoord : 0x467AC, 0x18;  
	uint LavaDeath2 : 0x122C94, 0x308; 
	float BossHP : 0x55234, 0x28; 
	float BossRage : 0x55234, 0x18; 
	byte SumArtifactsRelics : 0x4923C4, 0x44; 
	uint IsMenu : 0xF7464, 0x20; 
	byte IsCutscene : 0x1D3ED9, 0x3;
	float levelcount : 0x553A8, 0x80;
	float SMedPack : 0x28B5, 0xB8;
	float MedPack : 0x28B5, 0xC0;
	byte DontCheat1 : 0x2625F4, 0x394;
	byte DontCheat2 : 0x8F0F7, 0xD; 
	byte DontCheat3 : 0x8F67A, 0x2; 
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
    if((current.levelcount == 0||current.levelcount == 1) && current.IGT == 0 && old.zCoord == 0 && current.zCoord >0 && current.xCoord == 0 && current.yCoord <= 0)                              
		return true;
}

split
{
//Peru:
    if(current.AreaLabel == 2 && old.AreaLabel == 1 && current.RegionID == 1 && settings["MountainCaves1"])
       return true;
	if(current.AreaLabel == 7 && old.AreaLabel == 6 && current.RegionID == 1 && settings["MountainCaves2"])
       return true;
    if(current.AreaLabel == 8 && old.AreaLabel == 7 && current.RegionID == 1 && settings["VilcabambaWarp"])
	   return true;
	if(current.AreaLabel == 23 && current.levelcount > old.levelcount && current.RegionID == 1 && settings["TheLostValley"])
       return true; 
	if(current.AreaLabel == 16 && old.AreaLabel == 11 && current.RegionID == 1 && settings["TombOfQualopec1"])
       return true;
	if(current.AreaLabel == 17 && old.AreaLabel == 18 && current.RegionID == 1 && settings["TombOfQualopec2"])
       return true;

//Greece:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 2 && settings["StFrancisFolly1"])
       return true;
    if(current.AreaLabel == 3 && old.AreaLabel == 2 && current.RegionID == 2 && settings["StFrancisFolly2"])
       return true;
	if(current.AreaLabel == 31 && old.AreaLabel == 3 && current.RegionID == 2 && settings["TheColiseum"])
       return true;
    if(current.AreaLabel == 18 && current.levelcount > old.levelcount && current.RegionID == 2 && settings["MidasPalace"])
       return true;
	if(current.AreaLabel == 27 && current.zCoord >= 0 && old.zCoord < 0 && current.RegionID == 2 && settings["TombOfTihocan1"])
       return true;
	if(current.RegionID == 2 && current.BossHP == 40000 && old.IsCutscene == 1 && current.IsCutscene == 0 && settings["TombOfTihocan2"])
       return true;
	   
//Egypt:
    if(current.RegionID == 3 && old.RegionID != 3 && settings["TempleOfKhamoon"])
       return true;
	if(current.AreaLabel == 20 && old.AreaLabel != 20 && current.RegionID == 3 && settings["SanctuaryOfTheScion1"])
       return true;
    if(current.AreaLabel == 22 && old.AreaLabel != 22 && current.RegionID == 3 && settings["SanctuaryOfTheScion2"])
       return true;
	   
//Atlantis:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 4 && settings["NatlasMines1"])
       return true;
	if(current.AreaLabel == 5 && old.AreaLabel == 2 && current.RegionID == 4 && settings["NatlasMines2"])
       return true;
    if(current.AreaLabel == 11 && old.AreaLabel == 10 && current.RegionID == 4 && settings["TheGreatPyramid1"])
       return true;  
	if(current.AreaLabel == 14 && old.AreaLabel == 13 && current.RegionID == 4 && settings["TheGreatPyramid2"])
       return true;
	if(current.AreaLabel == 17 && old.AreaLabel == 16 && current.RegionID == 4 && settings["TheFinalConflict1"])
       return true;
	if(current.AreaLabel == 19 && current.RegionID == 4 && current.BossHP == 5600 && old.BossHP != 5600 && settings["TheFinalConflict2"])
       return true;
	if(current.AreaLabel == 19 && current.BossHP == 3200 && current.RegionID == 4 && old.IsCutscene == 1 && current.IsCutscene == 0 && settings["TheFinalConflict3"])
       return true;
	if(current.AreaLabel == 19 && current.levelcount > old.levelcount && current.RegionID == 4 && settings["TheFinalConflict4"])
       return true;
	
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
   if(((current.IGT < old.IGT)||(current.HP > old.HP && current.SMedPack == old.SMedPack && current.MedPack == old.MedPack)||((current.zCoord > (50 + old.zCoord)) && current.IGT == old.IGT && current.DontCheat1 == 1 && ((current.DontCheat2 == 0)||(current.DontCheat3 == 1)))) && settings["Cheats"])
   return true;
   if(current.HP <= 0 && old.HP > 0 && settings["HPDeath"])
   return true;
   if(settings["VoidDeath"] && ((current.level == 1 && current.AreaLabel == 1 && current.RegionID == 1 && current.zCoord < -1000 && old.zCoord > -1000)||(current.AreaLabel == 21 && current.RegionID == 1 && current.zCoord < -2000 && old.zCoord >= -2000)||(current.RegionID == 3 && current.AreaLabel == 16 && current.zCoord <= -4700 && old.zCoord > -4700)||(current.AreaLabel == 16 && current.RegionID == 3 && current.xCoord > 3000 && current.yCoord > -650 && current.zCoord <= -300 && old.zCoord > -300)||(current.AreaLabel == 16 && current.RegionID == 2 && current.zCoord <= -750 && old.zCoord > -750)||(current.AreaLabel == 21 && current.RegionID == 3 && current.zCoord <= -650 && old.zCoord > -600)))
   return true;
   if(current.RegionID == 4 && settings["LavaDeath"] && ((current.AreaLabel == 5 && current.zCoord < -1800 && old.zCoord >= -1800)||(current.AreaLabel == 17 && current.zCoord < -5000 && old.zCoord >= -5000)||(current.AreaLabel == 18  && current.zCoord < -200 && current.LavaDeath2 == 1 && old.LavaDeath2 == 0)||(current.AreaLabel == 6 && current.zCoord < -1000 && old.zCoord >= -1000)||(current.AreaLabel == 7 && current.yCoord > 1000 && current.xCoord < -1500 && current.zCoord < -3800 && old.zCoord >= -3800)||(current.AreaLabel == 19 && current.zCoord < -4500 && old.zCoord >= -4500)||(current.RegionID == 4 && current.AreaLabel == 13 && current.zCoord <= -150 && old.zCoord > -150)))
   return true;
   if(old.IGT == 59 && current.IGT == 60 && settings["1m"])
   return true;
   if(old.IGT == 119 && current.IGT == 120 && settings["2m"])
   return true;
   if(old.IGT == 179 && current.IGT == 180 && settings["3m"])
   return true;
   if(old.IGT == 239 && current.IGT == 240 && settings["4m"])
   return true;
   if(old.IGT == 299 && current.IGT == 300 && settings["5m"])
   return true;
   if(old.IGT == 599 && current.IGT == 600 && settings["10m"])
   return true;
   if(old.IGT == 899 && current.IGT == 900 && settings["15m"])
   return true;
   if(old.IGT == 1799 && current.IGT == 1800 && settings["30m"])
   return true;
   if(old.IGT == 2699 && current.IGT == 2700 && settings["45m"])
   return true;
   if(old.IGT == 3599 && current.IGT == 3600 && settings["60m"])
   return true;
   if(old.IGT == 5399 && current.IGT == 5400 && settings["90m"])
   return true;
   if(old.IGT == 7199 && current.IGT == 7200 && settings["120m"])
   return true;
   if(old.IGT == 10799 && current.IGT == 10800 && settings["180m"])
   return true;
}

isLoading
{
    return current.isLoading;
}

startup
{   settings.Add("Main", false, "Autoresets when:");
	settings.SetToolTip("Main", "Tick an option to autoreset the timer when that condition is satisfied.");
	
	  settings.Add("Cheats",false, "Uncheated Engine (beta)", "Main");
	  settings.SetToolTip("Cheats", "Prevents some forms of hacking/cheating during runs.");
	  settings.Add("HPDeath",false, "Lara's HP = 0", "Main");
	  settings.SetToolTip("HPDeath", "Only autoresets if Lara's HP is 0 upon dying.");
	  settings.Add("VoidDeath",false, "Lara dies upon falling into the void/a pit (beta)", "Main");
	  settings.SetToolTip("VoidDeath", "Autoresets at bottomless pits.");
	  settings.Add("LavaDeath",false, "Lara makes contact with lava (experimental, TEST BEFORE ENABLING IT!)", "Main");
	  settings.SetToolTip("LavaDeath", "TEST THIS BEFORE TRYING IT, MIGHT CAUSE UNWANTED RESETS.");
	  settings.Add("1m",false, "After 1 minute in-game time", "Main");
	  settings.SetToolTip("1m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("2m",false, "After 2 minutes in-game time", "Main");
	  settings.SetToolTip("2m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("3m",false, "After 3 minutes in-game time", "Main");
	  settings.SetToolTip("3m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("4m",false, "After 4 minutes in-game time", "Main");
	  settings.SetToolTip("4m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("5m",false, "After 5 minutes in-game time", "Main");
	  settings.SetToolTip("5m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("10m",false, "After 10 minutes in-game time", "Main");
	  settings.SetToolTip("10m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("15m",false, "After 15 minutes in-game time", "Main");
	  settings.SetToolTip("15m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("30m",false, "After 30 minutes in-game time", "Main");
	  settings.SetToolTip("30m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("45m",false, "After 45 minutes in-game time", "Main");
	  settings.SetToolTip("45m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("60m",false, "After 1 hour in-game time", "Main");
	  settings.SetToolTip("60m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("90m",false, "After 1 hour and 30 mins. in-game time", "Main");
	  settings.SetToolTip("90m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("120m",false, "After 2 hours in-game time", "Main");
	  settings.SetToolTip("120m", "Use it to improve your time while practicing runs or to race with friends.");
	  settings.Add("180m",false, "After 3 hours in-game time", "Main");
	  settings.SetToolTip("180m", "Use it to improve your time while practicing runs or to race with friends.");
	
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
