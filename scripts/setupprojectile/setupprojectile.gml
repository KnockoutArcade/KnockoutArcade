// Script assets have changed for v2.3.0 see
// https//help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupProjectile(selectedProjectile, selectedPaletteId = -1)
{
	var formedProjectile = {};
	
	formedProjectile.BasePalette = selectedProjectile.BaseColor.ColorPalette;
	formedProjectile.CopyCharacterPalette = selectedProjectile.CopyCharacterPalette;
	formedProjectile.CharacterPalette = selectedProjectile.Character;
	formedProjectile.AlternatePalettes = selectedProjectile.Palettes;
	formedProjectile.SelectedPalette = formedProjectile.BasePalette;
	formedProjectile.Name = selectedProjectile.Name;
	
	// Add stats to the projectile
	formedProjectile.HasLifetime = selectedProjectile.HasLifetime;
	formedProjectile.Lifetime = selectedProjectile.Lifetime;
	formedProjectile.AnimationSpeed = selectedProjectile.AnimationSpeed;
	formedProjectile.HorizontalSpeed = selectedProjectile.HorizontalSpeed;
	formedProjectile.VerticalSpeed = selectedProjectile.VerticalSpeed;
	formedProjectile.EnvironmentalDisplacement = selectedProjectile.EnvironmentalDisplacement;
	formedProjectile.FallSpeed = selectedProjectile.FallSpeed;
	formedProjectile.GroundTraction = selectedProjectile.GroundTraction;
	formedProjectile.AirTraction = selectedProjectile.AirTraction;
	formedProjectile.DestroyOnFloor = selectedProjectile.DestroyOnFloor;
	formedProjectile.DestroyOnWall = selectedProjectile.DestroyOnWall;
	formedProjectile.BounceOnFloor = selectedProjectile.BounceOnFloor;
	formedProjectile.BounceOnWall = selectedProjectile.BounceOnWall;
	formedProjectile.NumberOfBounces = selectedProjectile.NumberOfBounces;
	formedProjectile.Bounciness = selectedProjectile.Bounciness;
	formedProjectile.Transcendent = selectedProjectile.Transcendent;
	formedProjectile.Health = selectedProjectile.Health;
	
	formedProjectile.Sprites =
	{
		Sprite : asset_get_index(selectedProjectile.ProjectileSprites.Sprite),
		Destroy : asset_get_index(selectedProjectile.ProjectileSprites.Destroy)
	}
	
	formedProjectile.NumberOfWindows = selectedProjectile.NumberOfFrames;
	formedProjectile.Window = selectedProjectile.FrameData;
	formedProjectile.NumberOfHitboxes  = selectedProjectile.NumberOfHitboxes;
	formedProjectile.AttackProperty = selectedProjectile.AttackData;
	formedProjectile.CounterHitProperty = selectedProjectile.CounterData;
	formedProjectile.RehitData = selectedProjectile.RehitData;
	
	return formedProjectile;
}