#ifdef SPANISH
	#define STR0001 "1% DESCONTABLE SOBRE EL TOTAL"
	#define STR0002 "DEL EMBARQUE.              "
	#define STR0003 "SAO PAULO"
	#define STR0004 "Nº Poliza"
	#define STR0005 "Nº Declaracion"
	#define STR0006 "Fch. Seguro"
	#define STR0007 "Nº Cert. Seguro"
	#define STR0008 "SEGURO EFECTUADO DE CASA A CASA, CUBRIENDO TODOS LOS RIESGOS,"
	#define STR0009 "INCLUSIVE LOS RIESGOS DE GUERRA Y"
	#define STR0010 "HUELGA, DE CONFORMIDAD CON LAS CLAUSULAS DE CARGA (TODOS "
	#define STR0011 "LOS RIESGOS), CLAUSULAS DE GUERRA Y"
	#define STR0012 "CLAUSULAS DE HUELGAS, DEL INSTITUTO DE ASEGURADORES DE LONDRES."
#else
	#ifdef ENGLISH
		#define STR0001 "1% DEDUCTIVE OVER SHIPPING"
		#define STR0002 " TOTAL.                   "
		#define STR0003 "SAO PAULO"
		#define STR0004 "Policy No."
		#define STR0005 "Registration No."
		#define STR0006 "Insurance Date"
		#define STR0007 "Insurance Certificate No."
		#define STR0008 "DOOR BY DOOR INSURANCE, COVERING ALL RISKS, "
		#define STR0009 "INCLUDING WAR AND STRIKE RISKS,"
		#define STR0010 "ACCORDING TO THE LOAD CLAUSES (ALL RISKS),"
		#define STR0011 "WAR AND STRIKE CLAUSES, "
		#define STR0012 "IN ACCORDANCE WITH LONDON INSURANCE INSTITUTE."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "1% Dedutível Sobre O Total", "1% DEDUTIVEL SOBRE O TOTAL" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Do embfichue.              ", "DO EMBARQUE.              " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "São Paulo", "SAO PAULO" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Nº Apólice", "No. Apólice" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Nº Averbamento", "No. Averbação" )
		#define STR0006 "Dt. Seguro"
		#define STR0007 "Nr. Cert. Seguro"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Seguro Efectuado De Casa A Casa, Cobrindo Todos Os Riscos,", "SEGURO EFETUADO DE CASA A CASA, COBRINDO TODOS OS RISCOS," )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Incluindo Os Riscos De Guerra E", "INCLUSIVE OS RISCOS DE GUERRA E" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Greves, em conformidade com as cláusulas de carga (todos ", "GREVES, DE CONFORMIDADE COM AS CLAUSULAS DE CARGA (TODOS " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Os Riscos), Cláusulas De Guerra E", "OS RISCOS), CLAUSULAS DE GUERRA E" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Cláusulas De Greves, Do Instituto De Seguradoras De Londres.", "CLAUSULAS DE GREVES, DO INSTITUTO DE SEGURADORES DE LONDRES." )
	#endif
#endif
