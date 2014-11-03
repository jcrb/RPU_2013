ORUDAL
========================================================
author: 
date:  3 Juin 2014

Retour sur les tensions
========================

![tensions](tensions20140211.png)

---

- Durée plus longue et plus soutenue que les années précédentes
- production de cartes régionales
- un dispositif qui reste encore confus
- Suivi permanent ?


RPU et DSI
==========

- Strasbourg
- Colmar

- Evolutions réglementaires
- Impératifs horaires de l'InVS
- Nature de l'envoi

Recommandations
========================================================

Un **RPU** est composé de **18 items** qui peuvent être
divisés en deux groupes.

- groupe principal ou __RPU administratif__ (**core**)

  éléments de base qui peuvent **toujours** être relevés de manière exhaustive dès l'admission du patient et transmis au fil de l'eau au concentrateur régional.

  C'est le minimum qui doit pouvoir être transmis au moins une fois par 24 heures.

- groupe complémentaire ou __RPU médical__ (**supplementary**)

RPU Administratif (Core)
========================================================

- Il doit être transmis tous les jours avant 4 heures du matin
- Codage __UTF-8__
- Le fichier doit comporter un nombre d'enregistrements égal au nombre de passages (inscriptions) au service des urgences(SU)
- Il comprend l'ensemble des données recueillies au moment de l'enregistrement administratif du patient:

RPU Administratif (Core)
========================================================

  1. n° de dossier
  2. Date et heure d'enregistrement
  3. Le n° FINESS (géographique) de l'établissement
  4. La commune de résidence
  5. Le code postal  
  6. Date de naissance
  7. Mode d'entrée
  8. Provenance
  9. Mode de transport
  10. Prise en charge durant le transport
  11. Sexe

RPU Médical (Supplementary)
===========================

- RPU administratif +
  1. Diagnostic principal (DP)
  2. Diagnostics associés
  3. Motif de recours
  4. Gravité
  5. Actes réalisés
  6. Date et heure de sortie
  7. Mode de sortie
  8. Destination
  9. Orientation
- Cette partie du dossier est transmise au plus tard dans les 6 jours.


CR AG FEDORU du 20 mai 2014
========================================================

Informations générales
----------------------

- __COSUI RPU__: groupe de travail du ministère de la santé (DGOS, DEDORU, ATIH, InVS): pas de modification du schéma RPU avant longtemps.

- __ATIH__ loue les seveurs de l'ORUMIP pour les mettre à disposition des régions n'ayant pas de collecteur de RPU.

DGOS (Nathalie Cregut)
======================
Axe 1:
------
  - COSUI RPU chargé de la généralisation des RPU (DGOS, DEDORU, ATIH, InVS, ARS, DGS)
  - ATIH loue les serveurs de Midi-Pyrénées (SIRIUS)
  - 2.5 M€ fin 2013 pour l'informatisation des SU non informatisés

Axe 2:
------
  - commment utiliser les données ?
  - qualité des données
  - évolution ? (RPU Samu-Smur)
  - recommandations pour créer un ORU


DGOS (Nathalie Cregut)
======================

Axe 3: quels indicateurs ?
--------------------------
  - indicateurs opérationnels (durée de passage), quel socle d'indicateurs simples pour les ARS ?
  - deux types d'indicateurs:
    - statiques: priorié de la DGOS
    - dynamiques (orientés HET)

ATIH (Max Bensadon)
===================

- Programme SYRIUS (récupération des concentrateur régionaux)
- vérification des RPU
  - validité du schéma XML
  - cohérence du nombre de RPU transmis
  - en test depuis le 18 avril 2014

ATIH
========
- pour le contrôle/accès aux données ont défini 4 rôles dont 2 sont régionaux:
  - gestionnaire de fichier (référent technique)
    - demander un identifiant PLAGE auprès de l'administrateur régional (ARS)
  - un validateur régional
  - En pratique l'ATIH ne gère pas les pb techniques, c'est le rôle du référent technique régional.
- site: syrius@atih.sante.fr

===

- __anonymisation renforcée__:
  - suppression du nom de commune
  - date de naissance transformée en age
  - code postal transformé en code PMSI
- Validation des champs: __uniquement MONOchamp__ (pas de validation croisée)
  - production de 16 tableaux:
  - 0 < age <120
  - ZIP existe, etc...
  - durée de passage censurées à 24 h
  - moyennes mobiles pour 3 classes d'age
- encours de discussion: qui a accès à ces tableaux de bord

OSCOUR-InVS (Vanina Bousquet)
==============================
- 451 établissement transmettent des RPU
- 12 M de RPU et 13.000 DP différents
- L'Alsace se situe dans la moyenne avec une médiane de 56 DP/j
- les ORU peuvent avoir accès aux données régionales et nationales (faire une demande)

===

- Chiffres pour l'Alsace:
  - __62%__ des RPU sont remontés par rapport aux données SAE (moyenne nationale 72%)
  - __64%__ de RPU avec codage diagnostic. Entre 2012-2013 la qualité du codage a diminué probablement par introduction d'établissements ne codant pas.
  - __Exhaustivité diagnostique de 40%__ (% couverture x % codage).
  
  Varie en france de 20% à 100% avec une moyenne à 56%

OSCOUR-InVS (Vanina Bousquet)
==============================

![image](DP_evolution.png)

---

![mulhouse](tx_codage_mul.png)



Qualité des données (groupe de travail 1)
=========================================

Envoi des RPU
-------------
- entre 0 et 4h du matin envoi à la plateforme régionale de la totalité des RPU de la veille (cloturés ou non), ainsi que les RPU des 6 jours précédents.

- tout fichier transmis annule et remplace le fichier précédent, c'est à dire que c'est la totalité de l'information qui est transmise (et pas seulement les mises à jour)

===

- cependant cette règle est difficile à respecter pour les établissements qui font une saisie différée des RPU (notemment pendant la période de fermeture des secrétariats administratifs).

- les autres recommandations sont énumérées dans la circulaire du 32 juillet 2013.

===

Critères de rejet RPU
---------------------
- n° FINESS manquant
- date et heure de création manquant
- codage XML non conforme

Devenir des RPU rejetés
-----------------------
- stockage dans une base de données avec le message d'erreur généré
- information de l'établissement émetteur
- tous les RPU (conforme ou pas) sont archivés

===
  
Cohérence des données
---------------------
4 étapes de difficultés croissantes

1.Respect des Thésaurus
-----------------------
- DP: CIM10
- Motifs de passage: thésaurus SFMU
- Actes: CCAM
- gravité: CCMU

===

2.Analyse monochamps
--------------------

- cohérence du champ par rapport au schéma XML: par exemple DP en CIM10, age compris entre 0 et 120 ans, code postal, etc...
- création d'un logiciel local de vérification de la cohérence monochamp.
- alerte de l'émetteur si non conformité.
- production d'un "radar" mensuel.

===

3.Analyses croisées
------------------

- travail en cours InVS FEDORU pour avoir des règles communes.
- pas de recommandations nationale
- contrôle local (périodicité ?)
  - mode entrée et provenance
  - CCMU et orientation
  - Mode de sortie et orientation

4.Cohérence diagnostique
----------------------

- sexe et pathologie
- age et pathologie



Définitions des bornes 
======================

Sont définies:
-------------
- Horaires: jour, semaine, mois, journée, nuit, nuit profonde, PDS semaine, Weekend....
- Tranches d'age
- durée moyenne de passage (0h à 72 heures)
- temps d'attente de prise en charge médicale (interne, sénior)
- Taux de recours aux urgences
- sorties non convenues: regroupe fugue, sortie contre avis médical et parti sans attendre.

===

A définir:
----------
- TOP
- Patients en attente de lit d'hospitalisation

Axes d'analyse
=================

Nombre total de passages avec répartition par
--------------------------------------------

- région
- département
- territoires de santé (?)
- type d'établissement (public, privé, PSPH)
- commune de domicile
- année, jour de la semaine, mois, heure, période PDS et non PDS

---

- sexe
- age
- mode entrée
- mode de transport
- durée de passage
- gravité
- diagnostic principal
- mode de sortie
- mode orientation
- actes CCAM
- Taux de recours par région, département (territoire de santé)

SAMU et SMUR
============

Données du serveur régional + quelques données supplémentaires

Charte de Qualité de l'Observatoire
===================================

- Charte de qualité régionale précisant les rôles et engagements mutuels des membres de l'ORU
- modèle: charte ORULOR
- rédaction __Charte ORUDAL__ en cours.

Activité des structures d'urgence en Alsace
============================================

Rapport annuel 2013
-------------------

Etat des lieux en Mai 2014
==========================

- 12 établissements produisent des RPU depuis 2013
- SU pédiatrique de HTP (avril 2014)
- Clinique Ste Anne (en cours)
- SOS mains Diaconat Strasbourg (en cours)
- SOS Mains Diaconat Mulhouse (février 2014)
- Clinique des trois frontières change de n°FINESS (16 mai 2014)
- CH Thann (2015 ?)

===

![rpu](hop3.png)

En cours
=============

Registre des AVC à la phase aigüe
-----------------
- SAMU
- SU
- UNV


Petites annonces
================


__ODYS Grands Brûlés__ en cours de déploiement en Lorraine. Téléexpertise pour drands brûlés avec transmission d'images à partir d'un smartphone (Septembre 2014)

__Directives anticipées__ webminar organisé le __13 juin 2014__ à 17 heures par Alsace e-santé.
