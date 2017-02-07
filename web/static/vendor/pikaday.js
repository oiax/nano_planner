$(function() {
  $('.pikaday').each(function() {
    new Pikaday({ field: $(this)[0] });
  });
});
