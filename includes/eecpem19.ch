#ifdef SPANISH
	#define STR0001 " CP "
	#define STR0002 "Tel: "
	#define STR0003 " / Fax: "
	#define STR0004 "CENTRO DE SERVICIO A CLIENTES"
	#define STR0005 " DE "
	#define STR0006 "           Señor(a)"
	#define STR0007 "           C / C"
	#define STR0008 "           Adjunto a la presente, envío el primer ejemplar del Memorandum"
	#define STR0009 "de Exportacion y sus respectivos documentos - Bill of Landing, Registro de Exportacion"
	#define STR0010 "y Declaracion de Despacho - referente a los procesos:"
	#define STR0011 "                                Atentamente,"
	#define STR0012 "           POR FAVOR DEVUELVA ESTA COPIA CONFIRMANDO SU RECEPCION"
	#define STR0013 "Seleccion de Procesos"
	#define STR0014 "Para"
	#define STR0015 "Copia"
#else
	#ifdef ENGLISH
		#define STR0001 " ZIP CODE "
		#define STR0002 "Tel.No.: "
		#define STR0003 " / Fax: "
		#define STR0004 "CUSTOMER SERVICE CENTER"
		#define STR0005 " FROM "
		#define STR0006 "        Dear Sir or Madam"
		#define STR0007 "           C/C"
		#define STR0008 "           I herin infoem the attached forwarding of the Export"
		#define STR0009 " Memorandum 1st copy and its respective dociuments - Bill of Landing, Export Record "
		#define STR0010 "and the Dispatch Declaration - referring to the proceses:"
		#define STR0011 "                                Yours Truly,"
		#define STR0012 "           PLEASE SEND THIS COPY BACK REGISTERED"
		#define STR0013 "Process Selection"
		#define STR0014 "To"
		#define STR0015 "Copy"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", " c.p. ", " CEP " )
		#define STR0002 "Tel: "
		#define STR0003 If( cPaisLoc $ "ANG|PTG", " / fax: ", " / Fax: " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Centro De Serviço A Clientes", "CENTRO DE SERVICO A CLIENTES" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", " de ", " DE " )
		#define STR0006 "        A(o) Senhor(a)"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "           C/c", "           C/C" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "           Venho Por Este Meio Informá-lo Do Envio Em Anexo Da 1ª Via Do Memorando", "           Venho por meio desta informar-lhe o envio em anexo da 1a. via do Memorando" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "De Exportação E Seus Respectivos Documentos – Conhecimento De Carga, Registo De Exportação", "de Exportacao e seus respectivos documentos - Bill of Landing, Registro de Exportacao" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "E declaração de envio - referente aos processos:", "e Declaracao de Despacho - referente aos processos:" )
		#define STR0011 "                                Atenciosamente,"
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "           Por Favor Devolver Esta Via Protocolada", "           FAVOR DEVOLVER ESTA VIA PROTOCOLADA" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Seleção De Processos", "Seleção de Processos" )
		#define STR0014 "Para"
		#define STR0015 "Copia"
	#endif
#endif
