$(document).ready(function() {

	$('form.shorten_form').on('submit', function(event){
		event.preventDefault();
		$.ajax({
			url: event.target.action,
			method: event.target.method,
			data: $(event.target).serialize(),
			dataType: 'json'
		}).done(function(json){
			event.target.reset();
		});
	});
});