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
@Table(name = "categorias")
public class Categoria implements Serializable{
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "idCategoria")
    private int idCategoria;
    
    @Column(name = "nombre")
    private String nombre;
    
    public Categoria() {
        
    }
    
    public Categoria(int idCategoria, String nombre) {
        this.idCategoria = idCategoria;
        this.nombre = nombre;
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
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public ArrayList<Categoria> getCategorias(){
        return (ArrayList) new GenericoDAO().get("Categoria");
    }
    
}
