package com.ejemplo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ConfirmacionServlet", urlPatterns = "/confirmacion")
public class ConfirmacionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Si no hay datos de confirmación, redirigir al catálogo
        if (session == null || session.getAttribute("totalConfirmado") == null) {
            resp.sendRedirect(req.getContextPath() + "/catalogo");
            return;
        }

        req.setAttribute("totalConfirmado",  session.getAttribute("totalConfirmado"));
        req.setAttribute("itemsConfirmados", session.getAttribute("itemsConfirmados"));

        // Limpiar datos de confirmación de la sesión
        session.removeAttribute("totalConfirmado");
        session.removeAttribute("itemsConfirmados");

        req.getRequestDispatcher("/WEB-INF/views/confirmacion.jsp")
                .forward(req, resp);
    }
}