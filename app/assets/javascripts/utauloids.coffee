# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# favorites
$(document).on("page:change", ->
	$("a.favorites")
		.on("ajax:success", (e, xhr, status, error) ->
			$("a.favorites").toggleClass("none");
		)
		.on("ajax:error", (e, xhr, status, error) ->
			console.log("error while faving the utauloid");
		)
)
# favorites

# comments & reports
$(document).on("page:change", ->
	set_comments_events();
	set_report_events();
)

$(document).on("page:update", ->
  set_comments_events();
)

set_comments_events = () ->
	$("a[id^=edit_comment_]")
		.on("ajax:success", (e, data, status, xhr) ->
			parent_id = $(this).closest('.comment-item').attr('id');
			console.log(xhr);
			$('#' + parent_id).html(xhr.responseText);

			$("#" + parent_id).find("form[id^=edit_utauloid_" + parent_id + "]")
				.on("ajax:success", (e, data, status, xhr) ->
					console.log(xhr);
					$('#' + parent_id).html(xhr.responseText)
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
# comments

# audio preview
$(document).on("page:change", ->
	set_audio_preview_events()
)

set_audio_preview_events = () ->
	$("span[id^=audio_]")
		.on("click", () ->
			$(this).toggleClass('played');
			$(this).toggleClass('paused');
			pauseAllAudio($(this).attr('id'));
			playAudio($(this).attr('id'));
		)

pauseAllAudio = (audio_id) ->
	$("audio:not(#" + audio_id + ")").each( ->
			this.pause();
		)

	$("span:not(#" + audio_id + "):not(.paused)").each( ->
			$(this).toggleClass('played');
			$(this).toggleClass('paused');
		)

playAudio = (audio_id) ->
	player = $("audio[id=" + audio_id + "]").get(0);
	if player.paused
		player.play();
	else
		player.pause();
# audio preview

# search form
$(document).on("page:change", ->
	$("#search-form")
		.on("ajax:success", (e, xhr, status, error) ->
			$('.grid').html(xhr);
			set_audio_preview_events();
		)
		.on("ajax:error", (e, xhr, status, error) ->
			console.log("Error while fetching the search results");
		)

	$("form[id=search-form] label.btn")
		.on("click", (e) ->
			$(this).toggleClass('btn-default');
			$(this).toggleClass('btn-success');
			checkbox = $("input[type=checkbox][id=" + $(this).attr('id') + "]");
			$(checkbox).prop('checked', !$(checkbox).prop("checked"));
		)
)
# search form