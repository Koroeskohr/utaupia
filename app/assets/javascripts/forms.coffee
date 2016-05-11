$(document).on("page:change", ->
	$(".form-image-upload-input").each (index, input) ->
		$(input).on("change", (e) ->
			if this.files && this.files[0]
				reader = new FileReader();
				image = $(this).closest('.form-image-upload');
				label = $(image).find('.form-image-upload-label');

				$(label).addClass('form-image-upload-label-activated');

				reader.onload = (e) ->
					$(image).css('background-image', 'url("' + e.target.result + '")');

				reader.readAsDataURL(this.files[0]);
		)

	$(".form-audio-preview-upload-input").each (index, input) ->
		$(input).on("change", (e) ->
			if this.files && this.files[0]
				parent = $(this).closest('.form-audio-preview-upload');
				label = $(parent).find('.form-audio-preview-upload-label');

				$(parent).addClass('form-audio-preview-upload-actived');
				$(label).find('i.fa').removeClass('fa-file-audio-o');
				$(label).find('i.fa').html(this.files[0].name);
		)
)