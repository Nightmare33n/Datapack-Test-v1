# ==================================================
# GIVE ITEMS FUNCTION - Example
# ==================================================
# Give player a set of items

# Give diamond sword with enchantments
give @s minecraft:diamond_sword[enchantments={levels:{"minecraft:sharpness":5,"minecraft:unbreaking":3}}]

# Give 64 diamonds
give @s minecraft:diamond 64

# Give custom named item
give @s minecraft:golden_apple[item_name='{"text":"Super Apple","color":"gold","bold":true}']

# Display success message
tellraw @s ["",{"text":"[System] ","color":"green","bold":true},{"text":"Items given!","color":"white"}]
