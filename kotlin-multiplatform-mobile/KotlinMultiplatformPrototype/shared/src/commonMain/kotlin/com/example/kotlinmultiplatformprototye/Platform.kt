package com.example.kotlinmultiplatformprototye

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform