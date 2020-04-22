var CSRF_TOKEN = $("meta[name='csrf-token']").attr("content")

$('.comment-dd').on('click',function (e) {
  if ($(this).hasClass('is-active')) {
    return;
  }

  if (e.clientY > $(window).height() / 2) {
    $('.comment-dd').addClass('is-up')
  } else {
    $('.comment-dd').removeClass('is-up')
  }
  e.stopPropagation()
  $('.comment-dd.is-active').removeClass('is-active')
  $(this).addClass('is-active')
})


var deleleteComment = (postId, commentId) => {
  $.ajax({
    type: 'DELETE',
    url: `/posts/${postId}/comments/${commentId}`,
    contentType: 'application/json',
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-CSRF-Token", CSRF_TOKEN);
    },
  }).done(function () {
    $(`[comment-id|=${commentId}]`).remove();
  });
}


$('.comment-dd .dropdown-item').on('click',function (e) {
  var action = $(this).attr("action")
  var commentId = $(this).parents('.comment').attr('comment-id')
  var postId = $(this).parents('.post-container').attr('post-id')

  switch(action) {
    case 'delete': deleleteComment(postId, commentId); break;
  }

})