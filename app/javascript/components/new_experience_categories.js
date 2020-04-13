// Handle the addition/removal of categories for a new/edit experience page.
// Should be cleaned by translating to checkboxes.

const newExperienceCategories = () => {
  const array = document.querySelector("#experience_selected_categories");
  if (array) {
    const toggleActiveClass = (event) => {
      console.log(event.currentTarget.classList.toggle('active'));
    }

    const addOldCatToArray = (active_categories) => {
      active_categories.forEach((category) => {
        const tag = category.innerHTML.trim();
        array.value += (tag + ' ');
      })
    }
    // On edit, adding already existing categories to the array.
    const active_categories = document.querySelectorAll(".category-tag.active");
    addOldCatToArray(active_categories);

    const categories = document.querySelectorAll(".category-tag");

    // Add if not in, remove if already in array of selected categories
    const toggleFromArray = (event) => {
      const tag = event.currentTarget.innerHTML.trim();
      if (array.value.includes(tag)) {
        array.value = array.value.replace(tag,'');
      } else {
        array.value += (tag + ' ');
      }
    }

    categories.forEach((category) => {
      category.addEventListener('click', (event) => {
        toggleFromArray(event);
        toggleActiveClass(event);
      })
    })
  }
}

export { newExperienceCategories }
