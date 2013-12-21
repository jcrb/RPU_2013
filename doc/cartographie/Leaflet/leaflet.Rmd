OSM et leaflet
========================================================

*Leaflet* est un moteur de rendu en javascript d'OSM. 

La bibliothèque est récupérale à cette adresse *leafletjs.com.* http://leafletjs.com/  
Septembre 2013: version 0.6.4

Le dossier avec les démos est à la racine du serveur: *http://localhost/html/Leaflet/test.html*

Leaflet et OSM
--------------
http://switch2osm.org/using-tiles/getting-started-with-leaflet/

Leaflet est plus facile à manipuler qu'openlayers et c'est un bon choix pour faire de l'affichage de cartes simple.

Le programme de demo basique est *test.html*  
Remarque: on ne peut pas zoomer au max, poiurquoi ?

Leaflet et CloudMade
--------------------
Il affiche des tiles fournis par le site *CloudMade* qui nécessite une inscription (gratuite). En échange de l'inscription, on reçoit une clé pour afficher les cartes:
- http://account.cloudmade.com/user
- pass: vendenheim
- API key: 11c32d61dbb14ff89322b9cab7413a8f. 

Leaflet fournit plusieurs démos (http://leafletjs.com/examples/quick-start.html) dont l'une explique comment interfacer avec un tel portable

Démo perso sur le serveur:
- http://localhost/html/Leaflet/main.html

```{}
<!DOCTYPE html>
<html>

<head>
<!-- En-tête du document  -->
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 
  <meta name="title" content="Titre de la page" />
  <meta name="description" content="description de la page"
  <meta name="keywords" content="mots-clé1, mots-clé2, ..."
 
  <!-- Indexer et suivre -->
  <meta name="robots" content="index,follow" />

 <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.6.4/leaflet.css" />
 <!--[if lte IE 8]>
     <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.6.4/leaflet.ie.css" />
 <![endif]-->
<script src="http://cdn.leafletjs.com/leaflet-0.6.4/leaflet.js"></script>

</head>

<body>
<!-- CORPS DE LA PAGE  -->
  <p>Bienvenue sur ma page web</p>
  <div id="map" style="width: 1300px; height: 700px"></div>
  <script>
var APIkey='11c32d61dbb14ff89322b9cab7413a8f' <!-- BC9A493B41014CAABB98F0471D759707-->

function onClick(e) { alert('help');}

<!--  map.on('click', function(e) { alert(e.latlng); }); -->


var map = L.map('map').setView([48.534099,7.737703], 13);

L.tileLayer('http://{s}.tile.cloudmade.com/'+APIkey+'/997/256/{z}/{x}/{y}.png', {
  		maxZoom: 18,
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a 				href="http://cloudmade.com">CloudMade</a>'
		}).addTo(map);

L.marker([48.534099,7.737703]).addTo(map).bindPopup("<b>Zone Explosion</b><br />Quartier Leclerc").openPopup();


<!-- exemple d'alerte -->
var popup = L.popup();
function onMapClick(e) {
			popup
				.setLatLng(e.latlng)
				.setContent("Vous avez cliqué à  " + e.latlng.toString())
				.openOn(map);
		}
map.on('click', onMapClick);
```
