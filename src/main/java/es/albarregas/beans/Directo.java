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
@Table(name = "directos")
public class Directo implements Serializable{
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "idDirecto")
    private int idDirecto;
    
    @Column(name = "idUsuario")
    private int idUsuario;
    
    @Column(name = "idCategoria")
    private int idCategoria;
    
    public Directo(){
        
    }
    
    public Directo(int idDirecto, int idUsuario, int idCategoria){
        this.idDirecto = idDirecto;
        this.idUsuario = idUsuario;
        this.idCategoria = idCategoria;               
    }

    /**
     * @return the idDirecto
     */
    public int getIdDirecto() {
        return idDirecto;
    }

    /**
     * @param idDirecto the idDirecto to set
     */
    public void setIdDirecto(int idDirecto) {
        this.idDirecto = idDirecto;
    }

    /**
     * @return the idUsuario
     */
    public int getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    /**
     * @return the idCategoria
     */
    public int getIdCategoria() {
        return idCategoria;
    }

    /**
     * @param idCategoria the idCategoria to set
     */
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
    
}
