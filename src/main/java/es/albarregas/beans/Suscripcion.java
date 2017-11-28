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
@Table(name = "suscripciones")
public class Suscripcion implements Serializable {
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "idSuscripcion")
    private int idSuscripcion;
    
    @Column(name = "suscriptor")
    private int suscriptor;
    
    @Column(name = "usuarioSeguir")
    private int usuarioSeguir;
    
    public Suscripcion() {
        
    }
    
    public Suscripcion (int idSuscripcion, int suscriptor, int usuarioSeguir){
        this.idSuscripcion = idSuscripcion;
        this.suscriptor = suscriptor;
        this.usuarioSeguir = usuarioSeguir;
    }

    /**
     * @return the idSuscripcion
     */
    public int getIdSuscripcion() {
        return idSuscripcion;
    }

    /**
     * @param idSuscripcion the idSuscripcion to set
     */
    public void setIdSuscripcion(int idSuscripcion) {
        this.idSuscripcion = idSuscripcion;
    }

    /**
     * @return the suscriptor
     */
    public int getSuscriptor() {
        return suscriptor;
    }

    /**
     * @param suscriptor the suscriptor to set
     */
    public void setSuscriptor(int suscriptor) {
        this.suscriptor = suscriptor;
    }

    /**
     * @return the usuarioSeguir
     */
    public int getUsuarioSeguir() {
        return usuarioSeguir;
    }

    /**
     * @param usuarioSeguir the usuarioSeguir to set
     */
    public void setUsuarioSeguir(int usuarioSeguir) {
        this.usuarioSeguir = usuarioSeguir;
    }
    
}
