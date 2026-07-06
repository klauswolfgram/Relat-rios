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
		#define STR0001  "Unidade de medida "
		Static STR0002 := " nao cadastrada em "
		#define STR0003  "Aviso"
		Static STR0004 := "Notas Fiscais:"
		Static STR0005 := "Codigo"
		Static STR0006 := "Descricao"
		#define STR0007  "Documentos Para"
		Static STR0008 := "Notify's"
		#define STR0009  "Mensagens"
		Static STR0010 := "Observacoes"
		Static STR0011 := "Imprime N.C.M."
		#define STR0012  "Sim"
		Static STR0013 := "Nao"
		#define STR0014  "Assinante"
		#define STR0015  "Cargo"
		#define STR0016  "Doct. Para"
		Static STR0017 := "Ja existem dois notify's selecionados !"
		Static STR0018 := "Tipo Mensagem"
	#endif
#endif

#ifndef SPANISH
#ifndef ENGLISH
	STATIC uInit := __InitFun()

	Static Function __InitFun()
	uInit := Nil
	If Type('cPaisLoc') == 'C'

		If cPaisLoc == "ANG"
			STR0002 := " não registada em "
			STR0004 := "Facturas:"
			STR0005 := "Código"
			STR0006 := "Descrição"
			STR0008 := "Notificações"
			STR0010 := "Observações"
			STR0011 := "Imprimir N.c.m. "
			STR0013 := "Não"
			STR0017 := "Já existem dois notify's selecionados !"
			STR0018 := "Tipo De Mensagem"
		ElseIf cPaisLoc == "PTG"
			STR0002 := " não registada em "
			STR0004 := "Facturas:"
			STR0005 := "Código"
			STR0006 := "Descrição"
			STR0008 := "Notificações"
			STR0010 := "Observações"
			STR0011 := "Imprimir N.c.m. "
			STR0013 := "Não"
			STR0017 := "Já existem dois notify's selecionados !"
			STR0018 := "Tipo De Mensagem"
		EndIf
		EndIf
	Return Nil
#ENDIF
#ENDIF
