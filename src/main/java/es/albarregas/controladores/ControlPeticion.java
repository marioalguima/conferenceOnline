/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.albarregas.controladores;

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
        ArrayList<Usuario> usuarios;
        String nombreUsuario;
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
        }
        if (!respuesta.isEmpty()) {
            response.getWriter().append(respuesta);
        }

    }

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
