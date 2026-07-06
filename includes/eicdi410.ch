#ifdef SPANISH
	#define STR0001 "Buscar"
	#define STR0002 "Manutenção Containers"
	#define STR0003 "Estorno Containers"
	#define STR0004 "Proceso"
	#define STR0005 "Total Containers"
	#define STR0006 "Total Recibidos"
	#define STR0007 "Fch Embarque"
	#define STR0008 "Nº de D. I."
	#define STR0009 "Fact Pago Imp."
	#define STR0010 "Fact Despacho"
	#define STR0011 "Contenedor 20'"
	#define STR0012 "Contenedor 40'"
	#define STR0013 "Contenedor 40' HC"
	#define STR0014 "Outros Containers"
	#define STR0015 "Control de Saldo de Contenedores"
	#define STR0017 "Control de Saldo de Contenedores - Proceso: "
	#define STR0018 "1-Contenedor 20'"
	#define STR0019 "2-Contenedor 40'"
	#define STR0020 "3-Container 40 HC"
	#define STR0021 "4-Otros"
	#define STR0022 "Otros"
	#define STR0023 "Procesando Registros"
	#define STR0024 "Tipo Containers"
	#define STR0025 "Fch Entrega"
	#define STR0026 "Ctd. Recibida"
	#define STR0027 "Nº Fact"
	#define STR0028 "Serie Fact"
	#define STR0029 "Fecha Fact"
	#define STR0030 "Observaciones"
	#define STR0031 "Inclusion"
	#define STR0032 "Modificacion"
	#define STR0033 "Borrado"
	#define STR0039 "Grabando Contenedor: "
	#define STR0040 "Borrando Contenedor: "
	#define STR0041 "Fch Pago Imp"
	#define STR0042 "Fch Despacho"
	#define STR0043 "Contenedores 20'"
	#define STR0044 "Contenedores 40'"
	#define STR0045 "Containers 40 HC"
	#define STR0046 "Total Contenedores"
	#define STR0047 "Conts 20 Receb."
	#define STR0048 "Conts 40 Receb."
	#define STR0049 "Conts 40 HC Receb."
	#define STR0050 "Otros Recib."
	#define STR0051 "Total Contened. Recib."
	#define STR0052 "¿Confirma la Reversion?"
	#define STR0053 "Reversion"
	#define STR0055 "Calculadora"
	#define STR0056 "Agenda"
	#define STR0057 "Help de Programa"
	#define STR0058 "Incluir"
	#define STR0059 "Borrar"
	#define STR0060 "Modificar"
	#define STR0061 "Anular - <Ctrl-X>"
	#define STR0062 " de Contenedores"
	#define STR0063 "Fch Fondeo"
	#define STR0064 "Fch Devolucion"
	#define STR0065 "Cod. Armador"
	#define STR0066 "Armador"
	#define STR0067 "Aviso"
	#define STR0068 "Se debe informar el Armador."
#else
	#ifdef ENGLISH
		#define STR0001 "Search"
		#define STR0002 "Manutenção Containers"
		#define STR0003 "Estorno Containers"
		#define STR0004 "Process"
		#define STR0005 "Total Containers"
		#define STR0006 "Total Received"
		#define STR0007 "Shipment Dt"
		#define STR0008 "D.I. Nr."
		#define STR0009 "Tax Paym. Dt"
		#define STR0010 "Clearance Dt"
		#define STR0011 "Container 20'"
		#define STR0012 "Container 40'"
		#define STR0013 "Container 40' HC"
		#define STR0014 "Outros Containers"
		#define STR0015 "Containers Balance Control"
		#define STR0017 "Containers Balance Control - Process: "
		#define STR0018 "1-Container 20'"
		#define STR0019 "2-Container 40'"
		#define STR0020 "3-Container 40 HC"
		#define STR0021 "4-Other"
		#define STR0022 "Other"
		#define STR0023 "Processing Records"
		#define STR0024 "Tipo Containers"
		#define STR0025 "Deliv. Dt"
		#define STR0026 "Qtty. Received"
		#define STR0027 "NF Nr."
		#define STR0028 "NF Series"
		#define STR0029 "NF Date"
		#define STR0030 "Notes"
		#define STR0031 "Insert"
		#define STR0032 "Edit"
		#define STR0033 "Delete"
		#define STR0039 "Saving Container: "
		#define STR0040 "Deleting Container: "
		#define STR0041 "Tax Paym.Dt"
		#define STR0042 "Cleara.Dt"
		#define STR0043 "Containers 20'"
		#define STR0044 "Containers 40'"
		#define STR0045 "Containers 40 HC"
		#define STR0046 "Total Containers"
		#define STR0047 "Conts 20 Receb."
		#define STR0048 "Conts 40 Receb."
		#define STR0049 "Conts 40 HC Receb."
		#define STR0050 "Other Recei."
		#define STR0051 "Total Conts Recei."
		#define STR0052 "OK to Reversal ?"
		#define STR0053 "Reversal"
		#define STR0055 "Calculator"
		#define STR0056 "Schedule"
		#define STR0057 "Program Help"
		#define STR0058 "Add"
		#define STR0059 "Delete"
		#define STR0060 "Edit"
		#define STR0061 "Cancel - <Ctrl-X>"
		#define STR0062 " Containers"
		#define STR0063 "Annotation Dt"
		#define STR0064 "Return Date"
		#define STR0065 "Shipowner Code"
		#define STR0066 "Shipowner"
		#define STR0067 "Warning"
		#define STR0068 "A Shipowner must be entered."
	#else
		#define STR0001 "Pesquisar"
		#define STR0002 "Manutenção Containers"
		#define STR0003 "Estorno Containers"
		#define STR0004 "Processo"
		#define STR0005 "Total Containers"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Total Recebidos", "Total Recibidos" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Dt. Embarque", "Dt Embarque" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Nº Da D.i.", "No. da D.I." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Dt. Pagt. Imp.", "Dt Pagto. Imp." )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Dt.desembaraço", "Dt Desembaraco" )
		#define STR0011 "Container 20'"
		#define STR0012 "Container 40'"
		#define STR0013 "Container 40' HC"
		#define STR0014 "Outros Containers"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Controlo De Saldo De Contentores", "Controle de Saldo de Containers" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Controle de saldo de contentores - processo: ", "Controle de Saldo de Containers - Processo: " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "1-contentor 20'", "1-Container 20'" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "2-contentor 40'", "2-Container 40'" )
		#define STR0020 "3-Container 40 HC"
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "4-outros", "4-Outros" )
		#define STR0022 "Outros"
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "A Processar Registos", "Processando Registros" )
		#define STR0024 "Tipo Containers"
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Dt. Entrega", "Dt Entrega" )
		#define STR0026 "Qtd. Recebida"
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Nr. Factura", "No. NF" )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Série Factura", "Serie NF" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Data Factura", "Data NF" )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Observações", "Observacoes" )
		#define STR0031 "Inclusão"
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Alteracão", "Alteração" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Eliminação", "Exclusão" )
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "A gravar contentor: ", "Gravando Container: " )
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "A eliminar contentor: ", "Excluindo Container: " )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Dt. Pagt.imp.", "Dt Pagto.Imp" )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Dt. Desemb.", "Dt Desemb." )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Contentores 20'", "Containers 20'" )
		#define STR0044 "Containers 40'"
		#define STR0045 "Containers 40 HC"
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Total Contentores", "Total Containers" )
		#define STR0047 "Conts 20 Receb."
		#define STR0048 "Conts 40 Receb."
		#define STR0049 "Conts 40 HC Receb."
		#define STR0050 "Outros Receb."
		#define STR0051 If( cPaisLoc $ "ANG|PTG", "Total Cont. Receb.", "Total Conts Receb." )
		#define STR0052 If( cPaisLoc $ "ANG|PTG", "Confirma o reembolso ?", "Confirma o Estorno ?" )
		#define STR0053 If( cPaisLoc $ "ANG|PTG", "Devolução", "Estorno" )
		#define STR0055 "Calculadora"
		#define STR0056 "Agenda"
		#define STR0057 If( cPaisLoc $ "ANG|PTG", "Ajuda De Programa", "Help de Programa" )
		#define STR0058 "Incluir"
		#define STR0059 "Excluir"
		#define STR0060 "Alterar"
		#define STR0061 If( cPaisLoc $ "ANG|PTG", "Cancelar - <ctrl-x>", "Cancelar - <Ctrl-X>" )
		#define STR0062 If( cPaisLoc $ "ANG|PTG", " De Contentores", " de Containers" )
		#define STR0063 If( cPaisLoc $ "ANG|PTG", "Dt Atracação", "Dt Atracacao" )
		#define STR0064 If( cPaisLoc $ "ANG|PTG", "Dt Devolução", "Dt Devolucao" )
		#define STR0065 If( cPaisLoc $ "ANG|PTG", "Cód.armador", "Cod.Armador" )
		#define STR0066 "Armador"
		#define STR0067 "Aviso"
		#define STR0068 "O Armador deve ser informado."
	#endif
#endif
