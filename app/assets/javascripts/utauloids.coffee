# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# commments
$(document).on("click", "a[id^=edit_comment_]", () ->
	$(this)
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
# favorites

$(document).on("click", "a.favorites", () ->
  $(this)
    .on("ajax:success", (e, data, status, xhr) ->
      $("a.favorites").toggleClass("none")
    )
    .on("ajax:error", (e, xhr, status, error) ->
      console.log("error while faving the utauloid")
    )
)