//Autosplitter by NLM aka NextLevelMemes for Pokemon Emerald. 
//Thanks to Ero, Square, buurazu and 2838 for giving me advice on how to properly sigscan, and again to buurazu for his sigscan function which I used for this script

state("mGBA")
{
}

init
{
	vars.Count = 0;
	vars.Trainer = "Unknown";
	vars.print = "FUN";
	vars.IsDefeated = false;
	print("Clean Emerald ROM not found. Please buy a legal copy instead");
    print("Hang on while Windows reports this pirate copy to Game Freak...");
}

update
{	
	HashSet<byte> FanfareValues = new HashSet<byte> { 136, 138, 140, 142 };
	
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
	
	target = new SigScanTarget(1, "00 21 ?? ?? ?? ?? ?? ?? 40 00 ?? ?? ?? 01 ?? 01");
	vars.search(target,"Trumpets");
	{
	if(vars.addr == IntPtr.Zero)
	{
	target = new SigScanTarget(7, "90 00 00 00 00 00 00 00 00 01 01");
	vars.search(target,"Water");
	}
	if(vars.addr == IntPtr.Zero && vars.print == "FUN")
	{
	vars.print = "TROLL";
	print("None of the constants were found. How do I put this...");
	print("Your luck is so on point that if you were to use Metronome, you'd get Explosion");
	}
	}

	vars.Music = new MemoryWatcher<short>(vars.addr + 0x188);
	vars.MusicStartEnd = new MemoryWatcher<byte>(vars.addr - 0x24065);
	vars.Sprite1 = new MemoryWatcher<byte>(vars.addr - 0xC4);
	vars.Sprite2 = new MemoryWatcher<byte>(vars.addr - 0xC2);
	vars.OppLevel = new MemoryWatcher<byte>(vars.addr - 0x1D32E);
	vars.OppHP = new MemoryWatcher<short>(vars.addr - 0x1CCBC);
	vars.OppSpecies = new MemoryWatcher<short>(vars.addr - 0x1CCE4);
	vars.Fanfare = new MemoryWatcher<byte>(vars.addr + 0x668D);
	
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
	
	vars.OppLevel.Update(game);
    {
	}
	
	vars.OppHP.Update(game);
    {
	}
	
	vars.OppSpecies.Update(game);
    {
	}
	
	vars.Fanfare.Update(game);
    {
	}
	
	if(vars.OppLevel.Current == 5 && vars.Music.Current == 481)
	{
	vars.Trainer = "Rival 1";
	}
	
	if(vars.OppLevel.Current == 15 && vars.Music.Current == 481)
	{
	vars.Trainer = "Rival 2";
	}
	
	if(vars.OppLevel.Current == 18 && vars.Music.Current == 481)
	{
	vars.Trainer = "Rival 3";
	}
	
	if(vars.OppLevel.Current == 29 && vars.Music.Current == 481)
	{
	vars.Trainer = "Rival 4";
	}
	
	if(vars.OppLevel.Current == 34 && vars.Music.Current == 481)
	{
	vars.Trainer = "Rival 5";
	}
	
	if(((vars.Trainer == "Rival 1" && settings["Rival1"])||(vars.Trainer == "Rival 2" && settings["Rival2"])||(vars.Trainer == "Rival 3" && settings["Rival3"])||(vars.Trainer == "Rival 4" && settings["Rival4"])||(vars.Trainer == "Rival 5" && settings["Rival5"])) && vars.Music.Current == 481 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(((vars.Sprite1.Current == 70 && vars.Sprite1.Old == 255)||(vars.Sprite1.Current == 70 && vars.Sprite1.Old == 255)) && vars.Music.Current == 476)
	{
	vars.Trainer = "Wally";
	}
	
	if(vars.Trainer == "Wally" && vars.OppSpecies.Current == 392 && vars.OppLevel.Current == 16 && vars.Music.Current == 476)
	{
	vars.Trainer = "Wally 1";
	}
	
	if(vars.Trainer == "Wally" && vars.OppSpecies.Current == 394 && vars.OppLevel.Current >= 45 && vars.Music.Current == 476)
	{
	vars.Trainer = "Wally 2";
	}
	
	if(((vars.Trainer == "Wally 1" && settings["WhoAgain1"])||(vars.Trainer == "Wally 2" && settings["WhoAgain2"])) && vars.Music.Current == 476 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 483 && vars.OppLevel.Current == 24)
	{
	vars.Trainer = "Gang 1";
	}
	
	if(vars.Music.Current == 483 && vars.OppLevel.Current == 39)
	{
	vars.Trainer = "Gang 2";
	}
	
	if(vars.Music.Current == 483 && vars.OppLevel.Current == 41)
	{
	vars.Trainer = "Gang 3";
	}
	
	if(vars.Music.Current == 483 && vars.OppLevel.Current == 44)
	{
	vars.Trainer = "Gang 4";
	}
	
	if(((vars.Trainer == "Gang 1" && settings["Gang1"])||(vars.Trainer == "Gang 2" && settings["Gang2"])||(vars.Trainer == "Gang 3" && settings["Gang3"])||(vars.Trainer == "Gang 4" && settings["Gang4"])) && vars.Music.Current == 483 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 475 && (vars.Sprite1.Current == 69||vars.Sprite2.Current == 69))
	{
	vars.Trainer = "Admin Tabitha";
	}
	
	if(vars.Trainer == "Admin Tabitha" && vars.OppLevel.Current == 18)
	{
	vars.Trainer = "Admin Tabitha 1";
	}
	
	if(vars.Trainer == "Admin Tabitha" && vars.OppLevel.Current == 26)
	{
	vars.Trainer = "Admin Tabitha 2";
	}
	
	if(vars.Music.Current == 475 && (vars.Sprite1.Current == 12||vars.Sprite2.Current == 12))
	{
	vars.Trainer = "Admin Shelly";
	}
	
	if(vars.Trainer == "Admin Shelly" && vars.OppLevel.Current == 28)
	{
	vars.Trainer = "Admin Shelly 1";
	}
	
	if(vars.Trainer == "Admin Shelly" && vars.OppLevel.Current == 37)
	{
	vars.Trainer = "Admin Shelly 2";
	}
	
	if(vars.Music.Current == 475 && (vars.Sprite1.Current == 10||vars.Sprite2.Current == 10) && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.Trainer = "Admin Matt";
	}
	
	if(((vars.Trainer == "Admin Tabitha 1" && settings["Admin1"])||(vars.Trainer == "Admin Tabitha 2" && settings["Admin2"])||(vars.Trainer == "Admin Shelly 1" && settings["Admin3"])||(vars.Trainer == "Admin Shelly 2" && settings["Admin4"])||(vars.Trainer == "Admin Matt" && settings["Admin5"])) && vars.Music.Current == 475 && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(((vars.Music.Current == 471 && settings["FB"])||(vars.Music.Current == 477 && settings["BossOfGym"])||(vars.Music.Current == 482 && settings["E4"])||(vars.Music.Current == 478 && settings["Champions"])) && FanfareValues.Contains(vars.Fanfare.Current))
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 474 && vars.OppSpecies.Current == 63 && vars.OppHP.Current > 0 && FanfareValues.Contains(vars.Fanfare.Current) && settings["Abra"])
	{
	vars.IsDefeated = true;
	}
	
	if(vars.Music.Current == 470 && vars.OppSpecies.Current == 406 && vars.OppHP.Current > 0 && FanfareValues.Contains(vars.Fanfare.Current) && settings["Rayquaza"])
	{
	vars.IsDefeated = true;
	}
}


start
{
    if(vars.MusicStartEnd.Current == 20 && vars.MusicStartEnd.Old != 20)
	{
	vars.Count = 0;
	return true;
	}
}

split
{
	if(vars.IsDefeated && vars.Fanfare.Current == 0 && (vars.Fanfare.Old == 8||vars.Fanfare.Old == 16))
	{
	vars.IsDefeated = false;
	return true;
	}
	
	if(vars.Count == 0 && vars.Music.Current == 447 && vars.MusicStartEnd.Current != vars.MusicStartEnd.Old && vars.MusicStartEnd.Current == vars.MusicStartEnd.Old + 19 && settings["FS"])
	{
	vars.Count = 1;
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
	  settings.SetToolTip("Rival", "Tick the battles you want to split on");
	    settings.Add("Rival1",true, "Rival - Route 103", "Rival");
		settings.Add("Rival2",true, "Rival - Rustboro City", "Rival");
		settings.Add("Rival3",true, "Rival - Route 110", "Rival");
		settings.Add("Rival4",true, "Rival - Route 119", "Rival");
		settings.Add("Rival5",true, "Rival - Lilycove City", "Rival");
	  settings.Add("WhoAgain",true, "Rival (Wally)", "Main");
	  settings.SetToolTip("WhoAgain", "Tick the battles you want to split on");
	    settings.Add("WhoAgain1",true, "Wally - Mauville City", "WhoAgain");
		settings.Add("WhoAgain2",true, "Wally - Victory Road", "WhoAgain");
		settings.SetToolTip("WhoAgain2", "Includes rematches");
	  settings.Add("Gang",true, "Team Aqua/Magma related", "Main");
	  settings.SetToolTip("Gang", "Tick the battles you want to split on");
	    settings.Add("Gang1",true, "Maxie - Mt. Chimney", "Gang");
		settings.Add("Gang2",true, "Maxie - Magma Hideout", "Gang");
		settings.Add("Gang3",true, "Maxie - Space Center", "Gang");
		settings.Add("Gang4",true, "Archie - Seafloor Cavern", "Gang");
		settings.Add("Admin1",false, "Admin Tabitha - Mt. Chimney", "Gang");
		settings.Add("Admin3",false, "Admin Shelly - Weather Institute", "Gang");
		settings.Add("Admin5",false, "Admin Matt - Aqua Hideout", "Gang");
		settings.Add("Admin2",false, "Admin Tabitha - Magma Hideout", "Gang");
		settings.Add("Admin4",false, "Admin Shelly - Seafloor Cavern", "Gang");
	  settings.Add("BossOfGym", true, "Gym Leaders", "Main");
	  settings.SetToolTip("BossOfGym", "Includes all fights");
	  settings.Add("E4", true, "Elite Four", "Main");
	  settings.SetToolTip("E4", "Includes all fights");
	  settings.Add("Champions",true, "Champion", "Main");
	  settings.Add("FS",true, "Final Split (Hall of Fame)", "Main");
	  settings.SetToolTip("FS", "Splits when the credits start");
	  settings.Add("MrStoned",true, "Steven", "Main");
	  settings.SetToolTip("MrStoned", "For extended runs");
	  settings.Add("FB",true, "Frontier Brains", "Main");
	  settings.SetToolTip("FB", "For extended runs");
	  
	settings.Add("Main2", false, "Autosplits under different conditions:");
	settings.SetToolTip("Main2", "Tick the autosplits you want for your run");
	  settings.Add("Boat",false, "Getting on the boat after Dewford", "Main2");
	  settings.Add("Abra",false, "Upon capturing an Abra", "Main2");
	  settings.Add("Rayquaza",false, "Upon capturing Rayquaza", "Main2");
}
