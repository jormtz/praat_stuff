######################
# Autor: Jordi Martínez Martínez
# Toma una grada de intervalos y obtiene los comienzos, centros y finales de cada sección,
# siempre y cuando no esté vacía o no contenga un caracter no alfabético. 
# Imprime estas divisiones en una nueva grada de puntos y etiquétalas con el valor de F0
# en cada punto. Se utilizan las configuraciones locales del análisis de F0.
######################

# Pendientes: tal vez incluir la opción de llamar la grada con intervalos por su nombre.

# Limpia la pantalla
clearinfo

# Crea un vector con los audios seleccionados
sounds# = selected# ("Sound")

tam = size (sounds#)

# Grada donde están las divisiones a evaluar
grada = 1

# Comienza un bucle sobre cada audio
for k from 1 to tam
    selectObject: sounds# [k]
    gridName$ = selected$ ("Sound")
    
    # Crea objetos PointProcess con los puntos de inicio, centro y final de los intervalos con caracteres alfabéticos
    select TextGrid 'gridName$'
    sPoints = Get starting points: grada, "matches (regex)", "^[a-zA-Z]"
    select TextGrid 'gridName$'
    cPoints = Get centre points: grada, "matches (regex)", "^[a-zA-Z]"
    select TextGrid 'gridName$'
    ePoints = Get end points: grada, "matches (regex)", "^[a-zA-Z]"
    
    # Combina los objetos PointProcess
    selectObject: sPoints, cPoints 
    mergePoints1 = Union
    plusObject: ePoints
    mergePoints2 = Union
    
    # Crea un vector para los valores de tiempo del archivo PointProcess unificado
    numPoints = Get number of points
    points# = zero# (numPoints)
    
    for i from 1 to numPoints
        selectObject: mergePoints2 
        points# [i] = Get time from index: i
    endfor

    # Remueve los objetos PointProcess
    removeObject: sPoints,  cPoints, ePoints, mergePoints1, mergePoints2     
    
    # Ya tenemos los puntos en el tiempo donde hay que analizar la F0! Ahora, creamos un vector
    # para contener los valores de F0
    pitchPoints# = zero# (numPoints)
    
    # Agrega una grada en la última posición del TextGrid correspondiente al audio actualmente seleccionado
    select TextGrid 'gridName$'
    numInt2 = Get number of tiers
    numInt2 = numInt2 + 1
    selectObject: sounds# [k], "TextGrid " + gridName$
    View & Edit
    
    # Agrega los puntos en la grada creada y obtén los valores de F0 correspondientes
    editor: "TextGrid " + gridName$
        Add point tier: numInt2, "test"
        # Agrega los puntos requeridos
        for m from 1 to numPoints
            Move cursor to: points# [m]
            Add on selected tier
            pitchPoints# [m] = Get pitch
        endfor
    Close
    
    # Imprime los valores de F0
    select TextGrid 'gridName$'
    for n from 1 to numPoints
        punto$ = fixed$(pitchPoints# [n], 2)
        Set point text: numInt2, n, punto$
    endfor

# Detén el bucle
endfor

# Restaurar la selección original
selectObject (sounds#)