/// @description Insert description here
// You can write your code in this editor

// Russel Vars
global.stRusselMoves = {
	StandLight : {
		spriteID : sRussel_Standing_Light,
		numOfWindows : 4,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[1 , 0], [3, 1], [5, 2], [7, 3]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [3],
			lifetime : [4],
			attackWidth : [15],
			attackHeight : [5],
			widthOffset : [12],
			heightOfset : [15],
			group : [1],
			
			damage : [3],
			attackHitstop : [6],
			attackHitstun : [9],
			attackType : [eAttackType.MID],
			blockstun : [3],
			knockback: [2],
			airKnockbackV: [0],
			airKnockbackH: [1],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [2],
			
			particlexOffset : [0],
			particleyOffset : [0],
			particleEffect : [sSmallHitspark],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [3],
			lifetime : [6],
			attackWidth : [20],
			attackHeight : [6],
			widthOffset : [4],
			heightOfset : [12]
		}
		
	},
	
	StandLight2 : {
		spriteID : sRussel_Standing_Light2,
		numOfWindows : 4,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[0 , 0], [2, 1], [6, 2], [12, 3]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [2],
			lifetime : [4],
			attackWidth : [25],
			attackHeight : [8],
			widthOffset : [12],
			heightOfset : [15],
			group : [1],
			
			damage : [3],
			attackHitstop : [10],
			attackHitstun : [14],
			attackType : [eAttackType.MID],
			blockstun : [9],
			knockback: [2],
			airKnockbackV: [0],
			airKnockbackH: [1],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [2],
			
			particlexOffset : [3],
			particleyOffset : [0],
			particleEffect : [sSmallHitspark],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [2],
			lifetime : [8],
			attackWidth : [28],
			attackHeight : [10],
			widthOffset : [4],
			heightOfset : [12]
		}
		
	},
	
	StandLight3 : {
		spriteID : sRussel_Standing_Light3,
		numOfWindows : 4,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[3 , 1], [6, 2], [9, 3], [18, 4]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [6],
			lifetime : [3],
			attackWidth : [27],
			attackHeight : [8],
			widthOffset : [12],
			heightOfset : [15],
			group : [1],
			
			damage : [3],
			attackHitstop : [14],
			attackHitstun : [14],
			attackType : [eAttackType.MID],
			blockstun : [9],
			knockback: [0],
			airKnockbackV: [0],
			airKnockbackH: [1],
			
			launches: [true],
			LaunchKnockbackV: [-3],
			LaunchKnockbackH: [.1],
			pushback: [2],
			
			particlexOffset : [10],
			particleyOffset : [0],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [6],
			lifetime : [8],
			attackWidth : [10],
			attackHeight : [35],
			widthOffset : [4],
			heightOfset : [0]
		}
		
	},
	
	StandMedium : {
		spriteID : sRussel_Standing_Medium,
		numOfWindows : 6,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[2 , 1], [5, 2], [9, 3], [12, 4], [15, 5], [18, 6]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [5],
			lifetime : [4],
			attackWidth : [20],
			attackHeight : [8],
			widthOffset : [10],
			heightOfset : [12],
			group : [1],
			
			damage: [10],
			attackHitstop : [11],
			attackHitstun : [21],
			attackType : [eAttackType.MID],
			blockstun : [16],
			knockback: [4],
			airKnockbackV: [-2],
			airKnockbackH: [2],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [2],
			
			particlexOffset : [10],
			particleyOffset : [0],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [5],
			lifetime : [13],
			attackWidth : [22],
			attackHeight : [6],
			widthOffset : [4],
			heightOfset : [12]
		}
		
	},
	
	StandHeavy : {
		spriteID : sRussel_Standing_Heavy,
		numOfWindows : 7,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[2 , 1], [6, 2], [12, 3], [15, 4], [18, 5], [25, 6], [33, 7]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [12],
			lifetime : [5],
			attackWidth : [23],
			attackHeight : [20],
			widthOffset : [-1],
			heightOfset : [0],
			group : [1],
			
			damage: [20],
			attackHitstop : [18], // 15
			attackHitstun : [14],
			attackType : [eAttackType.MID],
			blockstun : [20],
			knockback: [5],
			airKnockbackV: [-2],
			airKnockbackH: [3],
			
			launches: [true],
			LaunchKnockbackV: [-1],
			LaunchKnockbackH: [3],
			pushback: [3],
			
			particlexOffset : [18],
			particleyOffset : [10],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [12],
			lifetime : [19],
			attackWidth : [22],
			attackHeight : [16],
			widthOffset : [-1],
			heightOfset : [0]
		}
		
	},
		
	CrouchingLight : {
		spriteID : sRussel_Crouching_Light,
		numOfWindows : 3,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[4 , 1], [6, 2], [8, 3]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [4],
			lifetime : [2],
			attackWidth : [20],
			attackHeight : [5],
			widthOffset : [8],
			heightOfset : [0],
			group : [1],
			
			damage : [4],
			attackHitstop : [6],
			attackHitstun : [11],
			attackType : [eAttackType.LOW],
			blockstun : [6],
			knockback: [2],
			airKnockbackV: [-2],
			airKnockbackH: [1],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [1],
			
			particlexOffset : [5],
			particleyOffset : [0],
			particleEffect : [sSmallHitspark],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [4],
			lifetime : [4],
			attackWidth : [25],
			attackHeight : [10],
			widthOffset : [4],
			heightOfset : [0]
		}
		
	},
	
	CrouchingMedium : {
		spriteID : sRussel_Crouching_Medium,
		numOfWindows : 10,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[3 , 1], [5, 2], [7, 3], [9, 4], [10, 5], [11, 6], [14, 7], [17, 8], [21, 9], [24, 10]],
		
		numOfHitboxes : 2,
		
		attackProperty : {
			start : [7, 9],
			lifetime : [2, 2],
			attackWidth : [13, 15],
			attackHeight : [10, 24],
			widthOffset : [9, 6],
			heightOfset : [10, 18],
			group : [1, 1],
			
			damage: [10, 10],
			attackHitstop : [11, 11],
			attackHitstun : [18, 18],
			attackType : [eAttackType.MID, eAttackType.MID],
			blockstun : [12, 12],
			knockback: [4, 4],
			airKnockbackV: [-2.5, -2.5],
			airKnockbackH: [.75, .75],
			
			launches: [true, false],
			LaunchKnockbackV: [-4, 0],
			LaunchKnockbackH: [.5, 0],
			pushback: [2, 2],
			
			particlexOffset : [10,10],
			particleyOffset : [0, 0],
			particleEffect : [sHitEffect, sHitEffect],
			particleDuration : [5, 5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [5],
			lifetime : [13],
			attackWidth : [15],
			attackHeight : [20],
			widthOffset : [4],
			heightOfset : [0]
		}
		
	},
		
	CrouchingHeavy : {
		spriteID : sRussel_Crouching_Heavy,
		numOfWindows : 10,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[5 , 1], [9, 2], [10, 3], [12 , 4], [16 , 5], [20 , 6], [24 , 7], [26 , 8], [28 , 9], [32 , 10]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [9],
			lifetime : [2],
			attackWidth : [30],
			attackHeight : [5],
			widthOffset : [8],
			heightOfset : [0],
			group : [1],
			
			damage : [10],
			attackHitstop : [14],
			attackHitstun : [11],
			attackType : [eAttackType.LOW],
			blockstun : [8],
			knockback: [2],
			airKnockbackV: [-2],
			airKnockbackH: [1],
			
			launches: [true],
			LaunchKnockbackV: [-1],
			LaunchKnockbackH: [1],
			pushback: [4],
			
			particlexOffset : [20],
			particleyOffset : [10],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 2,
		
		hurtboxProperty : {
			start : [9, 12],
			lifetime : [3, 4],
			attackWidth : [40, 20],
			attackHeight : [15, 15],
			widthOffset : [-1, -1],
			heightOfset : [0, 0]
		}
		
	},
	
	JumpingLight : {
		spriteID : sRussel_Jumping_Light,
		numOfWindows : 2,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[4 , 1], [8, 2]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [6],
			lifetime : [20],
			attackWidth : [12],
			attackHeight : [10],
			widthOffset : [6],
			heightOfset : [3],
			group : [1],
			
			damage : [5],
			attackHitstop : [6],
			attackHitstun : [7],
			attackType : [eAttackType.HIGH],
			blockstun : [3],
			knockback: [2],
			airKnockbackV: [0],
			airKnockbackH: [1],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [1],
			
			particlexOffset : [0],
			particleyOffset : [0],
			particleEffect : [sSmallHitspark],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [3],
			lifetime : [20],
			attackWidth : [36],
			attackHeight : [20],
			widthOffset : [-18],
			heightOfset : [6]
		}
		
	},
	
	JumpingMedium : {
		spriteID : sRussel_Jumping_Medium,
		numOfWindows : 6,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[4 , 1], [8, 2], [12, 3], [15, 4], [18, 5], [21, 6]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [8],
			lifetime : [6],
			attackWidth : [32],
			attackHeight : [12],
			widthOffset : [-6],
			heightOfset : [2],
			group : [1],
			
			damage: [8],
			attackHitstop : [8],
			attackHitstun : [10],
			attackType : [eAttackType.HIGH],
			blockstun : [6],
			knockback: [4],
			airKnockbackV: [-2],
			airKnockbackH: [2],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [2],
			
			particlexOffset : [10],
			particleyOffset : [0],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [8],
			lifetime : [13],
			attackWidth : [34],
			attackHeight : [15],
			widthOffset : [-6],
			heightOfset : [2]
		}
		
	},
	
	JumpingHeavy : {
		spriteID : sRussel_Jumping_Heavy,
		numOfWindows : 6,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[6 , 1], [10, 2], [12, 3], [14, 4], [18 , 5], [22 , 6]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [12],
			lifetime : [3],
			attackWidth : [15],
			attackHeight : [10],
			widthOffset : [0],
			heightOfset : [-10],
			group : [1],
			
			damage: [12],
			attackHitstop : [11],
			attackHitstun : [14],
			attackType : [eAttackType.HIGH],
			blockstun : [3],
			knockback: [4],
			airKnockbackV: [2],
			airKnockbackH: [1],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [2],
			
			particlexOffset : [10],
			particleyOffset : [0],
			particleEffect : [sHitEffect],
			particleDuration : [5]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [12],
			lifetime : [20],
			attackWidth : [20],
			attackHeight : [25],
			widthOffset : [-6],
			heightOfset : [-10]
		}
		
	},
	
	Grab : {
		spriteID : sRussel_Grab,
		numOfWindows : 5,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[4 , 1], [8, 2], [12, 3], [16, 4], [20 , 5]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [5],
			lifetime : [2],
			attackWidth : [17],
			attackHeight : [20],
			widthOffset : [0],
			heightOfset : [0],
			group : [1],
			
			damage: [0],
			attackHitstop : [0],
			attackHitstun : [0],
			attackType : [eAttackType.GRAB],
			blockstun : [0],
			knockback: [0],
			airKnockbackV: [0],
			airKnockbackH: [0],
			
			launches: [false],
			LaunchKnockbackV: [0],
			LaunchKnockbackH: [0],
			pushback: [0],
			
			particlexOffset : [10],
			particleyOffset : [0],
			particleEffect : [sHitEffect],
			particleDuration : [5],
			
			holdXOffset : [20],
			holdYOffset : [0]
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [4],
			lifetime : [20],
			attackWidth : [20],
			attackHeight : [25],
			widthOffset : [-6],
			heightOfset : [0]
		}
		
	},
	
	ForwardThrow : {
		spriteID : sRussel_ForwardThrow,
		numOfWindows : 9,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[5 , 1], [10, 2], [14, 3], [18, 4], [24 , 5], [34 , 6], [36 , 7], [38, 8], [40, 9]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [14],
			lifetime : [5],
			attackWidth : [35],
			attackHeight : [20],
			widthOffset : [0],
			heightOfset : [0],
			group : [2],
			
			damage: [10],
			attackHitstop : [16],
			attackHitstun : [10],
			attackType : [eAttackType.MID],
			blockstun : [5],
			knockback: [3],
			airKnockbackV: [0],
			airKnockbackH: [0],
			
			launches: [true],
			LaunchKnockbackV: [2],
			LaunchKnockbackH: [4],
			pushback: [0],
			
			particlexOffset : [20],
			particleyOffset : [10],
			particleEffect : [sHitEffect],
			particleDuration : [5],
			
			holdXOffset : [0],
			holdYOffset : [0]
		},
		
		isThrow : true,
		
		opponentPositionData : {
			numOfWindows : 2,
			//Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
			window : [[0, 20, 0, eSpritesToUse.HURT_SPRITE, 0, 0, -1], [13, 30, 0, eSpritesToUse.HURT_SPRITE, 0, 0, -1]],
			
			// This variable determines how far away the player should be from a wall if they are too close.
			distanceFromWall : 50,
		},
		
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [4],
			lifetime : [1],
			attackWidth : [20],
			attackHeight : [25],
			widthOffset : [-6],
			heightOfset : [0]
		}
		
	},
	
	BackwardThrow : {
		spriteID : sRussel_BackwardThrow,
		numOfWindows : 10,
		
		//        [window# [ Length, image_index ], ... ]
		window : [[4 , 1], [7, 2], [13, 3], [22, 4], [25 , 5], [28, 6], [31, 7], [43, 8], [49, 9], [55, 10]],
		
		numOfHitboxes : 1,
		
		attackProperty : {
			start : [28],
			lifetime : [5],
			attackWidth : [10],
			attackHeight : [20],
			widthOffset : [-50],
			heightOfset : [0],
			group : [2],
			
			damage: [10],
			attackHitstop : [16],
			attackHitstun : [10],
			attackType : [eAttackType.MID],
			blockstun : [5],
			knockback: [3],
			airKnockbackV: [0],
			airKnockbackH: [0],
			
			launches: [true],
			LaunchKnockbackV: [-4],
			LaunchKnockbackH: [-.2],
			pushback: [0],
			
			particlexOffset : [20],
			particleyOffset : [10],
			particleEffect : [sHitEffect],
			particleDuration : [5],
			
			holdXOffset : [0],
			holdYOffset : [0]
		},
		
		isThrow : true,
		
		opponentPositionData : {
			numOfWindows : 5,
			//Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
			window : [[0, 20, 0, eSpritesToUse.HURT_SPRITE, 0, 0, -1], [7, 20, 1, eSpritesToUse.HURT_SPRITE, 0, 0, -1], [13, 20, 2, eSpritesToUse.HURT_SPRITE, 0, 0, -1], [22, 10, -40, eSpritesToUse.HURT_SPRITE, 0, 90, -1], [25, -50, -2, eSpritesToUse.KNOCKDOWN_SPRITE, 5, 0, -1]],
			
			// This variable determines how far away the player should be from a wall if they are too close.
			distanceFromWall : -70,
		},
		
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [4],
			lifetime : [1],
			attackWidth : [20],
			attackHeight : [25],
			widthOffset : [-6],
			heightOfset : [0]
		}
		
	},
	
	NeutralSpecial : {
		spriteID : sRussel_NSpecial,
		numOfWindows : 25,
		
		//        [window# [ Starting Frame, image_index ], ... ]
		window : [[2 , 1], [4, 2], [6, 3], [10, 4], [11, 5], [12, 6], [13, 7], [14, 8], [15, 9], [16, 10], [17, 11], [18, 12], [19, 13], [20, 14], [21, 15], [22, 16], [23, 17], [24, 18], [25, 19], [26, 20], [27, 21], [28, 22], [31, 23], [36, 24], [40, 25]],
		
		numOfHitboxes : 2,
		
		attackProperty : {
			start : [10, 31],
			lifetime : [1, 4],
			attackWidth : [30, 30],
			attackHeight : [20, 20],
			widthOffset : [10, 10],
			heightOfset : [2, 2],
			group : [1, 2],
			
			damage: [1, 3],
			attackHitstop : [2, 12],
			attackHitstun : [8, 19],
			attackType : [eAttackType.MID, eAttackType.MID],
			blockstun : [4, 10],
			knockback: [1, 4],
			airKnockbackV: [-.5, -1],
			airKnockbackH: [.5, 2],
			
			launches: [false, false],
			LaunchKnockbackV: [0, 0],
			LaunchKnockbackH: [0, 0],
			pushback: [0, 3],
			
			particlexOffset : [20, 20],
			particleyOffset : [10, 10],
			particleEffect : [sHitEffect,sHitEffect],
			particleDuration : [5,5]
		},
		
		rehitData : {
			hitbox : 1, // The hitbox to be repeated
			numOfHits : 8, // How many times should that hitbox activate
			frames : [12, 14, 16, 18, 20, 22, 24, 26],
		},
		
		isThrow : false,
		
		numOfHurtboxes : 1,
		
		hurtboxProperty : {
			start : [10],
			lifetime : [16],
			attackWidth : [30],
			attackHeight : [30],
			widthOffset : [6],
			heightOfset : [2]
		}
		
	},
	
	SideSpecial : {
		spriteID : sRussel_SideSpecial,
		numOfWindows : 11,
		
		//        [window# [ Starting Frame, image_index ], ... ]
		window : [[4, 1], [8, 2], [10, 3], [12, 4], [14, 5], [20, 6], [21, 7], [22, 8], [24, 9], [26, 10], [30, 11]],
		
		numOfHitboxes : 2,
		
		attackProperty : {
			start : [8, 22],
			lifetime : [4, 4],
			attackWidth : [40, 40],
			attackHeight : [20, 20],
			widthOffset : [0, 0],
			heightOfset : [2, 2],
			group : [1, 2],
			
			damage: [7, 7],
			attackHitstop : [9, 16],
			attackHitstun : [24, 15],
			attackType : [eAttackType.MID, eAttackType.MID],
			blockstun : [16, 10],
			knockback: [6, 6],
			airKnockbackV: [-.5, 0],
			airKnockbackH: [2, 4],
			
			launches: [true, false],
			LaunchKnockbackV: [-1.5, 0],
			LaunchKnockbackH: [2, 0],
			pushback: [0, 3],
			
			particlexOffset : [20, 20],
			particleyOffset : [10, 10],
			particleEffect : [sHitEffect,sHitEffect],
			particleDuration : [5,5]
		},
		
		
		isThrow : false,
		
		numOfHurtboxes : 2,
		
		hurtboxProperty : {
			start : [8, 22],
			lifetime : [5, 6],
			attackWidth : [30, 30],
			attackHeight : [20, 20],
			widthOffset : [0, 0],
			heightOfset : [2, 2]
		}
		
	},
};

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
