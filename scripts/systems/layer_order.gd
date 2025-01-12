class_name RenderLayers  # or GameLayers instead of LayerOrder
extends Node

const LAYER_SPACING = 5  # Standard spacing between layers
const UI_LAYER_SPACING = 10  # Larger spacing for UI elements

enum ZIndex {
    # World Base Layers
    UNDERGROUND = -20,
    WATER = -15,
    BACKGROUND = -10,
    
    # Ground Level
    GROUND = 0,
    GROUND_DETAIL = 5,
    SHADOWS = 8,
    
    # Game Objects
    ITEMS = 10,
    CROPS = 15,
    BUILDINGS = 18,
    CHARACTERS = 20,
    
    # Above Ground
    ABOVE_CHARACTERS = 25,
    TREE_TOPS = 30,
    WEATHER = 35,
    ROOFS = 40,
    FLYING_OBJECTS = 50,
    
    # UI Elements
    UI_BACKGROUND = 90,
    UI = 100,
    UI_FOREGROUND = 110,
    CURSOR = 120
}