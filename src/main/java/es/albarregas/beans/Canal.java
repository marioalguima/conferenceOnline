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
    
    @MapsId
    @OneToOne
    @JoinColumn(name = "idCanal")
    private Usuario usuario;
    
    public Canal(){
        
    }
    
    public Canal(int idCanal, String descripcion, int imgUsuario, int imgPortada, Usuario usuario){
        this.idCanal = idCanal;
        this.descripcion = descripcion;
        this.imgUsuario = imgUsuario;
        this.imgPortada = imgPortada;
        this.usuario = usuario;
    }

    /**
     * @return the idCanal
     */
    public int getIdCanal() {
        return idCanal;
    }

    /**
     * @param idCanal the idCanal to set
     */
    public void setIdCanal(int idCanal) {
        this.idCanal = idCanal;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the imgUsuario
     */
    public int getImgUsuario() {
        return imgUsuario;
    }

    /**
     * @param imgUsuario the imgUsuario to set
     */
    public void setImgUsuario(int imgUsuario) {
        this.imgUsuario = imgUsuario;
    }

    /**
     * @return the imgPortada
     */
    public int getImgPortada() {
        return imgPortada;
    }

    /**
     * @param imgPortada the imgPortada to set
     */
    public void setImgPortada(int imgPortada) {
        this.imgPortada = imgPortada;
    }

    /**
     * @return the usuario
     */
    public Usuario getUsuario() {
        return usuario;
    }

    /**
     * @param usuario the usuario to set
     */
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
}
