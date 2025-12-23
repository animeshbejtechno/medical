package com.medical.store.ui.medicine

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.medical.store.data.model.Medicine

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MedicineListScreen(
    medicines: List<Medicine>,
    onAddToCart: (Medicine) -> Unit,
    onViewCart: () -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Available Medicines") },
                actions = {
                    IconButton(onClick = onViewCart) {
                        Text("Cart")
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
        ) {
            items(medicines) { medicine ->
                MedicineItem(medicine, onAddToCart)
            }
        }
    }
}

@Composable
fun MedicineItem(medicine: Medicine, onAddToCart: (Medicine) -> Unit) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Text(text = medicine.name, style = MaterialTheme.typography.titleLarge)
            Text(text = "Price: $${medicine.price}", style = MaterialTheme.typography.bodyMedium)
            Text(text = "Stock: ${medicine.stock}", style = MaterialTheme.typography.bodySmall)
            Spacer(modifier = Modifier.height(8.dp))
            Text(text = medicine.description, style = MaterialTheme.typography.bodyMedium)
            Button(
                onClick = { onAddToCart(medicine) },
                modifier = Modifier.align(androidx.compose.ui.Alignment.End)
            ) {
                Text("Add to Cart")
            }
        }
    }
}
