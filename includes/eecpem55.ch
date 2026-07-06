#ifdef SPANISH
	#define STR0001 "¿Desea mantener los datos de la ultima impresion?"
	#define STR0002 "Atencion"
	#define STR0003 "Codigo"
	#define STR0004 "Descripcion"
	#define STR0005 "Parametros"
	#define STR0006 "Specifications"
	#define STR0007 "Shipping Marks"
	#define STR0008 "Detalles"
	#define STR0009 "Titulo"
	#define STR0010 "Fecha"
	#define STR0011 "Responsable"
	#define STR0012 "Impresion:"
	#define STR0013 "Original"
	#define STR0014 "Copia"
	#define STR0015 "Blanco"
	#define STR0016 "Unidades de Medida"
	#define STR0017 "Quantity"
	#define STR0018 "Net Weight"
	#define STR0019 "Gross Weight"
	#define STR0020 "Volumenes"
	#define STR0021 "Tipo Mensaje"
	#define STR0022 "¡Debe informarse la fecha de impresion!"
	#define STR0023 "Aviso"
	#define STR0024 "¡Debe informarse el titulo del informe!"
	#define STR0025 "¡Debe informarse el responsable!"
	#define STR0026 "¡Debe informarse la unidad de medida para la cantidad!"
	#define STR0027 "¡Debe informarse la unidad de medida para el peso neto!"
	#define STR0028 "¡Debe informarse la unidad de medida para el peso bruto!"
	#define STR0029 "¡Debe informarse la unidad de medida para el volumen!"
	#define STR0030 "Tel.:"
	#define STR0031 " Fax.:"
	#define STR0032 "&Importador"
	#define STR0033 "&Exportador"
	#define STR0034 "Maximo de "
	#define STR0035 " lineas para impresion."
#else
	#ifdef ENGLISH
		#define STR0001 "Do you want to keep the last printing data ?"
		#define STR0002 "Warning"
		#define STR0003 "Code"
		#define STR0004 "Description"
		#define STR0005 "Parameters"
		#define STR0006 "Specifications"
		#define STR0007 "Shipping Marks"
		#define STR0008 "Details"
		#define STR0009 "Bill"
		#define STR0010 "Date"
		#define STR0011 "Person In-Charge"
		#define STR0012 "Printing:"
		#define STR0013 "Original"
		#define STR0014 "Copy"
		#define STR0015 "In Blank"
		#define STR0016 "Measurement Units"
		#define STR0017 "Quantity"
		#define STR0018 "Net Weight"
		#define STR0019 "Gross Weight"
		#define STR0020 "Volumes"
		#define STR0021 "Message Type"
		#define STR0022 "Printing date must be informed !"
		#define STR0023 "Warning"
		#define STR0024 "Report title must be informed !"
		#define STR0025 "Person in-charge must be informed !"
		#define STR0026 "Measurement unit for quantity must be informed !"
		#define STR0027 "Measurement unit for net weight must be informed !"
		#define STR0028 "Measurement unit for gross weight must be informed !"
		#define STR0029 "Measurement unit for volume must be informed !"
		#define STR0030 "Tel.No."
		#define STR0031 "Fax.No."
		#define STR0032 "&Importer"
		#define STR0033 "&Exporter"
		#define STR0034 "Maximum number of"
		#define STR0035 "rows to be printed."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Deseja manter os dados da última impressão ?", "Deseja manter os dados da ultima impressao ?" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atencao" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Código", "Codigo" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Parâmetros", "Parametros" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Especificações", "Specifications" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Definições De Remessa", "Shipping Marks" )
		#define STR0008 "Detalhes"
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Título", "Titulo" )
		#define STR0010 "Data"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Responsável", "Responsavel" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Impressão:", "Impressao:" )
		#define STR0013 "Original"
		#define STR0014 "Copia"
		#define STR0015 "Branco"
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Unidades De Medida", "Unidades de Medida" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Quantidade", "Quantity" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Peso Líquido", "Net Weight" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Peso Bruto", "Gross Weight" )
		#define STR0020 "Volumes"
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Tipo De Mensagem", "Tipo Mensagem" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "A data de impressão deve ser indicada !", "A data de impressao deve ser informada !" )
		#define STR0023 "Aviso"
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "O título do relatório deve ser indicado !", "O titulo do relatorio deve ser informado !" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "O responsável deve ser indicado !", "O responsavel deve ser informado !" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para a quantidade deve ser indicada !", "A unidade de medida para a quantidade deve ser informada !" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "A unidade de medida para o peso líquido deve ser informada !", "A unidade de medida para o peso liquido deve ser informada !" )
		#define STR0028 "A unidade de medida para o peso bruto deve ser informada !"
		#define STR0029 "A unidade de medida para o volume deve ser informada !"
		#define STR0030 "Tel.:"
		#define STR0031 " Fax.:"
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Importador", "&Importador" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Exportador", "&Exportador" )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Máximo de ", "Maximo de " )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", " linhas para impressão.", " linhas para impressao." )
	#endif
#endif
