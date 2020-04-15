
document.addEventListener("trix-file-accept", function(event) {
  event.preventDefault();
})

document.addEventListener('trix-initialize', () => {
  var el = document.querySelector('#trix-editor')
  el.addEventListener('keydown', function(event) {
    var blackList = ['b', 'i']
    if(event.ctrlKey && blackList.indexOf(event.key.toLowerCase()) > -1) {
      event.preventDefault()
    }
  })
})


