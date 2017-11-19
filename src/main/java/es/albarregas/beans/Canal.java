/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.beans;

import java.io.Serializable;
import javax.persistence.*;

/**
 *
 * @author Mario
 */
@Entity
@Table(name = "canales")
public class Canal implements Serializable{
    
    @Id
    @Column(name="idCanal")
    private int idCanal;
    
    @Column(name="descripcion")
    private String descripcion;
    
    @Column(name="imgUsuario")
    private int imgUsuario;
    
    @Column(name="imgPortada")
    private int imgPortada;
    
    public Canal(){
        
    }
    
    public Canal(int idCanal, String descripcion, int imgUsuario, int imgPortada){
        this.idCanal = idCanal;
        this.descripcion = descripcion;
        this.imgUsuario = imgUsuario;
        this.imgPortada = imgPortada;
    }
    
}
