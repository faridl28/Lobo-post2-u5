<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Carrito de Compras</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<header>
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/catalogo">🛒 TechStore</a>
        <nav>
            <a href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
            <a class="active" href="${pageContext.request.contextPath}/carrito">Ver carrito</a>
        </nav>
    </div>
</header>

<div class="container">
    <h1>🛒 Carrito de Compras</h1>

    <c:choose>

        <c:when test="${empty items}">
            <div class="table-wrap">
                <div class="empty">
                    <p>Tu carrito está vacío.</p>
                    <br>
                    <a href="${pageContext.request.contextPath}/catalogo"
                       class="btn btn-primary">← Volver al catálogo</a>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Precio unit.</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalGeneral" value="0"/>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td><strong>${item.producto.nombre}</strong></td>
                                <td><span class="badge">${item.producto.categoria}</span></td>
                                <td class="price">
                                    <fmt:formatNumber value="${item.producto.precio}"
                                                      type="currency"
                                                      currencySymbol="$"
                                                      maxFractionDigits="0"/>
                                </td>
                                <td>${item.cantidad}</td>
                                <td class="price">
                                    <fmt:formatNumber value="${item.subtotal}"
                                                      type="currency"
                                                      currencySymbol="$"
                                                      maxFractionDigits="0"/>
                                </td>
                            </tr>
                            <c:set var="totalGeneral"
                                   value="${totalGeneral + item.subtotal}"/>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Total y acciones -->
            <div class="cart-summary">
                <div>
                    <div class="total-label">Total del pedido</div>
                    <div class="total-amount">
                        <fmt:formatNumber value="${totalGeneral}"
                                          type="currency"
                                          currencySymbol="$"
                                          maxFractionDigits="0"/>
                    </div>
                </div>

                <div class="cart-actions">
                    <form method="post"
                          action="${pageContext.request.contextPath}/carrito">
                        <input type="hidden" name="accion" value="limpiar">
                        <button type="submit" class="btn btn-danger">
                            🗑 Limpiar carrito
                        </button>
                    </form>

                    <form method="post"
                          action="${pageContext.request.contextPath}/carrito">
                        <input type="hidden" name="accion" value="confirmar">
                        <button type="submit" class="btn btn-success">
                            ✔ Confirmar pedido
                        </button>
                    </form>
                </div>
            </div>
        </c:otherwise>

    </c:choose>

    <br>
    <a href="${pageContext.request.contextPath}/catalogo"
       class="btn btn-outline">← Seguir comprando</a>

</div>
</body>
</html>