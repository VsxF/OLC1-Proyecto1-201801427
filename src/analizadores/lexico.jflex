package analisis;

import java_cup.runtime.Symbol;

%%

%{
    //Codigo de usuario
    String coment = "";
    String entrada = "";

    private Symbol simb(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol simb(int type, Object val) {
            return new Symbol(type, yyline, yycolumn, val);
    }
%}

%cup
%class scanner
%public
%line
%char
%column
%full
//Maneja estados
%state BODY
%state COMENTARIO1
%state COMENTARIO2
%state CADENA
//Key sensitive
//%ignorecase

//Simbolos

Puntos = ":"
PuntoComa = ";"
KeyOpen = "{"
KeyClose = "}"
Porcent = "%"

//PALABRAS RESERVADAS
Conjunto = "CONJ:"
Flecha = "->"

ID = [A-Za-z][_0-9A-Za-z]

SPACE   = [\ \r\t\f\t]
ENTER   = [\ \n]
EndComent = [!>]

Character = [^\r\n]
EndLine = [\r|\n|\r\n]

COMMENT = {NormalComent} | {MultiComent}
NormalComent = "//" {Character}* {EndLine}
MultiComent = "<!" ({Character} | {EndLine})* {EndComent}

//ESTADOS

<YYINITIAL> {
    {KeyOpen} { yybegin(BODY) }
    {COMMENT} { return simb(sym.COMMENT) }
}
<BODY> {
    //Estructura
    {COMMENT} { return simb(sym.COMMENT) }
    {KeyClose} { return simb(symb.KEYCLOSE) }
}

