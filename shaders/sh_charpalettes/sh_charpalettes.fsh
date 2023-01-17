//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float range;
// Each color to match has its own vec4
uniform vec4 colorMatch1;
uniform vec4 colorMatch2;
uniform vec4 colorMatch3;
uniform vec4 colorMatch4;
uniform vec4 colorMatch5;
uniform vec4 colorMatch6;
uniform vec4 colorMatch7;
uniform vec4 colorMatch8;
uniform vec4 colorMatch9;
uniform vec4 colorMatch10;
uniform vec4 colorMatch11;
uniform vec4 colorMatch12;
uniform vec4 colorMatch13;
uniform vec4 colorMatch14;
uniform vec4 colorMatch15;
uniform vec4 colorMatch16;
// Each color to replace also has its own vec4
uniform vec4 colorReplace1;
uniform vec4 colorReplace2;
uniform vec4 colorReplace3;
uniform vec4 colorReplace4;
uniform vec4 colorReplace5;
uniform vec4 colorReplace6;
uniform vec4 colorReplace7;
uniform vec4 colorReplace8;
uniform vec4 colorReplace9;
uniform vec4 colorReplace10;
uniform vec4 colorReplace11;
uniform vec4 colorReplace12;
uniform vec4 colorReplace13;
uniform vec4 colorReplace14;
uniform vec4 colorReplace15;
uniform vec4 colorReplace16;

void main()
{
    vec4 pixelColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	float newRange = range / 255.0;
	
	// Go through and replace each color
	if(abs(pixelColor.r - colorMatch1.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch1.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch1.b) <= newRange) {
				pixelColor.rgb = colorReplace1.rgb;
			}
		}
	}
	
	// 2
	if(abs(pixelColor.r - colorMatch2.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch2.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch2.b) <= newRange) {
				pixelColor.rgb = colorReplace2.rgb;
			}
		}
	}
	
	// 3
	if(abs(pixelColor.r - colorMatch3.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch3.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch3.b) <= newRange) {
				pixelColor.rgb = colorReplace3.rgb;
			}
		}
	}
	
	// 4
	if(abs(pixelColor.r - colorMatch4.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch4.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch4.b) <= newRange) {
				pixelColor.rgb = colorReplace4.rgb;
			}
		}
	}
	
	// 5
	if(abs(pixelColor.r - colorMatch5.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch5.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch5.b) <= newRange) {
				pixelColor.rgb = colorReplace5.rgb;
			}
		}
	}
	
	// 6
	if(abs(pixelColor.r - colorMatch6.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch6.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch6.b) <= newRange) {
				pixelColor.rgb = colorReplace6.rgb;
			}
		}
	}
	
	// 7
	if(abs(pixelColor.r - colorMatch7.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch7.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch7.b) <= newRange) {
				pixelColor.rgb = colorReplace7.rgb;
			}
		}
	}
	
	// 8
	if(abs(pixelColor.r - colorMatch8.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch8.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch8.b) <= newRange) {
				pixelColor.rgb = colorReplace8.rgb;
			}
		}
	}
	
	// 9
	if(abs(pixelColor.r - colorMatch9.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch9.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch9.b) <= newRange) {
				pixelColor.rgb = colorReplace9.rgb;
			}
		}
	}
	
	// 10
	if(abs(pixelColor.r - colorMatch10.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch10.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch10.b) <= newRange) {
				pixelColor.rgb = colorReplace10.rgb;
			}
		}
	}
	
	// 11
	if(abs(pixelColor.r - colorMatch11.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch11.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch11.b) <= newRange) {
				pixelColor.rgb = colorReplace11.rgb;
			}
		}
	}
	
	// 12
	if(abs(pixelColor.r - colorMatch12.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch12.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch12.b) <= newRange) {
				pixelColor.rgb = colorReplace12.rgb;
			}
		}
	}
	
	// 13
	if(abs(pixelColor.r - colorMatch13.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch13.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch13.b) <= newRange) {
				pixelColor.rgb = colorReplace13.rgb;
			}
		}
	}
	
	// 14
	if(abs(pixelColor.r - colorMatch14.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch14.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch14.b) <= newRange) {
				pixelColor.rgb = colorReplace14.rgb;
			}
		}
	}
	
	// 15
	if(abs(pixelColor.r - colorMatch15.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch15.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch15.b) <= newRange) {
				pixelColor.rgb = colorReplace15.rgb;
			}
		}
	}
	
	// 16
	if(abs(pixelColor.r - colorMatch16.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch16.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch16.b) <= newRange) {
				pixelColor.rgb = colorReplace16.rgb;
			}
		}
	}
	
	gl_FragColor = pixelColor;
}
