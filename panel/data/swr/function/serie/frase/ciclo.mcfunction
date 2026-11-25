# A33 - Cada dia, si la frecuencia sigue abierta, suena la frase.
execute unless score FRASE_ACTIVA serie matches 1 run return 0
function swr:serie/frase/decir
schedule function swr:serie/frase/ciclo 24000t replace
