#include <Arduino.h>

// ESP32 doesn't define LED_BUILTIN, so define it if not already defined
#ifndef LED_BUILTIN
  #define LED_BUILTIN 2  // GPIO2 for ESP32
#endif

void setup() {
  // Initialize serial communication
  Serial.begin(115200);
  
  // Initialize built-in LED pin
  pinMode(LED_BUILTIN, OUTPUT);
  
  Serial.println("PlatformIO Multi-Platform Test");
  Serial.print("Built-in LED (GPIO");
  Serial.print(LED_BUILTIN);
  Serial.println(") will blink every second");
}

void loop() {
  // Turn LED on
  digitalWrite(LED_BUILTIN, HIGH);
  Serial.println("LED ON");
  delay(1000);
  
  // Turn LED off
  digitalWrite(LED_BUILTIN, LOW);
  Serial.println("LED OFF");
  delay(1000);
}
