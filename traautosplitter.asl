// TRA Auto Splitter Script v2.0 by NextLevelMemes, using apel's v.1 as base.
// This was thought as an Autosplitter for Any% no Bug Jump, Single Segment runs. It might not work well/as desired for other categories. 
// Known issues:
//     -Splits are based on specific routes/paths. They're consistent, but your placement of Lara might or might not trigger some checkpoints that 
//      refresh the area label, or you might use a different route that causes different values for other variables and accidentally cause an autosplit. 
//      So keep this in mind. 
//     -DON'T tick autoreset for lava-based deaths if you're unsure/lazy about testing it first. It might end up causing unwanted autoresets in Atlantis,
//      and I won't be held responsible for it. Also, I could not create an autoreset for every single lava death, it's too unreliable to make.
//     -If you restart during the Centaurs boss fight without having done any damage to them, the Centaur split might not work at all. This is because their last HP
//      value is stored until your next boss fight, and it will prevent said autosplit from happenning. To solve this, load any other boss fight
//      (wait for 1 second after the HP bar is shown). Then you can redo the fight again and it will autosplit correctly.
//     -If you select all reset options but have a "strange death" like getting hit by Qualopec's boulder or getting trapped + killed at the same slope,
//      the timer will not autoreset. This is because these deaths are not HP dependant and finding reliable variables for those is actually hard.
//     -Autoresets that depend on Lara falling somewhere have a chance of not working at times: this is because the game did not refresh the Z coordinate in time.
//     -LiveSplit version 1.7.7. is known to literally stop splitting (due to a bug) and even to skip splits it doesn't "like" the way they're written.
//      In this case, the IGT resets won't work at all no matter how they're written. Feel free to try them on earlier versions or wait for version 1.7.8.

state("tra")
{
    int level : 0x495404, 0xC; 
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
    float BossHP : 0x245EC, 0x578; 
    float BossRage : 0x55234, 0x18; 
    uint IGTStoryModePlusIL1 : 0x48F378, 0x40; 
}

init
{
    print("TRA found");
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
    if((current.level == 0||current.level == 1) && current.IGTStoryModePlusIL1 == 0 && old.zCoord == 0 && current.zCoord >0 && current.xCoord == 0 && current.yCoord <= 0)  
       return true;
}

//A new, reliable start function that is not messy and allows you to reset your timer, then load your "0" save from anywhere in the game and it'll autostart again
//without having to go back to the menu/create a new profile every time.

split
{
//Peru:
    if(current.AreaLabel == 2 && old.AreaLabel == 1 && current.level == 1 && current.RegionID == 1 && settings["MountainCaves1"])
       return true;
    if(current.AreaLabel == 7 && old.AreaLabel == 6 && current.level == 1 && current.RegionID == 1 && settings["MountainCaves2"])
       return true;
    if(current.AreaLabel == 8 && old.AreaLabel == 7 && current.RegionID == 1 && settings["VilcabambaWarp"])
       return true;
    if(current.AreaLabel == 23 && current.level == 2 && old.level == 1 && current.RegionID == 1 && settings["TheLostValley"])
       return true; 
    if(current.AreaLabel == 16 && old.AreaLabel == 11 && current.RegionID == 1 && settings["TombOfQualopec1"])
       return true;
    if(current.AreaLabel == 17 && old.AreaLabel == 18 && current.level == 3 && current.RegionID == 1 && settings["TombOfQualopec2"])
       return true; //THIS ONE DOES NOT AUTOSPLIT IF YOU GET INTO QUALOPEC'S THRONE ROOM WHILE AIRWALK/OOB.

//Greece:
    if(current.AreaLabel == 1 && old.AreaLabel != 1 && current.RegionID == 2 && settings["StFrancisFolly1"])
       return true;
    if(current.AreaLabel == 3 && old.AreaLabel == 2 && current.level == 4 && current.RegionID == 2 && settings["StFrancisFolly2"])
       return true;
    if(current.AreaLabel == 31 && old.AreaLabel == 3 && current.level == 4 && current.RegionID == 2 && settings["TheColiseum"])
       return true;
    if(current.AreaLabel == 18 && current.level == 5 && old.level == 4 && current.RegionID == 2 && settings["MidasPalace"])
       return true;
    if(current.AreaLabel == 27 && current.zCoord >= 0 && old.zCoord < 0 && current.level == 5 && current.RegionID == 2 && settings["TombOfTihocan1"])
       return true;
    if(current.RegionID == 2 && current.AreaLabel >=29 && old.BossHP != 40000 && current.BossHP == 40000 && current.zCoord >= 432 && settings["TombOfTihocan2"])
       return true;
    
//Egypt:
    if(current.RegionID == 3 && old.RegionID != 3 && current.level == 6 && settings["TempleOfKhamoon"])
       return true;
    if(current.AreaLabel == 20 && old.AreaLabel != 20 && current.level == 6 && current.RegionID == 3 && settings["SanctuaryOfTheScion1"])
       return true;
    if(current.AreaLabel == 22 && old.AreaLabel != 22 && current.level == 6 && current.RegionID == 3 && settings["SanctuaryOfTheScion2"])
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
    if(current.AreaLabel == 19 && current.RegionID == 4 && current.BossRage == 0 && current.BossHP == 5600 && old.BossHP != 5600 && settings["TheFinalConflict2"])
       return true;
    if(current.AreaLabel == 19 && current.BossHP == 3200 && old.BossHP > 3200 && current.BossRage >= 0 && current.RegionID == 4 && settings["TheFinalConflict3"])
       return true; 
    if(current.AreaLabel == 19 && current.level > old.level && current.RegionID == 4 && current.xCoord > -50 && current.yCoord > 150 && current.zCoord < -500 && settings["TheFinalConflict4"])
       return true;
}

reset
{
   if(current.HP <= 0 && old.HP > 0 && settings["HPDeath"])
      return true;
   if(settings["VoidDeath"] && ((current.level == 1 && current.AreaLabel == 1 && current.RegionID == 1 && current.zCoord < -1000 && old.zCoord > -1000)||(current.AreaLabel == 21 && current.RegionID == 1 && current.zCoord < -2000 && old.zCoord >= -2000)||(current.RegionID == 3 && current.AreaLabel == 16 && current.zCoord <= -4700 && old.zCoord > -4700)||(current.AreaLabel == 16 && current.RegionID == 3 && current.xCoord > 3000 && current.yCoord > -650 && current.zCoord <= -300 && old.zCoord > -300)||(current.AreaLabel == 16 && current.RegionID == 2 && current.zCoord <= -750 && old.zCoord > -750)||(current.AreaLabel == 21 && current.RegionID == 3 && current.zCoord <= -650 && old.zCoord > -600)))
      return true;
   if(current.RegionID == 4 && settings["LavaDeath"] && ((current.AreaLabel == 5 && current.zCoord < -1800 && old.zCoord >= -1800)||(current.AreaLabel == 17 && current.zCoord < -5000 && old.zCoord >= -5000)||(current.AreaLabel == 18  && current.zCoord < -200 && current.LavaDeath2 == 1 && old.LavaDeath2 == 0)||(current.AreaLabel == 6 && current.zCoord < -1000 && old.zCoord >= -1000)||(current.AreaLabel == 7 && current.yCoord > 1000 && current.xCoord < -1500 && current.zCoord < -3800 && old.zCoord >= -3800)||(current.AreaLabel == 19 && current.zCoord < -4500 && old.zCoord >= -4500)||(current.RegionID == 4 && current.AreaLabel == 13 && current.zCoord <= -150 && old.zCoord > -150)))
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
{       
        settings.Add("Main", false, "Autoresets when:");
	settings.SetToolTip("Main", "Tick an option to autoreset the timer when that condition is satisfied.");
	
	  settings.Add("HPDeath",false, "Lara's HP = 0", "Main");
	  settings.SetToolTip("HPDeath", "Only autoresets if Lara's HP is 0 upon dying.");
	  settings.Add("VoidDeath",false, "Lara dies upon falling into the void/a pit (beta)", "Main");
	  settings.SetToolTip("VoidDeath", "Autoresets at bottomless pits.");
	  settings.Add("LavaDeath",false, "Lara makes contact with lava (experimental, TEST BEFORE ENABLING IT!)", "Main");
	  settings.SetToolTip("LavaDeath", "TEST THIS BEFORE TRYING IT, MIGHT CAUSE UNWANTED RESETS.");
	  settings.Add("30m",false, "After 30 minutes in-game time (race)", "Main");
	  settings.SetToolTip("30m", "Just for challenges/competitions/races.");
	  settings.Add("45m",false, "After 45 minutes in-game time (race)", "Main");
	  settings.SetToolTip("45m", "Just for challenges/competitions/races.");
	  settings.Add("60m",false, "After 1 hour in-game time (race)", "Main");
	  settings.SetToolTip("60m", "Just for challenges/competitions/races.");
	  settings.Add("90m",false, "After 1 hour and 30 mins. in-game time (race)", "Main");
	  settings.SetToolTip("90m", "Just for challenges/competitions/races.");
	  settings.Add("120m",false, "After 2 hours in-game time (race)", "Main");
	  settings.SetToolTip("120m", "Just for challenges/competitions/races.");
	  settings.Add("180m",false, "After 3 hours in-game time (race)", "Main");
	  settings.SetToolTip("180m", "Just for challenges/competitions/races.");
	
	settings.Add("Main2", true, "Autosplits at:");
	settings.SetToolTip("Main2", "Untick the splits you don't feel necessary.");
	
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
}
