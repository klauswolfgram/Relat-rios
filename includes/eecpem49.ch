#ifdef SPANISH
	#define STR0001 "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEN: XXXX."
	#define STR0002 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCOS XXXX, ORIGEN XXX."
	#define STR0003 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEN XXX."
	#define STR0004 "ACCOUNT:   "
	#define STR0005 "BENEFICIARY:    "
	#define STR0006 "REFERENCE: Nº INVOICE:   "
	#define STR0007 "BENEFICIARIO:   "
	#define STR0008 "CUENTA:    "
	#define STR0009 "REFERENCIA: Nº INVOICE"
	#define STR0010 "¡Idioma no encontrado para la descripcion del total del peso!"
	#define STR0011 "Codigo"
	#define STR0012 "Descripcion"
	#define STR0013 "Documentos Para"
	#define STR0014 "Notifys"
	#define STR0015 "Observaciones"
	#define STR0016 "Mensaje"
	#define STR0017 "Original"
	#define STR0018 "Si"
	#define STR0019 "No"
	#define STR0020 "Nacional"
	#define STR0021 "Peso Bruto"
	#define STR0022 "Firma"
	#define STR0023 "Cargo"
	#define STR0024 "Doc. Para"
	#define STR0025 "¡Ya existen dos notifys seleccionados!"
	#define STR0026 "Aviso"
#else
	#ifdef ENGLISH
		#define STR0001 "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEM: XXXX."
		#define STR0002 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCOS XXXX, ORIGEM XXX."
		#define STR0003 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEM XXX."
		#define STR0004 "ACCOUNT:   "
		#define STR0005 "BENEFICIARY:    "
		#define STR0006 "REFERENCE: NR. INVOICE:   "
		#define STR0007 "BENEFICIARY:   "
		#define STR0008 "CUENTA:    "
		#define STR0009 "REFERENCE: INVOICE NR."
		#define STR0010 "Language not found for the weight total description!"
		#define STR0011 "Code"
		#define STR0012 "Description"
		#define STR0013 "Documents For"
		#define STR0014 "Notifys"
		#define STR0015 "Notes"
		#define STR0016 "Message"
		#define STR0017 "Original"
		#define STR0018 "Yes"
		#define STR0019 "No"
		#define STR0020 "National"
		#define STR0021 "Gross Weight"
		#define STR0022 "Subscriber"
		#define STR0023 "Position"
		#define STR0024 "Doct. To"
		#define STR0025 "There are two notifys already selected!"
		#define STR0026 "Warning"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto Xxx, Origem: Xxxx.", "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEM: XXXX." )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto Os Artigos Xxxx, Origem Xxx.", "ORIGEN: BRASIL. EXCEPTO LOS PRODUCOS XXXX, ORIGEM XXX." )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto Os Artigos Xxxx, Origem Xxx.", "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEM XXX." )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Conta:   ", "ACCOUNT:   " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Beneficiário:    ", "BENEFICIARY:    " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Referencia: núm. de recibo:   ", "REFERENCE: NR. INVOICE:   " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Beneficiário:   ", "BENEFICIARIO:   " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Conta:    ", "CUENTA:    " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Referência: Nº Factura", "REFERENCIA: NR. INVOICE" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Idioma não encontrado para a descrição do total do peso!", "Idioma nao encontrado para a descricao do total do peso!" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Código", "Codigo" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0013 "Documentos Para"
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Notificações", "Notify's" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Observações", "Observacoes" )
		#define STR0016 "Mensagem"
		#define STR0017 "Original"
		#define STR0018 "Sim"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0020 "Nacional"
		#define STR0021 "Peso Bruto"
		#define STR0022 "Assinante"
		#define STR0023 "Cargo"
		#define STR0024 "Doct. Para"
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Já existem dois comunicados seleccionados!", "Ja existem dois notify's selecionados!" )
		#define STR0026 "Aviso"
	#endif
#endif
