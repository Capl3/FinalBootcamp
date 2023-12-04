const consultaUno = async () => {
    const url = 'http://localhost:8080/producto';
    const response = await fetch(url);
    const datos = await response.json();
    return datos;
}

const construccionTabla = (producto) => {
    const cuerpoTabla = document.querySelector('#cuerpoTabla');
    cuerpoTabla.innerHTML = ''; // Limpiar contenido actual de la tabla

    producto.producto.forEach(producto => {
        const fila = document.createElement('tr');
        const columnaUno = document.createElement('td');
        const columnaDos = document.createElement('td');
        const columnaTres = document.createElement('td');
        const columnaCuatro = document.createElement('td');
        const columnaCinco = document.createElement('td');
        columnaUno.innerHTML = producto.productid;
        columnaDos.innerHTML = producto.name;
        columnaTres.innerHTML = producto.productnumber;
        columnaCuatro.innerHTML = producto.color;

        const subCategoriaNombre = producto.ProductSubCategory ? producto.ProductSubCategory.name : '';
        columnaCinco.innerHTML = subCategoriaNombre;

        fila.append(columnaUno, columnaDos, columnaTres, columnaCuatro, columnaCinco);
        cuerpoTabla.appendChild(fila);
    });

    document.getElementById('filtroForm').addEventListener('submit', async (event) => {
        event.preventDefault();

        const txtSubId = document.getElementById('txtSubId').value;
        const txtSubNombre = document.getElementById('txtSubNombre').value;
        const txtProdId = document.getElementById('txtProdId').value;
        const txtProdNombre = document.getElementById('txtProdNombre').value;

        const productos = await consultaUno();
        const productosFiltrados = productos.producto.filter(producto => {
            const productNumber = producto.productnumber;
            const nombreSubCategoria = producto.ProductSubCategory ? producto.ProductSubCategory.name.toLowerCase() : '';
            const idProducto = producto.productid.toString();
            const nombreProducto = producto.name.toLowerCase();

            return (
                (txtSubId === '' || productNumber.includes(txtSubId)) &&
                (txtSubNombre === '' || nombreSubCategoria.includes(txtSubNombre.toLowerCase())) &&
                (txtProdId === '' || idProducto.includes(txtProdId)) &&
                (txtProdNombre === '' || nombreProducto.includes(txtProdNombre.toLowerCase()))
            );
        });

        construccionTabla({ producto: productosFiltrados });
    });
}

consultaUno().then(construccionTabla);