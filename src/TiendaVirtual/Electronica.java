
package TiendaVirtual;


// Subclase Electronica
public class Electronica extends Producto {
    public Electronica(String nombre, double precio) {
        super(nombre, precio);
    }

    @Override
    public String getCategoria() {
        return "Electrónica";
    }
}


