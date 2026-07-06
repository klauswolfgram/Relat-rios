#ifdef SPANISH
	#define STR0001 "Unidad de medida "
	#define STR0002 " no registrada en "
	#define STR0003 "Aviso"
	#define STR0004 "Facturas:"
	#define STR0005 "Codigo"
	#define STR0006 "Descripcion"
	#define STR0007 "Documentos Para"
	#define STR0008 "Notifys"
	#define STR0009 "Mensajes"
	#define STR0010 "Observaciones"
	#define STR0011 "Imprime NCM"
	#define STR0012 "Si"
	#define STR0013 "No"
	#define STR0014 "Firma"
	#define STR0015 "Cargo"
	#define STR0016 "Doc. Para"
	#define STR0017 "¡Ya existen dos notifys seleccionados!"
	#define STR0018 "Tipo Mensaje"
#else
	#ifdef ENGLISH
		#define STR0001 "Unit of Measure "
		#define STR0002 " not registered on "
		#define STR0003 "Warning"
		#define STR0004 "Invoices:"
		#define STR0005 "Code"
		#define STR0006 "Description"
		#define STR0007 "Documents To"
		#define STR0008 "Notify's"
		#define STR0009 "Messages"
		#define STR0010 "Notes"
		#define STR0011 "Print N.C.M."
		#define STR0012 "Yes"
		#define STR0013 "No"
		#define STR0014 "Subscriber"
		#define STR0015 "Position"
		#define STR0016 "Doct. To"
		#define STR0017 "There are two selecte notifys !"
		#define STR0018 "Message Type"
	#else
		#define STR0001 "Unidade de medida "
		#define STR0002 If( cPaisLoc $ "ANG|PTG", " não registada em ", " nao cadastrada em " )
		#define STR0003 "Aviso"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Facturas:", "Notas Fiscais:" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Código", "Codigo" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0007 "Documentos Para"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Notificações", "Notify's" )
		#define STR0009 "Mensagens"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Observações", "Observacoes" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Imprimir N.c.m. ", "Imprime N.C.M." )
		#define STR0012 "Sim"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0014 "Assinante"
		#define STR0015 "Cargo"
		#define STR0016 "Doct. Para"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Já existem dois notify's selecionados !", "Ja existem dois notify's selecionados !" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Tipo De Mensagem", "Tipo Mensagem" )
	#endif
#endif
