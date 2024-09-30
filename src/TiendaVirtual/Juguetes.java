
package TiendaVirtual;


// Subclase Juguetes
public class Juguetes extends Producto {
    public Juguetes(String nombre, double precio) {
        super(nombre, precio);
    }

    @Override
    public String getCategoria() {
        return "Juguetes";
    }
}


