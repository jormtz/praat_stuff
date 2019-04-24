####################################
## Antes de ejecutar este script, carga y selecciona algunos objetos del tipo TextGrid.
## Este script captura las etiquetas puntuales de la grada 2 de una transcripción 
## Sp_ToBI en un objeto TextGrid, ordenando las etiquetas en tres columnas distintas, 
## especificadas manualmente en la grada 4.
####################################

clearinfo

#Imprime el encabezado de la tabla.
appendInfoLine: "ID", tab$, "tonos.ANT", tab$, "tonos.CR", tab$, "tonos.PRED"

# Crea un vector con los sonidos seleccionados
grids# = selected# ("TextGrid")

# Comienza un bucle que itera tantas veces como el tamaño del vector <grids#>.
for grid from 1 to size(grids#)
	# Selecciona el objeto actual en el bucle.
    selectObject: grids# [grid]

	# Define la variable <gridName$> como el nombre del objeto seleccionado.
	gridName$ = selected$ ("TextGrid")	 	

	# Define la variable <numInt> como el número de intervalos contenidos en la grada 4 del objeto TextGrid seleccionado.
	numInt4 = Get number of intervals: 4

	# Crea tres variables, una para cada intervalo que se analizará.
	ant$ = ""
	cr$ = ""
	pred$ = ""

	# Comienza un bucle que itere tantas veces como el valor de la variable <numInt4>.
	for i from 1 to numInt4
		# Obtén la etiqueta del intervalo actual.
		select TextGrid 'gridName$'
		# Define la variable <etiqueta$> como la cadena que esté en el intervalo actual.
		etiqueta$ = Get label of interval: 4, i

		# Condición: si la variable <etiqueta$> no es una cadena vacía, continúa.
		if etiqueta$ <> ""
			# Define la variable <acentos$> como una cadena vacía.
			acentos$ = "-" + etiqueta$ + "-"						

			# Condición: si la cadena es igual a "ANT", continúa.
			if etiqueta$ = "ANT"
				# Define la variable <ant$> como una cadena equivalente a la variable <acentos$>
				ant$ = acentos$

			# Condición: si la cadena es igual a "ANT", continúam si no, detente.
			elif etiqueta$ = "CR"
				# Define la variable <cr$> como una cadena equivalente a la variable <acentos$>
				cr$ = acentos$
			
			# Condición: si la cadena es igual a "ANT", continúam si no, detente.
			elif etiqueta$ = "PRED"
				# Define la variable <pred$> como una cadena equivalente a la variable <acentos$>
				pred$ = acentos$

			# Finaliza el condicional.
			endif
			
		
		# Finaliza el condicional.
		endif

	# Finaliza el bucle.		
	endfor
	# Imprime una línea que contiene las variables <gridName$>, <ant$>, <cr$> y <pred$> separadas por tabuladores.	
	appendInfoLine: gridName$, tab$, ant$, tab$, cr$, tab$,  pred$

# Finaliza el bucle actual.
endfor

# Selecciona los objetos del vector <grids#>.
selectObject (grids#)