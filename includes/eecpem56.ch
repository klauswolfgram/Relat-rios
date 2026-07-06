#ifdef SPANISH
	#define STR0001 "Descripcion de los Doc."
	#define STR0002 "Original"
	#define STR0003 "Copia"
	#define STR0004 "¿Desea mantemer los datos de la ultima impresion?"
	#define STR0005 "Atencion"
	#define STR0006 "Conocimiento de Embarque"
	#define STR0007 "Retiro"
	#define STR0008 "Factura Comercial"
	#define STR0009 "Packing List"
	#define STR0010 "Weight List"
	#define STR0011 "Certificado de Origen"
	#define STR0012 "Certificados"
	#define STR0013 "Aviso de Embarque"
	#define STR0014 "Fax"
	#define STR0015 "Courier"
	#define STR0016 "Certificado Cargo Gear"
	#define STR0017 "L / C Original"
	#define STR0018 "Por Enviar"
	#define STR0019 "Cuenta Grafica"
	#define STR0020 "Descontar de Factura"
	#define STR0021 "&Datos Generales"
	#define STR0022 "&Adjuntos"
	#define STR0023 "&Mensaje"
	#define STR0024 "&Instrucciones Especiales"
	#define STR0025 "&Cambio"
	#define STR0026 "Titulo"
	#define STR0027 "Documento"
	#define STR0028 "Contacto"
	#define STR0029 "Nombre"
	#define STR0030 "Telefono"
	#define STR0031 "Otros Datos"
	#define STR0032 "Cond. Pago"
	#define STR0033 "Fecha"
	#define STR0034 "Imprime Copia"
	#define STR0035 "Si"
	#define STR0036 "No"
	#define STR0037 "Banco de Cobranza"
	#define STR0038 "New"
	#define STR0039 "Datos de las Cuotas"
	#define STR0040 "Nº Contrato / Operacion"
	#define STR0041 "Valor"
	#define STR0042 "Tipo Mensaje"
	#define STR0043 "Tel.:"
	#define STR0044 " Fax: "
#else
	#ifdef ENGLISH
		#define STR0001 "Document Description"
		#define STR0002 "Original"
		#define STR0003 "Copy"
		#define STR0004 "Do you want to keep the last printing data ?"
		#define STR0005 "Warning"
		#define STR0006 "Bill of Lading"
		#define STR0007 "Bank Draft"
		#define STR0008 "Business Invoice"
		#define STR0009 "Packing List"
		#define STR0010 "Weight List"
		#define STR0011 "Source Certificate"
		#define STR0012 "Certificates"
		#define STR0013 "Shipping Notice"
		#define STR0014 "Fax Number"
		#define STR0015 "Courier"
		#define STR0016 "Gear Load Certifacate"
		#define STR0017 "Original L/C"
		#define STR0018 "To be sent"
		#define STR0019 "Graph Account"
		#define STR0020 "Deduct from the Invoice"
		#define STR0021 "General &Data"
		#define STR0022 "&Annexes"
		#define STR0023 "&Message"
		#define STR0024 "Special &Instructions"
		#define STR0025 "Ex&change"
		#define STR0026 "Bill"
		#define STR0027 "Document"
		#define STR0028 "Contact"
		#define STR0029 "Name"
		#define STR0030 "Telephone Number"
		#define STR0031 "Other Data"
		#define STR0032 "Payment Mode"
		#define STR0033 "Date"
		#define STR0034 "Print copy"
		#define STR0035 "Yes"
		#define STR0036 "No"
		#define STR0037 "Collection Bank"
		#define STR0038 "New"
		#define STR0039 "Installment Data"
		#define STR0040 "Contract/Operation No."
		#define STR0041 "Value"
		#define STR0042 "Message Type"
		#define STR0043 "Tel.No."
		#define STR0044 "Fax Number:"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Descrição Dos Doc.", "Descricao dos Doc." )
		#define STR0002 "Original"
		#define STR0003 "Copia"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Deseja manter os dados da última impressão ?", "Deseja manter os dados da ultima impressao ?" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atencao" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Conhecimento De Embfichue", "Conhecimento de Embarque" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Levantamento", "Saque" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Factura Comercial", "Fatura Comercial" )
		#define STR0009 "Packing List"
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Lista De Pesos", "Weight List" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Certificado De Origem", "Certificado de Origem" )
		#define STR0012 "Certificados"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Aviso De Embarque", "Aviso de Embarque" )
		#define STR0014 "Fax"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Guia", "Courier" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Certificado De Carga Do Equipamento", "Certificado Cargo Gear" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "L/c Original", "L/C Original" )
		#define STR0018 "A Remeter"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Conta Gráfica", "Conta Grafica" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Deduzir Da Factura", "Deduzir da Fatura" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Dados Gerais", "&Dados Gerais" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Anexos", "&Anexos" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "&mensagem", "&Mensagem" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Instruções Especiais", "&Instrucoes Especiais" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Câmbio", "&Cambio" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Título", "Titulo" )
		#define STR0027 "Documento"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Contacto", "Contato" )
		#define STR0029 "Nome"
		#define STR0030 "Telefone"
		#define STR0031 "Outros Dados"
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Cond.pagto.", "Cond.Pagto." )
		#define STR0033 "Data"
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Imprimir Cópia", "Imprime Copia" )
		#define STR0035 "Sim"
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Banco De Cobrança", "Banco de Cobranca" )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Novo", "New" )
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Dados Das Parcelas", "Dados das Parcelas" )
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "Núm. De Contrato/operação", "Nro. Contrato/Operacao" )
		#define STR0041 "Valor"
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Tipo De Mensagem", "Tipo Mensagem" )
		#define STR0043 "Tel.:"
		#define STR0044 If( cPaisLoc $ "ANG|PTG", " fax: ", " Fax: " )
	#endif
#endif
