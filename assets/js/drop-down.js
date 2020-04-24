$('.dropdown').on('click',function (e) {
  $('.dropdown').removeClass('is-active')

  if ($(this).hasClass('is-active')) {
    return;
  }

  if (e.clientY > $(window).height() / 2) {
    $(this).addClass('is-up')
  } else {
    $(this).removeClass('is-up')
  }
  e.stopPropagation()
  $(this).removeClass('is-active')
  $(this).addClass('is-active')
})
