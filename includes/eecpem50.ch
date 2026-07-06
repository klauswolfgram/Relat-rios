#ifdef SPANISH
	#define STR0001 "CP: "
	#define STR0002 "TEL.: "
	#define STR0003 " FAX: "
	#define STR0004 "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEN: XXXX."
	#define STR0005 "ORIGEN: BRASIL. EXCEPTO EL PRODUCTO XXXX, ORIGEN XXX."
	#define STR0006 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEN XXX."
	#define STR0007 "SAMPLES FOR DIVULGATTION AND TESTS"
	#define STR0008 "MUESTRAS PARA DIVULGACION Y PRUEBAS"
	#define STR0009 "ACCOUNT:    "
	#define STR0010 "BENEFICIARY:   "
	#define STR0011 "REFERENCE: Nº INVOICE:   "
	#define STR0012 "BENEFICIARIO:   "
	#define STR0013 "CUENTA:   "
	#define STR0014 "REFERENCIA: Nº INVOICE:   "
	#define STR0015 "Original"
	#define STR0016 "Copia"
	#define STR0017 "¡Idioma no encontrado para la descripcion del total del peso!"
	#define STR0018 "Codigo"
	#define STR0019 "Descripcion"
	#define STR0020 "Documentos Para"
	#define STR0021 "Notifys"
	#define STR0022 "Observaciones"
	#define STR0023 "Mensaje"
	#define STR0024 "Si"
	#define STR0025 "No"
	#define STR0026 "Nacional"
	#define STR0027 "Muestra"
	#define STR0028 "Peso Bruto"
	#define STR0029 "Firma"
	#define STR0030 "Cargo"
	#define STR0031 "Doc. Para"
	#define STR0032 "¡Ya existen dos notifys seleccionados!"
	#define STR0033 "Aviso"
	#define STR0034 "Producto Importado"
	#define STR0035 "Origen de la Mercaderia"
#else
	#ifdef ENGLISH
		#define STR0001 "ZIP CODE:"
		#define STR0002 "TEL.: "
		#define STR0003 " FAX: "
		#define STR0004 "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEM: XXXX."
		#define STR0005 "ORIGEN: BRASIL. EXCEPTO EL PRODUCTO XXXX, ORIGEM XXX."
		#define STR0006 "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEM XXX."
		#define STR0007 "SAMPLES FOR DIVULGATTION AND TESTS"
		#define STR0008 "MUESTRAS PARA DIVULGACION Y PRUEBAS"
		#define STR0009 "ACCOUT:    "
		#define STR0010 "BENEFICIARY:   "
		#define STR0011 "REFERENCE: NR. INVOICE:   "
		#define STR0012 "BENEFICIARY:   "
		#define STR0013 "CUENTA:   "
		#define STR0014 "REFERENCE: INVOICE NR.:   "
		#define STR0015 "Original"
		#define STR0016 "Copy"
		#define STR0017 "Language not found for the weight total description!"
		#define STR0018 "Code"
		#define STR0019 "Description"
		#define STR0020 "Documents For"
		#define STR0021 "Notifys"
		#define STR0022 "Notes"
		#define STR0023 "Message"
		#define STR0024 "Yes"
		#define STR0025 "No"
		#define STR0026 "National"
		#define STR0027 "Sample"
		#define STR0028 "Gross Weight"
		#define STR0029 "Subscriber"
		#define STR0030 "Position"
		#define STR0031 "Doct. For"
		#define STR0032 "There are two notifys selected !"
		#define STR0033 "Warning"
		#define STR0034 "Imported Product"
		#define STR0035 "Goods Source"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Código postal: ", "CEP: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Tel.: ", "TEL.: " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", " fax: ", " FAX: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto Xxx, Origem: Xxxx.", "ORIGIN: BRAZIL. EXCEPT XXX, ORIGEM: XXXX." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto O Produto Xxxx, Origem Xxx.", "ORIGEN: BRASIL. EXCEPTO EL PRODUCTO XXXX, ORIGEM XXX." )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Origem: Brasil. Excepto Os Artigos Xxxx, Origem Xxx.", "ORIGEN: BRASIL. EXCEPTO LOS PRODUCTOS XXXX, ORIGEM XXX." )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Amostras Para Divulgação E Testes", "SAMPLES FOR DIVULGATTION AND TESTS" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Amostras Para Divulgação E Testes", "MUESTRAS PARA DIVULGACION Y PRUEBAS" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Conta:    ", "ACCOUT:    " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Beneficiário:   ", "BENEFICIARY:   " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Referencia: núm. de recibo:   ", "REFERENCE: NR. INVOICE:   " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Beneficiário:   ", "BENEFICIARIO:   " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Conta:   ", "CUENTA:   " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Referência: nº factura:   ", "REFERENCIA: NR. INVOICE:   " )
		#define STR0015 "Original"
		#define STR0016 "Copia"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Idioma não encontrado para a descrição do total do peso!", "Idioma nao encontrado para a descricao do total do peso!" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Código", "Codigo" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0020 "Documentos Para"
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Notificações", "Notify's" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Observações", "Observacoes" )
		#define STR0023 "Mensagem"
		#define STR0024 "Sim"
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0026 "Nacional"
		#define STR0027 "Amostra"
		#define STR0028 "Peso Bruto"
		#define STR0029 "Assinante"
		#define STR0030 "Cargo"
		#define STR0031 "Doct. Para"
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Já existem dois notify's selecionados !", "Ja existem dois notify's selecionados !" )
		#define STR0033 "Aviso"
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Artigo Importado", "Produto Importado" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Origem Da Mercadoria", "Origem da Mercadoria" )
	#endif
#endif
