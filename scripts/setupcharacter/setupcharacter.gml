// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupCharacter(selectedCharacter, selectedPaletteId = -1)
{
	var formedCharacter = {};
	
	formedCharacter.basePalette = selectedCharacter.BaseColor.ColorPalette;
	formedCharacter.Name = selectedCharacter.Name;
	
	// if default palette is selected, the value should be -1
	if(selectedPaletteId >= 0)
	{
		formedCharacter.selectedPalette = selectedCharacter.Palettes[selectedPaletteId];
	}
	else
	{
		formedCharacter.selectedPalette = formedCharacter.basePalette;
	}
	
	//setup the moves
	for(var i = 0; i < array_length(selectedCharacter.MoveData); i++;)
	{
		var nextMove = {};
		nextMove.spriteId = asset_get_index(selectedCharacter.MoveData[i].SpriteName);
		nextMove.attackProperty = selectedCharacter.MoveData[i].AttackData;
		nextMove.numOfHitboxes  = selectedCharacter.MoveData[i].NumberOfHitboxes;
		nextMove.numOfHurtboxes = selectedCharacter.MoveData[i].NumberOfHurtboxes;
		nextMove.numOfWindows = selectedCharacter.MoveData[i].NumberOfFrames;
		nextMove.isThrow = selectedCharacter.MoveData[i].IsThrow;
		nextMove.window = selectedCharacter.MoveData[i].FrameData;
		nextMove.hurtboxProperty = selectedCharacter.MoveData[i].HurtboxData;
		nextMove.groundMovementData = selectedCharacter.MoveData[i].GroundMovementData;
		nextMove.airMovementData = selectedCharacter.MoveData[i].AirMovementData;
		nextMove.counterHitProperty = selectedCharacter.MoveData[i].CounterData;

		if(selectedCharacter.MoveData[i].IsThrow)
		{
			nextMove.opponentPositionData = selectedCharacter.MoveData[i].OpponentPositionData;
		}

		if(selectedCharacter.MoveData[i].RehitData.NumberOfHits != 0)
		{
			nextMove.rehitData = selectedCharacter.MoveData[i].RehitData;
		}
		
		switch(selectedCharacter.MoveData[i].MoveType)
		{
			case 1: // forward throw
			formedCharacter.ForwardThrow = nextMove;
			break;
			case 2: // grab
			formedCharacter.Grab = nextMove;
			break;
			case 3: // side special
			formedCharacter.SideSpecial = nextMove;
			break;
			case 4: // neutral special
			formedCharacter.NeutralSpecial = nextMove;
			break;
			case 5: // standing light 1
			formedCharacter.StandLight = nextMove;
			break;
			case 6: // standing light 2
			formedCharacter.StandLight2 = nextMove;
			break;
			case 7: // standing light 3
			formedCharacter.StandLight3 = nextMove;
			break;
			case 8: // standing medium
			formedCharacter.StandMedium = nextMove;
			break;
			case 9: // standing heavy
			formedCharacter.StandHeavy = nextMove;
			break;
			case 10: // crouching light
			formedCharacter.CrouchingLight = nextMove;
			break;
			case 11: // crouching medium
			formedCharacter.CrouchingMedium = nextMove;
			break;
			case 12: // crouching heavy
			formedCharacter.CrouchingHeavy = nextMove;
			break;
			case 13: // jumping light
			formedCharacter.JumpingLight = nextMove;
			break;
			case 14: // jumping medium
			formedCharacter.JumpingMedium = nextMove;
			break;
			case 15: // jumping heavy
			formedCharacter.JumpingHeavy = nextMove;
			break;
			case 0: // backward throw
			default:
			formedCharacter.BackwardThrow = nextMove;
			break;
		}
	}
	
	return formedCharacter;
}