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
TEXTO = {LETRA}+
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
{ETIQUETA_CIERRE}      { lexeme = yytext(); return EtiquetaCierre; }
{ATRIBUTO}             { lexeme = yytext(); return Atributo; }
{COMENTARIO}           { lexeme = yytext(); return Comentario; }
{ENTIDAD_HTML}         { lexeme = yytext(); return EntidadHTML; }
{CONTENIDO}            { lexeme = yytext(); return Contenido; }
{ESPACIO}              { /* Ignorar espacios */ }
<<EOF>>                { return EOF; }

// Manejo de errores
[^]                    { return ERROR; }
