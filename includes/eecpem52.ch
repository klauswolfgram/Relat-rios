#ifdef SPANISH
	#define STR0001 "¿Desea mantener los datos de la ultima impresion?"
	#define STR0002 "Atencion"
	#define STR0003 "&Parametros"
	#define STR0004 "&Specifications"
	#define STR0005 "Shipping &Marks"
	#define STR0006 "&Observacion"
	#define STR0007 "&Totales"
	#define STR0008 "Detalles"
	#define STR0009 "Titulo"
	#define STR0010 "Fecha"
	#define STR0011 "Responsable"
	#define STR0012 "Cond. Pago"
	#define STR0013 "Impresion:"
	#define STR0014 "Original"
	#define STR0015 "Copia"
	#define STR0016 "Blanco"
	#define STR0017 "Unidades de Medida"
	#define STR0018 "Quantity"
	#define STR0019 "Net Weight"
	#define STR0020 "Gross Weight"
	#define STR0021 "Unit Price"
	#define STR0022 "Total Amount"
	#define STR0023 "Volumes"
	#define STR0024 "Datos Adicionales"
	#define STR0025 "Origin of Goods"
	#define STR0026 "Issuing Bank"
	#define STR0027 "Tipo Mensaje"
	#define STR0028 "¡Debe informarse el titulo del informe!"
	#define STR0029 "Aviso"
	#define STR0030 "¡Debe informarse la fecha de impresion!"
	#define STR0031 "¡Debe informarse al responsable!"
	#define STR0032 "¡Debe informarse la condicion de pago!"
	#define STR0033 "¡Debe informarse la unidad de medida para la cantidad!"
	#define STR0034 "¡Debe informarse la unidad de medida para el peso neto!"
	#define STR0035 "¡Debe informarse la unidad de medida para el peso bruto!"
	#define STR0036 "¡Debe informarse la unidad de medida para el volumen!"
	#define STR0037 "¡Debe informarse la unidad de medida para el precio unitario!"
	#define STR0038 "¡Debe informarse la unidad de medida para el total general!"
	#define STR0039 "Tel.:"
	#define STR0040 " Fax.:"
	#define STR0041 "&Importador"
	#define STR0042 "&Exportador"
	#define STR0043 "Maximo de "
	#define STR0044 " lineas para impresion."
#else
	#ifdef ENGLISH
		#define STR0001 "Do you want to keep the last printing data ?"
		#define STR0002 "Warning"
		#define STR0003 "&Parameters"
		#define STR0004 "&Specifications"
		#define STR0005 "Shipping &Marks"
		#define STR0006 "N&ote"
		#define STR0007 "&Total"
		#define STR0008 "Details"
		#define STR0009 "Bill"
		#define STR0010 "Date"
		#define STR0011 "Person In-Charge"
		#define STR0012 "Payment Term"
		#define STR0013 "Printing:"
		#define STR0014 "Original"
		#define STR0015 "Copy"
		#define STR0016 "In Blank"
		#define STR0017 "Measurement Units"
		#define STR0018 "Quantity"
		#define STR0019 "Net Weight"
		#define STR0020 "Gross Weight"
		#define STR0021 "Unit Price"
		#define STR0022 "Total Amount"
		#define STR0023 "Volumes"
		#define STR0024 "Addicional Data"
		#define STR0025 "Goods Source"
		#define STR0026 "Issuing Bank"
		#define STR0027 "Message Type"
		#define STR0028 "Report title must be informed !"
		#define STR0029 "Warning"
		#define STR0030 "Printing date must be informed !"
		#define STR0031 "Person in-charge must be informed !"
		#define STR0032 "Payment term must be informed !"
		#define STR0033 "Measurement unit for quantity must be informed !"
		#define STR0034 "Measurement unit for net weight must be informed !"
		#define STR0035 "Measurement unit for gross weight must be informed !"
		#define STR0036 "Measurement unit for volume must be informed !"
		#define STR0037 "Measurement unit for the unit price must be informed !"
		#define STR0038 "Measurement unit for grand total must be informed !"
		#define STR0039 "Tel.No.:"
		#define STR0040 "Fax No.:"
		#define STR0041 "&Importer"
		#define STR0042 "&Exporter"
		#define STR0043 "Maximum number of"
		#define STR0044 "rows to be printed."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Deseja manter os dados da última impressão ?", "Deseja manter os dados da ultima impressao ?" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atencao" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Parâmetros", "&Parametros" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Especificações", "&Specifications" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Embarque marcas", "Shipping &Marks" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Observação", "&Observacao" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "&totais", "&Totais" )
		#define STR0008 "Detalhes"
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Título", "Titulo" )
		#define STR0010 "Data"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Responsável", "Responsavel" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Cond. De Pgt.", "Cond. Pagto." )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Impressão:", "Impressao:" )
		#define STR0014 "Original"
		#define STR0015 "Copia"
		#define STR0016 "Branco"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Unidades De Medida", "Unidades de Medida" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Quantidade", "Quantity" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Peso Líquido", "Net Weight" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Peso Bruto", "Gross Weight" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Preço Unitário", "Unit Price" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Quantia Total", "Total Amount" )
		#define STR0023 "Volumes"
		#define STR0024 "Dados Adicionais"
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Origem De Bens", "Origem of Goods" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Banco De Emissão", "Issuing Bank" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Tipo De Mensagem", "Tipo Mensagem" )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "O título do relatório deve ser introduzido!", "O titulo do relatorio deve ser informado!" )
		#define STR0029 "Aviso"
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "A data de impressão deve ser informada!", "A data de impressao deve ser informada!" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "O responsável deve ser indicado!", "O responsavel deve ser informado!" )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "A condição de pagamento deve ser indicada!", "A condicao de pagamento deve ser informada!" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para a quantidade deve ser indicada!", "A unidade de medida para a quantidade deve ser informada!" )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para o peso líquido deve ser indicada!", "A unidade de medida para o peso liquido deve ser informada!" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para o peso bruto deve ser indicada!", "A unidade de medida para o peso bruto deve ser informada!" )
		#define STR0036 "A unidade de medida para o volume deve ser informada!"
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para o preço unitário deve ser informada!", "A unidade de medida para o preco unitario deve ser informada!" )
		#define STR0038 "A unidade de medida para o total geral deve ser informada!"
		#define STR0039 "Tel.:"
		#define STR0040 " Fax.:"
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Importador", "&Importador" )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Exportador", "&Exportador" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Máximo de ", "Maximo de " )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", " linhas para impressão.", " linhas para impressao." )
	#endif
#endif
