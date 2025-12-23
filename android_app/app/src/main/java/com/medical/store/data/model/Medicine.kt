package com.medical.store.data.model

data class Medicine(
    val id: Int,
    val name: String,
    val price: Double,
    val stock: Int,
    val description: String
)
