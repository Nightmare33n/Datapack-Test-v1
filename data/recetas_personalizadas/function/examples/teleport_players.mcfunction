# ==================================================
# TELEPORT PLAYERS FUNCTION - Example
# ==================================================
# Teleport all players to spawn location

# Teleport to coordinates (0, 100, 0)
tp @a 0 100 0

# Play sound at teleport location
execute as @a at @s run playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1

# Add particle effect
execute as @a at @s run particle minecraft:portal ~ ~1 ~ 0.5 1 0.5 0.5 100

# Send message
tellraw @a ["",{"text":"[Teleport] ","color":"aqua","bold":true},{"text":"Teleported to spawn!","color":"white"}]
