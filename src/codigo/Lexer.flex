// Definición del paquete
package codigo;

// Importaciones
import static codigo.Tokens.*;

// Configuración de JFlex
%%
%class Lexer
%type Tokens
%unicode
%line
%column
%{
    public String lexeme; // Variable para almacenar el lexema
%}

// Expresiones regulares
LETRA = [a-zA-Z]
DIGITO = [0-9]
ESPACIO = [ \t\r\n]+
TEXTO = {LETRA}({LETRA}|{DIGITO})*

// Atributos en etiquetas HTML
ATRIBUTO_NOMBRE = [a-zA-Z]([a-zA-Z0-9_-])*
ATRIBUTO_VALOR = "\"[^\"]*\""
ATRIBUTO = {ATRIBUTO_NOMBRE} "=" {ATRIBUTO_VALOR}

ETIQUETA_APERTURA = "<"{TEXTO}({ESPACIO}+{ATRIBUTO})*">"
ETIQUETA_CIERRE = "</"{TEXTO}">"
ATRIBUTO = {LETRA}({LETRA}|{DIGITO}|[-_])*=\"[^\"]*\"
COMENTARIO = "<!--"~"-->"
ENTIDAD_HTML = "&lt;" | "&gt;" | "&amp;" | "&quot;" | "&apos;"
CONTENIDO = [^<&\r\n]+
DECLARACION_DOCTYPE = "<!DOCTYPE"[^>]+">"

// Estados (opcional, no necesario para este ejemplo)
%%

// Reglas léxicas
{DECLARACION_DOCTYPE}  { lexeme = yytext(); return DeclaracionDoctype; }
{ETIQUETA_APERTURA}    { lexeme = yytext(); return EtiquetaApertura; }
{ATRIBUTO}             { lexeme = yytext(); return Atributo; }
{ETIQUETA_CIERRE}      { lexeme = yytext(); return EtiquetaCierre; }
{COMENTARIO}           { lexeme = yytext(); return Comentario; }
{ENTIDAD_HTML}         { lexeme = yytext(); return EntidadHTML; }
{CONTENIDO}            { lexeme = yytext(); return Contenido; }
{ATRIBUTO_NOMBRE}      {ATRIBUTO_VALOR} { lexeme = yytext(); return Atributo; }
{ESPACIO}              { /* Ignorar espacios */ }
<<EOF>>                { return EOF; }

// Manejo de errores
[^]                    { return ERROR; }
