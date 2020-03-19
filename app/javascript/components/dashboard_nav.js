const dones = document.querySelector("#done");
const saved = document.querySelector("#saved");
const myExperiences = document.querySelector("#my-experiences");

const dashboardNav = () => {
  if (myExperiences) {
    const donesContainer = document.querySelector("#done-container");
    const savedContainer = document.querySelector("#saved-container");
    const myExperiencesContainer = document.querySelector("#my-experiences-container");

    const toggleActive = (event) => {
document.querySelector("#my-experiences");
      dones.classList.remove("active-title");
      saved.classList.remove("active-title");
      myExperiences.classList.remove("active-title");
      const id = event.currentTarget.id;
      event.currentTarget.classList.add("active-title");
      const container = document.querySelector(`#${id}-container`);
      donesContainer.setAttribute("hidden", "");
      savedContainer.setAttribute("hidden", "");
      myExperiencesContainer.setAttribute("hidden", "");
      container.removeAttribute("hidden", "");
    }

    dones.addEventListener('click', toggleActive);
    saved.addEventListener('click', toggleActive);
    myExperiences.addEventListener('click', toggleActive);
  }
}

export { dashboardNav };
