const nameInput = document.querySelector("#experience_name");

const updateNumber = (event) => {
  const charactersLeft = document.querySelector("#number-of-characters");
  const number = nameInput.value.length;
  const maybePluralize = (number === 44 || number === 46) ? '' : 's'
  if (number <= 45) {
    charactersLeft.innerHTML = "";
    charactersLeft.classList.remove('invalid-characters-number')
    charactersLeft.classList.add('valid-characters-number')
    charactersLeft.insertAdjacentHTML('afterbegin', `${45 - number} character${maybePluralize} left`);
  } else {
    charactersLeft.innerHTML = "";
    charactersLeft.classList.add('invalid-characters-number')
    charactersLeft.classList.remove('valid-characters-number')
    charactersLeft.insertAdjacentHTML('afterbegin', `${number - 45} character${maybePluralize} too many`);
  }
}

const updateCharactersLeft = () => {
  if (nameInput) {
    const number = nameInput.value.length;
    const validClass = (number > 45) ? 'invalid-characters-number' : 'valid-characters-number'
    nameInput.insertAdjacentHTML(
      'afterend',
      `<div id='number-of-characters' class='${validClass}'>${nameInput.value.length} characters entered.</div>`
      );
    nameInput.addEventListener('keyup', updateNumber)
  }
}


export { updateCharactersLeft }
