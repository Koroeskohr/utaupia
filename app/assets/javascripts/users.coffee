# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# message form
$(document).on("page:change", ->
	$("form[id=form_message_filter] label.btn")
		.on("click", (e) ->
			$(this).toggleClass('btn-default');
			$(this).toggleClass('btn-success');
			checkbox = $("input[type=checkbox][id=" + $(this).attr('id') + "]");
			$(checkbox).prop('checked', !$(checkbox).prop("checked"));
		)
)
# message form