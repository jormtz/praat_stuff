clearinfo

#encabezado
appendInfoLine: "ID", tab$, "PF.V1", tab$, "DUR.V1", tab$, "PF.V2", tab$, "DUR.V2", tab$, "DUR.SIL1", tab$, "DUR.SIL2"

sounds# = selected# ("Sound")
tam = size (sounds#)

for k from 1 to tam
    selectObject: sounds# [k]

	#Nombre
	sonido = selected ("Sound")
	soundName$ = selected$ ("Sound")
	 
	#Crea una pitch tier. 
	#OJO: para hombres Praat sugiere un rango de 75-300 Hz; 
	#para mujeres, uno de  100-500 Hz. Estaría bien crear algunas
	#reglas para ejecutar esto automáticamente según la clave del archivo.
	# e.g. el cuarto caracter de esta me indica si el informante es H o M.
	
	subcadena$ = left$ (soundName$, 4)
	subcadena2$ = right$ (subcadena$, 1)
	
	if subcadena2$ = "F"
		To Pitch... 0 100 500
		frecuencia = selected ("Pitch")
	
	elif subcadena2$ = "M" 
		To Pitch... 0 75 300
		frecuencia = selected ("Pitch")
	endif
	
	

	#Capturar propiedades de la grada '5' (sílabas en junturas)
	select TextGrid 'soundName$'
	numIntervalos = Get number of intervals: 5

	for i from 1 to numIntervalos
		select TextGrid 'soundName$'
		etiqueta$ = Get label of interval: 5, i
	   
			if etiqueta$ <> ""

				if etiqueta$ = "s1"
					inicioS1 = Get starting point: 5, i
					finS1 = Get end point: 5, i
					selectObject: frecuencia
					promFrecS1 = Get mean... 'inicioS1' 'finS1' semitones re 1 Hz

				else etiqueta$ = "s2"
					inicioS2 = Get starting point: 5, i
					finS2 = Get end point: 5, i
					selectObject: frecuencia
					promFrecS2 = Get mean... 'inicioS2' 'finS2' semitones re 1 Hz
				endif
			
			endif
			
	endfor

	#Capturar las propiedades de la grada 6
	select TextGrid 'soundName$'
	numIntervalos6 = Get number of intervals: 6

	#Variables
	
	#Promedio de F0 de la sílaba 1, en st.
	promFrecS1 = 0
	
	#Promedio de F0 de la sílaba 2, en st.
	promFrecS2 = 0
	
	#Promedio de F0 de la vocal 1, en st.
	promFrecV1 = 0
	
	#Duración de la vocal 1, en ms.
	duracionV1 = 0
	
	#Promedio de F0 de la vocal 2, en st.
	promFrecV2 = 0
	
	#Duración de la vocal 2, en ms.
	duracionV2 = 0
	
	#Duración del silencio 1, en ms.
	duracionSil1 = 0
	
	#Duración del silencio 2, en ms.
	duracionSil2 = 0



	for i from 1 to numIntervalos6
		select TextGrid 'soundName$'
		etiqueta6$ = Get label of interval: 6, i

		if etiqueta6$ <> ""
		
			if etiqueta6$ = "v1"
				inicioV1 = Get starting point: 6, i
				finV1 = Get end point: 6, i
				mitadV1 = (inicioV1 + finV1) / 2
				selectObject: frecuencia
				
				#Obtiene el promedio de frecuencia del intervalo 'v1'
				promFrecV1 = Get mean... 'inicioV1' 'finV1' semitones re 1 Hz
				#frecInicioV1 =  Get value at time... 'inicioV1' Hertz Linear
				#frecMitadV1 = Get value at time... 'mitadV1' Hertz Linear
				#frecFinV1 = Get value at time... 'finV1' Hertz Linear
				
				#Obtiene la duración del intervalo 'v1'
				duracionV1 = (finV1 - inicioV1) * 1000
			
			
			#Obtiene la duración del silencio 1
			elif etiqueta6$ = "sil1"
				inicioSil1 = Get starting point: 6, i
				finSil1 = Get end point: 6, i
				duracionSil1 = (finSil1 - inicioSil1) * 1000
			
			
			elif etiqueta6$ = "v2"
				inicioV2 = Get starting point: 6, i
				finV2 = Get end point: 6, i
				mitadV2 = (inicioV2 + finV2) / 2
				selectObject: frecuencia
				
				#Obtiene el promedio de frecuencia del intervalo 'v1'
				promFrecV2 = Get mean... 'inicioV2' 'finV2' semitones re 1 Hz
				#frecInicioV2 =  Get value at time... 'inicioV2' Hertz Linear
				#frecMitadV2 = Get value at time... 'mitadV2' Hertz Linear
				#frecFinV2 = Get value at time... 'finV2' Hertz Linear
				
				#Obtiene la duración del intervalo 'v2'
				duracionV2 = (finV2 - inicioV2) * 1000
			
			
			#Obtiene la duración del silencio 2
			elif etiqueta6$ = "sil2"
				inicioSil2 = Get starting point: 6, i
				finSil2 = Get end point: 6, i
				duracionSil2 = (finSil2 - inicioSil2) * 1000
					
				
			endif
			
		endif
		
	endfor


	#Imprimir el formato de tabla
	#appendInfoLine: "ID", tab$, "PROMEDIO FRECUENCIA S1", tab$, "PROMEDIO FRECUENCIA S2", tab$, "PROMEDIO FRECUENCIA V1", tab$, "DURACIÓN V1 (MS)"
	#appendInfoLine: soundName$, tab$, promFrecS1, tab$, promFrecS2, tab$, promFrecV1, tab$, duracionV1

	#pruebas
	appendInfoLine: soundName$, tab$, promFrecV1, tab$, duracionV1, tab$, promFrecV2, tab$, duracionV2, tab$, duracionSil1, tab$, duracionSil2
	removeObject: frecuencia

endfor

# Restore selection:
selectObject (sounds#)