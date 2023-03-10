/// @description Insert description here
// You can write your code in this editor

if P1charSelCol == P2charSelCol && P1charSelRow == P2charSelRow {
	draw_sprite(sCharSel_SelectionBox, 2 + (charSelBoxAlt * P1hasSelectedChar), 44 + (23 * P1charSelCol), 63 + (19 * P1charSelRow));
} else {
	draw_sprite(sCharSel_SelectionBox, 0 + (charSelBoxAlt * P1hasSelectedChar), 44 + (23 * P1charSelCol), 63 + (19 * P1charSelRow));
	draw_sprite(sCharSel_SelectionBox, 4 + (charSelBoxAlt * P2hasSelectedChar), 44 + (23 * P2charSelCol), 63 + (19 * P2charSelRow));
}



//Draw Player 1 character
PaletteSetup(global.p1PaletteID, p1LocalPalette);
	
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

if P1charSelCol == 0 && P1charSelRow == 0 draw_sprite(sRussel_Idle, 0 + P1charSelCurrentFrame, 29, 65);
if P1charSelCol == 1 && P1charSelRow == 0 draw_sprite(sBeverly_Idle, 0 + P1charSelCurrentFrame, 29, 65);
shader_reset();
	
if P1charSelCol == 0 && P1charSelRow == 0 draw_sprite(sCharSel_NameRussel, 0, 14, 69);
if P1charSelCol == 1 && P1charSelRow == 0 draw_sprite(sCharSel_NameBeverly, 0, 14, 69);



//Draw Player 2 character
PaletteSetup(global.p2PaletteID, global.RusselPalettes);
	
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
	
if P2charSelCol == 0 && P2charSelRow == 0 draw_sprite_ext(sRussel_Idle, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
if P2charSelCol == 1 && P2charSelRow == 0 draw_sprite_ext(sBeverly_Idle, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
shader_reset();
	
if P2charSelCol == 0 && P2charSelRow == 0 draw_sprite(sCharSel_NameRussel, 0, 118, 69);
if P2charSelCol == 1 && P2charSelRow == 0 draw_sprite(sCharSel_NameBeverly, 0, 118, 69);




if P1hasSelectedChar {
	if !P1hasSelectedAlt draw_sprite(sCharSel_PaletteSel, 0, 12, 47);
	else draw_sprite(sCharSel_CharReady, 0, 15, 46);
}
if P2hasSelectedChar {
	if !P2hasSelectedAlt draw_sprite(sCharSel_PaletteSel, 0, 116, 47);
	else draw_sprite(sCharSel_CharReady, 0, 119, 46);
}


if P1hasSelectedAlt && P2hasSelectedAlt {
	draw_sprite(sCharSel_ReadyToFight, RTF_currentFrame, 0, 0);
}

var pressStartID = layer_background_get_id("PressStart");
if RTF_currentFrame == 4 layer_background_visible(pressStartID, 1);
else layer_background_visible(pressStartID, 0);