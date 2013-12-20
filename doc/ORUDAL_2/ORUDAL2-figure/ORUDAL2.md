ORUDAL
========================================================
author: Dr JC Bartier
date: 3/12/2013
transition: rotate

Ordre du jour
================================================================
type: section

- **Evolution de la règlementation Mme Schieber**

- FEDORU

- Compte rendu de l’AG du 21/11/2013

- Point RPU, présentation des données

- Site Internet 

- Divers

Ordre du jour
================================================================
type: section

- Evolution de la règlementation Mme Schieber

- **FEDORU**

- Compte rendu de l’AG du 21/11/2013

- Point RPU, présentation des données

- Site Internet 

- Divers

Ordre du jour
================================================================
type: section

- Evolution de la règlementation Mme Schieber

- FEDORU

- **Compte rendu de l’AG du 21/11/2013**

- Point RPU, présentation des données

- Site Internet 

- Divers

Compte rendu de l’AG du 21/11/2013
==================================

Election du nouveau CA

Election d'un nouveau bureau
- **Président** Dr Bruno Goulesque
- **Vice-présidents**
  - Dr Hervé Delplancq
  - Dr Yannick Gottwalles
- **Tésorier** Mr Christian Caoduro (DG)
- **Secrétaire** Mme Christiane Walter (CSS)
- **secrétaire-adjoint** Dr Jean-Marie Minoux

Ordre du jour
================================================================
type: section

- Evolution de la règlementation Mme Schieber

- FEDORU

- Compte rendu de l’AG du 21/11/2013

- **Point RPU, présentation des données**

- Site Internet 

- Divers


Etat des lieux
========================================================

Au 1er novembre 2013
- **276 452** RPU enregistrés
- 12 établissements sur 14 (85%) participent à la remontée des RPU



RPU (1)
========================================================

Les eléments du RPU sont des données médico-administratives standards qui doivent figurer dans un dossier médical de base. 

Relever un RPU ne nécessite donc **pas un travail supplémentaire** de la part du personnel médical ou para médical.

Un certain nombre de ces informations sont **disponibles dès l'admission du malade** et avant toute intervention médicale.

RPU (2)
=========================================================

La transmission de ces informations au fil de l'eau permet de disposer en temps (quasi) réel, d'éléments qui entrent en ligne de compte pour l'élaboration d'**indicateurs de tension** (core).

C'est donc plus un problème de **SI** qu'un problème médical.

RPU (3)
========================================================

Un **RPU** est composé de **18 items** qui peuvent être
divisés en deux groupes.

- groupe principal (**core**)

  éléments de base qui peuvent **toujours** être relevés de manière exhausive dès l'admission du patient et transmis au fil de l'eau au concentrateur régional.

  C'est le minimun qui doit pouvoir être transmis au moins une fois par 24 heures.

- groupe complémentaire (**supplementary**)

Partie Core (12)
========================================================


- FINESS géographique de l'établissement
- date/heure d'entrée 
- code postal du lieu de résidence
- commune
- date de naissance
- sexe

***

- mode d'entrée
- provenance
- mode de transport
- mode de prise en charge
- CCMU
- motif de recours

Partie supplémentaire (6)
=========================================================

- date/heure de sortie
- Diagnostic principal
- diagnostics associés
- gestes selon CCAM
- mode de sortie
- l'orientation

<small>Le recueil plus tardif, nécessite une compétence médicale (diagnostic principal) et un délai qui peut dépasser 24 heures (date de sortie). </small>

Le service dispose de **6 jours** pour compléter cette partie.

Difficultés - imprécisions
========================================================
type: section

FINESS
========================================================

Il existe deux FINESS
- *juridique* qui est le même pour toutes les stuctures appartenant à  la même entité et 
- *géographique* qui est spécifique d'un site. 

Le FINESS juridique ne permet pas de distinguer l'activité d'un site particulier. 

Il est donc recommandé d'utiliser systématiqement le **FINESS géographique**. 

Le n° FINESS doit comporter **9 chiffres**.

Date et heure (1)
========================================================
 
 **Heure d'entrée** est à priori simple à définir: c'est l'heure  laquellele patient est enregistré. 
 
 - Dans la plupart des cas elle coincide avec l'arrivée physiqe du consultant, mais pas toujours (personnes annoncées par le SAMU, transfert du dossier SMUR).


Date et heure (2)
========================================================

 **Heure de sortie** est floue et ne fait pas consenssus. 
 
 Il peut s'agir de l'heure de la décision de sortie (prescription médicale horodatée et signée) ou de l'heure de sortie physique du SU, par symétrie avec l'heure d'entréee. L'heure de sortie est claire pour un patient ambulant et valide. 
 
 Pour un **transfert** dans un service ou **retour** par ambulance, se pose le problème du délai et du lieu d'attente (couloir) de l'attente du moyen de transport (ambulance, brancardiers). 
 
 L'**hospitalisation en UHTCD** est une sortie du point de vue du RPU mais une simple translation pour le service (porosité accueil/UHCD).
 
 Date et heure (3)
========================================================

Règles de rejet des durées de passage (non consensuelles)
- nulle ou négatives
- inférieures à 10 mn
- supérieures à 72 heures

Durée de présence
========================================================
!["image"](ORUDAL2-figure/presence2.png)

Durée de présence
========================================================
!["image"](ORUDAL2-figure/presence1.png)
 
Code postal
========================================================

- Code à 5 chiffre valable uniquement pour les personnes résidentes sur le territoire français. 
- La norme RPU définit un code de résidence pour les non résidents. Ce code (**99 999**)n'est en général pas respecté et nécessite un détrompage reposant sur le pays de résidence (pas demandé dans le RPU). 
- Pour des régions frontalières comme l'Alsace ilpourrait être intéressant de distinguer les résidents Suisses et Allemands des autres non résidents.
- Pour la partie des RPU à transmettre à l'**ATIH** ce dode doit être remplacé par un **code de résidence** calqué sur le modèle du **PMSI**.


Commune
========================================================

- Le nom de la commune figure en clair, ce qui peut poser des problèmes de cohérence (noms composés, accents). 

- Il est recommandé d'utiliser la **nomenclature des viles de l'INSEE**. 

- Pour le **schéma ATIH** le nom de la commune est remplacé par son code INSEE.


Date de naissance
========================================================

Pour le **schéma ATIH** la date de naissance est remplacée par l'**âge** calendaire à la date d'entrée du patient.

Sexe
========================================================

Le RPU attent une réponse dichotomique, **H**omme ou **F**emme (pas masculin / féminin)

Mode d'entrée
========================================================

Provenance
========================================================

Mode de transport
========================================================

Mode de prise en charge
========================================================

CCMU
========================================================

la CCMU 
doit être déterminée **dès l'admission** et non  la sortie du patient, ou être modifiée parceque l'état du patient évolue pendant le séjour aux urgences (étude INVS).

Motif de recours
========================================================

- La règle est d'utiliser le **thésaurus SFMU** version 2013, basé sue la classification internationale des maladies (CIM 10), seul reconnu par l'INVS et imposé parle ministère de la santé. 

- **La liste compte encore une quinzaine d'items inexacts ou imprécis.**

- la FEDORU va saisir officiellement la SFMU pour quelle corrige la page **RECOURS**

Motif de recours (2013)
========================================================

!["image"](ORUDAL2-figure/tous.png)

Diagnostic principal
========================================================

- Il se code avec la **CIM10** telle qu'elle est définie par l'OMS dans sa version officielle. 
- Ce code CIM10 habituellement utilisé dans les hôpitaux est celui du **PMSI**. Ce code comporte une racine commune avec le code CIM10 officiel. 
- Il n'y a donc pas lieu de disposer d'un thésaurus particulier et le **code PMSI est parfaitement utilisable** (pas de redondance, granularité plus fine)

Diagnostics associés
========================================================

- Même remarque de pour le diagnostic principal. 
- La porosité entre le SU et l'UHTCD rend cet item très imprécis. 
- Il est l'objet de discussions animées.

Taux de complétude
==================

!["image"](ORUDAL2-figure/acteurs.png)

Taux de complétude
==================

!["image"](ORUDAL2-figure/radar_hopital2.png)

Gestes selon CCAM
========================================================

Mode de sortie
========================================================

Il existe 3 modes de sortie des urgences:

 - l'hospitalisation (mutation ou transfert)
 
 - le retour à domicile (vrai retour, sorties atypiques, sortie contre avis, part sans attendre, réorientation...)
 
 - le décès

Mode sortie et gravité
=========================================================================

 <TABLE border=2>
 <TR> <TH><B>CCMU</B>  </TH> <TH> 1 </TH> <TH> 2 </TH> <TH> 3 </TH> <TH> 4 </TH> <TH> 5 </TH> <TH> D </TH> <TH> P </TH>  </TR>
   <TR> <TD align="right"> NA </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> </TR>
   <TR> <TD align="right"> Mutation </TD> <TD align="right"><FONT COLOR="#FF0000"> 1857 </TD> <TD align="right"> 20735 </TD> <TD align="right"> 21315 </TD> <TD align="right"> 2247 </TD> <TD align="right"> 576 </TD> <TD align="right">   8 </TD> <TD align="right"> 363 </TD> </TR>
   <TR> <TD align="right"> Transfert </TD> <TD align="right"> 120 </TD> <TD align="right"> 2130 </TD> <TD align="right"> 1332 </TD> <TD align="right">  75 </TD> <TD align="right">  35 </TD> <TD align="right">   0 </TD> <TD align="right"> 260 </TD> </TR>
   <TR> <TD align="right"> Domicile </TD> <TD align="right"> 27743 </TD> <TD align="right"> 132552 </TD> <TD align="right"> 6828 </TD> <TD align="right"> <FONT COLOR="#FF0000"> 148 </TD> <TD align="right"><FONT COLOR="#FF0000">  19 </TD> <TD align="right"><b><FONT COLOR="#FF0000">   4 </TD> <TD align="right"> 473 </TD> </TR>
   <TR> <TD align="right"> Décès </TD> <TD align="right">   0 </TD> <TD align="right">   2 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> </TR>
    </TABLE>

L'orientation
========================================================

Gravité et orientation
=======================================================
 <TABLE border=1>
 <TR> <TH><b>CCMU</b>  </TH> <TH> 1 </TH> <TH> 2 </TH> <TH> 3 </TH> <TH> 4 </TH> <TH> 5 </TH> <TH> D </TH> <TH> P </TH>  </TR>
   <TR> <TD align="right"> CHIR </TD> <TD align="right"> 149 </TD> <TD align="right"> 2733 </TD> <TD align="right"> 2759 </TD> <TD align="right"> 279 </TD> <TD align="right">   8 </TD> <TD align="right">   1 </TD> <TD align="right"> 115 </TD> </TR>
   <TR> <TD align="right"> FUGUE </TD> <TD align="right">  54 </TD> <TD align="right"> 121 </TD> <TD align="right">  20 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   7 </TD> </TR>
   <TR> <TD align="right"> HDT </TD> <TD align="right">   3 </TD> <TD align="right">  24 </TD> <TD align="right">  20 </TD> <TD align="right">   1 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">  40 </TD> </TR>
   <TR> <TD align="right"> HO </TD> <TD align="right">   0 </TD> <TD align="right">  11 </TD> <TD align="right">   5 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   9 </TD> </TR>
   <TR> <TD align="right"> MED </TD> <TD align="right"> 585 </TD> <TD align="right"> 4884 </TD> <TD align="right"> 7072 </TD> <TD align="right"> 548 </TD> <TD align="right">  33 </TD> <TD align="right">   0 </TD> <TD align="right"> 225 </TD> </TR>
   <TR> <TD align="right"> OBST </TD> <TD align="right">   3 </TD> <TD align="right">  48 </TD> <TD align="right">  27 </TD> <TD align="right">   3 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> </TR>
   <TR> <TD align="right"> PSA </TD> <TD align="right"> 904 </TD> <TD align="right"> 464 </TD> <TD align="right">  28 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   8 </TD> </TR>
   <TR> <TD align="right"> REA </TD> <TD align="right"><FONT COLOR="#FF0000">   1 </TD> <TD align="right"><FONT COLOR="#FF0000">  83 </TD> <TD align="right"> 205 </TD> <TD align="right"> 194 </TD> <TD align="right"> 338 </TD> <TD align="right">   0 </TD> <TD align="right">   3 </TD> </TR>
   <TR> <TD align="right"> REO </TD> <TD align="right"> 797 </TD> <TD align="right"> 290 </TD> <TD align="right">  40 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   1 </TD> </TR>
   <TR> <TD align="right"> SC </TD> <TD align="right">  59 </TD> <TD align="right"> 350 </TD> <TD align="right"> 605 </TD> <TD align="right"> 109 </TD> <TD align="right">  22 </TD> <TD align="right">   0 </TD> <TD align="right">   9 </TD> </TR>
   <TR> <TD align="right"> SCAM </TD> <TD align="right">  60 </TD> <TD align="right"> 262 </TD> <TD align="right">  72 </TD> <TD align="right">   3 </TD> <TD align="right">   0 </TD> <TD align="right">   0 </TD> <TD align="right">   1 </TD> </TR>
   <TR> <TD align="right"> SI </TD> <TD align="right">  14 </TD> <TD align="right"> 267 </TD> <TD align="right"> 612 </TD> <TD align="right"> 217 </TD> <TD align="right">  26 </TD> <TD align="right">   0 </TD> <TD align="right">   2 </TD> </TR>
   <TR> <TD align="right"> UHCD </TD> <TD align="right"> 1102 </TD> <TD align="right"> 10476 </TD> <TD align="right"> 7671 </TD> <TD align="right"> 976 </TD> <TD align="right"> 169 </TD> <TD align="right">   6 </TD> <TD align="right">  37 </TD> </TR>
    </TABLE>

Les données
===========
type: section

Elles doivent présenter 4 caractéristiques:
- conformité (règles d'acceptation et de rejet)
  - structurelle (schéma XML)
  - contenu conforme (ex.code CIM10 conforme)
- exhaustivité (donnée et passages)
- qualité (défaut technique  ou problème de codage)
- cohérence (bornes et définitions)

Quel doit être le devenir des RPU non conformes ?
- rejet total
- acceptation partielle



Données des RPU
===============
type: section

Activité 2013
================================================================

!["image"](ORUDAL2-figure/analyse3.png)

Activité 2013
================================================================

!["image"](ORUDAL2-figure/taux_hospitalisation.png)

Durées moyennes de passage
================================================================

!["image"](ORUDAL2-figure/moyenne_passages.png)

Horaires de passages
================================================================

!["image"](ORUDAL2-figure/als-geb2.png)

Comparaisons entrées-sorties
================================================================

!["image"](ORUDAL2-figure/passages1.png)

Comparaisons entrées-sorties
================================================================

!["image"](ORUDAL2-figure/passages2.png)

Comparaisons entrées-sorties
================================================================

!["image"](ORUDAL2-figure/passages3.png)

Pathologies
================================================================

Données CIM10 (asthme)
================================================================

!["image"](ORUDAL2-figure/asthme2.png)

Données CIM10 (pneumopathies)
================================================================

!["image"](ORUDAL2-figure/pneumo.png)

Données CIM10 (bronchiolites)
================================================================

!["image"](ORUDAL2-figure/bron2.png)

Données CIM10 (gastro-enterites)
================================================================

!["image"](ORUDAL2-figure/ge3.png)

Données CIM10 (intoxication au CO)
================================================================

!["image"](ORUDAL2-figure/co.png)

Données CIM10 (AVC)
================================================================

!["image"](ORUDAL2-figure/avc_sexe3.png)




Ordre du jour
================================================================
type: section

- Evolution de la règlementation Mme Schieber

- FEDORU

- Compte rendu de l’AG du 21/11/2013

- Point RPU, présentation des données

- **Site Internet** 

- Divers

Ordre du jour
================================================================
type: section

- Evolution de la règlementation Mme Schieber

- FEDORU

- Compte rendu de l’AG du 21/11/2013

- Point RPU, présentation des données

- Site Internet 

- **Divers**

