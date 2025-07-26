Verwendung und Installation
===========================

Dieser Abschnitt beschreibt die praktische Verwendung des 4CH-Opto-ISO Boards.

Vorbereitung
-----------

Benötigte Komponenten
~~~~~~~~~~~~~~~~~~~~

* 4CH-Opto-ISO PCB (fertig bestückt)
* Passende Anschlusskabel oder Steckverbinder
* Versorgungsspannung für Ein- und Ausgangsseite
* Multimeter für erste Tests

Werkzeuge
~~~~~~~~

* Schraubendreher (je nach Anschlussart)
* Abisolierzange
* Multimeter
* Oszilloskop (für erweiterte Tests)

Installation
-----------

Mechanische Montage
~~~~~~~~~~~~~~~~~~

1. **Montageposition wählen:**
   
   * Trockene, staubfreie Umgebung
   * Ausreichende Belüftung
   * Zugänglichkeit für Anschlüsse

2. **Befestigung:**
   
   * Montage auf DIN-Schiene (optional)
   * Verschraubung an Gehäusewand
   * Einbau in Schaltschrank

Elektrische Anschlüsse
~~~~~~~~~~~~~~~~~~~~~

.. warning::
   Alle Anschlüsse nur bei ausgeschalteter Versorgungsspannung vornehmen!

**Eingangsseitige Anschlüsse:**

.. code-block:: text

   Kanal 1: IN1+ / IN1-
   Kanal 2: IN2+ / IN2-
   Kanal 3: IN3+ / IN3-
   Kanal 4: IN4+ / IN4-
   Versorgung: VCC_IN / GND_IN (3.3V - 5V)

**Ausgangsseitige Anschlüsse:**

.. code-block:: text

   Kanal 1: OUT1+ / OUT1-
   Kanal 2: OUT2+ / OUT2-
   Kanal 3: OUT3+ / OUT3-
   Kanal 4: OUT4+ / OUT4-
   Versorgung: VCC_OUT / GND_OUT (3.3V - 24V)

Grundkonfiguration
-----------------

Spannungsversorgung
~~~~~~~~~~~~~~~~~~

1. **Eingangsspannung anlegen:**
   
   .. code-block:: text
   
      VCC_IN: 5V DC (oder 3.3V je nach Anwendung)
      GND_IN: Masse (Eingangsseite)

2. **Ausgangsspannung anlegen:**
   
   .. code-block:: text
   
      VCC_OUT: 5V-24V DC (je nach nachgelagerter Schaltung)
      GND_OUT: Masse (Ausgangsseite, isoliert von Eingangsseite)

Signalverbindungen
~~~~~~~~~~~~~~~~~

**Digitale Signale:**

.. code-block:: text

   Eingangssignal: 0V (Low) / VCC_IN (High)
   Ausgangssignal: Open Collector / Pull-Up über R_pullup

**Analoge Signale:**

.. note::
   Opto-Isolatoren sind primär für digitale Signale konzipiert. 
   Für analoge Signale sind spezielle Opto-Isolatoren erforderlich.

Anwendungsbeispiele
------------------

Mikrocontroller-Interface
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: c

   // Arduino Beispiel - Eingangsseitig
   digitalWrite(OUTPUT_PIN, HIGH);  // Signal senden
   delay(100);
   digitalWrite(OUTPUT_PIN, LOW);   // Signal stoppen

.. code-block:: c

   // Arduino Beispiel - Ausgangsseitig  
   int signal = digitalRead(INPUT_PIN);
   if (signal == LOW) {  // Opto-Isolator aktiv (invertiert)
       // Signal empfangen - Aktion ausführen
   }

Industrielle Steuerung
~~~~~~~~~~~~~~~~~~~~~

**SPS-Integration:**

* Eingänge an SPS-Ausgänge anschließen
* Ausgänge an SPS-Eingänge anschließen
* Separate 24V-Versorgung für Ausgangsseite

**Sensor-Interface:**

* Sensorsignale über Opto-Isolator zur Steuerung
* Galvanische Trennung für Sicherheit
* Schutz vor Überspannungen

Fehlerbehebung
--------------

Häufige Probleme
~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 30 35 35

   * - Problem
     - Mögliche Ursache
     - Lösung
   * - Kein Ausgangssignal
     - Keine Eingangsspannung
     - VCC_IN prüfen
   * - Signal invertiert
     - Normal bei Opto-Isolatoren
     - Software anpassen
   * - Schwaches Signal
     - Pull-Up-Widerstand fehlt
     - R_pullup ergänzen
   * - Überhitzung
     - Zu hoher Eingangsstrom
     - Vorwiderstand prüfen

Testverfahren
~~~~~~~~~~~~

**Kontinuitätstest:**

1. Versorgungsspannungen messen
2. Eingangsstrom bei aktivem Signal messen (sollte 10-20mA sein)
3. Ausgangsspannung bei aktivem/inaktivem Eingang messen

**Isolationstest:**

.. warning::
   Nur mit geeignetem Isolationstester durchführen!

1. Alle Anschlüsse trennen
2. Isolationsspannung zwischen Ein- und Ausgangsseite anlegen
3. Isolationswiderstand sollte > 10 MΩ bei 500V sein

Wartung
------

Regelmäßige Prüfungen
~~~~~~~~~~~~~~~~~~~

* **Monatlich:** Sichtprüfung auf Beschädigungen
* **Quartalsweise:** Funktionstest aller Kanäle
* **Jährlich:** Isolationstest erneuern

Reinigung
~~~~~~~~

* Trockene, antistatische Reinigung
* Keine Lösungsmittel verwenden
* Kontakte vor Korrosion schützen

.. tip::
   Dokumentieren Sie alle Änderungen und Tests für die Nachverfolgbarkeit 
   in sicherheitskritischen Anwendungen.
