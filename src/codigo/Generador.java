/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package codigo;

import jflex.Main;

/**
 *
 * @author Kevin
 */
public class Generador {
        public static void main(String[] args) {
        String[] flexArchivo = {"D:/Uni2025/Compiladores/practica/Proyecto1/src/codigo/Lexer.flex"};
        
        try {
            Main.main(flexArchivo);
            System.out.println("Lexer.java geneerado correctamente.");
        } catch (Exception e) {
            System.err.println("Error al generar Lexer.java; " + e.getMessage());
        }  
    }
    
}
