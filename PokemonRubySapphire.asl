//Autosplitter by NLM aka NextLevelMemes for Pokemon Ruby and Sapphire. Huge thanks to LoveSickHero for his rigorous testing and for finding the second constant, as well as to Snairam for his thorough testing.
//Thanks to Ero, Square, buurazu and 2838 for giving me advice on how to properly sigscan, and again to buurazu for his sigscan function which I used for this script.

state("mGBA")
{
}

init
{
	vars.Countdown = 1;
	vars.Trainer = "Unknown";
	vars.IsDefeated = false;
	print("Warning: savestates detected. Flagging times as suspicious for verifiers");
}

update
{	
	HashSet<short> MusicValues = new HashSet<short> { 459, 460, 461, 464, 465, 466 };
	HashSet<byte> FanfareValues = new HashSet<byte> { 49, 50, 66, 67, 71, 88, 89, 235, 236 };
	
	if(vars.startup == 0)
	{
	vars.search = (Action<SigScanTarget, string>) ((theTarget, name) => {
		foreach (var page in memory.MemoryPages())
		{
			var bytes = memory.ReadBytes(page.BaseAddress, (int)page.RegionSize);
			if (bytes == null)
				continue;
			
			var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
			vars.addr = scanner.Scan(theTarget); 

			if (vars.addr != IntPtr.Zero)
			{
				print(name + " found at 0x" + vars.addr.ToString("X"));
				break;
			}
		}
	});
	
	SigScanTarget target;
	
	target = new SigScanTarget(0, "00 21 ?? ?? ?? ?? ?? ?? 40 00 ?? ?? ?? 01 ?? 01");
	vars.search(target,"Trumpets");
	{
	if(vars.addr == IntPtr.Zero)
	{
	target = new SigScanTarget(7, "90 00 00 00 00 00 00 00 00 01 01");
	vars.search(target,"Water");
	}
	}
	
	vars.Music = new MemoryWatcher<short>(vars.addr + 0x275);
	vars.MusicStartEnd = new MemoryWatcher<byte>(vars.addr - 0x3F704);
	vars.Fanfare = new MemoryWatcher<byte>(vars.addr + 0x6F52);
	vars.Sprite1 = new MemoryWatcher<byte>(vars.addr - 0x153);
	vars.Sprite2 = new MemoryWatcher<byte>(vars.addr - 0x151);
	vars.OppSpecies = new MemoryWatcher<short>(vars.addr - 0x1B987);
	vars.OppHP = new MemoryWatcher<short>(vars.addr - 0x1B95F);
	vars.OppLevel = new MemoryWatcher<byte>(vars.addr - 0x1B95D);
	
	vars.startup = 1;
	}
	
	vars.Music.Update(game);
	{
	}
	
	vars.MusicStartEnd.Update(game);
    {
    }

	vars.Sprite1.Update(game);
    {
	}
	
	vars.Sprite2.Update(game);
    {
	}
	
	vars.OppSpecies.Update(game);
    {
	}
	
	vars.Fanfare.Update(game);
    {
	}
	
	vars.OppHP.Update(game);
    {
	}
	
	vars.OppLevel.Update(game);
    {
	}
	
	//Trainer checks:
	if(vars.Music.Current == 459 && ((vars.Sprite1.Old == 17 && (vars.Sprite1.Current == 255||vars.Sprite1.Current == 240))||(vars.Sprite2.Current == 17 && (vars.Sprite2.Current == 255||vars.Sprite2.Current == 240))))
	{
	vars.Trainer = "Wally";
	}
	
	if(vars.Trainer == "Wally" && vars.OppSpecies.Current == 392 && vars.Music.Current == 459 && vars.OppHP.Current == 0)
	{
	vars.Trainer = "Wally 1";
	}
	
	if(vars.Trainer == "Wally" && vars.OppSpecies.Current == 394 && vars.Music.Current == 459 && vars.OppHP.Current == 0)
	{
	vars.Trainer = "Wally 2";
	}
	
	if(((vars.Trainer == "Wally 1" && settings["WhoAgain1"])||(vars.Trainer == "Wally 2" && settings["WhoAgain2"])) && vars.Music.Current == 459 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 458 && (((vars.Sprite1.Current == 51||vars.Sprite1.Current == 52||vars.Sprite1.Current == 67||vars.Sprite1.Current == 68) && vars.Sprite1.Old != vars.Sprite1.Current)||((vars.Sprite2.Current == 51||vars.Sprite1.Current == 52||vars.Sprite2.Current == 67||vars.Sprite2.Current == 68) && vars.Sprite1.Old != vars.Sprite1.Current)))
	{
	vars.Trainer = "Admin";
	}
	
	if(vars.Trainer == "Admin" && vars.OppLevel.Current == 20)
	{
	vars.Trainer = "Admin 1";
	}
	
	if(vars.Trainer == "Admin" && vars.OppLevel.Current == 32)
	{
	vars.Trainer = "Admin 2";
	}
	
	if(vars.Trainer == "Admin" && vars.OppLevel.Current == 28)
	{
	vars.Trainer = "Admin 3";
	}
	
	if(vars.Trainer == "Admin" && vars.OppLevel.Current == 38)
	{
	vars.Trainer = "Admin 4";
	}
	
	if(((vars.Trainer == "Admin 1" && settings["Admin1"])||(vars.Trainer == "Admin 2" && settings["Admin2"])||(vars.Trainer == "Admin 3" && settings["Admin3"])||(vars.Trainer == "Admin 4" && settings["Admin4"])) && vars.Music.Current == 458 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 466 && vars.OppLevel.Current == 24)
	{
	vars.Trainer = "Gang1";
	}
	
	if(vars.Music.Current == 466 && vars.OppLevel.Current == 41)
	{
	vars.Trainer = "Gang2";
	}
	
	if(((vars.Trainer == "Gang1" && settings["Gang1"])||(vars.Trainer == "Gang2" && settings["Gang2"])) && FanfareValues.Contains(vars.Fanfare.Current) && vars.Music.Current == 466)
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 464 && vars.OppLevel.Current == 5)
	{
	vars.Trainer = "Rival 1";
	}
	
	if(vars.Music.Current == 464 && vars.OppLevel.Current == 18)
	{
	vars.Trainer = "Rival 2";
	}
	
    if(vars.Music.Current == 464 && vars.OppLevel.Current == 29)
	{
	vars.Trainer = "Rival 3";
	}
	
	if(vars.Music.Current == 464 && vars.OppLevel.Current == 32)
	{
	vars.Trainer = "Rival 4";
	}

	if(((vars.Trainer == "Rival 1" && settings["Rival1"])||(vars.Trainer == "Rival 2" && settings["Rival2"])||(vars.Trainer == "Rival 3" && settings["Rival3"])||(vars.Trainer == "Rival 4" && settings["Rival4"])) && FanfareValues.Contains(vars.Fanfare.Current) && vars.Music.Current == 464)
	{
	vars.IsDefeated = true;
	}
	
	if(((vars.Music.Current == 460 && settings["BossOfGym"])||(vars.Music.Current == 465 && settings["E4"])||(vars.Music.Current == 461 && settings["Champions"])) && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	//Wild mons checks:
	if(vars.Music.Current == 457 && vars.OppSpecies.Current == 63 && vars.OppHP.Current > 0 && FanfareValues.Contains(vars.Fanfare.Current) && settings["Abra"])
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 463 && (vars.OppSpecies.Current == 404||vars.OppSpecies.Current == 405) && vars.OppHP.Current > 0 && FanfareValues.Contains(vars.Fanfare.Current) && settings["KyogreGroudon"])
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 463 && (vars.OppSpecies.Current == 404||vars.OppSpecies.Current == 405) && vars.OppHP.Current == 0 && FanfareValues.Contains(vars.Fanfare.Current) && settings["KyogreGroudon0"])
	{
	vars.IsDefeated = true;
	}
}

start
{
    if(vars.MusicStartEnd.Current == 20 && vars.MusicStartEnd.Old != 20)
	{
	vars.Countdown = 1;
	return true;
	}
	else return false;
}

split
{
	if(vars.IsDefeated && vars.Fanfare.Current != vars.Fanfare.Old && ((vars.Fanfare.Old < 237 && vars.Fanfare.Old > 234)||(vars.Fanfare.Old < 68 && vars.Fanfare.Old > 65)||(vars.Fanfare.Old == 71)||(vars.Fanfare.Old > 48 && vars.Fanfare.Old < 51)||(vars.Fanfare.Old > 87 && vars.Fanfare.Old < 90)))
	{
	vars.IsDefeated = false;
	return true;
	}
	
	if(vars.Countdown == 1 && vars.Music.Current == 447 && vars.MusicStartEnd.Current != vars.MusicStartEnd.Old && vars.MusicStartEnd.Current == vars.MusicStartEnd.Old + 19 && settings["FS"])
	{
	vars.Countdown = 0;
	return true;
	}
	
	if(vars.Music.Current == 431 && vars.Music.Old == 427 && settings["Boat"])
	{
	return true;
	}
}

startup
{
	vars.startup = 0;
	settings.Add("Main", true, "Autosplits after battling:");
	settings.SetToolTip("Main", "Tick the autosplits you want for your run");
	  settings.Add("Rival",true, "Rival (May/Brendan)", "Main");
	  settings.SetToolTip("Rival", "Tick the fights you'd like to split on");
	    settings.Add("Rival1",true, "Rival - Route 103", "Rival");
		settings.Add("Rival2",true, "Rival - Route 110", "Rival");
		settings.Add("Rival3",true, "Rival - Route 119", "Rival");
		settings.Add("Rival4",true, "Rival - Lilycove City", "Rival");
	  settings.Add("WhoAgain",true, "Rival (Wally)", "Main");
		settings.Add("WhoAgain1",true, "Rival (Wally) - 1", "WhoAgain");
	    settings.SetToolTip("WhoAgain1", "Includes only the first fight");
	    settings.Add("WhoAgain2",true, "Rival (Wally) - 2", "WhoAgain");
	    settings.SetToolTip("WhoAgain2", "Includes the second fight and rematches");
	  settings.Add("Teams",true, "Team Aqua/Magma related", "Main");
	    settings.Add("Gang1",true, "Team Aqua/Magma Leaders - 1", "Teams");
	    settings.SetToolTip("Gang1", "Includes only the first fight");
	    settings.Add("Gang2",true, "Team Aqua/Magma Leaders - 2", "Teams");
	    settings.SetToolTip("Gang2", "Includes only the second fight");
		settings.Add("Admin1",false, "First fight with the Admin", "Teams");
	    settings.SetToolTip("Admin1", "Includes only the fight before the team leader");
	    settings.Add("Admin2",false, "Second fight with the admin", "Teams");
	    settings.SetToolTip("Admin2", "Includes only the second fight in the hideout");
		settings.Add("Admin3",false, "Fight with the admin inside the Weather Institute", "Teams");
	    settings.Add("Admin4",false, "Fight with the admin in the underwater cave", "Teams");
	  settings.Add("BossOfGym", true, "Gym Leaders", "Main");
	  settings.SetToolTip("BossOfGym", "Includes all fights");
	  settings.Add("E4", true, "Elite Four", "Main");
	  settings.SetToolTip("E4", "Includes all fights");
	  settings.Add("Champions",true, "Champion", "Main");
	  settings.Add("FS",true, "Final Split (Hall of Fame)", "Main");
	  settings.SetToolTip("FS", "Splits when the credits start");
	  
	  settings.Add("Main2", false, "Autosplits under different conditions:");
	  settings.SetToolTip("Main2", "Tick the autosplits you want for your run");
	  settings.Add("Boat",false, "Getting on the boat after Dewford", "Main2");
	  settings.Add("Abra",false, "Upon capturing an Abra", "Main2");
	  settings.Add("KyogreGroudon",false, "Upon capturing Kyogre/Groudon", "Main2");
	  settings.Add("KyogreGroudon0",false, "Upon defeating Kyogre/Groudon", "Main2");
}
