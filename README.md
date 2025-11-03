# DATAPACK TEST v1

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Minecraft 1.21.8 datapack collection for custom recipes. The primary datapack is `recetas_personalizadas` (Custom Recipes), which adds crafting recipes for normally uncraftable items.

## Datapack Structure

Minecraft datapacks follow a strict directory structure:
```
datapack_name/
├── pack.mcmeta                    # Datapack metadata and version
└── data/
    └── namespace/                 # Namespace (typically matches datapack name)
        ├── recipe/                # Custom crafting recipes
        ├── function/              # .mcfunction files (commands)
        ├── advancement/           # Custom advancements
        ├── loot_table/           # Custom loot tables
        ├── structure/            # Structure files
        └── tags/                 # Tag definitions
```

**Current namespace:** `recetas_personalizadas`

## Pack Format Version

- **pack_format: 81** - Minecraft 1.21.7 - 1.21.8
- When updating recipes or features, ensure compatibility with this version
- Reference: https://minecraft.wiki/w/Pack_format

## Recipe Development

### Recipe File Location
All recipes go in: `recetas_personalizadas/data/recetas_personalizadas/recipe/`

### Recipe Naming Convention
- File name should match the output item: `end_portal_frame.json`
- Use lowercase with underscores: `netherite_block.json`, `diamond_horse_armor.json`

### Recipe JSON Structure (VERIFIED for 1.21.8)
```json
{
  "type": "minecraft:crafting_shaped",
  "category": "building",
  "pattern": [
    "OEO",
    "EYE",
    "OEO"
  ],
  "key": {
    "O": "minecraft:obsidian",
    "E": "minecraft:end_stone",
    "Y": "minecraft:ender_eye"
  },
  "result": {
    "count": 1,
    "id": "minecraft:end_portal_frame"
  }
}
```

**IMPORTANT - Java Edition 1.21.8 Format Rules:**
- `key` values MUST be strings directly (e.g., `"O": "minecraft:obsidian"`)
- DO NOT use object format with `"item"` field (e.g., ~~`"O": { "item": "minecraft:obsidian" }`~~)
- `result` field uses `"id"` (not `"item"` - that's for Bedrock Edition)
- Order in result: `"count"` then `"id"`
- For item tags, prefix with `#` (e.g., `"O": "#minecraft:logs"`)

**Categories available:** `building`, `equipment`, `misc`, `redstone`

### Recipe Types with Examples

All example files are located in: `data/recetas_personalizadas/recipe/examples/`

#### 1. **crafting_shapeless** - Order doesn't matter
**File:** `shapeless_example.json`
```json
{
  "type": "minecraft:crafting_shapeless",
  "category": "misc",
  "ingredients": [
    "minecraft:dirt",
    "minecraft:wheat_seeds"
  ],
  "result": {
    "count": 1,
    "id": "minecraft:grass_block"
  }
}
```
- `ingredients`: Array of items (can use tags with `#`)
- Items can be placed in any order in crafting grid

#### 2. **smelting** - Furnace recipes
**File:** `smelting_example.json`
```json
{
  "type": "minecraft:smelting",
  "category": "misc",
  "ingredient": "minecraft:cobblestone",
  "result": {
    "id": "minecraft:stone"
  },
  "experience": 0.1,
  "cookingtime": 200
}
```
- `cookingtime`: Ticks (200 ticks = 10 seconds)
- `experience`: XP awarded when taken from furnace

#### 3. **blasting** - Blast furnace (2x faster than smelting)
**File:** `blasting_example.json`
```json
{
  "type": "minecraft:blasting",
  "category": "misc",
  "ingredient": "minecraft:iron_ore",
  "result": {
    "id": "minecraft:iron_ingot"
  },
  "experience": 0.7,
  "cookingtime": 100
}
```

#### 4. **smoking** - Smoker (2x faster for food)
**File:** `smoking_example.json`
```json
{
  "type": "minecraft:smoking",
  "category": "food",
  "ingredient": "minecraft:beef",
  "result": {
    "id": "minecraft:cooked_beef"
  },
  "experience": 0.35,
  "cookingtime": 100
}
```

#### 5. **stonecutting** - Stonecutter recipes
**File:** `stonecutting_example.json`
```json
{
  "type": "minecraft:stonecutting",
  "ingredient": "minecraft:stone",
  "result": {
    "count": 2,
    "id": "minecraft:stone_stairs"
  }
}
```
- No cooking time needed
- Usually gives more output than crafting

#### 6. **smithing_transform** - Smithing table (1.20+)
**File:** `smithing_transform_example.json`
```json
{
  "type": "minecraft:smithing_transform",
  "template": "minecraft:netherite_upgrade_smithing_template",
  "base": "minecraft:diamond_sword",
  "addition": "minecraft:netherite_ingot",
  "result": {
    "id": "minecraft:netherite_sword"
  }
}
```
- `template`: Smithing template item
- `base`: Item to upgrade
- `addition`: Material to add

## Testing Datapacks

### In-Game Testing
1. Place datapack in world's `datapacks/` folder
2. In Minecraft, run: `/reload` to reload datapacks
3. Check loaded datapacks: `/datapack list`
4. Test recipe in crafting table or Recipe Book (if unlocked)

### Enabling/Disabling
- Enable: `/datapack enable "file/recetas_personalizadas"`
- Disable: `/datapack disable "file/recetas_personalizadas"`

### Validation
- Use online validators for JSON syntax
- Test recipes in creative mode with Recipe Book visible
- Check server/game logs for datapack errors on `/reload`

## Functions (.mcfunction files)

Functions are files containing Minecraft commands that execute together. Located in: `data/namespace/function/`

### Example Files in `data/recetas_personalizadas/function/examples/`:

#### **give_items.mcfunction** - Give items to player
```mcfunction
# Give diamond sword with enchantments
give @s minecraft:diamond_sword[enchantments={levels:{"minecraft:sharpness":5,"minecraft:unbreaking":3}}]

# Give 64 diamonds
give @s minecraft:diamond 64

# Give custom named item
give @s minecraft:golden_apple[item_name='{"text":"Super Apple","color":"gold","bold":true}']

# Display success message
tellraw @s ["",{"text":"[System] ","color":"green","bold":true},{"text":"Items given!","color":"white"}]
```

#### **teleport_players.mcfunction** - Teleport with effects
```mcfunction
# Teleport to coordinates
tp @a 0 100 0

# Play sound and particles
execute as @a at @s run playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1
execute as @a at @s run particle minecraft:portal ~ ~1 ~ 0.5 1 0.5 0.5 100
```

#### **tick.mcfunction** - Runs every game tick (20 times/second)
```mcfunction
# Heal players standing on gold blocks
execute as @a at @s if block ~ ~-1 ~ minecraft:gold_block run effect give @s minecraft:regeneration 1 1 true

# Give speed to players holding diamond
execute as @a[nbt={SelectedItem:{id:"minecraft:diamond"}}] run effect give @s minecraft:speed 1 0 true
```

**To enable tick function:** Create `data/minecraft/tags/function/tick.json`:
```json
{
  "values": [
    "recetas_personalizadas:examples/tick"
  ]
}
```

### Running Functions
- In-game: `/function recetas_personalizadas:examples/give_items`
- From other function: `function recetas_personalizadas:examples/teleport_players`

## Advancements

Custom achievements/progression tracking. Located in: `data/namespace/advancement/`

### Example Files in `data/recetas_personalizadas/advancement/examples/`:

#### **first_diamond.json** - Inventory trigger
```json
{
  "display": {
    "icon": {
      "id": "minecraft:diamond"
    },
    "title": {
      "text": "First Diamond!",
      "color": "aqua"
    },
    "description": {
      "text": "Obtain your first diamond"
    },
    "frame": "task",
    "show_toast": true,
    "announce_to_chat": true
  },
  "criteria": {
    "get_diamond": {
      "trigger": "minecraft:inventory_changed",
      "conditions": {
        "items": [
          {
            "items": "minecraft:diamond"
          }
        ]
      }
    }
  },
  "rewards": {
    "experience": 100,
    "function": "recetas_personalizadas:examples/give_items"
  }
}
```

#### **kill_zombie.json** - Kill entity trigger
```json
{
  "display": {
    "icon": {
      "id": "minecraft:rotten_flesh"
    },
    "title": {
      "text": "Zombie Hunter",
      "color": "green"
    },
    "frame": "challenge",
    "show_toast": true
  },
  "criteria": {
    "killed_zombie": {
      "trigger": "minecraft:player_killed_entity",
      "conditions": {
        "entity": {
          "type": "minecraft:zombie"
        }
      }
    }
  },
  "rewards": {
    "experience": 50
  }
}
```

**Frame types:** `task`, `goal`, `challenge`

**Common triggers:**
- `minecraft:inventory_changed` - Player gets/loses item
- `minecraft:player_killed_entity` - Player kills mob
- `minecraft:location` - Player enters location
- `minecraft:consume_item` - Player eats/drinks
- `minecraft:item_used_on_block` - Right-click block with item

## Loot Tables

Control what items drop from mobs, chests, blocks. Located in: `data/namespace/loot_table/`

### Example Files in `data/recetas_personalizadas/loot_table/examples/`:

#### **custom_zombie_drops.json** - Entity loot
```json
{
  "type": "minecraft:entity",
  "pools": [
    {
      "rolls": 1,
      "entries": [
        {
          "type": "minecraft:item",
          "name": "minecraft:diamond",
          "weight": 1
        },
        {
          "type": "minecraft:item",
          "name": "minecraft:gold_ingot",
          "weight": 3
        },
        {
          "type": "minecraft:empty",
          "weight": 6
        }
      ],
      "conditions": [
        {
          "condition": "minecraft:killed_by_player"
        }
      ]
    }
  ]
}
```

#### **custom_chest.json** - Chest loot
```json
{
  "type": "minecraft:chest",
  "pools": [
    {
      "rolls": {
        "min": 3,
        "max": 7
      },
      "entries": [
        {
          "type": "minecraft:item",
          "name": "minecraft:diamond",
          "weight": 5,
          "functions": [
            {
              "function": "minecraft:set_count",
              "count": {
                "min": 1,
                "max": 3
              }
            }
          ]
        },
        {
          "type": "minecraft:item",
          "name": "minecraft:enchanted_book",
          "weight": 3,
          "functions": [
            {
              "function": "minecraft:enchant_randomly"
            }
          ]
        }
      ]
    }
  ]
}
```

**Loot table types:** `entity`, `chest`, `block`, `fishing`, `gift`

**Common functions:**
- `minecraft:set_count` - Random stack size
- `minecraft:enchant_randomly` - Random enchantments
- `minecraft:set_nbt` - Custom NBT data

**To override vanilla loot:** Use vanilla path (e.g., `data/minecraft/loot_table/entities/zombie.json`)

## Tags

Group items/blocks together for easy reference. Located in: `data/namespace/tags/`

### Example Files:

#### **tags/block/special_blocks.json**
```json
{
  "replace": false,
  "values": [
    "minecraft:diamond_block",
    "minecraft:emerald_block",
    "minecraft:gold_block",
    "#minecraft:beacon_base_blocks"
  ]
}
```

#### **tags/item/valuable_items.json**
```json
{
  "replace": false,
  "values": [
    "minecraft:diamond",
    "minecraft:emerald",
    "minecraft:netherite_ingot",
    "#minecraft:armors"
  ]
}
```

**Usage in recipes:**
```json
"key": {
  "L": "#minecraft:logs",
  "P": "#minecraft:planks"
}
```

**Usage in commands:**
```mcfunction
execute as @a at @s if block ~ ~-1 ~ #recetas_personalizadas:special_blocks run say Standing on special block!
```

**Tag options:**
- `replace: false` - Add to existing tag
- `replace: true` - Replace entire tag
- `#namespace:tag_name` - Reference another tag

## Common Item IDs
When creating recipes, use proper namespaced IDs:
- Vanilla items: `minecraft:item_name` (e.g., `minecraft:diamond`, `minecraft:oak_planks`)
- Custom items from mods require mod namespace: `modid:item_name`



## Important Notes
- JSON files must be valid (no trailing commas, proper quotes)
- Recipe files must use `.json` extension
- Namespace directories must be lowercase
- Always test with `/reload` after changes
- Back up world before testing new recipes that might break game balance
