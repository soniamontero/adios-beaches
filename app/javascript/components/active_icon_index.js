// Handle the toggle active class of category icons added on new and edit p
// ages of experience.

const activeIconIndex = () => {
  const iconsContainer = document.querySelector('.category-icons-scroll');
  if (iconsContainer) {
    const icons = document.querySelectorAll('.category-icon');

    const activateIcon = (event) => {
      icons.forEach((icon) => {
        icon.classList.remove('active');
      })
      event.currentTarget.classList.add('active');
    }

    icons.forEach((icon) => {
      icon.addEventListener('click', activateIcon)
    })
  }
}

export { activeIconIndex }
