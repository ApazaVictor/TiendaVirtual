
package TiendaVirtual;


// Subclase Libros
public class Libros extends Producto {
    public Libros(String nombre, double precio) {
        super(nombre, precio);
    }

    @Override
    public String getCategoria() {
        return "Libros";
    }
}



