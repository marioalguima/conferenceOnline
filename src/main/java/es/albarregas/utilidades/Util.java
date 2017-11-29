/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.utilidades;

import es.albarregas.beans.Usuario;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.MessageDigest;
import java.util.ArrayList;
import javax.servlet.http.Part;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Mario
 */
public class Util {

    public static String encriptarMD5(String cadena) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(cadena.getBytes());
        byte[] digest = md.digest();
        byte[] encoded = Base64.encodeBase64(digest);
        return new String(encoded);
    }

    public static String subirImagen(Part archivo, String nombre, String direccion) throws IOException {

        String filename = FilenameUtils.getBaseName(nombre);

        String extension = FilenameUtils.getExtension(".gif");

        Path fichero = Paths.get(direccion + System.getProperty("file.separator") + filename + "." + extension);
        
        Files.deleteIfExists(fichero);
        Path file = Files.createFile(fichero);

        try (InputStream input = archivo.getInputStream()) {
            Files.copy(input, file, StandardCopyOption.REPLACE_EXISTING);
        }

        System.out.println("Imagen subida a: " + file);

        return file.getFileName().toString();

    }
    
    public static String parseUsuarios(ArrayList<Usuario> usuarios) {
        String cadena = "{\"objeto\":[";
        for(Usuario u: usuarios){
            if(u.getCanal().getImgUsuario() != null){
                cadena = cadena.concat("{\"nombre\": \""+u.getNombre()+"\", \"imagen\": \""+u.getCanal().getImgUsuario().getImagen()+"\"},");
            }else{
                cadena = cadena.concat("{\"nombre\": \""+u.getNombre()+"\", \"imagen\": \"logotipo_min.png\"},");
            }
        }        
        cadena = cadena.substring(0, cadena.length()-1);
        cadena = cadena.concat("]}");
        return cadena;
    }

}
