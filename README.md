# GD3 2D Platformer Control & more


![Alt text](Screenshots/Godot_v3.0.6-stable_win64_2018-10-16_19-48-05.png?raw=true "PREVIEW")

# FEATURES :

- class for input event
    - IsPressed
    - IsHold
    - IsReleased
- class for shooting
    - with rapid fire option on/off
- class for throwing
- class for Platformer2D movement
    - move left
    - move right
    - jump/double jump
    - fall
    - pickup    
    - crunch
- class for animation state checker by assigned Platformer2D movement instance
- collision check is included inside classes
- play animation
- player facing by movement direction
- save/load player gamedata to JSON
- player start position and respawn
- pickup coins
- pickup ammo
- pickup health
- pickup grenade
- basic entities:
  - hazard (left, right, up, down) with hurt direction for player
  - InfoPanel (show message box with user defined text)
  - Door and move player to targe podition (next door with spawnPosition)
- simple inventory system

# TODO

- create basic entities:
  - enemies
