/*/{Protheus.doc} birtdataset.ch
	Definição da metalinguagem para definição de datasets para o BIRT.
	Inclui também definições de constantes de uso geral.
@author Renan Fragoso
@since 16/05/2014
@version 1.0
@description
	Contem os comandos da metalinguagem para definição de dataset para o BIRT.
	Através destes comandos, o desenvolver definirá o que será obtido de dados e como,
	definindo as regras de seleção e agrupamento de dados, que serão utilizados em
	relatórios criados via Birt.

/*/

#ifndef _BIRTDATASET_CH

#define _BIRTDATASET_CH

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
#define IX_PARAM_SIZE 19

// ##################################################################################
// Meta linguagem para definição do relatório pré-definido
// ##################################################################################

#command user_dataset <identifier>;
=> 	static _DATASET := nil;;
	user function d_<identifier>();;
		if ( _DATASET == nil );;
			_DATASET := _d<identifier>():_d<identifier>(<"identifier">);;
		endif;;
	return _DATASET;;
	class _d<identifier> from BIRTDataSet;;
    	method _d<identifier>();;
   		method run();;
   	endclass;;
	method run(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF) class _d<identifier>;;
  	return runProcess(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF);;
   	method _d<identifier>() class _d<identifier>;;
   	self:New( <"identifier"> )

	
#command dataset <identifier>;
=> 	static _DATASET := nil;;
	function d_<identifier>();;
		if ( _DATASET == nil );;
			_DATASET := _d<identifier>():_d<identifier>(<"identifier">);;
		endif;;
	return _DATASET;;
	class _d<identifier> from BIRTDataSet;;
    	method _d<identifier>();;
   		method run();;
   	endclass;;
	method run(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF) class _d<identifier>;;
  	return runProcess(p1,p2,p3,p4,p5,p6,p7,p8,p9, pA, PB, PC, PD, PE, PF);;
   	method _d<identifier>() class _d<identifier>;;
   	self:New( <"identifier"> )

#command name <expC>;
=> self:setName( <expC> )

#command title <expC>;
=> self:setTitle( <expC> )

#command description <expC>;
=> self:setDescription( <expC> )

#command PERGUNTE <cIDSX1>;
=> 	self:ParFromSX1( <cIDSX1> )

#command columns; // marcação utilizada para reconhecimento de identação e estrutura
=> SX3->( dbSetOrder( 2 ) )

#command define column <_alias> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
=> 	self:setColumn( <"_alias">, <"cType">, <nLen>, <nNDec> ) ;;
	[ self:setLabel( <"_alias">, <cLabel> ) ]

#command define column <_alias> ;
	like <_field>;
=> 	SX3->(dbSeek(<"_field">));;
	self:setColumn( <"_alias">, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL );;
	self:setLabel( <"_alias">, X3Titulo() )

#command define expression <_alias> ;
	type <cType: CHARACTER, DATE, NUMERIC, LOGICAL, MEMO>;
	[size <nLen> [decimals <nNDec>]];
	[label <cLabel>];
	sql <*exprSql*>;
=> 	self:setColumn( <"_alias">, <"cType">, <nLen>, <nNDec> );;
	self:setExprSql( <"_alias">, <"exprSql"> );;
	[ self:setLabel( <"_alias">, <cLabel> ) ]

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
=> 	_param := self:execParamDef( <"paramName">, <"cType">, <nLen>, <nNDec>, <cLabel>, <.req.>, {<minExp>,<maxExp>}, { <expSelection>});;
	[_param\[IX_DYNAMIC\] := { <"datasetName">, <"valueColumn">, <"displayColumn">, <"defaultValue">, <"orderColumn">, <.desc.>}];;
	[_param\[IX_HELP\] := <help>];;
	[_param\[IX_FORMAT\] := <mask>];;
	[_param\[IX_ECHO_INPUT\] := !<.no_echo.>];;
	[_param\[IX_HIDDEN\] := <.hidden.>];;
	[_param\[IX_WIDGET\] := <"widget">];;
	[_param\[IX_LIST_LIMIT\] := <listLimit>];;
	[_param\[IX_DEFAULT_VALUE\] := <defaultValue>]

#command define dataset parameter <paramName> ;
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
=> 	_param := self:rptParamDef(<"paramName">, <"cType">, <nLen>, <nNDec>, <cLabel>, <.req.>, {<minExp>,<maxExp>}, { <expSelection>});;
	[_param\[IX_DYNAMIC\] := { <"datasetName">, <"valueColumn">, <"displayColumn">, <"defaultValue">, <"orderColumn">, <.desc.>}];;
	[_param\[IX_HELP\] := <help>];;
	[_param\[IX_FORMAT\] := <mask>];;
	[_param\[IX_ECHO_INPUT\] := !<.no_echo.>];;
	[_param\[IX_HIDDEN\] := <.hidden.>];;
	[_param\[IX_WIDGET\] := <"widget">];;
	[_param\[IX_LIST_LIMIT\] := <listLimit>];;
	[_param\[IX_DEFAULT_VALUE\] := <"defaultValue">]

#command define query <exprSql>;
=> 	::setQuery( <exprSql> )

#command process dataset;
=> 	static function runProcess( self )

// ##################################################################################
// Meta linguagem para execução de relatório pré-definido
// ##################################################################################
#command define dataset <var> name <identifier> ;
=> 	<var> := iif( existDataSet( <"identifier"> ), d_<identifier>(), BIRTDataSet():New( <"identifier"> ) )

#command activate dataset <var> ;
	[format <format: HTML, PDF>];
=> 	[<var>:format(<"format">)];;
	<var>:Activate();<var>:Destroy();freeObj(<var>);_DATASET := nil
			
////
//
// ##################################################################################
#endif
