var dropdown = document.querySelector('#trends-dropdown');

dropdown.addEventListener('click', function(event) {
  event.stopPropagation();
  dropdown.classList.toggle('is-active');
});
