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

global.RusselPalettes = {
	numOfPalettes : 10,
	// Key - Each entry in the following array is a color that needs to get replaced for alts. Each entry
	// contains the rgb values for its color. They go from lightest to darkest.
	baseColorMatch : [
	// Jacket Colors [0-3] Pants Colors [4-5] Shirt Colors [6-7] Hair Colors [8-10] Skin Colors [11-13] Eyes [14] Extra [15]
		[255,137,100],[255,56,62],[199,62,117],[92,43,52],  [19,86,159],[28,6,66],  [247,255,255],[178,197,213],  [122,62,51],[255,0,0],[30,16,28],  [0,255,0],[237,203,156],[171,124,80],  [0,255,255],  [255,0,255]
	],
	
	// Each entry in this array contains color data about what color to replace the above colors with
	colorReplaces : [
	// Default
		[255,137,100],[255,56,62],[199,62,117],[92,43,52],  [19,86,159],[28,6,66],  [247,255,255],[178,197,213],  [122,62,51],[92,43,52],[30,16,28],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Blue
		[37,128,184],[31,78,165],[32,35,117],[15,4,46],  [107,83,24],[64,32,8],  [247,255,255],[178,197,213],  [122,62,51],[92,43,52],[30,16,28],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Yellow
		[227,224,96],[237,171,56],[185,93,60],[86,62,41],  [111,37,28],[59,4,17],  [247,255,255],[178,197,213],  [122,62,51],[92,43,52],[30,16,28],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Green
		[88,214,100],[61,161,73],[24,84,31],[2,26,14],  [37,128,184],[32,35,117],  [247,255,255],[178,197,213],  [122,62,51],[92,43,52],[30,16,28],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Kyo
		[71,61,61],[26,22,22],[15,15,15],[15,3,3],  [0,35,81],[14,0,34],  [247,255,255],[178,197,213],  [69,18,28],[31,6,20],[3,9,10],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Ryu
		[247,255,255],[178,197,213],[91,105,135],[26,22,69],  [26,22,22],[15,3,3],  [247,255,255],[178,197,213],  [167,34,0],[126,2,18],[41,6,34],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Jazz Boy
		[245,154,198],[227,109,184],[186,74,199],[124,43,171],  [26,22,22],[15,3,3],  [92,209,255],[71,138,193],  [122,62,51],[92,43,52],[30,16,28],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Halloween
		[245,160,49],[230,116,30],[204,70,12],[171,34,7],  [135,41,204],[58,4,125],  [71,61,61],[26,22,22],  [69,18,28],[31,6,20],[3,9,10],  [92,43,52],[122,62,51],[30,16,28],  [247,255,255],  [255,0,255],
	// DIO
		[227,224,96],[237,171,56],[185,93,60],[86,62,41],  [237,171,56],[86,62,41],  [71,61,61],[26,22,22],  [237,171,56],[185,93,60],[86,62,41],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255],
	// Rock
		[255,137,100],[255,56,62],[199,62,117],[92,43,52],  [71,61,61],[26,22,22],  [71,61,61],[26,22,22],  [227,213,123],[196,163,63],[122,74,20],  [255,137,100],[237,203,156],[171,124,80],  [247,255,255],  [255,0,255]
	],
}

global.p1PaletteID = 0;
global.p2PaletteID = 1;

global.p1SelectedCharacter = 0;
global.p2SelectedCharacter = 0;

global.gameMode = 0;