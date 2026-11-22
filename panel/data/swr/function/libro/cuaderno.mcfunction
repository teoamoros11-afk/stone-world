# Reparte el cuaderno segun lo anotado. Un libro escrito no se edita: se da uno nuevo.
scoreboard players add DESCUBRIMIENTOS swr 0
execute if score DESCUBRIMIENTOS swr matches 22.. run function swr:libro/cuaderno/5
execute unless score DESCUBRIMIENTOS swr matches 22.. if score DESCUBRIMIENTOS swr matches 18.. run function swr:libro/cuaderno/4
execute unless score DESCUBRIMIENTOS swr matches 18.. if score DESCUBRIMIENTOS swr matches 14.. run function swr:libro/cuaderno/3
execute unless score DESCUBRIMIENTOS swr matches 14.. if score DESCUBRIMIENTOS swr matches 5.. run function swr:libro/cuaderno/2
execute unless score DESCUBRIMIENTOS swr matches 5.. if score DESCUBRIMIENTOS swr matches 0.. run function swr:libro/cuaderno/1
