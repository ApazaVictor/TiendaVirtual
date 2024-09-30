
package TiendaVirtual;

//victor hugo
import java.util.Scanner;

// Clase principal
public class Principal {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Tienda tienda = new Tienda();

        // Solicitar datos del cliente
        System.out.print("Ingrese su nombre: ");
        String nombreCliente = scanner.nextLine();
        System.out.print("Ingrese su DNI: ");
        String dniCliente = scanner.nextLine();
        Cliente cliente = new Cliente(nombreCliente, dniCliente);

        // Mostrar productos y permitir que el cliente elija
        tienda.mostrarProductos();
        System.out.println("\nSeleccione los productos que desea agregar al carrito (máximo 5 productos). Ingrese '0' para terminar.");

        int productosSeleccionados = 0;
        while (productosSeleccionados < 5) {
            System.out.print("Número de producto: ");
            int opcion = scanner.nextInt();
            if (opcion == 0) break;
            tienda.agregarAlCarrito(opcion);
            productosSeleccionados++;
        }

        // Mostrar el carrito y calcular total
        tienda.mostrarCarrito();
        tienda.generarComprobante(cliente);
    }
}



