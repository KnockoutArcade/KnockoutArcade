/// @description Insert description here
// You can write your code in this editor

transitionTimer = 0; // *GETS OVERWRITTEN BY CHARACTER SELECT* Timer to keep track of transition
transitionLength = 0; // *GETS OVERWRITTEN BY CHARACTER SELECT* When to make this object go away (in frames)

// Get the layer ids of the KO text that scrolls by
transitionKOText_top = layer_get_id("TransitionKOText_Top");
transitionKOText_bottom = layer_get_id("TransitionKOText_Bottom");

transitionKOText_StartScrolling = 50; // The frame to start scrolling the KO text on
transitionKOText_EndScrolling = 70; // The frame to stop scrolling the KO text on
