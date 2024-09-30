
package TiendaVirtual;


import java.util.ArrayList;
import java.util.Scanner;

// Clase Tienda
public class Tienda {
    private ArrayList<Producto> productos = new ArrayList<>();
    private ArrayList<Producto> carrito = new ArrayList<>();

    public Tienda() {
        // Inicializamos productos en categorías específicas
        productos.add(new Electronica("Televisor", 1500.00));
        productos.add(new Electronica("Laptop", 3200.00));
        productos.add(new Electronica("Smartphone", 1200.00));
        productos.add(new Electronica("Auriculares", 200.00));
        productos.add(new Electronica("Consola de Videojuegos", 2300.00));

        productos.add(new Ropa("Camiseta", 50.00));
        productos.add(new Ropa("Pantalón", 120.00));
        productos.add(new Ropa("Zapatillas", 250.00));
        productos.add(new Ropa("Chaqueta", 350.00));
        productos.add(new Ropa("Gorro", 30.00));

        productos.add(new Hogar("Sofá", 1800.00));
        productos.add(new Hogar("Mesa", 500.00));
        productos.add(new Hogar("Silla", 150.00));
        productos.add(new Hogar("Lámpara", 80.00));
        productos.add(new Hogar("Espejo", 200.00));

        productos.add(new Juguetes("Pelota", 30.00));
        productos.add(new Juguetes("Muñeca", 60.00));
        productos.add(new Juguetes("Carrito", 40.00));
        productos.add(new Juguetes("Rompecabezas", 25.00));
        productos.add(new Juguetes("Juego de Mesa", 100.00));

        productos.add(new Libros("Cien Años de Soledad", 60.00));
        productos.add(new Libros("El Principito", 30.00));
        productos.add(new Libros("Don Quijote", 50.00));
        productos.add(new Libros("Moby Dick", 45.00));
        productos.add(new Libros("Orgullo y Prejuicio", 35.00));
    }

    public void mostrarProductos() {
        System.out.println("Productos disponibles:");
        for (int i = 0; i < productos.size(); i++) {
            System.out.println((i + 1) + ". " + productos.get(i));
        }
    }

    public void agregarAlCarrito(int index) {
        if (index >= 1 && index <= productos.size()) {
            Producto p = productos.get(index - 1);
            carrito.add(p);
            System.out.println(p.getNombre() + " añadido al carrito.");
        } else {
            System.out.println("Producto no válido.");
        }
    }

    public void mostrarCarrito() {
        System.out.println("-------------------------------------");
        System.out.println("\nProductos en tu carrito:");
        for (Producto p : carrito) {
            System.out.println(p);
        }
    }

    public double calcularTotal() {
        double total = 0;
        for (Producto p : carrito) {
            total += p.getPrecio();
        }
        return total;
    }

    public void generarComprobante(Cliente cliente) {
        System.out.println("\n-------- Comprobante de Pago --------");
        System.out.println("Cliente: " + cliente.getNombre());
        System.out.println("DNI: " + cliente.getDni());
        System.out.println("-------------------------------------");
        mostrarCarrito();
        double total = calcularTotal();
        double igv = total * 0.18;
        System.out.println("Subtotal: S/" + total);
        System.out.println("IGV (18%): S/" + igv);
        System.out.println("Total a pagar: S/" + (total + igv));
        System.out.println("Gracias por su compra.");
        System.out.println("-------------------------------------");
    }
}

