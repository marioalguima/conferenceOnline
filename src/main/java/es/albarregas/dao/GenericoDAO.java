package es.albarregas.dao;

import es.albarregas.persistencia.HibernateUtil;
import java.io.Serializable;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;

import org.hibernate.Session;
import org.hibernate.TransactionException;


public class GenericoDAO<T> implements IGenericoDAO<T> {
    
    private Session sesion;
    
    private void iniciarSesion(){
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
    }
    
    private void cerrarSesion(){
        try{
        sesion.getTransaction().commit();
        sesion.close();
        }catch(TransactionException e){
            Logger.getLogger(GenericoDAO.class.getName()).log(Level.ALL, null, e);
        }
    }
    
    private void manejarExcepcion(HibernateException he) throws HibernateException {
        sesion.getTransaction().rollback();
        Logger.getLogger(GenericoDAO.class.getName()).log(Level.SEVERE, null, he);
        throw he;
    } 

    @Override
    public void add(T objeto) {
        try {
            iniciarSesion();
            sesion.save(objeto);
            sesion.flush();
            
        } catch (HibernateException he){
            manejarExcepcion(he);
            Logger.getLogger(GenericoDAO.class.getName()).log(Level.SEVERE, null, he);
        } finally {
            if(sesion!=null){
                cerrarSesion();
            }
        }
    }

    @Override
    public <T> List<T> get(String entidad) {
        List<T> listadoResultados = null;
        try {
            iniciarSesion();
            listadoResultados = sesion.createQuery(" from " + entidad).list();
        } catch(HibernateException he){
            this.manejarExcepcion(he);
        } finally {
            this.cerrarSesion();
        }
        return listadoResultados;
    }

    @Override
    public <T> T getOne(Serializable pk, Class<T> claseEntidad) {
        T objetoRecuperado = null;
        
        try {
            iniciarSesion();
            objetoRecuperado = sesion.get(claseEntidad, pk);
        } catch(HibernateException he){
            this.manejarExcepcion(he);
        } finally {
            this.cerrarSesion();
        }
        
        return objetoRecuperado;
    }
    
    @Override
    public void update(T objeto) {
        try {
            iniciarSesion();
            sesion.update(objeto);
            sesion.flush();
            
        } catch (HibernateException he){
            manejarExcepcion(he);
            Logger.getLogger(GenericoDAO.class.getName()).log(Level.SEVERE, null, he);
        } finally {
            cerrarSesion();
        }
    }

    @Override
    public void delete(T objeto) {
        try {
            iniciarSesion();
            sesion.delete(objeto);
        } catch(HibernateException he){
            this.manejarExcepcion(he);
        } finally {
            this.cerrarSesion();
        }
    }
}
