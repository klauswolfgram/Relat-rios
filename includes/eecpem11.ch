#ifdef SPANISH
	#define STR0001 "TEL.: "
	#define STR0002 " Fax: "
	#define STR0003 "Unidad de medida "
	#define STR0004 " no registrada en "
	#define STR0005 "Aviso"
	#define STR0006 "Facturas:"
	#define STR0007 "Codigo"
	#define STR0008 "Descripcion"
	#define STR0009 "Documentos para"
	#define STR0010 "Notifys"
	#define STR0011 "Mensajes"
	#define STR0012 "Observaciones"
	#define STR0013 "Imprime NCM"
	#define STR0014 "Si"
	#define STR0015 "No"
	#define STR0016 "Imprime Peso Bruto"
	#define STR0017 "Suscriptor"
	#define STR0018 "Cargo"
	#define STR0019 "Doct.Para"
	#define STR0020 "Tipo Mensaje"
	#define STR0021 "Configuraciones"
	#define STR0022 "Unidades de Medida"
	#define STR0023 "U. M. Cant.:"
	#define STR0024 "U. M. Precio:"
	#define STR0025 "U. M. Peso.:"
	#define STR0026 "Impresion"
	#define STR0027 "Descripción del producto"
	#define STR0028 "Archivo"
	#define STR0029 "Proceso"
#else
	#ifdef ENGLISH
		#define STR0001 "Tel.No.: "
		#define STR0002 " FAX: "
		#define STR0003 "Measurement unit "
		#define STR0004 " is not registered in "
		#define STR0005 "Warning"
		#define STR0006 "Invoices:"
		#define STR0007 "Code"
		#define STR0008 "Description"
		#define STR0009 "Documents For"
		#define STR0010 "Notify´s"
		#define STR0011 "Messages"
		#define STR0012 "Observations"
		#define STR0013 "Print N.C.M."
		#define STR0014 "Yes"
		#define STR0015 "No"
		#define STR0016 "Print Gross Weight"
		#define STR0017 "Signatory"
		#define STR0018 "Function"
		#define STR0019 "Doct.For"
		#define STR0020 "Type of Message"
		#define STR0021 "Configurations"
		#define STR0022 "Measurement Units"
		#define STR0023 "M.U. Qtt.:"
		#define STR0024 "M.U. Price.:"
		#define STR0025 "M.U. Weight.:"
		#define STR0026 "Print"
		#define STR0027 "Product description"
		#define STR0028 "Register"
		#define STR0029 "Process"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Tel.: ", "TEL.: " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " fax: ", " FAX: " )
		#define STR0003 "Unidade de medida "
		#define STR0004 If( cPaisLoc $ "ANG|PTG", " não registada em ", " nào cadastrada em " )
		#define STR0005 "Aviso"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Facturas:", "Notas Fiscais:" )
		#define STR0007 "Código"
		#define STR0008 "Descrição"
		#define STR0009 "Documentos Para"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Notificações", "Notify's" )
		#define STR0011 "Mensagens"
		#define STR0012 "Observações"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Imprimir N.c.m. ", "Imprime N.C.M." )
		#define STR0014 "Sim"
		#define STR0015 "Não"
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Imprimir Peso Bruto", "Imprime Peso Bruto" )
		#define STR0017 "Assinante"
		#define STR0018 "Cargo"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Doct.para", "Doct.Para" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Tipo De Mensagem", "Tipo Mensagem" )
		#define STR0021 "Configurações"
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Unidades De Medida", "Unidades de Medida" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "U.m. Qtde.:", "U.M. Qtde.:" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "U.m. Preço.:", "U.M. Preço.:" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "U.m. Peso.:", "U.M. Peso.:" )
		#define STR0026 "Impressão"
		#define STR0027 "Descrição do produto"
		#define STR0028 "Cadastro"
		#define STR0029 "Processo"
	#endif
#endif
