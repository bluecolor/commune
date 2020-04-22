var postTitle = $('input.post-title')
var submitBtn = $('.post-action-btn')
var postBody = $('#post-body')

var isSubmitDisabled = () => {
  if (postTitle.val() && postBody.val()) {
    console.log('rem')
    submitBtn.prop("disabled", false);
  } else {
    submitBtn.attr("disabled", "disabled");
  }
}

postTitle.on('input', () => {
  isSubmitDisabled()
})

$('.new-post #trix-editor').on('trix-change', e => {
  isSubmitDisabled()
})