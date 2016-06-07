// ######################################################################################
// Projeto: DATA WAREHOUSE
// Modulo : Ferramentas
// Fonte  : DWVer - Definição de versão, release e build do SigaDW
// ---------+-------------------+--------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+--------------------------------------------------------
// 18.12.03 | 0548-Alan Candido |
// 27.09.05 | 0548-Alan Candido | versão 3.0
// 17.04.06 | 0548-Alan Candido | implementação de identificação da P10
// 24/09/07 | 0548-Alan Candido | BOPS 132350 - Implementação do campo "export" em TAB_CONSULTAS
// 29/05/07 | 0548-Alan Candido | BOPS 146059
//          |                   | Implementação dos campos "rnkSubTotal" e "rnkTotal" em TAB_CONSTYPE
// 12.08.08 |0548-Alan Cândido  | BOPS 146580 
//          |                   | Definição de DWCACHE, para habilitação do novo sistema de carga
//          |                   | de consultas.
//          |                   | NOTA: Devido a um problema no uso de HttpSession em classes
//          |                   |       com herança (propriedades da classe pai não são salvas)
//          |                   |       esta chave não deve ser habilitada, até o referido problema
//          |                   |       ser revolvido.    
// 24/10/08 |3174-Valdiney GOMES| Inclusão das constantes de verificação de idioma. 
// 25.11.08 | 0548-Alan Candido | FNC 00000007374/2008 (10) e 00000007385/2008 (8.11)
//          |                   | . Atualização da BUILD da aplicação
//          |                   | . Definição da constante BUILD_WEB para identificar versão do site
//          |                   | . Eliminação de constantes fora de uso.
// 09.12.08 | 0548-Alan Candido | FNC 00000149278/811 (8.11) e 00000149278/912 (9.12)
//          |                   | Implementação de ranking por nível de drill-down
// 19.02.10 | 0548-Alan Candido | FNC 00000003657/2010 (9.12) e 00000001971/2010 (11)
//          |                   | Implementação de visual para P11 e adequação para o 'dashboard'
// --------------------------------------------------------------------------------------

#ifndef _DWVER_CH_
                 
#define _DWVER_CH_
#define VERSION  "3"
#define RELEASE  "00"
//#define DW_BETA_RELEASE // indica que é versão beta
#ifdef DW_BETA_RELEASE
  #define FASE   "R-4 beta"
#else
  #define FASE   "R-4"
#endif

#define ESTATISTICAS    // habilita processos estatisticos

//#define VER_P10     		// indica que a compilação é para o P10
#define VER_P11         // indica que a compilação é para o P11 
                        // para outras versões, manter a linha comentada
#ifdef VER_P10
  #define FASE   "P10 R-1.1"
#endif

#ifdef VER_P11
  #define FASE    "P11"
  #define RELEASE "01"
#endif

#define BUILD       "100219"	//Usar formato YYMMDD
#define BUILD_WEB   "100219"  //Usar formato YYMMDD

// NOTA: Ao modificar o valor de BUILD_WEB, proceder:
//       . check-out do arquivo build.dw (site SigaDW)
//       . compilar todo o SigaDW
//       . executar dwGenWebBuild() (dwLib.prw)
//       . copiar o código gerado e grava-lo no arquivo build.dw  (site SigaDW)
//       . check-in do arquivo build.dw
//       . gerar ZIP do site e anexar as reservas

// NOTA: Devido a um problema no uso de HttpSession em classes com herança (propriedades da classe 
//       pai não são salvas) esta chave não deve ser habilitada, até o referido problema
//       ser revolvido.
// define DWCACHE
#endif
  
#ifdef SPANISH
	#define IDIOMA "ES"
	#define IDIOMA2 "es"
#else
#ifdef ENGLISH
	#define IDIOMA "EN"
	#define IDIOMA2 "en"
#else
	#define IDIOMA "PT"
	#define IDIOMA2 "pt"
#endif
#endif
