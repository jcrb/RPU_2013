Commentaires sur les RPU 2013
========================================================
Général
-------
Encoder les fichiers en UTF8 (\e9 au lieu de é haguenau)

RPU Administratif (Core)
-------------------------
- Il doit être transmis tous les jours avant 4 heures du matin
- Le fichier doit comporter un nombre d'enregistrements égal au nombre de passages (inscriptions) au service des urgences(SU)
- Il comprend l'ensemble des données recueillies au moment de l'enregistrement administratif du patient:
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

RPU Médical (Supplementary)
---------------------------
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
- Cette partie du dossier est transmise au plus pars dans les 6 jours.


No de dossier
-------------
- attribué par l'expéditeur
- doit être unique
- permet de lier le RPU aux diagnostics associés et aux gestes

FINESS
------
FINESS géographique (mettre la liste des finess)

COMMUNE
-------
- nom de la commune de résidence du patient
- lettre majuscules sans accent
- les nom composé sont séparés par un tiret (WIR-AU-VAL)
- Modèle INSEE

Date-Heure
----------

- format ISO
- heure d'entrée et de sortie sont obligatoire sinon rejet
- heure de sortie ne peut pas être inférieure à l'heue d'entrée
- heure de sortie correspond à la sortie physique du patient

MODE D’ENTREE
-------------
Le RPU connait 3 modes d'entrée:
- Mutation: le malade vient d'une autre unité médicale de la même entité juridique
- Transfert: le malade vient d'une autre entité juridique 
- Domicile: le malade vient de son domicile ou de son substitut, tel une structure d'hébergement médico-social. Ce mode inclut les entrées à partir de la voie publique. Le code 8 du mode d'entrée est à utiliser en cas de naissance d'un nouveau-né quelque soit la situation d’hospitalisation ou de non hospitalisation de la mère

Une correction est nécessaire pour les **transferts** qui sont mal ortographiés dans certains enregistrements:

d1$MODE_ENTREE <- as.character(d1$MODE_ENTREE)
d1[d1$MODE_ENTREE == "Transfe  rt" & !is.na(d1$MODE_ENTREE), "MODE_ENTREE"] <- "Transfert"
d1$MODE_ENTREE <- as.factor(d1$MODE_ENTREE)
summary(d1$MODE_ENTREE)

Domicile  Mutation Transfert      NA's 
   301318      3512      3355     32153 
   
Provenance
----------
Le RPU connait deux origine du patient 
- par *mutation ou transfert*. Le patient est adressé par un service du même établissement (*mutation*) ou d'un autre établissement (*transfert*). On distingue 4 cas:
  - MCO: un service hospitalier
  - SSR: soins de suite et de réadaptation
  - SLD: soins de longue durée
  - PSY: psychiatrie
- en provenance directe du *domicile*
  - soit parce que c'est le choix du patient. C'est le cas de la plupart des passages aux urgences et ce passage n'est pas du à des raisons organisationelles (**PEA**).
  - soit parcequ'on lui a demandé de passer par les urgences avant d'être admis dans un autre service. Le passage aux urgences se fait pour des raisons organisationnelles (**PEO**).

Pour 2013 les résultats sont les suivants:

       3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis   Sav
  NA      0     0     0     0     0     0     0     0     0     0     0     0
  MCO    23     1  2394   852    20  1522  1446   905     1   656     9    14
  SSR     0     0     0    14     7    13    13     0     0     0     1     0
  SLD     0     0     0     7     3     4     8     0     0     0     0     0
  PSY     0     2     0     0     0    29    14     0     0     0     0     0
  PEA    12     0 61308    31  2256     0     0 52579 25739 28878 12453   718
  PEO     0     0  1056 27436    10     0     0   418   204     0     0     0

Hôpitaux devant modifier leur paramétrage:
- 3Fr: item non renseigné
- Alk: item non renseigné
- Dia: inversion PEA-PEO
- Geb: item partiellement renseigné
- Hag: item non renseigné
- Hus: item non renseigné
- Sav: item partiellement renseigné

- Les chiffres de *provenance* et *mode d'entrée* devraient être équivalents.
- la somme PEA + PEO doit être égale à MODE_ENTREE.Domicile

CCMU
----

- CCMU 1: consultation simple sans acte biologique ou radiologique (ex. angine)
- CCMU 2: nécessité d'un acte bio ou radio et/ou d'un petit geste (suture), pas d'hospitalisation
- CCMU 3: hospitalisation nécessaire dans un service conventionnel
- CCMU 4: SI, SC
- CCMU 5: REA

Lire un fichier depuis google drive
-----------------------------------

1. créer un fichier dans drive (calc)
2. le rendre exportable: fichier/publier sur le web/démarrer la publication, remplacer page Web par CSV
3. copier l'adresse du lien
```{}
require(RCurl)
file <- "https://docs.google.com/spreadsheet/pub?key=0Aieb-IfcCNcXdFh2bklWeHhKUTVwZUFMSlBJQkpPcWc&output=csv"
f <- read.table(textConnection(getURL(file)), header=T, sep=",")
```


Test Jahia (9/12/2013)
-----------------------

- Création dossier ORUDAL dans téléchargement
- 3 fichiers y sont placées: test2.html, data2.csv et dygraphs.js
- création d'un lien dans Orudal vers test2.html
- fonctionne sans pb

RPU
===========

Enregistré dans:
- Resural/Orudal/
- Resural/Stat Resural/RPU2013/doc/RPU Commentaires

Contexte
---------

maîtrise d'ouvrage (MOA): ARS

maîtrise d'oeuvre (MOE): RESURAL

assistant à maitrise d'ouvrage (AMO): Alsace e-santé

La **maîtrise d'ouvrage (MOA)**, aussi dénommée maître d'ouvrage est l'entité porteuse du besoin, définissant l'objectif du projet, son calendrier et le budget consacré à ce projet. Le résultat attendu du projet est la réalisation d'un produit, appelé ouvrage.

La maîtrise d'ouvrage (en anglais Project Owner) maîtrise l'idée de base du projet et représente, à ce titre, les utilisateurs finaux à qui l'ouvrage est destiné.

La mission d'une **maîtrise d'œuvre** est de :

    concevoir le projet, s'il est lui-même architecte ou ingénieur architecte (sinon ce rôle est dévolu à un cabinet d'architectes extérieur)2 ;
    élaborer le cahier des clauses techniques particulières (CCTP) et contrôler la bonne exécution des travaux ;
    jouer un rôle d’interface entre le client et les entreprises chargées d’exécuter les travaux.
    
L'**assistant à maîtrise d'ouvrage (AMO ou AMOA)** a pour mission d'aider le maître d'ouvrage à définir, piloter et exploiter, le projet réalisé par le maître d'œuvre. L'assistant a un rôle de conseil et de proposition, le décideur restant le maître d'ouvrage. Il facilite la coordination de projet et permet au maître d'ouvrage de remplir pleinement ses obligations au titre de la gestion du projet en réalisant une mission d'assistance à maîtrise d'ouvrage.


périmètre d'application
-----------------------

règle: tout service titulaire d'une autorisation service d'urgence doit produire des RPU (texte de référence ?)

discussion:

- en dehors de l'autorisation qu'est-ce qui défini (caractérise) un service d'urgence (c'est quoi un service d'urgence) ?
- sens commun: service animé par des médecin urgentistes (au sens du diplôme, ref ?) et capables de prendre en charge 24/24h des patients de tous age souffrant de pathologie médicales et/ou chirurgicale.
- est-il souhaitable qu'un service répondant à la définition de SU mais n'ayant pas l'autorisation (St Luc) fournisse des RPU (Art. R. 6123-12)?
- que faire des RPU provenant de services ayant une autorisation SU mais ne répondant pas à la définition de SU (sos mains). En terme decompréhension de l'activité mains, ilfaudrait alors inclure l'activité do CCOM. Cependant si on tient compte de cette activité, on augmente globalement le nombre de RPU et on fausse les comparaisons inter-régionale (pas d'exemple équivalent en Lorraine). En terme de définition d'indicateurs d'hopital en tension, cette connaissance n'apporte aucune information car la surcharge d'un SU conventionnel ne peut être compensée par la présence d'un SU mains. Faut-il exiger un RPU complet sachant que la simple indication du ervive suffit à connaitre le motif de consultation ? De même le devenir du patient impacte peu les lits d'hospitalisation (chirirgie ambulatoire)
- la réglementation prévoit que des services comme la mains soint considérés comme des PTAD, lesquels doivent être cnventionnés avec un SU. Un PTAD peut-il être conventionnéavec lui-même? A terme tous les services labellisés mains vont faire partie de groupes hospitaliers disposants d'une autorisation SU:
- CCOM -> HUS
- Diaconnat Strasbourg -> Cliniques de Strasbourg (regroupement de 3 cliniques: diaconnat, adassa, ste odile, dans un bâtiment unique sur le site du port du rhin).
- sos mains Mulhouse -> 

en pratique: les autorisations SU en Alsace relèvent plus d'une logique financière que d'une logique de soins et exiger des RPU des PTAD au motif que certains disposent d'une autorisation SU ne présente aucun intérêt en terme d'analyse de l'activité des SU et singularise l'Alsace par rapport aux autres régions.

Saisie des RPU
--------------
Les eléments du RPU sont des données médico-administratives standards qui doivent figurer dans un dossier médical de base. Relever un PU ne nécésite donc pas un travail supplémentaire de la part du personnel médical ou para médical. En faitle RPU n'est qu'une extraction automatique de certains éléments du dossier. Sa seule contrainte est horaire. Un certain nombre de ces informations sont disponibles dès l'admission du malade et avant toute intervention médicale. La transmission de ces informations au fil de l'eau permet de disposer en temps (quasi) réel, d'éléments qui entrent en ligne de compte pour l'élabnoration d'indicateurs de tension (core). C'est donc plus un problème de SI qu'un problèe médical.

Les éléments du RPU peuvent être divisés en 2 groupes:

- core: éléments de bases qui peuvent toujours être relevés de manière exhausive dès l'admission du patient et transmis au fil de l'eau au concentrateur régional. C'est le minimun qui doit pouvoir être transmis au mpoins une fois par 24 heures.

- supplémentaires: ce sont les autres éléments du RPU. Leur recueil plus tardif, nécessite une compétence médicale (diagnostic principal) et un délai qui peut dépasser 24 heures (date de sortie). Le service dispose de 6 jours pour compléter cette partie.

### Partie Core (12):

- FINESS géographique de l'établissement
- date/heure d'entrée (format aaaa-mm-jj HH:MM:SS)
- code postal du lieu de résidence
- commune
- date de naissance
- sexe
- mode d'entrée
- provenance
- mode de transport
- mode de prise en charge
- CCMU la CCMU doit être déterminée dès l'admission
- motif de recours

### Partie supplémentaire (6):

- date/heure de sortie: nécessaire mais à définir (heure de transfert en UHCD, sortie physique du SU pour une sortie définitive, heure de prise en charge par une ambulance pour un transfert ou d'admission dans un service ?)
- Diagnostic principal
- diagnostics associés
- gestes selon CCAM
- mode de sortie
- l'orientation

Difficultés - imprécisions
--------------------------
### FINESS
Il existe deux FINESS, *juridique* qui est le même pour toutes les stuctures appartenant à  la même entité et *géographique* qui est spécifique d'un site. Le FINESS juridique ne permet pas de distinguer l'activité d'un site particulier. Il est donc recommandé d'utiliser systématiqement le FINESS géographique. Le n° FINESS doit comporter **9 chiffres**.

### Date et heure
 format et norme ISO
 
 **Heure d'entrée** est à priori simple à définir: c'est l'heure  laquellele patient est enregistré. Dans la plupart des cas elle coincide avec l'arrivée physiqe du consultant, mais pas toujours (parsonnes annoncées par le SAMU, transfert du dossier SMUR).
 
 **Heure de sortie** est floue et ne fait pas consenssus. Il peut s'agir de l'heure de la décision de sortie (prescription médicale horodatée et signée) ou de l'heure de sortie physique du SU, par symétrie avec l'heure d'entréee. L'heure de sortie est claire pourun patient ambulant et valide. Pour un patient transféré dans un service ou rentrant chez lui par ambulance, se pose le problème du délai et du lieu d'attente (couloir) du moyen de transport (ambulance, brancardiers). L'hospitalisation en UHTCD est une sortie du point de vue du RPU mais une simple translation pour le service (porosité accueil/UHCD).

### Code postal
Code à 5 chiffre valable uniquement pour les personnes résidentes sur le territoire français. La norme RPU définit un code de résidence pour les non résidents. Ce code n'est en général pas respecté et nécessite un détrompage reposant sur le pays de résidence (pas demandé dans le RPU). Pour des régions frontalières comme l'Alsace ilpourrait être intéressant de distinguer les résidents Suisses et Allemands des autres non résidents.
Pour la partie des RPU à transmettre à l'ATIH ce dode doit être remplacé par un code de résidence calqué sur le modèle du PMSI.

### Commune
Le nomde la commune figure en clair, ce qui peut poser des problèmes de cohérence (noms composés, accents). Il est recommandé d'utiliser la nomenclature des viles de l'INSEE. Pour le gabarit ATIH le nom de la commune est remplavé par son code INSEE.

### Date de naissance
Pour le gabarit ATIH la date de naissance est remplacée par l'age calendaire à la date d'entrée du patient.

### Sexe
Le RPU attent une réponse dichotomique, **H**omme ou **F**emme (pas masculin / féminin)

### Mode d'entrée

### Provenance

### Mode de transport

### Mode de prise en charge

### CCMU la CCMU 
doit être déterminée dès l'admission et non  la sortie du patient, ou être modifiée parceque l'état du patient évolue pendant le séjour aux urgences (étude INVS).

### Motif de recours
La règle est d'utiliser le **thésaurus SFMU** version 2013, basé sue la classification internationale des maladies (CIM 10), seul reconnu par l'INVS et imposé parle ministère de la santé. La liste compte encore une quinzaine d'items inexacts ou imprécis.

### Diagnostic principal
Il se code avec la CIM10 telle qu'elle est définie par l'OMS dans sa version officielle. Ce code CIM10 habituellement utilisé dans les hôpitaux est celui du PMSI. Ce code comporte une racine commune avec le code CIM10 officiel. Il n'y a donc pas lieu de disposer d'un thésaurus particulier et le code PMSI et parfaitement utilisable (pas de redondance, granularité plus fine)

### Diagnostics associés
Même remarque de pour le diagnostic principal. La porosité entre le SU et l'UHTCD rend cet item très imprécis. Il est l'objet de discussions animées.

### Gestes selon CCAM

### Mode de sortie

### L'orientation


Transmission des RPU
--------------------

Support technique régional
---------------------------
Concentrateur régional: organisme qui gère une base de données où sont stockés les RPU. Le concentrateur à pour mission de transmettre les RPU au niveau national selon les préconisations de l'INVS d'une part erde l'ATIH d'autre part. Par ailleurs il assure un accsè à ces données à l'ARS et au organisme conventionnés avec l'ARS (RESURAL).

Les hôpitaux sont dotés d'un système d'information (SI) et les SU sont informatisés. Le logiciel présent aux rgences peut saisir toutes les données nécessaires au RPU. Le SI de l'établissement extrait les données nécessaires et formate le fichier selon le schéma XML précinisé par l'INVS.

Alsace e-santé met en place les connecteurs permettant le transfert des fichiers depuis l'établissement jusqu'à la plateforme esanté.
AeS met en place un accès aux données du RPU pour permettre à RESURAL d'y accéder
Resural exploite les données au profit des ES, de Résural et de l'OUDAL.

