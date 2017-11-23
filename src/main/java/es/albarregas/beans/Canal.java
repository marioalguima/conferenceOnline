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
public class Canal implements Serializable {

    @Id
    @Column(name = "idCanal")
    private int idCanal;

    @Column(name = "descripcion")
    private String descripcion;
    
    @Column(name = "titulo")
    private String titulo;

    @OneToOne
    @JoinColumn(name = "imgUsuario")
    private Imagen imgUsuario;

    @MapsId
    @OneToOne
    @JoinColumn(name = "idCanal")
    private Usuario usuario;

    public Canal() {

    }

    public Canal(int idCanal, String descripcion, String titulo, Imagen imgUsuario, Usuario usuario) {
        this.idCanal = idCanal;
        this.descripcion = descripcion;
        this.imgUsuario = imgUsuario;
        this.titulo = titulo;
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
    public Imagen getImgUsuario() {
        return imgUsuario;
    }

    /**
     * @param imgUsuario the imgUsuario to set
     */
    public void setImgUsuario(Imagen imgUsuario) {
        this.imgUsuario = imgUsuario;
    }

    /**
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
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
