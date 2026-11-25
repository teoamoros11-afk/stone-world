# La frase de Why-Man y de Ibara, con boton: pulsar el texto arma la medusa.
# Uso: /function swr:serie/medusa/voz
tellraw @a [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"¿Quieres morir? ","color":"dark_purple","italic":true},{"text":"[ARMAR]","color":"light_purple","bold":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/medusa/iniciar"},"hoverEvent":{"action":"show_text","value":"Gasta una carga y empieza la cuenta atras de 30 s"}}]
