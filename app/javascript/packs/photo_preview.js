const openFile = (event) => {
  const input = event.target;
  const reader = new FileReader();
  reader.onload = function (){
      const output = document.getElementById('DefaultImagePreview');
      output.style.backgroundImage = 'url(' + reader.result + ')';
      // output.style.display = 'block';
      // output.src = reader.result;
  };
  // If statement fixes error in case user clicks previous to get back to edit.
  if (input.files[0]) {
    reader.readAsDataURL(input.files[0]);
  }
};

const photoPreview = () => {
  let photo = document.querySelector('#experience_photo');
  let photoButton = document.querySelector('#photo_input');
  if (photo) {
    photo.addEventListener('change', (event)=>{
      openFile(event);
      // photoButton.style['display'] = 'none';
    });
  }
}

export { photoPreview };
