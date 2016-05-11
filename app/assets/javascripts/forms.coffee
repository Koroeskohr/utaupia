$(document).on("page:change", ->
	$(".form-image-upload > input").each (index, input) ->
		$(input).on("change", (e) ->
			if this.files && this.files[0]
				reader = new FileReader();
				image = $(this).closest('.form-image-upload');
				label = $(this).closest('.form-image-upload').find('.form-image-upload-label');


				$(label).find('i.fa').toggleClass('fa-upload');

				reader.onload = (e) ->
					$(image).css('background-image', 'url("' + e.target.result + '")');
					$(label).find('i.fa').toggleClass('fa-upload');

				reader.readAsDataURL(this.files[0]);
		)
)