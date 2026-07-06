#ifdef SPANISH
	#define STR0001 "1-No Enviados"
	#define STR0002 "2-Ya Enviados "
	#define STR0003 "3-Ambos       "
	#define STR0004 "Enviado"
	#define STR0005 "Estatus"
	#define STR0006 "Importador"
	#define STR0007 "Marca / Desmarca Todos"
	#define STR0008 "Campo de control de la Integracion-IN86 no existe."
	#define STR0009 "Entre en el configurador y cree el campo con las siguientes caracteristicas:"
	#define STR0010 "Campo: EEC_IN86"
	#define STR0011 "Tipo: Caracter"
	#define STR0012 "Tamano: 1"
	#define STR0013 "¡Formato: !"
	#define STR0014 "Encabezamiento y Descripcion: Flag IN86"
	#define STR0015 "Propiedad: marque la opcion Visualiza"
	#define STR0016 "Atencion"
	#define STR0017 "Integracion - IN86"
	#define STR0018 "Establecimiento"
	#define STR0019 "Fecha de la R. E."
	#define STR0020 "A"
	#define STR0021 "Fecha del embarque"
	#define STR0022 "Tipo"
	#define STR0023 "Seleccionando Procesos"
	#define STR0024 "¡No hay datos para generar el archivo!"
	#define STR0025 "Seleccion de Procesos - Integracion IN86"
	#define STR0026 "¡Integracion anulada por el usuario!"
	#define STR0027 "Aviso"
	#define STR0028 "Procesando"
	#define STR0029 "Espere"
	#define STR0030 "Integracion - IN86 - Configuracion"
	#define STR0031 "Archivo"
	#define STR0032 "Camino"
	#define STR0033 "Modelo"
	#define STR0034 "Conforme Tabla de Modelos de"
	#define STR0035 "Documentos Fiscales prevista en el"
	#define STR0036 "manual de orientacion del Convenio"
	#define STR0037 "ICMS nº 57, de 1995"
	#define STR0038 "Generando el archivo texto"
	#define STR0039 "¡Archivo generado con exito!"
	#define STR0040 "¡Proceso de embarque no registrado!"
	#define STR0041 "¡Local Invalido!"
	#define STR0042 "¡Rellene el Proceso o el Local!"
	#define STR0043 "Ya existe un archivo con este nombre. ¿Desea superponer?"
	#define STR0044 "¡No fue posible crear el archivo!"
	#define STR0045 "¡Intervalo de R. E. invalido!"
	#define STR0046 "¡Intervalo de la fecha de embarque invalido !"
	#define STR0047 "Verificando Proceso "
	#define STR0048 "Si"
	#define STR0049 "No"
	#define STR0050 "Verifique si todos los items del proceso estan con numero de RE y SD rellenados. Proceso "
	#define STR0051 "Existe alguna factura con falta de informaciones. Proceso "
	#define STR0052 ". ¡Verifique!"
	#define STR0053 "Fecha de la Factura"
	#define STR0054 "¡Intevalo de fechas de la facturas invalido!"
#else
	#ifdef ENGLISH
		#define STR0001 "1-Not Sent    "
		#define STR0002 "2-Already Sent"
		#define STR0003 "3-Both        "
		#define STR0004 "Sent"
		#define STR0005 "Status"
		#define STR0006 "Importer"
		#define STR0007 "Mark/Unmark All"
		#define STR0008 "IN86-Integration control Field does not exist."
		#define STR0009 "Start the configurator and create a field with the following features:"
		#define STR0010 "Field: EEC_IN86"
		#define STR0011 "Type: Caracter"
		#define STR0012 "Size: 1"
		#define STR0013 "Format: !"
		#define STR0014 "Header and Description: Flag IN86"
		#define STR0015 "Propriety: mark the option View"
		#define STR0016 "Attention"
		#define STR0017 "Integration - IN86"
		#define STR0018 "Store"
		#define STR0019 "Date of R.E."
		#define STR0020 "To"
		#define STR0021 "Date of shipment"
		#define STR0022 "Type"
		#define STR0023 "Selecting Processes"
		#define STR0024 "There are no data to generate the file !"
		#define STR0025 "Selection of Processes - Integration IN86"
		#define STR0026 "Integration cancelled by user !"
		#define STR0027 "Warning"
		#define STR0028 "Processing"
		#define STR0029 "Please, Wait"
		#define STR0030 "Integration - IN86 - Configuration"
		#define STR0031 "File"
		#define STR0032 "Route"
		#define STR0033 "Model"
		#define STR0034 "According to Table of Fiscal Document"
		#define STR0035 "Models foreseen in"
		#define STR0036 "Agreement orientation manual"
		#define STR0037 "ICMS n.57, of 1995"
		#define STR0038 "Generating the text file"
		#define STR0039 "File successfully generated !"
		#define STR0040 "Shipment process not registered !"
		#define STR0041 "Invalid store !"
		#define STR0042 "Fill out the Process or the Store !"
		#define STR0043 "A file with this name already exists. Do you want to overwrite it ?"
		#define STR0044 "A file was not possible to be created !"
		#define STR0045 "Invalid R.E. interval !"
		#define STR0046 "Invalid date of shipment !"
		#define STR0047 "Checking Process "
		#define STR0048 "Yes"
		#define STR0049 "No"
		#define STR0050 "Check whether the number of RE and SD is filled out in all items of process. Process "
		#define STR0051 "There is at least one invoice missing information. Process "
		#define STR0052 ". Check     !"
		#define STR0053 "Date of Invoice"
		#define STR0054 "Invalid interval of invoice dates !"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "1-não Enviados", "1-Nao Enviados" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "2-já enviados ", "2-Ja Enviados " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "3-ambos       ", "3-Ambos       " )
		#define STR0004 "Enviado"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Estado", "Status" )
		#define STR0006 "Importador"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Marca/desmarca Todos", "Marca/Desmarca Todos" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Campo de controlo da integração-in86 não existe.", "Campo de controle da Integracao-IN86 nao existe." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Entre no configurador e crie o campo com as seguintes características:", "Entre no configurador e crie o campo com as seguintes carasteristicas:" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Campo: Eec_in86", "Campo: EEC_IN86" )
		#define STR0011 "Tipo: Caracter"
		#define STR0012 "Tamanho: 1"
		#define STR0013 "Formato: !"
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Cabeçalho E Descrição: Marca In86", "Cabecalho e Descricao: Flag IN86" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Propriedade: Marcar A Opção Visualizada", "Propriedade: marcar a opcao Visualiza" )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Atenção", "Atencao" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Integração - In86", "Integracao - IN86" )
		#define STR0018 "Estabelecimento"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Data Da R.e.", "Data da R.E." )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Até", "Ate" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Data do embfichue", "Data do embarque" )
		#define STR0022 "Tipo"
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "A Seleccionar Processos", "Selecionando Processos" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Não há dados para criar o ficheiro !", "Nao ha dados para gerar o arquivo !" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Selecção De Processos - Integração In86", "Selecao de Processos - Integracao IN86" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Integração cancelada pelo utilizador !", "Integracao cancelada pelo usuario !" )
		#define STR0027 "Aviso"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "A processar", "Processando" )
		#define STR0029 "Aguarde"
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Integração - In86 - Configuração", "Integracao - IN86 - Configuracao" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Ficheiro", "Arquivo" )
		#define STR0032 "Caminho"
		#define STR0033 "Modelo"
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Conforme tabela de modelos de", "Conforme Tabela de Modelos de" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Documentos fiscais previstos no", "Documentos Fiscais prevista no" )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Manual De Orientação Do Acordo", "manual de orientacao do Convenio" )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Icms n.57, de 1995", "ICMS n.57, de 1995" )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "A criar ficheiro de texto", "Gerando o arquivo texto" )
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Ficheiro criado com sucesso !", "Arquivo gerado com sucesso !" )
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "Processo de embarque não registado !", "Processo de embarque nao cadastrado !" )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Estabelecimento inválido !", "Estabelecimento Invalido !" )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Preencha o processo ou o estabelecimento !", "Preencha o Processo ou o Estabelecimento !" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Já existe um ficheiro com este nome. deseja substitui-lo ?", "Ja existe um arquivo com este nome. Deseja sobrepor ?" )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Não foi possível criar o ficheiro !", "Nao foi possivel criar o arquivo !" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", "Intervalo de r.e. inválido !", "Intervalo de R.E. invalido !" )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Intervalo da data de embfichue inválido !", "Intervalo da data de embarque invalido !" )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "A verificar processo ", "Verificando Processo " )
		#define STR0048 "Sim"
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Verifique se todos os itens do processo têm número de re e sd preenchidos. processo ", "Verifique se todos os itens do processo estao com numero de RE e SD preenchidos. Processo " )
		#define STR0051 If( cPaisLoc $ "ANG|PTG", "Existe alguma factura em que faltam informações. processo ", "Existe alguma nota fiscal faltando informacoes. Processo " )
		#define STR0052 If( cPaisLoc $ "ANG|PTG", ". verifique !", ". Verifique !" )
		#define STR0053 If( cPaisLoc $ "ANG|PTG", "Data Da Factura", "Data da Nota Fiscal" )
		#define STR0054 If( cPaisLoc $ "ANG|PTG", "Intervalo de datas das facturas inválido !", "Intevalo de datas das notas fiscais invalido !" )
	#endif
#endif
