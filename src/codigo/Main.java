/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package codigo;

import java.io.FileReader;
import java.io.IOException;

/**
 *
 * @author Kevin
 */
public class Main {
    public static void main(String[] args) {
        try {
            // Verifica si se proporcionó un archivo de entrada
            if (args.length == 0) {
                System.out.println("Uso: java codigo.Main <entrada.html>");
                return;
            }

            // Lee el archivo de entrada
            String archivoEntrada = args[0];
            FileReader reader = new FileReader(archivoEntrada);
            Lexer lexer = new Lexer(reader);

            // Analiza el archivo
            Tokens token;
            while ((token = lexer.yylex()) != Tokens.EOF) {
                System.out.println("Token: " + token + " | Lexema: " + lexer.lexeme);
            }

            // Cierra el archivo
            reader.close();
        } catch (IOException e) {
            System.err.println("Error al leer el archivo: " + e.getMessage());
        }
    }
    
    
}
