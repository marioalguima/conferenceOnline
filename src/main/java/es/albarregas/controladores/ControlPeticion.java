/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.controladores;

import es.albarregas.beans.Categoria;
import es.albarregas.beans.Directo;
import es.albarregas.beans.Suscripcion;
import es.albarregas.beans.Usuario;
import es.albarregas.dao.GenericoDAO;
import es.albarregas.utilidades.Util;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controlador para las peticiones sobre la ejecución de la web que no tengan que ver con la información del usuario: suscribirse y cancelar suscripcion, buscar usuarios,
 * bloquear y desbloquear usuarios y borrar y añadir categorias por parte del administrador, etc 
 *
 * @author Mario
 */
@WebServlet(name = "ControlPeticion", urlPatterns = {"/ControlPeticion"})
public class ControlPeticion extends HttpServlet {

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
        doPost(request, response);
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
        Usuario usuario; // Variable para almacenar el usuario que pidan
        ArrayList<Usuario> usuarios; // Variable para almacenar usuarios que se necesiten
        String nombreUsuario; // Variable para almacenar el nombre del usario que pidan
        // Procesa qué petición han demandado        
        switch (request.getParameter("peticion")) {
            
            case "buscarUsuario":
                nombreUsuario = request.getParameter("nombre");
                if (nombreUsuario != null) {
                    usuarios = buscarUsuarios(nombreUsuario, request);
                    if (usuarios.isEmpty()) {
                        respuesta = "notok";
                    } else {
                        respuesta = Util.parseUsuarios(usuarios);
                    }
                }
                break;
            case "canal":
                nombreUsuario = request.getParameter("nombre");
                if (nombreUsuario != null) {
                    usuarios = buscarUsuarios(nombreUsuario, request);
                    if (!usuarios.isEmpty()) {
                        request.setAttribute("CANAL", usuarios.get(0));
                        request.getRequestDispatcher("canal.jsp").forward(request, response);
                    }
                }
                break;
            case "suscribirse":
                suscribirse(Integer.parseInt(request.getParameter("idUsuario")), request);
                respuesta = "ok";
                break;
            case "quitarSuscripcion":
                eliminarSuscripcion(Integer.parseInt(request.getParameter("idUsuario")), request);
                respuesta = "ok";
                break;
            case "bloquearUsuario":
                bloquearUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                respuesta = "ok";
                break;
            case "desbloquearUsuario":
                desbloquearUsuario(Integer.parseInt(request.getParameter("idUsuario")));
                respuesta = "ok";
                break;
            case "borrarCategorias":
                borrarCategorias(request.getParameter("categorias"));
                respuesta = "ok";
                break;
            case "anadirCategoria":
                anadirCategoria(request.getParameter("categoria"));
                respuesta = "ok";
                break;
            case "iniciarDirecto":                
                iniciarDirecto(request.getParameter("usuario"), request.getParameter("categoria"));
                respuesta = "ok";
                break;
        }
        if (!respuesta.isEmpty()) {
            response.getWriter().append(respuesta);
        }

    }
    
    /**
     * Añade un nuevo registro a la tabla directos con el usuario que se le pasa
     * 
     * @param usuario Nombre del usuario cuyo directo se inicia
     */
    private void iniciarDirecto(String usuario, String idCategoria){
        GenericoDAO genDao = new GenericoDAO();
        Usuario usu = (Usuario)genDao.get("Usuario where idUsuario ='"+usuario+"'").get(0);
        Directo directo = new Directo(0,usu.getIdUsuario(), Integer.parseInt(idCategoria));
        genDao.add(directo);
    }
    
    /**
     * Añade una categoría a la base de datos
     * 
     * @param categoria String con la categoría a añadir a la base de datos
     */
    private void anadirCategoria(String categoria){
        Categoria categoriaAnadir = new Categoria(0, categoria);
        new GenericoDAO().add(categoriaAnadir);
    }
    
    /**
     * Borra una o más categorías de la base de datos
     * 
     * @param categorias String con todas las categorías a borrar separados por ','
     */
    private void borrarCategorias(String categorias){
        GenericoDAO genDao = new GenericoDAO();
        Categoria categoria;
        StringTokenizer tokens = new StringTokenizer(categorias, ",");
        
        while(tokens.hasMoreTokens()){
            categoria = (Categoria) genDao.get("Categoria where idCategoria='"+tokens.nextToken()+"'").get(0);
            genDao.delete(categoria);
        }
    }

    /**
     * Bloquea uno o todos los usuarios que no estén ya bloqueados ni sean administradores
     * 
     * @param idUsuario int con el idUsuario a bloquear. Si es igual a -1 bloqueará todos los usuarios
     */
    private void bloquearUsuario(int idUsuario) {
        GenericoDAO genDao = new GenericoDAO();
        Usuario usuario;
        if (idUsuario != -1) {
            usuario = (Usuario) genDao.get("Usuario where idUsuario='" + idUsuario + "'").get(0);
            usuario.setTipo("b");
            genDao.update(usuario);
        } else {
            ArrayList usuarios = (ArrayList) genDao.get("Usuario where tipo='n'");
            for (int i = 0; i < usuarios.size(); i++) {
                usuario = (Usuario) usuarios.get(i);
                usuario.setTipo("b");
                genDao.update(usuario);
            }
        }
    }

    /**
     * Desbloquea a uno o a todos los usuarios bloqueados
     * 
     * @param idUsuario int con el idUsuario a desbloquear. Si es -2 desbloquea a todos los usuarios bloqueados
     */
    private void desbloquearUsuario(int idUsuario) {
        GenericoDAO genDao = new GenericoDAO();
        Usuario usuario;
        if (idUsuario != -2) {
            usuario = (Usuario) genDao.get("Usuario where idUsuario='" + idUsuario + "'").get(0);
            usuario.setTipo("n");
            genDao.update(usuario);
        } else {
            ArrayList usuarios = (ArrayList) genDao.get("Usuario where tipo='b'");
            for (int i = 0; i < usuarios.size(); i++) {
                usuario = (Usuario) usuarios.get(i);
                usuario.setTipo("n");
                genDao.update(usuario);
            }
        }
    }

    /**
     * El usuario registrado se suscribe al usuario cuyo idUsuario se pasa como parámetro
     * 
     * @param idUsuarioSeguir int con el idUsuario al que se va a suscribir el usuario registrado
     * @param request para almacenar al usuario actualizado en la sesión
     */
    private void suscribirse(int idUsuarioSeguir, HttpServletRequest request) {
        Suscripcion suscripcion;
        GenericoDAO genDao = new GenericoDAO();
        Usuario usuario = (Usuario) request.getSession().getAttribute("USUARIO");
        suscripcion = new Suscripcion(0, usuario.getIdUsuario(), idUsuarioSeguir);
        genDao.add(suscripcion);
        usuario.getSuscripciones().add((Usuario) genDao.get("Usuario where idUsuario='" + idUsuarioSeguir + "'").get(0));
        request.getSession().setAttribute("USUARIO", usuario);
    }

    /**
     * Elimina la suscripción del usuario registrado del usuario cuyo idUsuario se pasa como parámetro
     * 
     * @param idUsuarioSeguir int con el idUsuario del que se va a desuscribir el usuario registrado
     * @param request para almacenar al usuario actualizado en la sesión
     */
    private void eliminarSuscripcion(int idUsuarioSeguir, HttpServletRequest request) {
        Suscripcion suscripcion;
        GenericoDAO genDao = new GenericoDAO();
        Usuario usuario = (Usuario) request.getSession().getAttribute("USUARIO");
        ArrayList<Suscripcion> suscripciones = (ArrayList) genDao.get("Suscripcion where suscriptor='" + usuario.getIdUsuario() + "' and usuarioSeguir='" + idUsuarioSeguir + "'");
        if (suscripciones != null && !suscripciones.isEmpty()) {
            suscripcion = suscripciones.get(0);
            genDao.delete(suscripcion);
            for (int i = 0; i < usuario.getSuscripciones().size(); i++) {
                if (usuario.getSuscripciones().get(i).getIdUsuario() == suscripcion.getUsuarioSeguir()) {
                    usuario.getSuscripciones().remove(i);
                }
            }
        }
        request.getSession().setAttribute("USUARIO", usuario);
    }

    /**
     * Busca una lista de usuarios cuyo nombre empiece con las letras introducidas
     * 
     * @param nombre String con las letras con las que empieza el nombre del usuario a buscar
     * @param request para no mostrar el nombre del usuario registrado que está realizando la búsqueda
     * @return ArrayList con la lista de usuarios cuyo inicio del nombre coincide con el introducido
     */
    private ArrayList<Usuario> buscarUsuarios(String nombre, HttpServletRequest request) {
        Usuario usuarioActivo = (Usuario) request.getSession(false).getAttribute("USUARIO");
        String consulta = "Usuario where upper(nombre) like '" + nombre.toUpperCase() + "%' and tipo = 'n'";
        if (usuarioActivo != null) {
            String nombreUsuario = usuarioActivo.getNombre();
            consulta = consulta.concat(" and nombre != '" + nombreUsuario + "'");
        }
        GenericoDAO genDao = new GenericoDAO();
        ArrayList<Usuario> usuarios = (ArrayList) genDao.get(consulta);
        return usuarios;
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

}
