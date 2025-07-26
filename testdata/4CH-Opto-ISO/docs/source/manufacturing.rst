Fertigung und Produktion
=======================

Dieses Kapitel beschreibt die Fertigung und Produktion des 4CH-Opto-ISO PCB.

Fertigungsunterlagen
===================

Alle notwendigen Fertigungsunterlagen sind im `production/` Verzeichnis verfügbar.

Generierte Dateien
-----------------

Gerber-Dateien
~~~~~~~~~~~~~

Die Gerber-Dateien enthalten alle Layerinformationen:

.. code-block:: text

   production/gerbers/
   ├── 4CH-Opto-ISO-F_Cu.gtl          # Oberseite Kupfer
   ├── 4CH-Opto-ISO-B_Cu.gbl          # Unterseite Kupfer  
   ├── 4CH-Opto-ISO-F_Mask.gts        # Oberseite Lötresist
   ├── 4CH-Opto-ISO-B_Mask.gbs        # Unterseite Lötresist
   ├── 4CH-Opto-ISO-F_Silkscreen.gto  # Oberseite Bestückungsdruck
   ├── 4CH-Opto-ISO-B_Silkscreen.gbo  # Unterseite Bestückungsdruck
   ├── 4CH-Opto-ISO-Edge_Cuts.gm1     # Platinenkontur
   └── 4CH-Opto-ISO.drl               # Bohrdatei

.. note::
   
   Alle Gerber-Dateien entsprechen dem RS-274X Standard und sind mit gängigen CAM-Systemen kompatibel.

Bohrdateien
~~~~~~~~~~

* **Format**: Excellon
* **Einheiten**: Metrisch (mm)
* **Koordinaten**: Absolut

Dokumentation
~~~~~~~~~~~~

* **PDF-Schaltplan**: Vollständiger Schaltplan
* **PDF-Assembly**: Bestückungsplan
* **PDF-Fab**: Fertigungszeichnung

Bill of Materials (BOM)
~~~~~~~~~~~~~~~~~~~~~~

* **CSV-Format**: Maschinell lesbar
* **HTML-Format**: Interaktive BOM mit Bauteilpositionen
* **Herstellerinformationen**: Bestellnummern und Spezifikationen

Fertigungsparameter
------------------

PCB-Spezifikationen
~~~~~~~~~~~~~~~~~~

.. list-table:: PCB-Parameter
   :widths: 40 30 30
   :header-rows: 1

   * - Parameter
     - Wert
     - Bemerkung
   * - Lagenanzahl
     - 2
     - Standard Doppelseitig
   * - Platinenstärke
     - 1.6mm
     - Standard FR4
   * - Kupferdicke
     - 35μm
     - 1oz Standard
   * - Min. Leiterbahnbreite
     - 0.2mm
     - 8mil
   * - Min. Via-Durchmesser
     - 0.3mm
     - 0.6mm Außendurchmesser
   * - Min. Bohrung
     - 0.2mm
     - Mechanische Bohrung
   * - Oberflächenbehandlung
     - HASL
     - Bleifreie Option verfügbar

Lötparameter
~~~~~~~~~~~

.. list-table:: Löt-Spezifikationen
   :widths: 40 30 30
   :header-rows: 1

   * - Parameter
     - Wert
     - Bemerkung
   * - Reflow-Profil
     - SAC305
     - Bleifreies Lot
   * - Peak-Temperatur
     - 245°C
     - ±5°C
   * - Verweilzeit über 217°C
     - 45-90s
     - Kritisch für Lötqualität
   * - Aufheizrate
     - 1-3°C/s
     - Gleichmäßige Erwärmung
   * - Abkühlrate
     - <4°C/s
     - Vermeidung von Rissen

.. warning::
   
   Temperaturprofile müssen genau eingehalten werden, um Lötfehler zu vermeiden.

Qualitätskontrolle
-----------------

Automatisierte Prüfungen
~~~~~~~~~~~~~~~~~~~~~~~

* **AOI (Automated Optical Inspection)**: Visuelle Kontrolle
* **ICT (In-Circuit Test)**: Elektrische Funktionsprüfung
* **Boundary Scan**: JTAG-basierte Tests (falls verfügbar)

Funktionstests
~~~~~~~~~~~~~

* **Stromaufnahme-Test**: Überprüfung der Leistungsaufnahme
* **Funktionalitäts-Test**: Vollständige Funktionsprüfung
* **Umgebungstest**: Tests unter verschiedenen Bedingungen

Fertigungspartner
----------------

Empfohlene PCB-Hersteller:

* **JLCPCB**: Kostengünstige Prototypen
* **PCBWay**: Professionelle Kleinserien
* **Eurocircuits**: Europäische Fertigung
* **OSH Park**: Open-Source-Hardware-freundlich

.. tip::
   
   Für Prototypen sind 5-10 Stück ausreichend. Für Serien ab 100 Stück sollten Kostenvergleiche durchgeführt werden.

Kostenschätzung
--------------

.. list-table:: Kostenschätzung (ungefähre Werte)
   :widths: 30 25 25 20
   :header-rows: 1

   * - Stückzahl
     - PCB-Kosten
     - Bestückung
     - Gesamt
   * - 5 Stück
     - 2-5€
     - 10-20€
     - 12-25€
   * - 10 Stück
     - 1-3€
     - 8-15€
     - 9-18€
   * - 100 Stück
     - 0.5-1€
     - 5-10€
     - 5.5-11€
   * - 1000 Stück
     - 0.2-0.5€
     - 2-5€
     - 2.2-5.5€

.. note::
   
   Preise variieren je nach Hersteller, Spezifikationen und aktueller Marktlage.
