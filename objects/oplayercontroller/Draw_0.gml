/// @description Insert description here
// You can write your code in this editor

var tempDepth = depth;
depth = -2;
draw_sprite(sShadow, 0, x, 104);

depth = tempDepth;


shader_set(sh_CharPalettes);

shader_set_uniform_f(sh_handle_range, 1);

// Set up color Matches
#region
shader_set_uniform_f(sh_handle_match1,
	colorMatch1.toShaderValue(colorMatch1.red),
	colorMatch1.toShaderValue(colorMatch1.green),
	colorMatch1.toShaderValue(colorMatch1.blue),
	
);
shader_set_uniform_f(sh_handle_match2,
	colorMatch2.toShaderValue(colorMatch2.red),
	colorMatch2.toShaderValue(colorMatch2.green),
	colorMatch2.toShaderValue(colorMatch2.blue),
	
);
shader_set_uniform_f(sh_handle_match3,
	colorMatch3.toShaderValue(colorMatch3.red),
	colorMatch3.toShaderValue(colorMatch3.green),
	colorMatch3.toShaderValue(colorMatch3.blue),
	
);
shader_set_uniform_f(sh_handle_match4,
	colorMatch4.toShaderValue(colorMatch4.red),
	colorMatch4.toShaderValue(colorMatch4.green),
	colorMatch4.toShaderValue(colorMatch4.blue),
	
);
shader_set_uniform_f(sh_handle_match5,
	colorMatch5.toShaderValue(colorMatch5.red),
	colorMatch5.toShaderValue(colorMatch5.green),
	colorMatch5.toShaderValue(colorMatch5.blue),
	
);
shader_set_uniform_f(sh_handle_match6,
	colorMatch6.toShaderValue(colorMatch6.red),
	colorMatch6.toShaderValue(colorMatch6.green),
	colorMatch6.toShaderValue(colorMatch6.blue),
	
);
shader_set_uniform_f(sh_handle_match7,
	colorMatch7.toShaderValue(colorMatch7.red),
	colorMatch7.toShaderValue(colorMatch7.green),
	colorMatch7.toShaderValue(colorMatch7.blue),
	
);
shader_set_uniform_f(sh_handle_match8,
	colorMatch8.toShaderValue(colorMatch8.red),
	colorMatch8.toShaderValue(colorMatch8.green),
	colorMatch8.toShaderValue(colorMatch8.blue),
	
);
shader_set_uniform_f(sh_handle_match9,
	colorMatch9.toShaderValue(colorMatch9.red),
	colorMatch9.toShaderValue(colorMatch9.green),
	colorMatch9.toShaderValue(colorMatch9.blue),
	
);
shader_set_uniform_f(sh_handle_match10,
	colorMatch10.toShaderValue(colorMatch10.red),
	colorMatch10.toShaderValue(colorMatch10.green),
	colorMatch10.toShaderValue(colorMatch10.blue),
	
);
shader_set_uniform_f(sh_handle_match11,
	colorMatch11.toShaderValue(colorMatch11.red),
	colorMatch11.toShaderValue(colorMatch11.green),
	colorMatch11.toShaderValue(colorMatch11.blue),
	
);
shader_set_uniform_f(sh_handle_match12,
	colorMatch12.toShaderValue(colorMatch12.red),
	colorMatch12.toShaderValue(colorMatch12.green),
	colorMatch12.toShaderValue(colorMatch12.blue),
	
);
shader_set_uniform_f(sh_handle_match13,
	colorMatch13.toShaderValue(colorMatch13.red),
	colorMatch13.toShaderValue(colorMatch13.green),
	colorMatch13.toShaderValue(colorMatch13.blue),
	
);
shader_set_uniform_f(sh_handle_match14,
	colorMatch14.toShaderValue(colorMatch14.red),
	colorMatch14.toShaderValue(colorMatch14.green),
	colorMatch14.toShaderValue(colorMatch14.blue),
	
);
shader_set_uniform_f(sh_handle_match15,
	colorMatch15.toShaderValue(colorMatch15.red),
	colorMatch15.toShaderValue(colorMatch15.green),
	colorMatch15.toShaderValue(colorMatch15.blue),
	
);
shader_set_uniform_f(sh_handle_match16,
	colorMatch16.toShaderValue(colorMatch16.red),
	colorMatch16.toShaderValue(colorMatch16.green),
	colorMatch16.toShaderValue(colorMatch16.blue),
	
);
#endregion

// Set up color Replaces
#region
shader_set_uniform_f(sh_handle_replace1,
	colorReplace1.toShaderValue(colorReplace1.red),
	colorReplace1.toShaderValue(colorReplace1.green),
	colorReplace1.toShaderValue(colorReplace1.blue),
	
);
shader_set_uniform_f(sh_handle_replace2,
	colorReplace2.toShaderValue(colorReplace2.red),
	colorReplace2.toShaderValue(colorReplace2.green),
	colorReplace2.toShaderValue(colorReplace2.blue),
	
);
shader_set_uniform_f(sh_handle_replace3,
	colorReplace3.toShaderValue(colorReplace3.red),
	colorReplace3.toShaderValue(colorReplace3.green),
	colorReplace3.toShaderValue(colorReplace3.blue),
	
);
shader_set_uniform_f(sh_handle_replace4,
	colorReplace4.toShaderValue(colorReplace4.red),
	colorReplace4.toShaderValue(colorReplace4.green),
	colorReplace4.toShaderValue(colorReplace4.blue),
	
);
shader_set_uniform_f(sh_handle_replace5,
	colorReplace5.toShaderValue(colorReplace5.red),
	colorReplace5.toShaderValue(colorReplace5.green),
	colorReplace5.toShaderValue(colorReplace5.blue),
	
);
shader_set_uniform_f(sh_handle_replace6,
	colorReplace6.toShaderValue(colorReplace6.red),
	colorReplace6.toShaderValue(colorReplace6.green),
	colorReplace6.toShaderValue(colorReplace6.blue),
	
);
shader_set_uniform_f(sh_handle_replace7,
	colorReplace7.toShaderValue(colorReplace7.red),
	colorReplace7.toShaderValue(colorReplace7.green),
	colorReplace7.toShaderValue(colorReplace7.blue),
	
);
shader_set_uniform_f(sh_handle_replace8,
	colorReplace8.toShaderValue(colorReplace8.red),
	colorReplace8.toShaderValue(colorReplace8.green),
	colorReplace8.toShaderValue(colorReplace8.blue),
	
);
shader_set_uniform_f(sh_handle_replace9,
	colorReplace9.toShaderValue(colorReplace9.red),
	colorReplace9.toShaderValue(colorReplace9.green),
	colorReplace9.toShaderValue(colorReplace9.blue),
	
);
shader_set_uniform_f(sh_handle_replace10,
	colorReplace10.toShaderValue(colorReplace10.red),
	colorReplace10.toShaderValue(colorReplace10.green),
	colorReplace10.toShaderValue(colorReplace10.blue),
	
);
shader_set_uniform_f(sh_handle_replace11,
	colorReplace11.toShaderValue(colorReplace11.red),
	colorReplace11.toShaderValue(colorReplace11.green),
	colorReplace11.toShaderValue(colorReplace11.blue),
	
);
shader_set_uniform_f(sh_handle_replace12,
	colorReplace12.toShaderValue(colorReplace12.red),
	colorReplace12.toShaderValue(colorReplace12.green),
	colorReplace12.toShaderValue(colorReplace12.blue),
	
);
shader_set_uniform_f(sh_handle_replace13,
	colorReplace13.toShaderValue(colorReplace13.red),
	colorReplace13.toShaderValue(colorReplace13.green),
	colorReplace13.toShaderValue(colorReplace13.blue),
	
);
shader_set_uniform_f(sh_handle_replace14,
	colorReplace14.toShaderValue(colorReplace14.red),
	colorReplace14.toShaderValue(colorReplace14.green),
	colorReplace14.toShaderValue(colorReplace14.blue),
	
);
shader_set_uniform_f(sh_handle_replace15,
	colorReplace15.toShaderValue(colorReplace15.red),
	colorReplace15.toShaderValue(colorReplace15.green),
	colorReplace15.toShaderValue(colorReplace15.blue),
	
);
shader_set_uniform_f(sh_handle_replace16,
	colorReplace16.toShaderValue(colorReplace16.red),
	colorReplace16.toShaderValue(colorReplace16.green),
	colorReplace16.toShaderValue(colorReplace16.blue),
	
);
#endregion

draw_self();

shader_reset();