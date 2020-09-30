console.log('takumi');
$('#takumi').css("color","#d9534f");


$(document).ready(function(){
  var isbn_field = '#isbn';
  var image_field = '#image';
  var title_field = '#title';
  var url_field = '#url';
  if ($(isbn_field).val()) {
    $(image_field).val('');
    $(title_field).val('');
    $(url_field).val('');
    if ($(isbn_field).val().length == 13){
        $.get('https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?', {
          isbn:  $(isbn_field).val(),
          applicationId: "1075324079437478132"
        }, function(data){
          if (data.count > 0){
              console.log(data);
              book = data['Items']['0'];
              console.log(book);
              $(title_field).val(book.Item.title);
              $(url_field).val(book.Item.itemUrl)
              $(image_field).val(book.Item.mediumImageUrl);
          }
        });
    }
  };
});