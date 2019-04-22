# Antes de correr el script, carga y selecciona algunos archivos TextGrid.
# Este script asume que las primeras cuatro gradas se corresponden al esquema
# del sistema de etiquetado prosódico Sp_ToBI, con algunas anotaciones particulares
# en la grada 4.

# Limpia la pantalla de la consola.
clearinfo

# Crea un vector con los objetos TextGrid seleccionados.
texts# = selected# ("TextGrid")

# Comienza un bucle sobre cada objeto TextGrid contenido el vector texts#
for text from 1 to size(texts#)
   # Selecciona el objeto TextGrid actual.
   selectObject: texts# [text]

   # Obtiene el número de puntos en la grada 2 de Sp_TobI (cesuras).
   numCesuras = Get number of points: 2

   # Obtiene el número de puntos en la grada 3 de Sp_TobI (acentos y junturas tonales).
   numAcentos = Get number of points: 3

   # writeInfoLine: "Los acentos tonales de esta muestra son: ", newline$

   # Crea una cadena vacía.
   cadena$ = ""

   # Comienza un bucle sobre los puntos de la grada 3 (acentos y junturas tonales). 
   # Recupera la etiqueta de cada punto e imprímela sobre la cadena vacía seguida de un tabulador.
   for i from 1 to numAcentos
      text$ = Get label of point: 3, i
      acento$ [i] = text$
      cadena$ = cadena$ + acento$ [i] + tab$ 
      #appendInfoLine: tab$, i, tab$, acento$ [i], tab$
   # Detiene el bucle anterior.
   endfor

#Imprime la cadena con los acentos y junturas tonales.
appendInfoLine: cadena$

#Detiene el primer bucle.
endfor


