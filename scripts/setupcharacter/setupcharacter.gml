// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupCharacter(selectedCharacter, selectedPaletteId = -1)
{
	var formedCharacter = {};
	
	formedCharacter.MaxHP = selectedCharacter.MaxHitPoints;
	formedCharacter.BasePalette = selectedCharacter.BaseColor.ColorPalette;
	formedCharacter.NumberOfPalettes = selectedCharacter.NumberOfPalettes;
	formedCharacter.AlternatePalettes = selectedCharacter.Palettes;
	formedCharacter.SelectedPalette = formedCharacter.BasePalette;
	formedCharacter.Name = selectedCharacter.Name;
	formedCharacter.UniqueData = selectedCharacter.UniqueData;
	formedCharacter.NonmoveSoundData = selectedCharacter.NonmoveSoundData;
	
	// add stats to the character
	formedCharacter.HorizontalSpeed = selectedCharacter.HorizontalSpeed;
	formedCharacter.VerticalSpeed = selectedCharacter.VerticalSpeed;
	formedCharacter.EnvironmentalDisplacement = selectedCharacter.EnvironmentalDisplacement;
	formedCharacter.WalkSpeed = selectedCharacter.WalkSpeed;
	formedCharacter.RunSpeed = selectedCharacter.RunSpeed;
	formedCharacter.Traction = selectedCharacter.Traction;
	formedCharacter.JumpSpeed = selectedCharacter.JumpSpeed;
	formedCharacter.FallSpeed = selectedCharacter.FallSpeed;
	formedCharacter.BackDashDuration = selectedCharacter.BackDashDuration;
	formedCharacter.BackDashInvincibility = selectedCharacter.BackDashInvincibility;
	formedCharacter.BackDashSpeed = selectedCharacter.BackDashSpeed;
	formedCharacter.BackDashStartup = selectedCharacter.BackDashStartup;
	formedCharacter.FastFallSpeed = selectedCharacter.FastFallSpeed;
	
	// This value will be: None = 0, DoubleJump = 1, SuperJump = 2, ShortHop = 4
	// They can be combined, though they will likely not be in practice...
	// meaning someone capable of a doublejump and shorthop would have a value of 5
	// The way you would check if someone has double jump is using bitwise operations
	// To check if someone can doublejump for instance, you would do this:
	// if(JumpType & 1 == 1)
	// ShortHop would be:
	// if(JumpType & 4 == 4)
	// For a more in depth and less useful overview of this, see the official docs: https://manual.yoyogames.com/Additional_Information/Bitwise_Operators.htm
	formedCharacter.JumpType = selectedCharacter.JumpType;
	formedCharacter.JumpHorizontalSpeed = selectedCharacter.JumpHorizontalSpeed;
	formedCharacter.SuperMeterBuildRate = selectedCharacter.SuperMeterBuildRate;
	formedCharacter.Sprites =
	{
		Idle : asset_get_index(selectedCharacter.CharacterSprites.Idle),
		Crouch : asset_get_index(selectedCharacter.CharacterSprites.Crouch),
		StandBlock : asset_get_index(selectedCharacter.CharacterSprites.StandBlock),
		CrouchBlock : asset_get_index(selectedCharacter.CharacterSprites.CrouchBlock),
		WalkForward : asset_get_index(selectedCharacter.CharacterSprites.WalkForward),
		WalkBackward : asset_get_index(selectedCharacter.CharacterSprites.WalkBackward),
		RunForward : asset_get_index(selectedCharacter.CharacterSprites.RunForward),
		RunBackward : asset_get_index(selectedCharacter.CharacterSprites.RunBackward),
		JumpSquat : asset_get_index(selectedCharacter.CharacterSprites.JumpSquat),
		Jump : asset_get_index(selectedCharacter.CharacterSprites.Jump),
		Hurt : asset_get_index(selectedCharacter.CharacterSprites.Hurt),
		Grab : asset_get_index(selectedCharacter.CharacterSprites.Grab),
		Hold : asset_get_index(selectedCharacter.CharacterSprites.Hold),
		Launched : asset_get_index(selectedCharacter.CharacterSprites.Launched),
		Knockdown : asset_get_index(selectedCharacter.CharacterSprites.Knockdown),
		GetUp : asset_get_index(selectedCharacter.CharacterSprites.GetUp)
	}
	
	//setup the moves
	formedCharacter.MoveData = selectedCharacter.MoveData;
	
	for(var i = 0; i < array_length(selectedCharacter.MoveData); i++;)
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
		nextMove.NumberOfSounds = selectedCharacter.MoveData[i].NumberOfSounds;
		nextMove.MoveSoundData = selectedCharacter.MoveData[i].MoveSoundData;

		if(selectedCharacter.MoveData[i].IsThrow)
		{
			nextMove.OpponentPositionData = selectedCharacter.MoveData[i].OpponentPositionData;
		}
		
		switch(selectedCharacter.MoveData[i].MoveType)
		{
			case 1: // backward throw
			formedCharacter.BackwardThrow = nextMove;
			break;
			case 2: // forward throw
			formedCharacter.ForwardThrow = nextMove;
			break;
			case 4: // grab
			formedCharacter.Grab = nextMove;
			break;
			case 8: // side special
			formedCharacter.SideSpecial = nextMove;
			break;
			case 16: // neutral special
			formedCharacter.NeutralSpecial = nextMove;
			break;
			case 32: // standing light 1
			formedCharacter.StandLight = nextMove;
			break;
			case 64: // standing light 2
			formedCharacter.StandLight2 = nextMove;
			break;
			case 128: // standing light 3
			formedCharacter.StandLight3 = nextMove;
			break;
			case 256: // standing medium
			formedCharacter.StandMedium = nextMove;
			break;
			case 512: // standing heavy
			formedCharacter.StandHeavy = nextMove;
			break;
			case 1024: // crouching light
			formedCharacter.CrouchingLight = nextMove;
			break;
			case 2048: // crouching medium
			formedCharacter.CrouchingMedium = nextMove;
			break;
			case 4096: // crouching heavy
			formedCharacter.CrouchingHeavy = nextMove;
			break;
			case 8192: // jumping light
			formedCharacter.JumpingLight = nextMove;
			break;
			case 16384: // jumping medium
			formedCharacter.JumpingMedium = nextMove;
			break;
			case 32768: // jumping heavy
			formedCharacter.JumpingHeavy = nextMove;
			break;
			case 65536: // up special
			formedCharacter.UpSpecial = nextMove;
			break;
			case 131072: // down special
			formedCharacter.DownSpecial = nextMove;
			break;
			case 262144: // command grab
			formedCharacter.CommandGrab = nextMove;
			break;
			case 524288: // command normal 1
			formedCharacter.CommandNormal1 = nextMove;
			break;
			case 1048576: // command normal 2
			formedCharacter.CommandNormal2 = nextMove;
			break;
			case 2097152: // command normal 3
			formedCharacter.CommandNormal3 = nextMove;
			break;
			
		}
		
		switch (selectedCharacter.MoveData[i].EnhanceMoveType)
		{
			case 1:
			formedCharacter.EnhancedNeutralSpecial = nextMove;
			break;
			case 2:
			formedCharacter.EnhancedSideSpecial = nextMove;
			break;
			case 4:
			formedCharacter.EnhancedUpSpecial = nextMove;
			break;
			case 8:
			formedCharacter.EnhancedDownSpecial = nextMove;
			break;
			case 16:
			formedCharacter.EnhancedNeutralSpecial2 = nextMove;
			break;
			case 32:
			formedCharacter.EnhancedSideSpecial2 = nextMove;
			break;
			case 64:
			formedCharacter.EnhancedUpSpecial2 = nextMove;
			break;
			case 128:
			formedCharacter.EnhancedDownSpecial2 = nextMove;
			break;
			case 256:
			formedCharacter.RekkaLauncher = nextMove;
			break;
			case 512:
			formedCharacter.RekkaFinisher = nextMove;
			break;
			case 1024:
			formedCharacter.RekkaConnecter = nextMove;
			break;
			case 2048:
			formedCharacter.RekkaLow = nextMove;
			break;
			case 4096:
			formedCharacter.RekkaHigh = nextMove;
			break;
		}
	}
	
	return formedCharacter;
}