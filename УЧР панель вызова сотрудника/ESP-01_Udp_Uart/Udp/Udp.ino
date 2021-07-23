/*
 * ESP ретранслятор.
 * UDP broadcast -> UART;
 * UART -> UDA broadcast.
 */

#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

#define STASSID "esp-test"
#define STAPSK  "12345678"
#define LOCALPORT  2021

IPAddress local_ip(192, 168, 5, 1);

char packetBuffer[UDP_TX_PACKET_MAX_SIZE + 1];

WiFiUDP Udp;

void setup()
{
  Serial.begin(4800);
  /*Serial.println();
  Serial.println("Setting soft-AP ... ");*/

  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(local_ip, local_ip, IPAddress(255, 255, 255, 0));
  WiFi.softAP(STASSID, STAPSK, 1, 0, 8); //softAP(const String& ssid,const String& passphrase = emptyString,int channel = 1,int ssid_hidden = 0,int max_connection = 4);

  delay(1000);

  WiFi.printDiag(Serial);

  /*Serial.print("Soft-AP IP address = "); Serial.println(WiFi.softAPIP());
  Serial.print("Soft-AP subnetMask = "); Serial.println(WiFi.subnetMask());
  Serial.printf("MAC address = %s\n", WiFi.softAPmacAddress().c_str());*/

  Udp.begin(LOCALPORT);

  delay(500);
}

void loop()
{
  if (Udp.parsePacket())
  {
    int n = Udp.read(packetBuffer, UDP_TX_PACKET_MAX_SIZE);
    packetBuffer[n] = 0;
    Serial.print(packetBuffer);
  }

  delay(100);

  if (Serial.available()) 
  {
    size_t packetLength = Serial.readBytes(packetBuffer, UDP_TX_PACKET_MAX_SIZE);
    Udp.beginPacket(IPAddress (192, 168, 5, 255), LOCALPORT);
    Udp.write(packetBuffer, packetLength);
    Udp.endPacket();
  }
  
  delay(100);
}
