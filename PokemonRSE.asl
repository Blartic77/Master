//Autosplitter by NLM aka NextLevelMemes for Pokemon Ruby, Sapphire and Emerald. 
//Thanks to Ero, Square, buurazu and 2838 for giving me advice on how to properly sigscan, and again to buurazu for his sigscan function which I used for this script
//Known issues:
//-If you lose an important battle, it will split regardless. Might not be too important if you're aiming for a good time and reset upon losing.


state("mGBA")
{
}

state("VBA")
{
}

init
{
    vars.Game = "Unknown";
	vars.memeonrepeat = 1;
    if(vars.memeonrepeat > 0)
    {
	vars.Count = 0;
    print("Warning: savestates detected. Flagging times as suspicious for verifiers");
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
	
	target = new SigScanTarget(0, "50 4F 4B 45 4D 4F 4E 20 45 4D 45 52");
   	vars.search(target,"Emerald");
	{
	vars.Game = "Emerald";
	}
    
	if(vars.addr == IntPtr.Zero)
	{
	target = new SigScanTarget(0, "50 4F 4B 45 4D 4F 4E 20 52 55 42 59");
   	vars.search(target,"Ruby");
	vars.Game = "Ruby";
	}
	
	if(vars.addr == IntPtr.Zero)
	{
	target = new SigScanTarget(0, "50 4F 4B 45 4D 4F 4E 20 53 41 50 50");
   	vars.search(target,"Sapphire");
	vars.Game = "Sapphire";
	}
	
	if(vars.addr == IntPtr.Zero)
	{
	vars.Game = "Unknown";
	}
	
if(vars.Game == "Emerald")
	{
	target = new SigScanTarget(6, "0A 08 ?? ?? ?? ?? DA 01 00 00 02 00");
   	vars.search(target,"MEMES");
	vars.StepNumber = new MemoryWatcher<short>(vars.addr);
	
	target = new SigScanTarget(0, "00 32 02 00 30 33 20 00 33 33");
   	vars.search(target,"FUN");
	vars.BirchAppearanceNo = new MemoryWatcher<byte>(vars.addr - 0x2C6);
	
	target = new SigScanTarget(7, "FF ?? ?? FF D6 04 D7 FF");
   	vars.search(target,"TRYHARDING");
	vars.RNGPosition = new MemoryWatcher<byte>(vars.addr);
	}

if(vars.Game == "Ruby"||vars.Game == "Sapphire")
	{
	target = new SigScanTarget(6, "07 08 ?? ?? ?? ?? C9 01 00 00 02 00");
   	vars.search(target,"MEMES");
	vars.StepNumber = new MemoryWatcher<short>(vars.addr);
	
	target = new SigScanTarget(0, "00 A0 AA 0A 00 AA AA AA 00 0A 00 A0 00");
   	vars.search(target,"FUN");
	vars.BirchAppearanceNo = new MemoryWatcher<byte>(vars.addr - 0x2B8);
	
	target = new SigScanTarget(7, "FF ?? ?? FF D6 04 D7 ??");
   	vars.search(target,"TRYHARDING");
	vars.RNGPosition = new MemoryWatcher<byte>(vars.addr);
	}
    }
}


update
{
if(vars.Game == "Emerald")
    {
    vars.StepNumber.Update(game);
	{
	}
	vars.BirchAppearanceNo.Update(game);
    {
    }
	vars.RNGPosition.Update(game);
    {
	if(vars.RNGPosition.Current == 255 && vars.RNGPosition.Old == 70)
	{
	vars.Count = 1;
	}
	if(vars.Count == 1)
	    {
		if(vars.RNGPosition.Current == 70 && vars.RNGPosition.Old == 255)
		{
		vars.Count = 2;
		}
		}
    }
	}
if(vars.Game == "Ruby"||vars.Game == "Sapphire")
	{
    vars.StepNumber.Update(game);
	{
	}
	vars.BirchAppearanceNo.Update(game);
    {
    }
	vars.RNGPosition.Update(game);
    {
	if(vars.RNGPosition.Current == 255 && vars.RNGPosition.Old == 17)
	{
	vars.Count = 1;
	}
	if(vars.Count == 1)
	    {
		if(vars.RNGPosition.Current == 17 && vars.RNGPosition.Old == 255)
		{
		vars.Count = 2;
		}
		}
    }
	}
}

start
{
    if(vars.BirchAppearanceNo.Current == 20 && vars.BirchAppearanceNo.Old != 20)
	return true;
	else return false;
}

split
{
if(vars.Game == "Emerald")
	{
    if(vars.StepNumber.Current != vars.StepNumber.Old && ((vars.StepNumber.Old == 481)||(vars.StepNumber.Old == 482)||(vars.StepNumber.Old == 478)||(vars.StepNumber.Old == 483)||(vars.StepNumber.Old == 471)||(vars.StepNumber.Old == 477)))
	return true;
	if(vars.StepNumber.Current == 447 && vars.BirchAppearanceNo.Current != vars.BirchAppearanceNo.Old && vars.BirchAppearanceNo.Current == vars.BirchAppearanceNo.Old + 19)
	return true;
	if(vars.StepNumber.Old == 476 && vars.StepNumber.Current != 476 && vars.Count == 2)
	{
	return true;
	vars.Count = 0;
	}
	else return false;
	}

if(vars.Game == "Ruby"||vars.Game == "Sapphire")
	{
    if(vars.StepNumber.Current != vars.StepNumber.Old && ((vars.StepNumber.Old == 464)||(vars.StepNumber.Old == 460)||(vars.StepNumber.Old == 466)||(vars.StepNumber.Old == 465)||(vars.StepNumber.Old == 461)))
	return true;
	if(vars.StepNumber.Current == 447 && vars.BirchAppearanceNo.Current != vars.BirchAppearanceNo.Old && vars.BirchAppearanceNo.Current == vars.BirchAppearanceNo.Old + 19)
	return true;
	if(vars.StepNumber.Old == 459 && vars.StepNumber.Current != 459 && vars.Count == 2)
	{
	return true;
	vars.Count = 0;
	}
	else return false;
	}
}

exit
{
vars.memeonrepeat = 2;
}

shutdown
{
vars.memeonrepeat = 0;
}

startup
{
    var errorMessage = MessageBox.Show (
        "To ensure it works please follow these steps:\n"+
		" \n"+
        "1) Load the game in the emu. Have a wild battle* \n"+
		"2) Run LiveSplit and load the script \n"+
		" \n"+
		"*: except the very first battle against the mon \n"+
		"that attacks Birch, as it has special properties. \n"+
		" \n"+
		"Once done you can reset and start a New Game. \n"+
		"Also if you close the emu you'll have to close \n"+
		"LiveSplit and redo the steps above (sorry!)",
		"Instructions to make it work",
     	MessageBoxButtons.OK,
		MessageBoxIcon.Error
    );
}
