<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pedido Confirmado</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<header>
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/catalogo">🛒 TechStore</a>
        <nav>
            <a href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
            <a href="${pageContext.request.contextPath}/carrito">Ver carrito</a>
        </nav>
    </div>
</header>

<div class="container">
    <div class="confirm-card">
        <div class="icon">✅</div>
        <h1>¡Pedido confirmado!</h1>
        <p>Gracias por tu compra. Tu pedido fue registrado correctamente.</p>

        <!-- Resumen de ítems comprados -->
        <c:if test="${not empty itemsConfirmados}">
            <div class="table-wrap" style="text-align:left; margin-bottom:1.5rem">
                <table>
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Cant.</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${itemsConfirmados}">
                            <tr>
                                <td>${entry.value.producto.nombre}</td>
                                <td>${entry.value.cantidad}</td>
                                <td class="price">
                                    <fmt:formatNumber value="${entry.value.subtotal}"
                                                      type="currency"
                                                      currencySymbol="$"
                                                      maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div class="confirm-total">
            Total pagado:
            <fmt:formatNumber value="${totalConfirmado}"
                              type="currency"
                              currencySymbol="$"
                              maxFractionDigits="0"/>
        </div>

        <a href="${pageContext.request.contextPath}/catalogo"
           class="btn btn-primary">← Volver al catálogo</a>
    </div>
</div>
</body>
</html>