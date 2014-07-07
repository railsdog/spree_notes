$(document).ready(function(){
  $('.js-create-note-button button').on('click', function() {
    var $scope = $(this).parents('.create-note-container');
    $scope.find('.js-create-note-button').remove();
    $scope.find('.js-create-note-form').show();
  });
});
