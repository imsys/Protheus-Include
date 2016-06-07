/*/{Protheus.doc} tdsBirt.ch
	Definição da metalingguagem para definição de relatórios pré-definidos.
	Inclui também definições de constantes de uso geral.
@author acandido
@since 21/06/2013
@version 1.0
@description
	Contem os comandos da metalinguagem para definição de relatórios pré-definidos.
	Através destes comandos, o desenvolver definirá o que será obtido de dados e como,
	definindo as regras de seleção e agrupamento de dados, que serão utilizados em
	relatórios criados via Birt. O usuário deste relatório, poderá apenas trabalhar
	no leiuate dele.

/*/

#ifndef _TDSBIRT_CH
#  define __TDSBIRT_CH

// modos de processamento
#define TB_NOTHING    0
#define TB_PREVIEW    1
#define TB_STRUCT     2
#define TB_RUNNING    3

//indexadores de apoio para acesso a definições efetuadas em arrays
#define IX_ALIAS 1
#define IX_TYPE  2
#define IX_LEN   3
#define IX_NDEC  4
#define IX_LABEL 5
#define IX_EXPR_SQL 6
#define IX_REQUIRED 7
#define IX_RANGE 8
#define IX_SELECTION 9
#define IX_DYNAMIC 10
#define IX_HELP 11
#define IX_FORMAT 12
#define IX_ECHO_INPUT 13
#define IX_HIDDEN 14
#define IX_WIDGET 15
#define IX_LIST_LIMIT 16
#define IX_DEFAULT_VALUE 17
#define IX_VALUE 18
#define IX_VALID 19

#define IX_PARAM_SIZE 19

//pastas padrão
#define DIR_BIRT_TEMP "\tdsBirt_temp"
#define DIR_WEB_VIEWER "\webapps\WebViewer"

#define DIR_JETTY DIR_TDSBIRT_HOME + "\jetty"
#define DIR_STANDE_ALONE DIR_TDSBIRT_HOME + "\standalone"

#define E000_SUCESS "E000_SUCCESS"
#define E000_SUCESS_TEXT ""

//codigo e mensagens de erros tratados ou emitidos
#define E001_INVALID_PARAMS       "E001_INVALID_PARAMS"
#define E001_INVALID_PARAMS_TEXT "O usuário e/ou a senha informado são inválidas"

#define E002_REPORT_DEF_NOT_FOUND "E002_REPORT_DEF_NOT_FOUND"
#define E002_REPORT_DEF_NOT_FOUND_TEXT "A definição do relatório solicitado não foi localizada."

#define E003_REPORT_TOO_MANY_DEF "E003_REPORT_TOO_MANY_DEF"
#define E003_REPORT_TOO_MANY_DEF_TEXT "Existe mais de uma definição do relatório solicitado."

#define E004_RUN_ERROR "E004_RUN_ERROR"
#define E004_RUN_ERROR_TEXT "Ocorreu uma falha durante a execução do relatório. Veja detalhes no log do servidor."

#define E005_EXTRACT_RPO "E005_EXTRACT_RPO"
#define E005_EXTRACT_RPO_TEXT "Não foi possível extrair definição do relatório do RPO."

#define E006_IO_ERROR  "E006_IO_ERROR"
#define E006_IO_ERROR_TEXT "Falha durante operação de I/O. "

#define E007_SGDB_NOT_SUPPORTED  "E007_SGDB_NOT_SUPPORTED"
#define E007_SGDB_NOT_SUPPORTED_TEXT "SGDB não suportado pelo serviço de impressão (WebViewer)."

#define E008_CATALINA_HOME       "E008_CATALINA_HOME"
#define E008_CATALINA_HOME_TEXT "Variável de ambiente CATALINA_HOME não foi definida no servidor do Protheus Server."

#define E009_XML_ERROR           "E009_XML_ERROR"
#define E009_XML_ERROR_TEXT      "Erro "

#define E010_DB_NOT_CONNECTED    "E010_DB_NOT_CONNECTED"
#define E010_DB_NOT_CONNECTED_TEXT  "Banco de dados não conectado ou RPO não compatível."


//formatos de arquivos de saida suportados
//ao modificar os formatos, verificar a definicao do comando "activate report"
#define FMT_HTML   "html"
#define FMT_PDF   "pdf"

// ##################################################################################
// Meta linguagem para definição do relatório pré-definido
// ##################################################################################
#command report <identifier> ;
=> static _REPORT := nil;;
	function r_<identifier>();;
		if (_REPORT == nil);;
			_REPORT := _r<identifier>():_r<identifier>(<"identifier">);;
		endif;;
	return _REPORT;;
	class _r<identifier> from BIRTReport;;
     method _r<identifier>();;
     method run();;
    end class;;
	method run(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF) class _r<identifier>;;
    return runReport(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF);;
    method _r<identifier>() class _r<identifier>;;
    	::BIRTReport(<"identifier">);;
		::preDefined(.t.)

#command user_report <identifier> ;
=> static _REPORT := nil;;
	 user function r_<identifier>();;
		if (_REPORT == nil);;
			_REPORT := _r<identifier>():_r<identifier>(<"identifier">);;
		endif;;
	return _REPORT;;
	class _r<identifier> from BIRTReport;;
     method _r<identifier>();;
     method run();;
    end class;;
	method run(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF) class _r<identifier>;;
    return runReport(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF);;
    method _r<identifier>() class _r<identifier>;;
    	::BIRTReport(<"identifier">);;
		::preDefined(.t.)		
		
#command name <expC>;
=> ::name(<expC>)

#command title <expC>;
=> ::title(<expC>)

#command description <expC>;
=> ::description(<expC>)

#command columns; // marcação utilizada para reconhecimento de identação e estrutura
=> SX3->(dbSetOrder(2))

#command define column <_alias> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
=> ::column(<"_alias">, <"cType">, <nLen>, <nNDec>);;
	[::label(<"_alias">, <cLabel>)]

#command define column <_alias> ;
	like <_field>;
=> SX3->(dbSeek(<"_field">));;
	::column(<"_alias">, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL);;
	::label(<"_alias">, X3Titulo())

#command define expression <_alias> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
	sql <*exprSql*>;
=> ::column(<"_alias">, <"cType">, <nLen>, <nNDec>);;
	::exprSql(<"_alias">, <"exprSql">);;
	[::label(<"_alias">, <cLabel>)]

#command parameters; // marcação utilizada para reconhecimento de identação e estrutura
=>

#command define parameter <paramName> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
	[<req: required>];
	[range [min <minExp>] [max <maxExp>]];
	[selection <expSelection,...>];
	[dynamic dataset <datasetName> ;
				value column <valueColum> ;
				display column <displayColumn> ;
				default value <defaultValue2>;
				order by <orderColumn> <desc:descend> ] ;
	[help <help>];
	[format <mask>];
	[<hidden: hidden>];
	[<no_echo: no echo>];
	[<widget: TEXT, COMBO, LISTBOX, RADIO>];
	[list max <listLimit>];
	[default value <defaultValue>];
=> _param := ::execParamDef(<"paramName">, <"cType">, <nLen>, <nNDec>, <cLabel>, <.req.>, {<minExp>,<maxExp>}, { <expSelection>});;
	[_param\[IX_DYNAMIC\] := { <"datasetName">, <"valueColumn">, <"displayColumn">, <"defaultValue">, <"orderColumn">, <.desc.>}];;
	[_param\[IX_HELP\] := <help>];;
	[_param\[IX_FORMAT\] := <mask>];;
	[_param\[IX_ECHO_INPUT\] := !<.no_echo.>];;
	[_param\[IX_HIDDEN\] := <.hidden.>];;
	[_param\[IX_WIDGET\] := <"widget">];;
	[_param\[IX_LIST_LIMIT\] := <listLimit>];;
	[_param\[IX_DEFAULT_VALUE\] := <defaultValue>]

#command define report parameter <paramName> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
	[<req: required>];
	[range [min <minExp>] [max <maxExp>]];
	[selection <expSelection,...>];
	[dynamic dataset <datasetName> ;
				value column <valueColum> ;
				display column <displayColumn> ;
				default value <defaultValue2>;
				order by <orderColumn> <desc:descend> ] ;
	[help <help>];
	[format <mask>];
	[<hidden: hidden>];
	[<no_echo: no echo>];
	[<widget: TEXT, COMBO, LISTBOX, RADIO>];
	[list max <listLimit>];
	[default value <defaultValue>];
=> _param := ::rptParamDef(<"paramName">, <"cType">, <nLen>, <nNDec>, <cLabel>, <.req.>, {<minExp>,<maxExp>}, { <expSelection>});;
	[_param\[IX_DYNAMIC\] := { <"datasetName">, <"valueColumn">, <"displayColumn">, <"defaultValue">, <"orderColumn">, <.desc.>}];;
	[_param\[IX_HELP\] := <help>];;
	[_param\[IX_FORMAT\] := <mask>];;
	[_param\[IX_ECHO_INPUT\] := !<.no_echo.>];;
	[_param\[IX_HIDDEN\] := <.hidden.>];;
	[_param\[IX_WIDGET\] := <"widget">];;
	[_param\[IX_LIST_LIMIT\] := <listLimit>];;
	[_param\[IX_DEFAULT_VALUE\] := <"defaultValue">]
	
	

//#command groups;
//=> // marcação utilizada para reconhecimento de identação e estrutura

//#command define group <col,...>;
//=> ::groups({<"col">})

//#command order by ;
//=> // marcação utilizada para reconhecimento de identação e estrutura

//#command define order <col> [<desc:descend>];
//=> ::orderBy(<"col">, <.desc.>)

//#command define query <*exprSql*>;
//=> ::query(<"exprSql">)

#command define query <exprSql>;
=> ::query(<exprSql>)

#command process report;
=>	static function runReport(self)

// ##################################################################################
// Meta linguagem para execução de relatório pré-definido
// ##################################################################################
#command define report <var> name <identifier> title <cTitle> ;	
			[ <lAsk: askpar> ];
			[ <lExclusive: exclusive> ];
=> 	<var> := iif(existRpt(<"identifier">), r_<identifier>(), BIRTReport():BIRTReport(<"identifier">));;
	<var>:setTitle( <cTitle> );;
	[ <var>:lPergunte := <.lAsk.> ];;
	[ <var>:setPExclusive( <.lExclusive.> ) ]

#command define user_report <var> name <identifier> title <cTitle> ;	
			[ <lAsk: askpar> ];
			[ <lExclusive: exclusive> ];
=> 	<var> := iif(existUsrRpt(<"identifier">), r_<identifier>(), BIRTReport():BIRTReport(<"identifier">));;
	<var>:setTitle( <cTitle> );;
	[ <var>:lPergunte := <.lAsk.> ];;
	[ <var>:setPExclusive( <.lExclusive.> ) ]	
	
#command activate report <var> ;
	[layout <layout>];
	[format <format: HTML, PDF>];
=> [<var>:layout(<"layout">)];;
	[<var>:format(<"format">)];;
	<var>:show();<var>:_BIRTReport();freeObj(<var>);_REPORT := nil
			
#command save report <var> ;
	[layout <layout>];
	[format <format: HTML, PDF>];
	output <output>;
=> [<var>:layout(<"layout">)];;
	[<var>:format(<"format">)];;
	<var>:save(<"output">);<var>:_BIRTReport();freeObj(<var>);_REPORT := nil

#command print report <var> ;
	[layout <layout>];
	[format <format: HTML, PDF>];
=> [<var>:layout(<"layout">)];;
	[<var>:format(<"format">)];;
	<var>:print();<var>:_BIRTReport();freeObj(<var>);_REPORT := nil

////
//
// ##################################################################################
#endif
