const mapContainer = document.querySelector("#map");
const experiencesContainer = document.querySelector("#experience-cards-container");
const displayMapButton = document.querySelector("#display-map-button input");

const toggleMap = () => {
  if (mapContainer) {
    displayMapButton.addEventListener("change", (event) => {
      if (displayMapButton.checked) {
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

    // displayMapButton.addEventListener("change", (event) => {
    //   console.log("hello")

    // })
  }
}

export { toggleMap };
