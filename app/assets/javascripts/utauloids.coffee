# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# favorites

$(document)
  .on("ajax:success", (e, data, status, xhr) ->
    console.log(this)
    $(this).promise().done( () ->
      $("a.favorites").toggleClass("none")
    )
  )
  .on("ajax:error", (e, xhr, status, error) ->
    console.log("error while faving the utauloid")
  )

# comments & reports
$(document).on("page:before-change", ->
  set_comments_events();
)

$(document).on("page:change", ->
	set_comments_events();
	set_report_events();
)

set_comments_events = () ->
	$("a[id^=edit_comment_")
		.on("ajax:success", (e, data, status, xhr) ->
			parent_id = $(this).parent().attr('id');
			$(this).parent().html(xhr.responseText);

			$("#" + parent_id).find("form[id^=edit_utauloid_" + parent_id + "]")
				.on("ajax:success", (e, data, status, xhr) ->
					$(this).parent().html(xhr.responseText)
				)
			.on("ajax:error", (e, xhr, status, error) ->
				console.log("error while updating the comment")
			)
		)
		.on("ajax:error", (e, xhr, status, error) ->
			console.log("error while fetching the comment")
		)

set_report_events = () ->
	$("a[id^=report_utauloid_]")
	.on("ajax:success", (e, data, status, xhr) ->
		$(this).remove();
	)
	.on("ajax:error", (e, xhr, status, error) ->
		console.log("error while updating the comment");
	)
#comments
