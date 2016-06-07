TOTVS - Microsiga Protheus Include (Header) Files
=================================================

Arquivos de cabeçalhos disponibilizados pela TOTVS em 5 de Junho de 2016.

Geralmente estes são disponibilizados compactados via [deflate](https://en.wikipedia.org/wiki/DEFLATE) em um formato de específico.

Estou aqui disponibilizando-os em um formato legível e de fácil acesso. Os arquivos se encontram dentro da pasta `include`.

## Mais informações

Os arquivos descompactados em linguagem AdvPL já estão disponibilizados na pasta `include`, os procedimentos seguintes não são necessários.

A maneira que usei para descompactar os arquivos cabeçalhos foi através do seguinte script python:

decompress.py:

    #!/usr/bin/python

    import zlib
    import sys

    with open(sys.argv[1]) as f:
        content = f.readlines()
        
    compressed = ''.join(content)

    decompress = zlib.decompressobj(-zlib.MAX_WBITS)
    inflated = decompress.decompress(compressed[14:])
    inflated += decompress.flush()

    print (inflated[:-1])

Modo de uso:

    ./decompress.py script_compactado.ch > script_descompactado.ch

O entendimento e análise da compactação ocorreram na seguinte discussão:

<http://www.reddit.com/r/codes/comments/26bpbh/does_someone_knows_how_i_could_decompressdecode/>


## Licença

Os arquivos de cabeçalhos foram descompactados e deixados intactos. Uma boa parte informa o copyright no topo do arquivo.

Deixo estes arquivos disponível como um esforço para que este possa ajudar de forma educativa muitos programadores que trabalham com o Protheus.

O material aqui é disponibilizado sem nenhum lucro para aqueles que tem demonstrado um interesse prévio em receber essas informações para pesquisas e propósitos educativos.

Acredito que a disponibilização destes arquivos caiam dentro de um [Uso Justo](https://pt.wikipedia.org/wiki/Fair_use) e não ofenda o copyright, sendo que é apresentada na [Lei 9.609/98](http://www.planalto.gov.br/ccivil_03/Leis/L9609.htm) Artigo 6º II:

    Art. 6º Não constituem ofensa aos direitos do titular de programa de computador:
    II - a citação parcial do programa, para fins didáticos, desde que identificados o programa e o titular dos direitos respectivos;

Estes arquivos de cabeçalhos não são significativos do sistema e não o colocam em risco. Sua disponibilização para estudo só traz o progresso e benefícios para a sociedade, já que torna possível um entendimento muito mais amplo de funções usadas no Protheus e facilita no desenvolvimento daqueles que usam esta plataforma.


