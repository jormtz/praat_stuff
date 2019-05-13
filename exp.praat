######################
# Tabula los contenidos de un archivo TextGrid con anotaciones en estilo ToBI.
# Formato del encabezado: <nombre de archivo> <cesuras> <tonos> <división ortográfica>
#
######################

form ToBI explorer
    text texto
endform 

# Limpia la pantalla
clearinfo

# Crea un vector con los TextGrids seleccionados
grids# = selected# ("TextGrid")

# Define una variable llamada <tam> equivalente al tamaño del vector <grids#>
tam = size (grids#)

# Comienza un bucle que itere tantas veces como el valor de la variable <tam>
for k from 1 to tam
    # Selecciona el objeto correspondiente al índice equivalente a la variable k, dentro del vector <grids#>
    selectObject: grids# [k]
    # Define la variable <gridName$>, equivalente al nombre del TextGrid seleccionado
	gridName$ = selected$ ("TextGrid")

    numInt1 = Get number of intervals: 1
    numInt2 = Get number of points: 2
    numInt3 = Get number of points: 3
    numInt4 = Get number of intervals: 4

    # Transcripción ortográfica
    grid1$ = ""

    for int from 1 to numInt1
        int$ = Get label of interval: 1, int 
        grid1$ = grid1$ + " " + int$ 
    endfor

    # Cesuras
    grid2$ = ""

    for int from 1 to numInt2
        int$ = Get label of point: 2, int 
        grid2$ = grid2$ + " " + int$ 
    endfor

    # Tonos
    grid3$ = ""

    for int from 1 to numInt3
        int$ = Get label of point: 3, int 
        grid3$ = grid3$ + " " + int$ 
    endfor


    appendInfoLine: gridName$, tab$, grid2$, tab$, grid3$, tab$, grid1$ 
# Detén el bucle
endfor

# Restaurar la selección original
selectObject (grids#)