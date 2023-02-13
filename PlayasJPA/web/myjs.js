$(document).ready(function() {
    console.log('ready');
    init();
});

function init(){

   onshowresumen();
}


function onshowresumen(){
	$('#modalresumen').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) 
          var partido = button.data('partido')
          var local = button.data('local')
         
	  var modal = $(this)
	  modal.find('h5').text(local)
          // Ajax
          $.ajax({
            type: "GET",
            url: "Controller?op=resumen&partido="+partido,
            success : function(info) {
                    $("#resumen").html(info);
                }
            });
          })
}
