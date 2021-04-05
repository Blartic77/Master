//Script by NLM aka NextLevelMemes

state("ROTK")
{
    byte Load : 0xAAFA0, 0x178;
    byte IsCutscene : 0xEA468, 0x4;
    string5 Level : 0x7F388, 0x58E;
    uint BossHP : 0x179754, 0xAA0;
}

init
{
    print("Checking your browse history. Looking for stored passwords...");
    refreshRate = 30;
}

start
{
    if(current.Level == "Hel01" && old.Level == "Fro03")
	return true;
	else return false;
}

split
{
	if(current.Level != old.Level && current.Level != "Fro03")
	return true;
	if(current.Level == "Cra01" && current.BossHP == 100 && current.IsCutscene == 0 && old.IsCutscene == 1)
	return true;
	else return false;
}

isLoading
{
	if(current.Load == 1||current.Load == 255)
	return true;
	else return false;
}

startup
{
    var errorMessage = MessageBox.Show
	(
        "If you're using software like DxWnd to play in\n"+
        "windowed mode, make sure you run the game\n"+
        "first and LiveSplit afterwards, as otherwise\n"+
	    "the autosplitter might not work at all.",
       	"RotK splitter WARNING!",
     	MessageBoxButtons.OK,
		MessageBoxIcon.Error
    );
}
