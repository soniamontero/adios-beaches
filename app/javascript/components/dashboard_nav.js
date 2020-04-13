// Handle active classes of the user show navigation.
const dashboardNav = () => {
  const dones = document.querySelector("#done");
  const saved = document.querySelector("#saved");
  const myExperiences = document.querySelector("#my-experiences");

  if (myExperiences) {
    const toggleActive = (event) => {
      myExperiences.classList.remove("active-icon");
      saved.classList.remove("active-icon");
      dones.classList.remove("active-icon");
      const id = event.currentTarget.id;
      event.currentTarget.classList.add("active-icon");
    }

    dones.addEventListener('click', toggleActive);
    saved.addEventListener('click', toggleActive);
    myExperiences.addEventListener('click', toggleActive);
  }
}

export { dashboardNav };
