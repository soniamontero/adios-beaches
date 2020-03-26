const dones = document.querySelector("#done");
const saved = document.querySelector("#saved");
const myExperiences = document.querySelector("#my-experiences");

const dashboardNav = () => {
  if (myExperiences) {
    const myExperiencesContainer = document.querySelector("#my-experiences-container");
    const savedContainer = document.querySelector("#saved-container");
    const donesContainer = document.querySelector("#done-container");

    const toggleActive = (event) => {
      document.querySelector("#my-experiences");
      myExperiences.classList.remove("active-icon");
      saved.classList.remove("active-icon");
      dones.classList.remove("active-icon");
      const id = event.currentTarget.id;
      event.currentTarget.classList.add("active-icon");
      const container = document.querySelector(`#${id}-container`);
      myExperiencesContainer.setAttribute("hidden", "");
      savedContainer.setAttribute("hidden", "");
      donesContainer.setAttribute("hidden", "");
      container.removeAttribute("hidden", "");
    }

    dones.addEventListener('click', toggleActive);
    saved.addEventListener('click', toggleActive);
    myExperiences.addEventListener('click', toggleActive);
  }
}

export { dashboardNav };
