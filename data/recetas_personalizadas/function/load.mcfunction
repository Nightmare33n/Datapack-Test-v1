# ========================================
# LOAD FUNCTION - Recetas Personalizadas
# ========================================
# Esta función se ejecuta cuando el datapack se carga/recarga



# Mensaje de confirmación de carga
tellraw @a ["",{"text":"[Recetas Personalizadas] ","color":"green","bold":true},{"text":"Datapack cargado correctamente ✓","color":"yellow"}]

# Mensaje de debug con detalles
tellraw @a ["",{"text":"[DEBUG] ","color":"gray"},{"text":"Pack Format: 81 | Minecraft 1.21.8","color":"white"}]

# Mensaje de recetas disponibles
tellraw @a ["",{"text":"[INFO] ","color":"aqua"},{"text":"Recetas añadidas: ","color":"white"},{"text":"End Portal Frame","color":"light_purple"}]
