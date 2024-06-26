/// @description Insert description here
// You can write your code in this editor
var pressStartID = layer_background_get_id("PressStart");

if (state == eCharacterSelectState.CHARACTER_SELECT)
{
	// Hide specific background layers
	layer_background_visible(pressStartID, 0);

    if (P1charSelCol == P2charSelCol && P1charSelRow == P2charSelRow)
    {
        draw_sprite(sCharSel_SelectionBox, 2 + (charSelBoxAlt * P1hasSelectedChar), 44 + (23 * P1charSelCol), 63 + (19 * P1charSelRow));
    }
    else
    {
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
        colorMatch1.red,
        colorMatch1.green,
        colorMatch1.blue,
    

    );
    shader_set_uniform_f(sh_handle_match2,
        colorMatch2.red,
        colorMatch2.green,
        colorMatch2.blue,
    

    );
    shader_set_uniform_f(sh_handle_match3,
        colorMatch3.red,
        colorMatch3.green,
        colorMatch3.blue,
    

    );
    shader_set_uniform_f(sh_handle_match4,
        colorMatch4.red,
        colorMatch4.green,
        colorMatch4.blue,
    

    );
    shader_set_uniform_f(sh_handle_match5,
        colorMatch5.red,
        colorMatch5.green,
        colorMatch5.blue,
    

    );
    shader_set_uniform_f(sh_handle_match6,
        colorMatch6.red,
        colorMatch6.green,
        colorMatch6.blue,
    

    );
    shader_set_uniform_f(sh_handle_match7,
        colorMatch7.red,
        colorMatch7.green,
        colorMatch7.blue,
    

    );
    shader_set_uniform_f(sh_handle_match8,
        colorMatch8.red,
        colorMatch8.green,
        colorMatch8.blue,
    

    );
    shader_set_uniform_f(sh_handle_match9,
        colorMatch9.red,
        colorMatch9.green,
        colorMatch9.blue,
    

    );
    shader_set_uniform_f(sh_handle_match10,
        colorMatch10.red,
        colorMatch10.green,
        colorMatch10.blue,
    

    );
    shader_set_uniform_f(sh_handle_match11,
        colorMatch11.red,
        colorMatch11.green,
        colorMatch11.blue,
    

    );
    shader_set_uniform_f(sh_handle_match12,
        colorMatch12.red,
        colorMatch12.green,
        colorMatch12.blue,
    

    );
    shader_set_uniform_f(sh_handle_match13,
        colorMatch13.red,
        colorMatch13.green,
        colorMatch13.blue,
    

    );
    shader_set_uniform_f(sh_handle_match14,
        colorMatch14.red,
        colorMatch14.green,
        colorMatch14.blue,
    

    );
    shader_set_uniform_f(sh_handle_match15,
        colorMatch15.red,
        colorMatch15.green,
        colorMatch15.blue,
    

    );
    shader_set_uniform_f(sh_handle_match16,
        colorMatch16.red,
        colorMatch16.green,
        colorMatch16.blue,
    

    );
    #endregion

    // Set up color Replaces
    #region
    shader_set_uniform_f(sh_handle_replace1,
        colorReplace1.red,
        colorReplace1.green,
        colorReplace1.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace2,
        colorReplace2.red,
        colorReplace2.green,
        colorReplace2.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace3,
        colorReplace3.red,
        colorReplace3.green,
        colorReplace3.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace4,
        colorReplace4.red,
        colorReplace4.green,
        colorReplace4.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace5,
        colorReplace5.red,
        colorReplace5.green,
        colorReplace5.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace6,
        colorReplace6.red,
        colorReplace6.green,
        colorReplace6.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace7,
        colorReplace7.red,
        colorReplace7.green,
        colorReplace7.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace8,
        colorReplace8.red,
        colorReplace8.green,
        colorReplace8.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace9,
        colorReplace9.red,
        colorReplace9.green,
        colorReplace9.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace10,
        colorReplace10.red,
        colorReplace10.green,
        colorReplace10.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace11,
        colorReplace11.red,
        colorReplace11.green,
        colorReplace11.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace12,
        colorReplace12.red,
        colorReplace12.green,
        colorReplace12.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace13,
        colorReplace13.red,
        colorReplace13.green,
        colorReplace13.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace14,
        colorReplace14.red,
        colorReplace14.green,
        colorReplace14.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace15,
        colorReplace15.red,
        colorReplace15.green,
        colorReplace15.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace16,
        colorReplace16.red,
        colorReplace16.green,
        colorReplace16.blue,
    

    );
    #endregion

    if (P1charSelCol == 0 && P1charSelRow == 0)
    {
        draw_sprite(sRussel_Idle, 0 + P1charSelCurrentFrame, 29, 65);
    }
    else if (P1charSelCol == 1 && P1charSelRow == 0)
    {
        draw_sprite(sBeverly_Idle, 0 + P1charSelCurrentFrame, 29, 65);
    }
    else if (P1charSelCol == 2 && P1charSelRow == 0)
    {
        draw_sprite(sJay_Idle, 0 + P1charSelCurrentFrame, 29, 65);
    }
	else if (P1charSelCol == 0 && P1charSelRow == 1)
    {
        draw_sprite(sGunther_Idle_mockup_strip1, 0 + P1charSelCurrentFrame, 29, 65);
    }
    shader_reset();

    if (P1charSelCol == 0 && P1charSelRow == 0)
    {
        draw_sprite(sCharSel_NameRussel, 0, 14, 69);
    }
    else if (P1charSelCol == 1 && P1charSelRow == 0)
    {
        draw_sprite(sCharSel_NameBeverly, 0, 14, 69);
    }
    else if (P1charSelCol == 2 && P1charSelRow == 0)
    {
        draw_sprite(sCharSel_NameJay, 0, 14, 69);
    }
	else if (P1charSelCol == 0 && P1charSelRow == 1)
    {
        draw_sprite(sCharSel_NameGunther, 0, 14, 69);
    }


    //Draw Player 2 character
    PaletteSetup(global.p2PaletteID, p2LocalPalette);

    shader_set(sh_CharPalettes);

    shader_set_uniform_f(sh_handle_range, 1);

    // Set up color Matches
    #region
    shader_set_uniform_f(sh_handle_match1,
        colorMatch1.red,
        colorMatch1.green,
        colorMatch1.blue,
    

    );
    shader_set_uniform_f(sh_handle_match2,
        colorMatch2.red,
        colorMatch2.green,
        colorMatch2.blue,
    

    );
    shader_set_uniform_f(sh_handle_match3,
        colorMatch3.red,
        colorMatch3.green,
        colorMatch3.blue,
    

    );
    shader_set_uniform_f(sh_handle_match4,
        colorMatch4.red,
        colorMatch4.green,
        colorMatch4.blue,
    

    );
    shader_set_uniform_f(sh_handle_match5,
        colorMatch5.red,
        colorMatch5.green,
        colorMatch5.blue,
    

    );
    shader_set_uniform_f(sh_handle_match6,
        colorMatch6.red,
        colorMatch6.green,
        colorMatch6.blue,
    

    );
    shader_set_uniform_f(sh_handle_match7,
        colorMatch7.red,
        colorMatch7.green,
        colorMatch7.blue,
    

    );
    shader_set_uniform_f(sh_handle_match8,
        colorMatch8.red,
        colorMatch8.green,
        colorMatch8.blue,
    

    );
    shader_set_uniform_f(sh_handle_match9,
        colorMatch9.red,
        colorMatch9.green,
        colorMatch9.blue,
    

    );
    shader_set_uniform_f(sh_handle_match10,
        colorMatch10.red,
        colorMatch10.green,
        colorMatch10.blue,
    

    );
    shader_set_uniform_f(sh_handle_match11,
        colorMatch11.red,
        colorMatch11.green,
        colorMatch11.blue,
    

    );
    shader_set_uniform_f(sh_handle_match12,
        colorMatch12.red,
        colorMatch12.green,
        colorMatch12.blue,
    

    );
    shader_set_uniform_f(sh_handle_match13,
        colorMatch13.red,
        colorMatch13.green,
        colorMatch13.blue,
    

    );
    shader_set_uniform_f(sh_handle_match14,
        colorMatch14.red,
        colorMatch14.green,
        colorMatch14.blue,
    

    );
    shader_set_uniform_f(sh_handle_match15,
        colorMatch15.red,
        colorMatch15.green,
        colorMatch15.blue,
    

    );
    shader_set_uniform_f(sh_handle_match16,
        colorMatch16.red,
        colorMatch16.green,
        colorMatch16.blue,
    

    );
    #endregion

    // Set up color Replaces
    #region
    shader_set_uniform_f(sh_handle_replace1,
        colorReplace1.red,
        colorReplace1.green,
        colorReplace1.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace2,
        colorReplace2.red,
        colorReplace2.green,
        colorReplace2.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace3,
        colorReplace3.red,
        colorReplace3.green,
        colorReplace3.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace4,
        colorReplace4.red,
        colorReplace4.green,
        colorReplace4.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace5,
        colorReplace5.red,
        colorReplace5.green,
        colorReplace5.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace6,
        colorReplace6.red,
        colorReplace6.green,
        colorReplace6.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace7,
        colorReplace7.red,
        colorReplace7.green,
        colorReplace7.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace8,
        colorReplace8.red,
        colorReplace8.green,
        colorReplace8.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace9,
        colorReplace9.red,
        colorReplace9.green,
        colorReplace9.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace10,
        colorReplace10.red,
        colorReplace10.green,
        colorReplace10.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace11,
        colorReplace11.red,
        colorReplace11.green,
        colorReplace11.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace12,
        colorReplace12.red,
        colorReplace12.green,
        colorReplace12.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace13,
        colorReplace13.red,
        colorReplace13.green,
        colorReplace13.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace14,
        colorReplace14.red,
        colorReplace14.green,
        colorReplace14.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace15,
        colorReplace15.red,
        colorReplace15.green,
        colorReplace15.blue,
    

    );
    shader_set_uniform_f(sh_handle_replace16,
        colorReplace16.red,
        colorReplace16.green,
        colorReplace16.blue,
    

    );
    #endregion

    if (P2charSelCol == 0 && P2charSelRow == 0)
    {
        draw_sprite_ext(sRussel_Idle, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
    }
    else if (P2charSelCol == 1 && P2charSelRow == 0)
    {
        draw_sprite_ext(sBeverly_Idle, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
    }
    else if (P2charSelCol == 2 && P2charSelRow == 0)
    {
        draw_sprite_ext(sJay_Idle, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
    }
	else if (P2charSelCol == 0 && P2charSelRow == 1)
    {
        draw_sprite_ext(sGunther_Idle_mockup_strip1, 0 + P2charSelCurrentFrame, 131, 65, -1, 1, 0, -1, 1);
    }
    shader_reset();

    if (P2charSelCol == 0 && P2charSelRow == 0)
    {
        draw_sprite(sCharSel_NameRussel, 0, 118, 69);
    }
    else if (P2charSelCol == 1 && P2charSelRow == 0)
    {
        draw_sprite(sCharSel_NameBeverly, 0, 118, 69);
    }
    else if (P2charSelCol == 2 && P2charSelRow == 0)
    {
        draw_sprite(sCharSel_NameJay, 0, 118, 69);
    }
	else if (P2charSelCol == 0 && P2charSelRow == 1)
    {
        draw_sprite(sCharSel_NameGunther, 0, 118, 69);
    }




    if (P1hasSelectedChar)
    {
        if (!P1hasSelectedAlt)
        {
            draw_sprite(sCharSel_PaletteSel, 0, 12, 47);
        }
        else
        {
            draw_sprite(sCharSel_CharReady, 0, 15, 46);
        }
    }
    if P2hasSelectedChar
    {
        if (!P2hasSelectedAlt)
        {
            draw_sprite(sCharSel_PaletteSel, 0, 116, 47);
        }
        else
        {
            draw_sprite(sCharSel_CharReady, 0, 119, 46);
        }
    }
}
else if (state == eCharacterSelectState.STAGE_SELECT || state == eCharacterSelectState.TRANSITION_TO_FIGHT)
{
	
	draw_sprite(sReadyToFight_strip5, RTF_currentFrame, 0, 0);
	
	draw_sprite(sStageSelect_Portraits1, 1, 0, 0);
	
    if (RTF_currentFrame == 4)
    {
        layer_background_visible(pressStartID, 1);
    }
	draw_sprite(sStageSelect_Cursor, 0 + (mapSelBoxAlt * P1hasSelectedMap), 23 + (28 * P1mapSelCol), 68 + (17 * P1mapSelRow));
	
	draw_sprite(sStageSelect_MusicOption_strip4, 2, 13, 85);
	
	draw_sprite(sStageSelect_Text_strip2, 0, 12, 56);
	
	if (P1mapSelCol == 0 && P1mapSelRow == 0)
	{
		draw_sprite(sStageSelect_StageNames_strip5, 0, 53, 58);
	}
	else if (P1mapSelCol == 1 && P1mapSelRow == 0)
	{
		draw_sprite(sStageSelect_StageNames_strip5, 1, 53, 58);
	}
	else if (P1mapSelCol == 2 && P1mapSelRow == 0)
	{
		draw_sprite(sStageSelect_StageNames_strip5, 2, 53, 58);
	}
	else if (P1mapSelCol == 3 && P1mapSelRow == 1)
	{
		draw_sprite(sStageSelect_StageNames_strip5, 4, 53, 58);
	}
	else
	{
		draw_sprite(sStageSelect_StageNames_strip5, 3, 53, 58);
	}
}
else if (state == eCharacterSelectState.MUSIC_SELECT)
{
	draw_sprite(sStageSelect_Portraits1, 1, 0, 0);
	
	draw_sprite(sReadyToFight_strip5, RTF_currentFrame, 0, 0);
	
	draw_sprite(sStageSelect_ShadeBox, 1, 0, 0);
	
    if (RTF_currentFrame == 4)
    {
        layer_background_visible(pressStartID, 1);
    }
	
	draw_sprite(sStageSelect_MusicOption_strip4, 2, 13, 85);
	
	draw_sprite(sStageSelect_Text_strip2, 1, 12, 56);
	
	if (P1musicSelRow == 0)
	{
		draw_sprite(sStageSelect_MusicNames_strip5, 0, 53, 58);
	}
	else if (P1musicSelRow == 1)
	{
		draw_sprite(sStageSelect_MusicNames_strip5, 1, 53, 58);
	}
	else if (P1musicSelRow == 2)
	{
		draw_sprite(sStageSelect_MusicNames_strip5, 2, 53, 58);
	}
	else if (P1musicSelRow == 3)
	{
		draw_sprite(sStageSelect_MusicNames_strip5, 3, 53, 58);
	}
	else
	{
		draw_sprite(sStageSelect_MusicNames_strip5, 4, 53, 58);
	}
}
