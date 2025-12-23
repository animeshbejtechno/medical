package com.medical.store

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.runtime.*
import com.medical.store.ui.theme.OnlineMedicalStoreTheme
import com.medical.store.ui.login.LoginScreen
import com.medical.store.ui.medicine.MedicineListScreen
import com.medical.store.ui.cart.CartScreen
import com.medical.store.data.model.Medicine
import com.medical.store.data.model.CartItem

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            OnlineMedicalStoreTheme {
                var isLoggedIn by remember { mutableStateOf(false) }
                var currentScreen by remember { mutableStateOf("login") }
                val cartItems = remember { mutableStateListOf<CartItem>() }
                
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    when (currentScreen) {
                        "login" -> LoginScreen(onLoginSuccess = { 
                            isLoggedIn = true 
                            currentScreen = "medicine_list"
                        })
                        "medicine_list" -> {
                            val mockMedicines = listOf(
                                Medicine(1, "Paracetamol", 5.0, 100, "Pain reliever and fever reducer"),
                                Medicine(2, "Amoxicillin", 15.0, 50, "Antibiotic for bacterial infections"),
                                Medicine(3, "Ibuprofen", 8.0, 80, "Nonsteroidal anti-inflammatory drug")
                            )
                            MedicineListScreen(
                                medicines = mockMedicines,
                                onAddToCart = { medicine ->
                                    val existing = cartItems.find { it.medicine.id == medicine.id }
                                    if (existing != null) {
                                        existing.quantity++
                                    } else {
                                        cartItems.add(CartItem(medicine, 1))
                                    }
                                },
                                onViewCart = { currentScreen = "cart" }
                            )
                        }
                        "cart" -> {
                            CartScreen(
                                cartItems = cartItems,
                                onRemoveItem = { cartItems.remove(it) },
                                onCheckout = { 
                                    // Handle checkout
                                    cartItems.clear()
                                    currentScreen = "medicine_list"
                                },
                                onBack = { currentScreen = "medicine_list" }
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Welcome to $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    OnlineMedicalStoreTheme {
        Greeting("Android")
    }
}
