#ifdef SPANISH
	#define STR0001 "Informe de Demurrage"
	#define STR0002 "A rayas"
	#define STR0003 "Importacion"
	#define STR0004 "Armador: "
	#define STR0005 "De "
	#define STR0006 " a "
	#define STR0007 "        EXCENTO"
	#define STR0008 "Despues "
	#define STR0009 "Total del Contenedor:"
	#define STR0010 "Total del Proceso:"
	#define STR0011 "Total del Armador:"
	#define STR0012 "Proceso"
	#define STR0013 "Fch. Fondeo"
	#define STR0014 "Nº de la D. I."
	#define STR0015 "Fch Embarque"
	#define STR0016 "Fch Despach"
	#define STR0017 "Tot. Contenedores"
	#define STR0018 "Cuentas Recibido"
	#define STR0019 "Nº Contenedor"
	#define STR0020 "Tipo Contenedor"
	#define STR0021 "Moneda"
	#define STR0022 "Fch. Devolucion"
	#define STR0023 "Fch. Pago."
	#define STR0024 "Periodo"
	#define STR0025 "Nº Dias"
	#define STR0026 "Moneda Extranjera"
	#define STR0027 "Moneda Nacional"
	#define STR0028 "Fecha Final no puede ser menor que Fecha Inicial"
	#define STR0029 "Aviso"
	#define STR0030 "*** ANULADO POR EL OPERADOR ***"
	#define STR0031 "Armador Diferente del Proceso"
	#define STR0032 "Container devuelto"
	#define STR0033 "Container no devuelto"
#else
	#ifdef ENGLISH
		#define STR0001 "Demurrage report"
		#define STR0002 "Z.Form"
		#define STR0003 "Import"
		#define STR0004 "Shipowner: "
		#define STR0005 "From"
		#define STR0006 " to "
		#define STR0007 "        EXEMPT"
		#define STR0008 "After"
		#define STR0009 "Container Total:"
		#define STR0010 "Process Total:"
		#define STR0011 "Shipowner Total:"
		#define STR0012 "Process"
		#define STR0013 "Annotation Dt."
		#define STR0014 "D.I. Number"
		#define STR0015 "Shipment Dt"
		#define STR0016 "Disch. Dt."
		#define STR0017 "Containers Tot."
		#define STR0018 "Received Conts."
		#define STR0019 "Container Nr."
		#define STR0020 "Container Type"
		#define STR0021 "Currency"
		#define STR0022 "Return Date"
		#define STR0023 "Paym. Dt."
		#define STR0024 "Period"
		#define STR0025 "Nr.of Days"
		#define STR0026 "Foreign Currency"
		#define STR0027 "National Currency"
		#define STR0028 "Final Date cannot be lower than Initial Date"
		#define STR0029 "Warning"
		#define STR0030 "*** CANCELLED BY THE OPERATOR ***"
		#define STR0031 "Shipowner Different from the Process"
		#define STR0032 "Container Returned"
		#define STR0033 "Container not Returned"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Relatório De Taxa De Armazenagem", "Relatorio de Demurrage" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Código de barras", "Zebrado" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Importação", "Importacao" )
		#define STR0004 "Armador: "
		#define STR0005 "De "
		#define STR0006 " a "
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "        Isento", "        ISENTO" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Após ", "Apos " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Total Do Contentor:", "Total do Container:" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Total Do Processo:", "Total do Processo:" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Total Do Armador:", "Total do Armador:" )
		#define STR0012 "Processo"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Dt.atracagem", "Dt.Atracacao" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Nº Da D.i.", "No. da D.I." )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Dt.embarque", "Dt.Embarque" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Dt.desemb.", "Dt.Desemb." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Tot.contentores", "Tot.Containers" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Conts.recebido", "Conts.Recebido" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Nr. Contentor", "Nr. Container" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Pedido Contentor", "Tipo Container" )
		#define STR0021 "Moeda"
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Data de devolução", "Dt.Devolucao" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Dt.pagt.", "Dt.Pagto." )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Período", "Periodo" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Nr. Dias", "No. Dias" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Moeda Estrangeira", "Moeda Estrageira" )
		#define STR0027 "Moeda Nacional"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
		#define STR0029 "Aviso"
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "*** cancelado pelo operador ***", "*** CANCELADO PELO OPERADOR ***" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Armador Diferente Do Processo", "Armador Diferente do Processo" )
		#define STR0032 "Conteiner Devolvido"
		#define STR0033 "Conteiner Não Devolvido"
	#endif
#endif
