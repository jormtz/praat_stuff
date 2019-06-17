clearinfo

#Obtiene el número de puntos en la grada 2 de Sp_TobI
numCesuras = Get number of points: 2

# Obtiene el número de puntos en la grada 3 de Sp_TobI
numAcentos = Get number of points: 3

# writeInfoLine: "Los acentos tonales de esta muestra son: ", newline$

cadena$ = ""

for i from 1 to numAcentos
    text$ = Get label of point: 3, i
    acento$ [i] = text$
    cadena$ = cadena$ + acento$ [i] + tab$ 
    #appendInfoLine: tab$, i, tab$, acento$ [i], tab$
endfor

appendInfoLine: cadena$

   
