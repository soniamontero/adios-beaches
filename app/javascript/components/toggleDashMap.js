// Handle the map and its button depending on window's size + click.
// To clean.

const toggleDashMap = () => {
  const mapContainer = document.querySelector("#dashboard-map");
  const experiencesContainer = document.querySelector("#experience-cards-container");
  const displayMapButtonInput = document.querySelector("#display-map-button input");
  const displayMapButton = document.querySelector("#display-map-button");
  if (mapContainer) {
    displayMapButton.addEventListener("change", (event) => {
      if (displayMapButtonInput.checked) {
        mapContainer.classList.add("d-block");
        mapContainer.classList.remove("display-none");
        experiencesContainer.classList.add("display-none");
        experiencesContainer.classList.remove("d-flex");
      } else {
        mapContainer.classList.remove("d-block");
        mapContainer.classList.add("display-none");
        experiencesContainer.classList.remove("display-none");
        experiencesContainer.classList.add("d-flex");
      }
    })

    const checkSizeOnLoad = (event) => {
      if (window.innerWidth > 765) {
        displayMapButton.classList.remove('display-flex');
        displayMapButton.classList.add('display-none');
        mapContainer.classList.add("d-block");
        mapContainer.classList.remove("display-none");
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('display-flex');
        mapContainer.classList.remove("d-block");
        mapContainer.classList.add("display-none");
      }
    }

    document.addEventListener("DOMContentLoaded", checkSizeOnLoad)

    window.addEventListener('resize', (event) => {
      if (event.currentTarget.innerWidth > 765) {
        displayMapButton.classList.remove('display-flex');
        displayMapButton.classList.add('display-none');
        mapContainer.classList.add("d-block");
        mapContainer.classList.remove("display-none");
        experiencesContainer.classList.remove("display-none");
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('display-flex');
        if (displayMapButtonInput.checked) {
          mapContainer.classList.remove("display-none");
          mapContainer.classList.add("d-block");
          experiencesContainer.classList.add("display-none");
          experiencesContainer.classList.remove("display-flex");
        } else {
          mapContainer.classList.remove("d-block");
          mapContainer.classList.add("display-none");
          experiencesContainer.classList.add("display-flex");
          experiencesContainer.classList.remove("display-none");
        }
      }
    })

  }
}

export { toggleDashMap };
