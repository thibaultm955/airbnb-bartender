import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
	  const bounds = new mapboxgl.LngLatBounds();
	  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
	  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 4000 });
  };

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

	  const markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {
      const element = document.createElement('div');
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });

	  fitMapToMarkers(map, markers);
  };
};

export { initMapbox };
