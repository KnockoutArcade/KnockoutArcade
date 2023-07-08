/// This object is for controlling audio separately from the game manager.
// Music playing in different rooms, enabiling and disabiling audio groups, ect. 

audio_group_stop_all(audiogroup_mus); //Stop previous music upon loading a new 

audio_group_load(audiogroup_mus); // Reload Audio Groups
audio_group_load(audiogroup_sfx);
