Verwendung und Installation
===========================

Dieses Kapitel beschreibt die praktische Verwendung des 4CH-Opto-ISO PCB.

Vorbereitung
-----------

Benötigte Komponenten
~~~~~~~~~~~~~~~~~~~~

Vor der Installation stellen Sie sicher, dass alle Komponenten verfügbar sind:

* 4CH-Opto-ISO PCB (bestückt)
* Stromversorgung (3.3V-5V DC)
* Verbindungskabel
* Anschlussstecker

Werkzeuge
~~~~~~~~

* Lötkolben (falls Anpassungen nötig)
* Multimeter für Tests
* Oszilloskop (optional, für Signalanalyse)
* Antistatik-Schutz

Installation
-----------

Mechanische Montage
~~~~~~~~~~~~~~~~~~

1. **Montageort wählen**
   
   * Trockene, staubfreie Umgebung
   * Temperaturbereich: -10°C bis +60°C
   * Keine direkte Sonneneinstrahlung

2. **Befestigung**
   
   * Verwenden Sie die vorgesehenen Montagelöcher
   * M3 Schrauben empfohlen
   * Abstand zur Gehäusewand: mindestens 5mm

3. **Mechanische Sicherheit**
   
   * Keine scharfen Kanten berühren
   * Komponenten vor mechanischen Stößen schützen
   * Ausreichende Belüftung sicherstellen

Elektrische Anschlüsse
~~~~~~~~~~~~~~~~~~~~~

.. danger::
   
   Vor allen elektrischen Arbeiten die Stromversorgung trennen!

**Stromversorgung (J1):**

.. list-table:: Anschluss J1 - Stromversorgung
   :widths: 15 20 65
   :header-rows: 1

   * - Pin
     - Signal
     - Beschreibung
   * - 1
     - +VDD
     - Positive Versorgungsspannung (3.3V-5V)
   * - 2
     - GND
     - Masse/Ground

**Signaleingang (J2):**

.. list-table:: Anschluss J2 - Eingang
   :widths: 15 20 65
   :header-rows: 1

   * - Pin
     - Signal
     - Beschreibung
   * - 1
     - IN1
     - Signaleingang Kanal 1
   * - 2
     - IN2
     - Signaleingang Kanal 2
   * - 3
     - IN3
     - Signaleingang Kanal 3
   * - 4
     - GND
     - Signalmasse

**Signalausgang (J3):**

.. list-table:: Anschluss J3 - Ausgang
   :widths: 15 20 65
   :header-rows: 1

   * - Pin
     - Signal
     - Beschreibung
   * - 1
     - OUT1
     - Signalausgang Kanal 1
   * - 2
     - OUT2
     - Signalausgang Kanal 2
   * - 3
     - OUT3
     - Signalausgang Kanal 3
   * - 4
     - GND
     - Signalmasse

Grundkonfiguration
-----------------

Spannungsversorgung
~~~~~~~~~~~~~~~~~~

1. **Spannungsprüfung**
   
   Überprüfen Sie die Versorgungsspannung mit einem Multimeter:
   
   * Sollwert: 3.3V - 5.0V DC
   * Toleranz: ±5%
   * Welligkeit: <50mV

2. **Stromaufnahme-Test**
   
   * Leerlauf: <10mA
   * Betrieb: 50-100mA (typisch)
   * Maximum: <500mA

3. **Funktionstest**
   
   * LED-Anzeigen überprüfen
   * Signalausgabe messen
   * Temperatur überwachen

Signalverbindungen
~~~~~~~~~~~~~~~~~

1. **Eingangssignale**
   
   * Spannungspegel: 0V - VDD
   * Impedanz: >10kΩ
   * Frequenzbereich: DC - 100kHz

2. **Ausgangssignale**
   
   * Ausgangsspannung: 0V - VDD
   * Ausgangsstrom: max. 20mA pro Kanal
   * Lastimpedanz: >1kΩ empfohlen

Anwendungsbeispiele
------------------

Beispiel 1: Signalverstärkung
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text

   Eingangssignal -> J2 (Pin 1) -> Verstärkung -> J3 (Pin 1) -> Ausgangssignal
   
   Verstärkungsfaktor: 2x
   Bandbreite: DC - 50kHz
   
Beispiel 2: Signalfilterung
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: text

   Verrauschtes Signal -> J2 -> Tiefpassfilter -> J3 -> Gefiltertes Signal
   
   Grenzfrequenz: 10kHz
   Dämpfung: -40dB/Dekade

Industrielle Steuerung
~~~~~~~~~~~~~~~~~~~~

Das 4CH-Opto-ISO kann in industriellen Steuerungsanlagen eingesetzt werden:

.. code-block:: text

   SPS-Ausgang -> Optokoppler -> 4CH-Opto-ISO -> Aktor
   
   Vorteile:
   * Galvanische Trennung
   * Störungsunterdrückung  
   * Signalaufbereitung

.. note::
   
   Bei industriellen Anwendungen sind zusätzliche Schutzmaßnahmen zu beachten.

Fehlerbehebung
=============

Häufige Probleme
~~~~~~~~~~~~~~~

**Problem: Keine Stromversorgung**

* Überprüfen Sie die Kabelverbindungen
* Messen Sie die Eingangsspannung
* Kontrollieren Sie die Sicherungen

**Problem: Kein Ausgangssignal**

* Eingangssignal vorhanden?
* LED-Status überprüfen
* Lastimpedanz kontrollieren

**Problem: Überhitzung**

* Umgebungstemperatur reduzieren
* Belüftung verbessern
* Laststrom verringern

Testverfahren
~~~~~~~~~~~~

**Grundfunktionstest:**

1. Spannungsversorgung anlegen
2. Eingangssignal (1kHz Sinus, 1V) anlegen
3. Ausgang mit Oszilloskop messen
4. Verstärkung und Phase prüfen

**Langzeittest:**

1. Kontinuierlicher Betrieb (24h)
2. Temperaturüberwachung
3. Signalqualität überwachen
4. Drift-Messung

Wartung
------

Regelmäßige Prüfungen
~~~~~~~~~~~~~~~~~~~

* **Monatlich**: Sichtprüfung auf Beschädigungen
* **Halbjährlich**: Elektrische Parameter prüfen
* **Jährlich**: Vollständige Funktionsprüfung

Reinigung
~~~~~~~~

* Druckluft für Staubentfernung
* Isopropanol für Kontaktreinigung
* Keine aggressiven Lösungsmittel verwenden

.. warning::
   
   Vor Reinigungsarbeiten immer die Stromversorgung trennen!
