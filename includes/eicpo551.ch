#ifdef SPANISH
	#define STR0001 "Carta para envio de pedido"
	#define STR0002 "Buscar"
	#define STR0003 "Impresion"
	#define STR0004 "Seleccionando registros..."
	#define STR0005 "CARTA P/ ENVIO DE PEDIDO"
	#define STR0006 "Imprimiendo..."
	#define STR0007 "Emision de Shipping Instructions"
	#define STR0008 "PURCHASE ORDER"
	#define STR0009 "TO........:"
	#define STR0010 "ATTN......:"
	#define STR0011 "FAX Nº....:"
	#define STR0012 "PHONE Nº..:"
	#define STR0013 "OUR REFERENCE P. O. "
	#define STR0014 "PURCHASER: "
	#define STR0015 "PLEASE  FIND  ATTACHED  OUR  PURCHASE  ORDER  AND  CONFIRM  THE"
	#define STR0016 "REQUESTED SHIPMENT SCHEDULE WITHIN (05) DAYS."
	#define STR0017 "PLEASE NOTE THE REMARKS ON THE ATTACHED P. O."
	#define STR0018 "ANY DOUBT PLS CONTACT US"
	#define STR0019 "PHONE...:"
	#define STR0020 "Fax.....:"
	#define STR0021 "Modificar texto"
	#define STR0022 ""
#else
	#ifdef ENGLISH
		#define STR0001 "Letter to send Order"
		#define STR0002 "Search"
		#define STR0003 "Print"
		#define STR0004 "Selecting Records..."
		#define STR0005 "LETTER TO SEND ORDER"
		#define STR0006 "Printing..."
		#define STR0007 "Issue of Shipping Instructions"
		#define STR0008 "PURCHASE ORDER"
		#define STR0009 "TO........:"
		#define STR0010 "ATTN......:"
		#define STR0011 "FAX NO....:"
		#define STR0012 "PHONE NO..:"
		#define STR0013 "OUR REFERENCE P.O. "
		#define STR0014 "PURCHASER: "
		#define STR0015 "PLEASE  FIND  ATTACHED  OUR  PURCHASE  ORDER  AND  CONFIRM  THE"
		#define STR0016 "REQUESTED SHIPMENT SCHEDULE WITHIN (05) DAYS."
		#define STR0017 "PLEASE NOTE THE REMARKS ON THE ATTACHED P.O."
		#define STR0018 "ANY DOUBT PLS CONTACT US"
		#define STR0019 "PHONE...:"
		#define STR0020 "FAX.....:"
		#define STR0021 "Edit Text"
		#define STR0022 ""
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Carta Para Envio Do Pedido", "Carta para envio do Pedido" )
		#define STR0002 "Pesquisar"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Impressão", "Impressao" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "A Seleccionar Registos...", "Selecionando Registros..." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Carta P/ Envio Do Pedido", "CARTA P/ ENVIO DO PEDIDO" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "A imprimir...", "Imprimindo..." )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Emissão De Instruções De Embarque", "Emissao do Shipping Instructions" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Ordem De Compra", "PURCHASE ORDER" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Para.........: ", "TO........:" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Empregado ao serviço.......: ", "ATTN......:" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Fax Nr.....: ", "FAX NR....:" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Telefone Nr...: ", "PHONE NR..:" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Nossa referência enc. ", "OUR REFERENCE P.O. " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Comprador: ", "PURCHASER: " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Segue Em Anexo A Nossa Ordem De Compra E Confirme O", "PLEASE  FIND  ATTACHED  OUR  PURCHASE  ORDER  AND  CONFIRM  THE" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Pedido De Embarque No Prazo De(05) Dias.", "REQUESTED SHIPMENT SCHEDULE WITHIN (05) DAYS." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Por Favor Leia As Instruções No P.o. Anexado.", "PLEASE NOTE THE REMARKS ON THE ATTACHED P.O." )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Em Caso De Dúvida, Não Hesite Em Contactar-nos", "ANY DOUBT PLS CONTACT US" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Telefone...:", "PHONE...:" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Fax.....:", "FAX.....:" )
		#define STR0021 "Alterar Texto"
		#define STR0022 ""
	#endif
#endif
