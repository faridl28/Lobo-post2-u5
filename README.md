# Lobo-post2-u5 — Post-Contenido 2 · Unidad 5

Aplicación Java Web que implementa un catálogo de productos con búsqueda,
filtrado por categoría y carrito de compras en sesión.

## Tecnologías

- Java 17
- Jakarta Servlets 6.0 / JSP 3.1 / JSTL 3.0
- Apache Tomcat 10.x
- Maven 3.x

## Estructura del proyecto

catalogo-web/
├── src/main/java/com/ejemplo/
│   ├── model/
│   │   ├── Producto.java
│   │   └── CarritoItem.java
│   └── servlet/
│       ├── CatalogoServlet.java
│       ├── CarritoServlet.java
│       └── ConfirmacionServlet.java
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── views/
│   │       ├── catalogo.jsp
│   │       ├── carrito.jsp
│   │       └── confirmacion.jsp
│   ├── css/
│   │   └── estilos.css
│   └── index.jsp
└── pom.xml

## Instrucciones de ejecución

### 1. Clonar el repositorio
```bash
git clone https://github.com/faridl28/Lobo-post2-u5.git
cd Lobo-post2-u5
```

### 2. Compilar con Maven
En IntelliJ IDEA abrir el panel Maven → Lifecycle → `clean` → `package`.
O desde terminal:
```bash
mvn clean package
```

### 3. Desplegar en Tomcat
En IntelliJ: `Add Configuration` → `Tomcat Server → Local` → pestaña
Deployment → agregar `catalogo-web:war exploded` → Run.

### 4. Acceder a la aplicación

http://localhost:8081/catalogo-web/

## Funcionalidades

| Ruta | Descripción |
|------|-------------|
| `/catalogo` | Lista los 6 productos con búsqueda por nombre y filtro por categoría |
| `/carrito` | Muestra ítems en sesión con cantidades y subtotales |
| `/confirmacion` | Resumen del pedido tras confirmar la compra |

## Checkpoints verificados

- [x] Compila con `mvn clean package` sin errores
- [x] Despliega en Tomcat sin errores
- [x] `/catalogo` muestra los 6 productos
- [x] Búsqueda por texto filtra correctamente
- [x] Filtro por categoría funciona
- [x] "Agregar al carrito" añade el producto a la sesión
- [x] Agregar el mismo producto incrementa la cantidad (no duplica fila)
- [x] "Limpiar carrito" vacía el carrito y redirige a `/catalogo`
- [x] "Confirmar pedido" muestra la vista de confirmación con el total

## Capturas de pantalla

### Catálogo
<img width="1365" height="735" alt="image" src="https://github.com/user-attachments/assets/3c394f5d-0510-457d-a632-a1eefd56f84c" />

### Carrito
<img width="1365" height="686" alt="image" src="https://github.com/user-attachments/assets/269c3a3b-f55a-4563-b816-833d3a462acc" />

### Confirmación
<img width="1365" height="738" alt="image" src="https://github.com/user-attachments/assets/17ba9275-3880-450d-8545-a99b75b2c2bf" />
