$('.comment-dd').on('click',function (e) {
  e.stopPropagation()
  $(this).addClass('is-active')
})