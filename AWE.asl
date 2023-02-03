//Script by Blartic77

state("AWE")
{
}

init
{
	refreshRate = 60;
	vars.GameExit = 1;
}

update
{
	if(vars.GameExit > 0)
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
				print(name + " starts at 0x" + vars.addr.ToString("X"));
				break;
			}
		}
	});

	SigScanTarget target;
	
    target = new SigScanTarget(0, "00 00 00 00 00 00 00 00 ?? 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 ?? ?? ?? ?? ?? 00 00 00 ?? 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ?? ?? ?? ?? ?? ?? ?? ?? 08 00 00 00 08 00 00 00 ?? ?? ?? ?? FF FF FF FF");
	vars.search(target,"LoadAddress");
	vars.Load = new MemoryWatcher<byte>(vars.addr + 0x20);
	vars.GameStarted = new MemoryWatcher<byte>(vars.addr + 0x24);

	vars.GameExit = -1;
	
	vars.GameStarted.Update(game);
	{
	}
	
	if(vars.GameExit == -1 && vars.GameStarted.Current == 2)
    {	
	    target = new SigScanTarget(0, "4C 61 6D 65 72 4F 4B 00");
	    vars.search(target,"LevelAddress");
	    vars.Level = new StringWatcher(vars.addr - 0x238, 25);
	}
	
	}
	
	vars.Load.Update(game);
	{
	}
	
	vars.Level.Update(game);
	{
	}
}

isLoading
{
	if(vars.Load.Current == 1)
	return true;
	else if(vars.Load.Current != 1)
	return false;
}

start
{
    if((vars.Level.Current == "Waiting for the Storm"||vars.Level.Current == "The Last Straw"||vars.Level.Current == "A True King of Persia") && vars.Level.Old == "ancient_wars_sparta")
	return true;
	else return false;
}

split
{
    if(vars.Level.Current != vars.Level.Old && vars.Level.Current != "ancient_wars_sparta")
	return true;
	if(vars.Level.Current == "ancient_wars_sparta" && (vars.Level.Old == "The Final Blow"||vars.Level.Old == "The Battle Of Plataea"||vars.Level.Old == "The White Citadel"))
	return true;
	else return false;
}

startup
{
    vars.GameExit = 3;
	var errorMessage = MessageBox.Show
	(
        "If you're using software like DxWnd to play in\n"+
        "windowed mode, make sure you run the game\n"+
        "first and LiveSplit (ran as administrator)\n"+
		"afterwards, as otherwise the autosplitter\n"+
	    "might not work at all. Also, if you close the\n"+
	    "game you'll have to run LiveSplit again.",
       	"AWE splitter WARNING!",
     	MessageBoxButtons.OK,
		MessageBoxIcon.Error
    );
}

exit
{
vars.GameExit = 2;
}
