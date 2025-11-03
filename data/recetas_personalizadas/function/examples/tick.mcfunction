# ==================================================
# TICK FUNCTION - Example (runs every game tick)
# ==================================================
# This function runs 20 times per second

# Heal players standing on gold blocks
execute as @a at @s if block ~ ~-1 ~ minecraft:gold_block run effect give @s minecraft:regeneration 1 1 true

# Give speed to players holding diamond
execute as @a[nbt={SelectedItem:{id:"minecraft:diamond"}}] run effect give @s minecraft:speed 1 0 true

# Detect players in specific area (x: -10 to 10, y: 60 to 70, z: -10 to 10)
execute as @a[x=-10,y=60,z=-10,dx=20,dy=10,dz=20] run title @s actionbar {"text":"You are in the special zone!","color":"yellow"}
