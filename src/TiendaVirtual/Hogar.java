
package TiendaVirtual;


// Subclase Hogar
public class Hogar extends Producto {
    public Hogar(String nombre, double precio) {
        super(nombre, precio);
    }

    @Override
    public String getCategoria() {
        return "Hogar";
    }
}


