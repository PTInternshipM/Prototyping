package com.example.kotlinmultiplatformprototye.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.*
import com.example.kotlinmultiplatformprototye.BTDevice
import java.util.*

@Composable
fun MyApplicationTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colors = if (darkTheme) {
        darkColors(
            primary = Color(0xFFBB86FC),
            primaryVariant = Color(0xFF3700B3),
            secondary = Color(0xFF03DAC5)
        )
    } else {
        lightColors(
            primary = Color(0xFF6200EE),
            primaryVariant = Color(0xFF3700B3),
            secondary = Color(0xFF03DAC5)
        )
    }
    val typography = Typography(
        body1 = TextStyle(
            fontFamily = FontFamily.Default,
            fontWeight = FontWeight.Normal,
            fontSize = 16.sp
        )
    )
    val shapes = Shapes(
        small = RoundedCornerShape(4.dp),
        medium = RoundedCornerShape(4.dp),
        large = RoundedCornerShape(0.dp)
    )

    MaterialTheme(
        colors = colors,
        typography = typography,
        shapes = shapes,
        content = content
    )
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    DevicesList()
                }
            }
        }
    }
}

// below is the Composable function
// which we have created for our ListView.
@OptIn(ExperimentalUnitApi::class)
@Composable
fun DevicesList() {
    // on below line we arecreating a simple list
    // of strings and adding different programming
    // languages in it.
    val devices = listOf(
        BTDevice(UUID.randomUUID().toString(), "Device A", 80, "China"),
        BTDevice(UUID.randomUUID().toString(), "Device B", 20,"China"),
        BTDevice(UUID.randomUUID().toString(), "Device A", 1, "China"),
        BTDevice(UUID.randomUUID().toString(), "Device A", 69, "China")
    )
    // on below line we are
    // creating a simple column
    Column(
        // inside this column we are specifying modifier
        // to specify max width and max height
        modifier = Modifier
            .fillMaxWidth()
            .fillMaxHeight(),
        // on below line we are specifying horizontal alignment
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // on below line we are creating a simple text
        // view for displaying heading for our application
        Text(
            text = "Devices",
            // in modifier we are specifying padding
            // for our text from all sides.
            modifier = Modifier.padding(10.dp),
            // on below line we are specifying
            // style for our text
            style = TextStyle(
                color = Color.Black,
                fontSize = TextUnit(value = 20.0F, type = TextUnitType.Sp)
            ), fontWeight = FontWeight.Black
        )
        // on below line we are calling lazy column
        // for displaying listview.
        LazyColumn {
            // on below line we are populating
            // items for listview.
            items(devices) {
                // on below line we are specifying ui for each item of list view.
                // we are specifying a simple text for each item of our list view.
                Text(it.name, modifier = Modifier.padding(15.dp))
                // on below line we are specifying
                // divider for each list item
                Divider()
            }
        }
    }
}

@Composable
fun Greeting(text: String) {
    Text(text = text)
}

@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        Greeting("Hello, Android!")
    }
}
