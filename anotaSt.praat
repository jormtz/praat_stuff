######################
# Crea puntos en los comienzos, centros y finales de sílabas y
# los etiqueta con el valor de F0 en esos puntos en semitonos
######################

;form ToBI explorer
;    text texto
;endform 

# Limpia la pantalla
clearinfo

# Crea un vector con los audios seleccionados
sounds# = selected# ("Sound")

tam = size (sounds#)

# Comienza un bucle sobre cada audio
for k from 1 to tam
    selectObject: sounds# [k]
    gridName$ = selected$ ("Sound")
    
    # Crea objetos PointProcess con los puntos de inicio, centro y final de los intervalos con letras
    select TextGrid 'gridName$'
    sPoints = Get starting points: 1, "matches (regex)", "^[a-zA-Z]"
    select TextGrid 'gridName$'
    cPoints = Get centre points: 1, "matches (regex)", "^[a-zA-Z]"
    select TextGrid 'gridName$'
    ePoints = Get end points: 1, "matches (regex)", "^[a-zA-Z]"
    
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
    ;appendInfoLine: pointTime 
    endfor     
    
    # Ya tenemos los puntos donde hay que analizar la F0!
    
    pitchPoints# = zero# (numPoints)

    selectObject: sounds# [k]
    pitch = To Pitch: 0, 75, 600
    
    for l from 1 to numPoints
    pointF0 = Get value at time: points# [l], "semitones re 1 Hz", "Nearest" ;hay q colocar opción para este último valor
    pitchPoints# [l] = pointF0
    ;appendInfoLine: pointF0 
    endfor

    # Ya tenemos los análisis de F0! (bueno, hay que solucionar el undefined...)
    
    # Agrega un tier en la última posición del TextGrid correspondiente al audio actualmente seleccionado
    select TextGrid 'gridName$'
    numInt2 = Get number of tiers
    numInt2 = numInt2 + 1
    View & Edit alone
    editor: "TextGrid " + gridName$
    Add point tier: 7, "test"

    # Agrega los puntos requeridos
    for m from 1 to numPoints
    Move cursor to: points# [m]
    Add on selected tier
    endfor
    endeditor
    
    # Esto funciona, pero que hay que decirle que cheque el tier más alto = el mismo que numInt2
    # Ahorita simplemente imprime en el tier 7
    select TextGrid 'gridName$'
    for n from 1 to numPoints
    punto$ = fixed$(pitchPoints# [n], 3)
    Set point text: 7, n, punto$
    endfor



    ;appendInfoLine: gridName$, tab$, points# 
    removeObject: sPoints, cPoints, ePoints, mergePoints1, mergePoints2, pitch 
# Detén el bucle
endfor

# Restaurar la selección original
selectObject (sounds#)