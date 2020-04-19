var CSRF_TOKEN = $("meta[name='csrf-token']").attr("content")

$('.comment-dd').on('click',function (e) {
  e.stopPropagation()
  $('.comment-dd.is-active').removeClass('is-active')
  $(this).addClass('is-active')
})

$('.reaction.comment-like').on('click', function(e) {

  var me = $(this)
  var commentId = $(this).parents('.comment').attr('comment-id')
  var postId = $(this).parents('.post-container').attr('post-id')
  var action = me.hasClass('comment-liked') ? 'dislike' : 'like'

  $.ajax({
    type: 'PUT',
    url: `/posts/${postId}/comments/${commentId}/${action}`,
    contentType: 'application/json',
    beforeSend: function(xhr) {
      xhr.setRequestHeader("X-CSRF-Token", CSRF_TOKEN);
    },
  }).done(function () {
    me.toggleClass('comment-liked')
  });
})


$('.post-container #trix-editor').on('focus', function() {
  $('.right-container').animate({ scrollTop: $(document).height() }, 1000);
})
