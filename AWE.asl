//Script by NLM aka NextLevelMemes. Start and split functions will be implemented soon (already working on them).

state("AWE")
{
}

init
{
	refreshRate = 60;
	vars.GameExit = 1;
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
	}
	
}

update
{
	vars.Load.Update(game);
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

startup
{
    vars.GameExit = 3;
	var errorMessage = MessageBox.Show
	(
        "If you're using software like DxWnd to play in\n"+
        "windowed mode, make sure you run the game\n"+
        "first and LiveSplit (ran as administrator)\n"+
		"afterwards, as otherwise the autosplitter\n"+
		"might not work at all. Also, if you close\n"+
	    "the game you'll have to close and run\n"+
		"LiveSplit again.",
       	"AWE splitter WARNING!",
     	MessageBoxButtons.OK,
		MessageBoxIcon.Error
    );
}

exit
{
vars.GameExit = 2;
}
