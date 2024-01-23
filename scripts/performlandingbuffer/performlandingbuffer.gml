// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PerformLandingBuffer()
{
	// Landing Buffer
	if (landingBufferAttack != 0)
	{
		// Transition into the landing attack
		PressAttackButton(landingBufferAttack);
		
		// Reset landing buffer vars
		landingBufferAttack = 0;
		landingBufferTimer = 0;
	}
}