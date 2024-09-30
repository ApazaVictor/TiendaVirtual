
package TiendaVirtual;


// Subclase Ropa
public class Ropa extends Producto {
    public Ropa(String nombre, double precio) {
        super(nombre, precio);
    }

    @Override
    public String getCategoria() {
        return "Ropa";
    }
}
