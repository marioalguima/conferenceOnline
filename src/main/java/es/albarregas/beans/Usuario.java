/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.beans;

import java.io.Serializable;
import java.util.ArrayList;
import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;

/**
 *
 * @author Mario
 */
@Entity
@Table(name = "usuarios")
public class Usuario implements Serializable {
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "idUsuario")
    private int idUsuario;
    
    @Column(name = "nombre")
    private String nombre;
    
    @Column(name = "email")
    private String email;
    
    @Column(name = "password")
    private String password;
    
    @Column(name = "tipo")
    private char tipo;
    
    @OneToOne(cascade = CascadeType.MERGE)
    @PrimaryKeyJoinColumn
    private Canal canal;
    
    @Transient
    private ArrayList<Usuario> suscripciones = new ArrayList();
    
    public Usuario(){
        
    }
    
    public Usuario(int idUsuario, String nombre, String email, String password, char tipo){
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.password = password;
        this.tipo = tipo;
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

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the tipo
     */
    public char getTipo() {
        return tipo;
    }

    /**
     * @param tipo the tipo to set
     */
    public void setTipo(char tipo) {
        this.tipo = tipo;
    }

    /**
     * @return the canal
     */
    public Canal getCanal() {
        return canal;
    }

    /**
     * @param canal the canal to set
     */
    public void setCanal(Canal canal) {
        this.canal = canal;
    }

    /**
     * @return the suscripciones
     */
    public ArrayList<Usuario> getSuscripciones() {
        return suscripciones;
    }

    /**
     * @param suscripciones the suscripciones to set
     */
    public void setSuscripciones(ArrayList<Usuario> suscripciones) {
        this.suscripciones = suscripciones;
    }
        
}
