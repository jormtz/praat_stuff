clearinfo

#Crea un vector con los archivos TextGrid seleccionados
texts# = selected# ("TextGrid")

#Calcula el tamaño del vector
len = size (texts#)
appendInfoLine: "Número de archivos: ", len

#Comienza un bucle sobre los TextGrids seleccionados
for text from 1 to len 
    
    selectObject: texts# [text]

    #Obtiene el número de puntos en la grada 2 de Sp_TobI
    numCesuras = Get number of points: 2

    # Obtiene el número de puntos en la grada 3 de Sp_TobI
    numAcentos = Get number of points: 3

    # writeInfoLine: "Los acentos tonales de esta muestra son: ", newline$

    #Crea una cadena vacía
    cadena$ = ""

    #Comienza un bucle sobre la grada 3 de Sp_ToBI
    for i from 1 to numAcentos
        text$ = Get label of point: 3, i
        acento$ [i] = text$
        cadena$ = cadena$ + acento$ [i] + tab$ 
        #appendInfoLine: tab$, i, tab$, acento$ [i], tab$
    endfor

    appendInfoLine: cadena$

endfor 
   
