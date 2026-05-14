package com.ejemplo.servlet;

import com.ejemplo.model.CarritoItem;
import com.ejemplo.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CarritoServlet", urlPatterns = "/carrito")
public class CarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");
        HttpSession session = req.getSession();

        @SuppressWarnings("unchecked")
        Map<Integer, CarritoItem> carrito =
                (Map<Integer, CarritoItem>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new LinkedHashMap<>();
            session.setAttribute("carrito", carrito);
        }

        switch (accion != null ? accion : "") {

            case "agregar": {
                int idProd = Integer.parseInt(req.getParameter("idProducto"));
                Producto prod = obtenerProducto(idProd);
                if (prod != null) {
                    // Si ya existe incrementa cantidad, si no crea ítem nuevo
                    carrito.merge(idProd,
                            new CarritoItem(prod, 1),
                            (existing, nuevo) -> {
                                existing.setCantidad(existing.getCantidad() + 1);
                                return existing;
                            });
                }
                resp.sendRedirect(req.getContextPath() + "/catalogo");
                break;
            }

            case "limpiar": {
                carrito.clear();
                resp.sendRedirect(req.getContextPath() + "/catalogo");
                break;
            }

            case "confirmar": {
                double total = carrito.values().stream()
                        .mapToDouble(CarritoItem::getSubtotal).sum();
                session.setAttribute("totalConfirmado", total);
                session.setAttribute("itemsConfirmados",
                        new LinkedHashMap<>(carrito));
                carrito.clear();
                resp.sendRedirect(req.getContextPath() + "/confirmacion");
                break;
            }

            default:
                resp.sendRedirect(req.getContextPath() + "/catalogo");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        @SuppressWarnings("unchecked")
        Map<Integer, CarritoItem> carrito = (session != null)
                ? (Map<Integer, CarritoItem>) session.getAttribute("carrito")
                : null;

        req.setAttribute("items",
                carrito != null ? carrito.values() : Collections.emptyList());

        req.getRequestDispatcher("/WEB-INF/views/carrito.jsp")
                .forward(req, resp);
    }

    private Producto obtenerProducto(int id) {
        @SuppressWarnings("unchecked")
        List<Producto> catalogo =
                (List<Producto>) getServletContext().getAttribute("catalogo");

        if (catalogo == null) return null;

        return catalogo.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);
    }
}