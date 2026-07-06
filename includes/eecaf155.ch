#ifdef SPANISH
	#define STR0001 "Embarque"
	#define STR0002 "Usar la cotizacion de la fecha del:"
	#define STR0003 "&Dia"
	#define STR0004 "&Embarque"
	#define STR0005 "Barco"
	#define STR0006 "Mensajero"
	#define STR0007 " De "
	#define STR0008 " A "
	#define STR0009 "Abierto"
	#define STR0010 "Cerrado"
	#define STR0011 "BASE"
	#define STR0012 "C. I. F."
	#define STR0013 "TOTAL GENERAL"
	#define STR0014 "COSTO POR PROCESO"
	#define STR0015 "PEDIDO "
	#define STR0016 "FCH."
	#define STR0017 "TOTAL DEL PEDIDO "
	#define STR0018 "COSTO POR ITEM"
	#define STR0019 "TOTAL DEL ITEM "
	#define STR0020 "¡Proceso no registrado !"
	#define STR0021 "Atencion"
	#define STR0022 "120-Por Remitir"
	#define STR0023 "121-Cuenta Grafica"
	#define STR0024 "122-Por Deducir de la Factura"
	#define STR0025 "120-Comision (Por Remitir)"
	#define STR0026 "121-Comision (Cuenta Grafica)"
	#define STR0027 "122-Comision (Por Deducir de la Factura)"
#else
	#ifdef ENGLISH
		#define STR0001 "Shipment"
		#define STR0002 "Use the quotation on the ... date:"
		#define STR0003 "&Day"
		#define STR0004 "&Shipment"
		#define STR0005 "Ship"
		#define STR0006 "Courier"
		#define STR0007 " From "
		#define STR0008 " To "
		#define STR0009 "Open"
		#define STR0010 "Closed"
		#define STR0011 "BASIS"
		#define STR0012 "C.I.F."
		#define STR0013 "GRAND TOTAL"
		#define STR0014 "COST PER PROCESS"
		#define STR0015 "ORDER "
		#define STR0016 "DT."
		#define STR0017 "ORDER TOTAL "
		#define STR0018 "COST PER ITEM"
		#define STR0019 "ITEM TOTAL "
		#define STR0020 "Process not registered !"
		#define STR0021 "Attention"
		#define STR0022 "120-To Be Forwarded"
		#define STR0023 "121-Graph Account"
		#define STR0024 "122-To Be Discounted from the Invoice"
		#define STR0025 "120-Commission (To Be Forwarded)"
		#define STR0026 "121-Commission (Graph Account)"
		#define STR0027 "122-Commission (To Be Discounted from the Invoice)"
	#else
		#define STR0001 "Embarque"
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Usar a cotação da data do:", "Usar a cotacao da data do:" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "&dia", "&Dia" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Embarque", "&Embarque" )
		#define STR0005 "Navio"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Guia", "Courier" )
		#define STR0007 " de "
		#define STR0008 " para "
		#define STR0009 "Aberto"
		#define STR0010 "Fechado"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Base", "BASE" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "C.i.f.", "C.I.F." )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Total Crial", "TOTAL GERAL" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Custo Por Processo", "CUSTO POR PROCESSO" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Pedido ", "PEDIDO " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Dt.", "DT." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Total do pedido ", "TOTAL DO PEDIDO " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Custo Por Elemento", "CUSTO POR ITEM" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Total do item ", "TOTAL DO ITEM " )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Processo não registado !", "Processo nao cadastrado !" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atencao" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "120-a Remeter", "120-A Remeter" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "121-conta Gráfica", "121-Conta Grafica" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "122-a Deduzir Da Factura", "122-A Deduzir da Fatura" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "120-emissão (a Remeter)", "120-Comissao (A Remeter)" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "121-emissão (conta Gráfica)", "121-Comissao (Conta Grafica)" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "122-emissão (a Deduzir Da Factura)", "122-Comissao (A Deduzir da Fatura)" )
	#endif
#endif
