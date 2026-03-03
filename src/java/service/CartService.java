package service;

import model.Cart;
import model.CartItem;

public class CartService {

    public void addToCart(Cart cart, CartItem item) {
        if (cart != null && item != null) {
            cart.addItem(item);
        }
    }

    public void removeFromCart(Cart cart, int index) {
        if (cart != null) {
            cart.removeItem(index);
        }
    }

    public void clearCart(Cart cart) {
        if (cart != null) {
            cart.clear();
        }
    }
}
