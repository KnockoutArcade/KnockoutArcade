// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// This script is responsible for iterating through each move and overwriting the current character's data if their moveset has changed.
function OverwriteMoveset()
{
	for (var i = 0; i < array_length(selectedCharacter.MoveData); i++;)
	{
		for (var j = 0; j < array_length(selectedCharacter.MoveData[i].InMovesets); j++;)
		{
			if (selectedCharacter.MoveData[i].InMovesets[j] == currentMovesetID)
			{
				var nextMove = {};
				nextMove.SpriteId = asset_get_index(selectedCharacter.MoveData[i].SpriteName);
				nextMove.Duration = selectedCharacter.MoveData[i].Duration;
				nextMove.AttackProperty = selectedCharacter.MoveData[i].AttackData;
				nextMove.NumberOfHitboxes  = selectedCharacter.MoveData[i].NumberOfHitboxes;
				nextMove.NumberOfHurtboxes = selectedCharacter.MoveData[i].NumberOfHurtboxes;
				nextMove.NumberOfWindows = selectedCharacter.MoveData[i].NumberOfFrames;
				nextMove.NumberOfProjectiles = selectedCharacter.MoveData[i].NumberOfProjectiles;
				nextMove.IsThrow = selectedCharacter.MoveData[i].IsThrow;
				nextMove.Window = selectedCharacter.MoveData[i].FrameData;
				nextMove.HurtboxProperty = selectedCharacter.MoveData[i].HurtboxData;
				nextMove.GroundMovementData = selectedCharacter.MoveData[i].GroundMovementData;
				nextMove.AirMovementData = selectedCharacter.MoveData[i].AirMovementData;
				nextMove.CounterHitProperty = selectedCharacter.MoveData[i].CounterData;
				nextMove.RehitData = selectedCharacter.MoveData[i].RehitData;
				nextMove.ProjectileData = selectedCharacter.MoveData[i].ProjectileData;
				nextMove.MoveCanCancelInto = selectedCharacter.MoveData[i].MoveCanCancelInto;
				nextMove.CommandNormalData = selectedCharacter.MoveData[i].CommandNormalData;
				nextMove.NumberOfEnhancements = selectedCharacter.MoveData[i].NumberOfEnhancements;
				nextMove.SpecialData = selectedCharacter.MoveData[i].SpecialData;
				nextMove.InMovesets = selectedCharacter.MoveData[i].InMovesets;
				nextMove.SwitchMoveset = selectedCharacter.MoveData[i].SwitchMoveset;
				nextMove.SwitchToMoveset = selectedCharacter.MoveData[i].SwitchToMoveset;
				nextMove.SpiritData = selectedCharacter.MoveData[i].SpiritData;
				nextMove.NumberOfSounds = selectedCharacter.MoveData[i].NumberOfSounds;
				nextMove.MoveSoundData = selectedCharacter.MoveData[i].MoveSoundData;

				if(selectedCharacter.MoveData[i].IsThrow)
				{
					nextMove.OpponentPositionData = selectedCharacter.MoveData[i].OpponentPositionData;
				}
		
				switch(selectedCharacter.MoveData[i].MoveType)
				{
					case 1: // backward throw
					selectedCharacter.BackwardThrow = nextMove;
					break;
					case 2: // forward throw
					selectedCharacter.ForwardThrow = nextMove;
					break;
					case 4: // grab
					selectedCharacter.Grab = nextMove;
					break;
					case 8: // side special
					selectedCharacter.SideSpecial = nextMove;
					break;
					case 16: // neutral special
					selectedCharacter.NeutralSpecial = nextMove;
					break;
					case 32: // standing light 1
					selectedCharacter.StandLight = nextMove;
					break;
					case 64: // standing light 2
					selectedCharacter.StandLight2 = nextMove;
					break;
					case 128: // standing light 3
					selectedCharacter.StandLight3 = nextMove;
					break;
					case 256: // standing medium
					selectedCharacter.StandMedium = nextMove;
					break;
					case 512: // standing heavy
					selectedCharacter.StandHeavy = nextMove;
					break;
					case 1024: // crouching light
					selectedCharacter.CrouchingLight = nextMove;
					break;
					case 2048: // crouching medium
					selectedCharacter.CrouchingMedium = nextMove;
					break;
					case 4096: // crouching heavy
					selectedCharacter.CrouchingHeavy = nextMove;
					break;
					case 8192: // jumping light
					selectedCharacter.JumpingLight = nextMove;
					break;
					case 16384: // jumping medium
					selectedCharacter.JumpingMedium = nextMove;
					break;
					case 32768: // jumping heavy
					selectedCharacter.JumpingHeavy = nextMove;
					break;
					case 65536: // up special
					selectedCharacter.UpSpecial = nextMove;
					break;
					case 131072: // down special
					selectedCharacter.DownSpecial = nextMove;
					break;
					case 262144: // command grab
					selectedCharacter.CommandGrab = nextMove;
					break;
					case 524288: // command normal 1
					selectedCharacter.CommandNormal1 = nextMove;
					break;
					case 1048576: // command normal 2
					selectedCharacter.CommandNormal2 = nextMove;
					break;
					case 2097152: // command normal 3
					selectedCharacter.CommandNormal3 = nextMove;
					break;
			
				}
		
				switch (selectedCharacter.MoveData[i].EnhanceMoveType)
				{
					case 1:
					selectedCharacter.EnhancedNeutralSpecial = nextMove;
					break;
					case 2:
					selectedCharacter.EnhancedSideSpecial = nextMove;
					break;
					case 4:
					selectedCharacter.EnhancedUpSpecial = nextMove;
					break;
					case 8:
					selectedCharacter.EnhancedDownSpecial = nextMove;
					break;
					case 16:
					selectedCharacter.EnhancedNeutralSpecial2 = nextMove;
					break;
					case 32:
					selectedCharacter.EnhancedSideSpecial2 = nextMove;
					break;
					case 64:
					selectedCharacter.EnhancedUpSpecial2 = nextMove;
					break;
					case 128:
					selectedCharacter.EnhancedDownSpecial2 = nextMove;
					break;
					case 256:
					selectedCharacter.RekkaLauncher = nextMove;
					break;
					case 512:
					selectedCharacter.RekkaFinisher = nextMove;
					break;
					case 1024:
					selectedCharacter.RekkaConnecter = nextMove;
					break;
					case 2048:
					selectedCharacter.RekkaLow = nextMove;
					break;
					case 4096:
					selectedCharacter.RekkaHigh = nextMove;
					break;
				}
			}
		}
	}
}