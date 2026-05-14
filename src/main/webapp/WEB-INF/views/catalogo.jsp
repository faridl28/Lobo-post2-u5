<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Catálogo de Productos</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<header>
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/catalogo">🛒 TechStore</a>
        <nav>
            <a class="active" href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
            <a href="${pageContext.request.contextPath}/carrito">Ver carrito</a>
        </nav>
    </div>
</header>

<div class="container">
    <h1>Catálogo de Productos</h1>

    <!-- Barra de búsqueda y filtro -->
    <form class="search-bar" method="get"
          action="${pageContext.request.contextPath}/catalogo">

        <input type="text" name="q"
               value="${not empty busqueda ? busqueda : ''}"
               placeholder="Buscar por nombre...">

        <select name="cat">
            <option value="">Todas las categorías</option>
            <c:forEach var="cat" items="${categorias}">
                <option value="${cat}"
                    <c:if test="${cat == catActual}">selected</c:if>>${cat}</option>
            </c:forEach>
        </select>

        <button type="submit" class="btn-primary">🔍 Buscar</button>

        <c:if test="${not empty busqueda or not empty catActual}">
            <a href="${pageContext.request.contextPath}/catalogo"
               class="btn btn-outline">✕ Limpiar filtros</a>
        </c:if>
    </form>

    <!-- Tabla de productos -->
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty productos}">
                        <tr>
                            <td colspan="6">
                                <div class="empty">
                                    <p>😕 No se encontraron productos.</p>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${productos}">
                            <tr>
                                <td>${p.id}</td>
                                <td><strong>${p.nombre}</strong></td>
                                <td><span class="badge">${p.categoria}</span></td>
                                <td class="price">
                                    <fmt:formatNumber value="${p.precio}"
                                                      type="currency"
                                                      currencySymbol="$"
                                                      maxFractionDigits="0"/>
                                </td>
                                <td>${p.stock}</td>
                                <td>
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/carrito">
                                        <input type="hidden" name="accion"     value="agregar">
                                        <input type="hidden" name="idProducto" value="${p.id}">
                                        <button type="submit" class="btn-add">+ Carrito</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</div>
</body>
</html> 