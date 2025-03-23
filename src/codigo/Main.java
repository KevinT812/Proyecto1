/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package codigo;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedWriter;
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
                System.out.println("Uso: java codigo.Main <entrada.txt>");
                return;
            }

            // Lee el archivo de entrada
            String archivoEntrada = args[0];
            FileReader reader = new FileReader(archivoEntrada);
            Lexer lexer = new Lexer(reader);

            // Crea un archivo de salida
            BufferedWriter writer = new BufferedWriter(new FileWriter("salida.txt"));

            // Analiza el archivo
            Tokens token;
            while ((token = lexer.yylex()) != Tokens.EOF) {
                String output = "Token: " + token + " | Lexema: " + lexer.lexeme;
                System.out.println(output); // Opcional: sigue imprimiendo en consola
                writer.write(output);
                writer.newLine();
                
            if (token == Tokens.EtiquetaApertura) {
                procesarAtributos(lexer.lexeme, writer);
                }
            }

            // Cierra los archivos
            reader.close();
            writer.close();
        } catch (IOException e) {
            System.err.println("Error al leer o escribir el archivo: " + e.getMessage());
        }
    }
    public static void procesarAtributos(String lexema, BufferedWriter writer) throws IOException {
        String[] partes = lexema.replace("<", "").replace(">", "").split("\\s+");
        for (String parte : partes) {
            if (parte.matches("[a-zA-Z][a-zA-Z0-9_-]*=\"[^\"]*\"")) {
                // Aquí tienes un atributo, puedes procesarlo
                String output = "Token: Atributo | Lexema: " + parte ;
                System.out.println(output); // Opcional: sigue imprimiendo en consola
                writer.write(output);
                writer.newLine();
            }
        }
    }
}
