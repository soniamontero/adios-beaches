const mapContainer = document.querySelector("#dashboard-map");
const experiencesContainer = document.querySelector("#experience-cards-container");
const displayMapButtonInput = document.querySelector("#display-map-button input");
const displayMapButton = document.querySelector("#display-map-button");

const toggleDashMap = () => {
  if (mapContainer) {
    displayMapButton.addEventListener("change", (event) => {
      if (displayMapButtonInput.checked) {
        mapContainer.classList.add("d-block");
        mapContainer.classList.remove("display-none");
        experiencesContainer.classList.add("display-none");
        experiencesContainer.classList.remove("d-block");
      } else {
        mapContainer.classList.remove("d-block");
        mapContainer.classList.add("display-none");
        experiencesContainer.classList.remove("display-none");
        experiencesContainer.classList.add("d-block");
      }
    })

    const checksize = (event) => {
      if (window.innerWidth > 765) {
        displayMapButton.classList.remove('d-flex');
        displayMapButton.classList.add('display-none');
        mapContainer.classList.add("d-block");
        mapContainer.classList.remove("display-none");
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('d-flex');
        mapContainer.classList.remove("d-block");
        mapContainer.classList.add("display-none");
      }
    }

    document.addEventListener("DOMContentLoaded", checksize)

    window.addEventListener('resize', (event) => {
      if (event.currentTarget.innerWidth > 765) {
        displayMapButton.classList.remove('d-flex');
        displayMapButton.classList.add('display-none');
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('d-flex');
      }
    })

  }
}

export { toggleDashMap };
