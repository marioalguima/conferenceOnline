/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.beans;

import es.albarregas.dao.GenericoDAO;
import java.io.Serializable;
import java.util.ArrayList;
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
    
    
    @OneToOne
    @JoinColumn(name = "idUsuario")
    private Usuario usuario;
    
    @Column(name = "idCategoria")
    private int idCategoria;
    
    public Directo(){
        
    }
    
    public Directo(int idDirecto, Usuario usuario, int idCategoria){
        this.idDirecto = idDirecto;
        this.usuario = usuario;
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
     * @return the usuario
     */
    public Usuario getUsuario() {
        return usuario;
    }

    /**
     * @param usuario the idUsuario to set
     */
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
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
    
    /**
     * Devuelve los directos de una categoría
     * @param idCategoria entero con el id de la categoría de los directos
     * @return ArrayList con los directos de dicha categoría
     */
    public ArrayList<Directo> getDirectosCategoria(int idCategoria){
        return (ArrayList) new GenericoDAO().get("Directo where idCategoria='"+idCategoria+"'");
    }
    
    /**
     * Devuelve true si el usuario buscado está en directo y false si no lo está
     * @param idUsuario idUsuario del usuario a saber si está en directo
     * @return boolean true si está en directo, false si no lo está
     */
    public boolean usuarioOnline(int idUsuario){        
        return !new GenericoDAO().get("Directo where idUsuario='"+idUsuario+"'").isEmpty();
    }
    
}
