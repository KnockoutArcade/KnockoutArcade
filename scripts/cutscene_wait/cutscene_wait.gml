/// This Function tells a cutscene object how long to wait until proceeding to the next instruction
function Cutscene_Wait(frames)
{
	waitTimer += 1;
	
	if (waitTimer >= frames)
	{
		waitTimer = 0;
		
		Cutscene_ENDSCENE();
	}
}