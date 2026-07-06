#ifdef SPANISH
	#define STR0001 "Remitir"
	#define STR0002 "Cuenta Grafica"
	#define STR0003 "Descontar Factura"
	#define STR0004 "0-Todos"
	#define STR0005 "1-Remitir"
	#define STR0006 "2-Cuenta Grafica"
	#define STR0007 "3-Descontar Factura"
	#define STR0008 "TODOS"
	#define STR0009 " A "
	#define STR0010 "No existe comision para el intervalo seleccionado"
	#define STR0011 "Aviso"
	#define STR0012 "Fecha Inicial"
	#define STR0013 "Fecha Final"
	#define STR0014 "Representante"
	#define STR0015 "Exportador"
	#define STR0016 "Fabricante"
	#define STR0017 "Tipo Comision"
	#define STR0018 "Fecha Final no puede ser menor que Fecha Inicial"
#else
	#ifdef ENGLISH
		#define STR0001 "Send"
		#define STR0002 "Graphic Account"
		#define STR0003 "Deduce Invoice"
		#define STR0004 "0-All"
		#define STR0005 "1-Send"
		#define STR0006 "2-Graphic Account"
		#define STR0007 "3-Deduce Invoice"
		#define STR0008 "ALL"
		#define STR0009 " TO "
		#define STR0010 "There is no commission for the selected interval"
		#define STR0011 "Warning"
		#define STR0012 "Initial Date"
		#define STR0013 "Final Date"
		#define STR0014 "Representative"
		#define STR0015 "Exporter"
		#define STR0016 "Manufacturer"
		#define STR0017 "Comission Type"
		#define STR0018 "Final Date cannot be lower than Initial Date"
	#else
		#define STR0001 "Remeter"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Conta Gráfica", "Conta Grafica" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Deduzir Factura", "Deduzir Fatura" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "0-todos", "0-Todos" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "1-remeter", "1-Remeter" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "2-conta Gráfica", "2-Conta Gráfica" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "3-deduzir Factura", "3-Deduzir Fatura" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Todos", "TODOS" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", " até ", " ATE " )
		#define STR0010 "Não existe comissão para o intervalo escolhido"
		#define STR0011 "Aviso"
		#define STR0012 "Data Inicial"
		#define STR0013 "Data Final"
		#define STR0014 "Representante"
		#define STR0015 "Exportador"
		#define STR0016 "Fabricante"
		#define STR0017 "Tipo Comissão"
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Data final não pode ser menor que data inicial", "Data Final não pode ser menor que Data Inicial" )
	#endif
#endif
