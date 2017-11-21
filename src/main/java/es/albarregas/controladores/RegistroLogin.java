/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.controladores;

import es.albarregas.beans.Canal;
import es.albarregas.beans.Usuario;
import es.albarregas.dao.GenericoDAO;
import es.albarregas.utilidades.Util;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mario
 */
@WebServlet(name = "RegistroLogin", urlPatterns = {"/RegistroLogin"})
public class RegistroLogin extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String respuesta = "";

        switch (request.getParameter("peticion")) {
            case "comprobarNombreRegistro":
                if (comprobarNombre(request.getParameter("nombre"))) {
                    respuesta = "ok";
                } else {
                    respuesta = "notOk";
                }
                break;
            case "comprobarEmailRegistro":
                if (comprobarEmail(request.getParameter("email"))) {
                    respuesta = "ok";
                } else {
                    respuesta = "notOk";
                }
                break;
            case "Registrarse":
                darAltaUsuario(request.getParameter("usuarioRegistro"), request.getParameter("emailRegistro"), request.getParameter("passwordRegistro"));
                //TODO Hacer la sesion y almacenar el usuario en sesion
                response.sendRedirect("index.jsp");
                break;
            case "Entrar":
                Usuario usuario = iniciarSesion(request.getParameter("usuarioLogin"), request.getParameter("passwordLogin"));
                if(usuario != null){
                    //TODO Hacer la sesion y almacenar el usuario en sesion
                }else{
                    respuesta = "notok";
                }                
                break;
        }
        if (!respuesta.isEmpty()) {
            response.getWriter().append(respuesta);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    /**
     * Da de alta un usuario nuevo en la base de datos
     * @param nombre Nombre del usuario
     * @param email Email del usuario
     * @param password Contraseña del usuario
     */
    private void darAltaUsuario(String nombre, String email, String password) {
        GenericoDAO genDao = new GenericoDAO();
        String encriptada = "";
        
        try{
            encriptada = Util.encriptarMD5(password);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        
        Usuario usuario = new Usuario(0, nombre, email, encriptada, 'n');
        Canal canal = new Canal(0, "", 0, 0, usuario);
        genDao.add(usuario);
        genDao.add(canal);
    }
    
    /**
     * Inicia sesión si hay coincidencias con los datos, sino devuelve false
     * @param nombre Usuario que intenta iniciar sesión
     * @param password Contraseña del usuario
     * @return 
     */
    private Usuario iniciarSesion(String nombre, String password){
        String encriptada = "";
        Usuario usuario = null;
        ArrayList<Usuario> usuarios;
        try{
            encriptada = Util.encriptarMD5(password);
        }catch(Exception e){
            System.err.println(e.getMessage());
        }
        usuarios = (ArrayList) new GenericoDAO().get("Usuario where nombre='" + nombre + "' and password='" + encriptada + "'");
        if(!usuarios.isEmpty()){
            usuario = usuarios.get(0);
        }
        return usuario;
    }

    /**
     * Devuelve si el nombre está disponible o no
     * @param nombre Nombre de usuario a comprobar si existe en la base de datos
     * @return un Boolean sobre si existe o no el nombre
     */
    private boolean comprobarNombre(String nombre) {

        return new GenericoDAO().get("Usuario where nombre='" + nombre + "'").isEmpty();

    }

    /**
     * Devuelve si el email está disponible o no
     * @param email Email de usuario a comprobar si existe en la base de datos
     * @return un Boolean sobre si existe o no el email
     */
    private boolean comprobarEmail(String email) {

        return new GenericoDAO().get("Usuario where email='" + email + "'").isEmpty();

    }

}
