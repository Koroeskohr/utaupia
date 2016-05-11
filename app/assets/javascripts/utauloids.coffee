# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# favorites
$(document).on("page:change", ->
  $("a.favorites")
    .on("ajax:success", (e, xhr, status, error) ->
      $("a.favorites").toggleClass("favorites-hidden");
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
  checkUtauloidFormChanged();
)

$(document).on("page:update", ->
  set_comments_events();
)

checkUtauloidFormChanged = () ->
  window.utauloidFormChanged = false
  if $(".utauloid-edit").length 
    $(".utauloid-edit .utauloid-form").on("change input", ->
      window.utauloidFormChanged = true;
    )
    $(".utauloid-edit .utauloid-form input+label").on("click", ->
      window.utauloidFormChanged = true;
    )
    $(".utauloid-edit .utauloid-form").on("submit", (e) ->
      $(window).off("beforeunload");
      return true;
    );
    $(window).on("beforeunload", ->
      if(window.utauloidFormChanged)
        return "You have unsaved changes. Do you really want to close this page?"; 
    )
  


set_comments_events = () ->
  $("a[id^=edit_comment_]")
    .on("ajax:success", (e, data, status, xhr) ->
      parent_id = $(this).closest('.utauloid-show-comments-list-item').attr('id');
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
    $(this).after("Your report has been sent.");
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
  $("audio")
    .on("ended", () ->
      if $("div#" + $(this).attr("id")).hasClass('showcase-utauloid-audio-preview-button-open')
        $("div#" + $(this).attr("id")).removeClass('showcase-utauloid-audio-preview-button-open');

      $("div#" + $(this).attr("id")).find("i.fa").toggleClass('fa-play-circle-o').toggleClass('fa-pause-circle-o');
    )
  $("div[id^=audio_]")
    .on("click", () ->
      $(this).find('i.fa').toggleClass('fa-play-circle-o');
      $(this).find('i.fa').toggleClass('fa-pause-circle-o');
      if $(this).hasClass('showcase-utauloid-audio-preview-button')
        $(this).toggleClass('showcase-utauloid-audio-preview-button-open');

      pauseAllAudio($(this).attr('id'));
      playAudio($(this).attr('id'));
    )

pauseAllAudio = (audio_id) ->
  $("audio:not(#" + audio_id + ")").each( ->
      this.pause();
    )

  $("div[id^=audio_]:not(#" + audio_id + ") i.fa.fa-pause-circle-o").each( ->
      $(this).toggleClass('fa-play-circle-o');
      $(this).toggleClass('fa-pause-circle-o');
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
  $("#utauloid-list-search-form-hidden-button")
    .on("click", (e) ->
      $("#utauloid-list-search-form-hidden").toggleClass("utauloid-list-search-form-hidden-open");
      $(this).find("i.fa").toggleClass("fa-chevron-down").toggleClass("fa-chevron-up");
    )

  $("#utauloid-list-search-form")
    .on("ajax:success", (e, xhr, status, error) ->
      $('#utauloid-list-grid-items').html(xhr);
      set_audio_preview_events();
    )
    .on("ajax:error", (e, xhr, status, error) ->
      console.log("Error while fetching the search results");
    )

  $("form[id=utauloid-list-search-form] label.btn")
    .on("click", (e) ->
      $(this).toggleClass('btn-default');
      $(this).toggleClass('btn-success');
      checkbox = $("input[type=checkbox][id=" + $(this).attr('id') + "]");
      $(checkbox).prop('checked', !$(checkbox).prop("checked"));
    )
)
# search form

# forms
$(document).on("page:change", ->
  $(".utauloid-edit form label.btn")
    .on("click", (e) ->
      $(this).toggleClass('btn-default');
      $(this).toggleClass('btn-success');
      checkbox = $("input[type=checkbox][id=" + $(this).attr('id') + "]");
      $(checkbox).prop('checked', !$(checkbox).prop("checked"));
    )

  $(".utauloid-new form label.btn")
    .on("click", (e) ->
      $(this).toggleClass('btn-default');
      $(this).toggleClass('btn-success');
      checkbox = $("input[type=checkbox][id=" + $(this).attr('id') + "]");
      $(checkbox).prop('checked', !$(checkbox).prop("checked"));
    )

  $(".utauloid-form-is-creator-container .bootstrap-switch")
    .on("click", (e) ->
      processCreatorSwitch($(".utauloid-form-is-creator-container .bootstrap-switch"));
    )

  processCreatorSwitch($(".utauloid-form-is-creator-container .bootstrap-switch"));
)

processCreatorSwitch = (e) ->
  console.log($(e));
  if $(e).hasClass('bootstrap-switch-on')
    console.log('on');
    $('.utauloid-form-is-creator-text-container').addClass('utauloid-form-is-creator-text-container-hidden');
  else
    console.log('off');
    $('.utauloid-form-is-creator-text-container').removeClass('utauloid-form-is-creator-text-container-hidden');
# forms

# difficulty vote
$(document).on("page:change", ->
  $("form[id^=edit_difficulty_vote_]")
    .on("ajax:success", (e, xhr, status, error) ->
      $('#utauloid-view-note').html(xhr + "<br>Your vote has been updated.");
    )
    .on("ajax:error", (e, xhr, status, error) ->
      console.log("Error while voting");
    )

  $("form[id=new_difficulty_vote]")
    .on("ajax:success", (e, xhr, status, error) ->
      $('#utauloid-view-note').html(xhr + "<br>Thanks for voting!");
      $(this).remove();
    )
    .on("ajax:error", (e, xhr, status, error) ->
      console.log("Error while voting");
    )
)
# difficulty vote