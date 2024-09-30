
package TiendaVirtual;


import java.util.ArrayList;

public class Compra {
    private Cliente cliente;
    private ArrayList<Producto> productos;
    private double total;

    // Constructor
    public Compra(Cliente cliente) {
        this.cliente = cliente;
        this.productos = new ArrayList<>();
    }

    // Agregar productos
    public void agregarProducto(Producto producto) {
        productos.add(producto);
    }

    // Calcular el total
    public void calcularTotal() {
        total = 0;
        for (Producto producto : productos) {
            total += producto.getPrecio();
        }
    }

    // Generar comprobante
    public void generarComprobante() {
        calcularTotal();
        double igv = total * 0.18;
        double totalConIgv = total + igv;

        System.out.println("\nComprobante de Pago:");
        System.out.println("Cliente: " + cliente.getNombre());
        System.out.println("DNI: " + cliente.getDni());
        System.out.println("Productos comprados:");
        for (Producto producto : productos) {
            System.out.println("- " + producto.getNombre() + ": $" + producto.getPrecio());
        }
        System.out.println("Total sin IGV: $" + total);
        System.out.println("IGV (18%): $" + igv);
        System.out.println("Total con IGV: $" + totalConIgv);
        System.out.println("Gracias por su compra.");
    }
}


