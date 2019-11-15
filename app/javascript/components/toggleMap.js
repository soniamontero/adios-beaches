const mapContainer = document.querySelector("#map");
const experiencesContainer = document.querySelector("#experience-cards-container");
const displayMapButtonInput = document.querySelector("#display-map-button input");
const displayMapButton = document.querySelector("#display-map-button");

const toggleMap = () => {

  if (mapContainer) {
    displayMapButton.addEventListener("change", (event) => {
      if (displayMapButtonInput.checked) {
        mapContainer.classList.add("display-flex");
        mapContainer.classList.remove("display-none");
        experiencesContainer.classList.add("display-none");
        experiencesContainer.classList.remove("display-flex");
      } else {
        mapContainer.classList.remove("display-flex");
        mapContainer.classList.add("display-none");
        experiencesContainer.classList.remove("display-none");
        experiencesContainer.classList.add("display-flex");
      }
    })

    const checksize = (event) => {
      if (window.innerWidth > 765) {
        displayMapButton.classList.remove('display-flex');
        displayMapButton.classList.add('display-none');
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('display-flex');
      }
    }

    document.addEventListener("DOMContentLoaded", checksize)


    window.addEventListener('resize', (event) => {
      if (event.currentTarget.innerWidth > 765) {
        displayMapButton.classList.remove('display-flex');
        displayMapButton.classList.add('display-none');
      } else {
        displayMapButton.classList.remove('display-none');
        displayMapButton.classList.add('display-flex');
      }
    })

  }
}

export { toggleMap };
