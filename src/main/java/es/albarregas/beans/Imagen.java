/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.beans;

import java.io.Serializable;
import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;

/**
 *
 * @author Mario
 */
@Entity
@Table(name = "imagenes")
public class Imagen implements Serializable{
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "idImagen")
    private int idImagen;
    
    @Column(name = "imagen")
    private String imagen;
    
    public Imagen(){
        
    }
    
    public Imagen(int idImagen, String imagen){
        this.idImagen = idImagen;
        this.imagen = imagen;
    }

    /**
     * @return the idImagen
     */
    public int getIdImagen() {
        return idImagen;
    }

    /**
     * @param idImagen the idImagen to set
     */
    public void setIdImagen(int idImagen) {
        this.idImagen = idImagen;
    }

    /**
     * @return the imagen
     */
    public String getImagen() {
        return imagen;
    }

    /**
     * @param imagen the imagen to set
     */
    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
}
