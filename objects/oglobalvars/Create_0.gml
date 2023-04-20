/// @description Insert description here
// You can write your code in this editor



// Projectile Vars
global.ProjectileBase_HitboxData = { // Seperating the name of the projectile from HitboxData to make it easier to read
	// Projectiles have slightly different data than normal attacks. They don't need animation or movement data.
	// They also don't need a startup or lifetime, as they are active indefinetly until the projectile despawns
	// Projectiles also can't be grabs or throws.
	
	NumberOfHitboxes : 1,
		
	AttackData : [
		{
			AttackWidth : 10,
			AttackHeight : 5,
			WidthOffset : -5,
			HeightOffset : -2,
			Group : 1,
		
			Damage : 10,
			MeterGain : 4,
			ComboScaling : 2,
			AttackHitStop : 6,
			AttackHitStun : 9,
			AttackType : eAttackType.MID,
			BlockStun : 3,
			KnockBack: 1,
			AirKnockbackVertical: 0,
			AirKnockbackHorizontal: 1,
		
			Launches: false,
			LaunchKnockbackVertical: 0,
			LaunchKnockbackHorizontal: 0,
			Pushback: 1,
		
			ParticleXOffset : 0,
			ParticleYOffset : 0,
			ParticleEffect : "sSmallHitspark",
			ParticleDuration : 5
		}
	],
	
	CounterData: [
		{ // everything that changes for this move on counter hit
			CounterHitLevel: 1,
		
			Group : 1,
		
			Damage : 12,
			MeterGain : 4,
			ComboScaling : 2,
			AttackHitStop : 6,
			AttackHitStun : 9,
			AttackType : eAttackType.MID,
			BlockStun : 3,
			KnockBack: 1,
			AirKnockbackVertical: 0,
			AirKnockbackHorizontal: 1,
		
			Launches: false,
			LaunchKnockbackVertical: 0,
			LaunchKnockbackHorizontal: 0,
			Pushback: 1,
		
			ParticleXOffset : 0,
			ParticleYOffset : 0,
			ParticleEffect : "sSmallHitspark",
			ParticleDuration : 5
		}
	],
}


global.p1PaletteID = 0;
global.p2PaletteID = 1;

global.p1SelectedCharacter = 0;
global.p2SelectedCharacter = 0;

global.gameMode = 0;

// Where to start in a single player level
global.p1StartingPositionX = 32;
global.p1StartingPositionY = 104;

// Where to put the player on the campaign map
global.campaignMapLocationX = 0;
global.campaignMapLocationY = 0;