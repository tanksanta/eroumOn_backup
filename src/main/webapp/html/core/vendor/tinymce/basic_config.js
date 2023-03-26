/**
 * tinymce 기본설정 js
 *
 * 2020-06-02 kkm
 * try{
		document.createEvent("TouchEvent");
		tinymce.init({
			selector:"#cn",
			mobile: { menubar: true, theme: 'mobile', toolbar: 'undo bold italic underline link fontsizeselect forecolor removeformat'}
		});
	} catch(e){
		tinymce.overrideDefaults(baseConfig);
		tinymce.init({selector:"#cn"});
	}
 *
 * Mobile일 경우 overrideDefaults옵션 설정이 안됨??. 사용페이지에서 mobile 옵션을 사용하여 생성
 *
 *
 */

	var cleanHTML = function(input) {
	    // 1. remove line breaks / Mso classes
	    var stringStripper = /(\n|\r| class=(")?Mso[a-zA-Z]+(")?)/g;
	    var output = input.replace(stringStripper, ' ');

	    //console.log("STEP 1 >");
	    //console.log(output);

	    // 2. strip Word generated HTML comments
	    var commentSripper = new RegExp('<!--(.*?)-->', 'g');
	    var output = output.replace(commentSripper, '');

	    //console.log("STEP 2 >");
	    //console.log(output);

	    // 3. remove tags leave content if any
	    var tagStripper = new RegExp('<(\/)*(title|meta|link|\\?xml:|st1:|o:|font)(.*?)>', 'gi');
	    output = output.replace(tagStripper, '');

	    //console.log("STEP 3 >");
	    //console.log(output);

	    // 4. Remove everything in between and including tags '<style(.)style(.)>'
	    var badTags = ['style', 'script', 'applet', 'embed', 'noframes', 'noscript'];

	    for (var i = 0; i < badTags.length; i++) {
	        var tagStripper = new RegExp('<' + badTags[i] + '.*?' + badTags[i] + '(.*?)>', 'gi');
	        output = output.replace(tagStripper, '');
	    }

	    //console.log("STEP 4 >");
	    //console.log(output);

	    // A different attempt
	    //output = (output).replace(/font-family\:[^;]+;?|font-size\:[^;]+;?|line-height\:[^;]+;?/g, '');

	    // 5. remove attributes ' style="..."'
	    var badAttributes = ['start'];
	    for (var i = 0; i < badAttributes.length; i++) {
	        var attributeStripper = new RegExp(' ' + badAttributes[i] + '="(.*?)"', 'gi');
	        output = output.replace(attributeStripper, '');
	    }

	    //console.log("STEP 5 >");
	    //console.log(output);

	    return output;
	};


	var baseConfig = {
			//selector:"textarea#cn",
			theme: 'silver',
			height: 300,
			language: 'ko_KR',
			toolbar_mode: 'sliding', //sliding, floating, wrap
			plugins: 'print preview paste importcss searchreplace autolink autosave directionality code visualblocks visualchars fullscreen image link media codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount textpattern noneditable charmap autoresize',
			menubar: 'file edit view insert format tools table',
			toolbar: 'undo redo | bold italic underline strikethrough | forecolor backcolor removeformat | alignleft aligncenter alignright alignjustify | outdent indent | image media link | code',

			autoresize_bottom_margin:30,
			max_width:870,
			min_height:300,
			max_height: 600,

			/*붙여넣기 옵션*/
			//paste_data_images: true,
			paste_enable_default_filters: false,
			convert_fonts_to_spans: true,
			paste_word_valid_elements: "b,strong,i,em,h1,h2,u,p,ol,ul,li,a[href],span,color,font-size,font-color,font-family,mark,table,tr,td",
		    paste_retain_style_properties: "all",
		    //추가 html 차단시 사용, 조절해서 사용할 것
		    paste_postprocess: function(plugin, args) {
		        args.node.innerHTML = cleanHTML(args.node.innerHTML);
		    },

			//paste_webkit_styles: "color font-size",

		    //클래스 없는 span 제거 방지 - 20201119, kkm
		    extended_valid_elements: 'span[*]',

			/*자동저장	*/
			autosave_ask_before_unload: true,
			autosave_interval: "10s",	// 자동저장 간격 s
			autosave_prefix: "{path}{query}-{id}-",
			//autosave_restore_when_empty: false, //편집기가 비어있을때 작성하던 글 복원 여부
			autosave_retention: "10m",	// 로컬스토리지 저장 기간 m


			/*에디터에 CSS적용
			 */
			//content_css: '',
			//importcss_append: true,

			/* 이미지 설정 */
			//image_title: true, //타이틀 태그
			resize_img_proportional: false,
			automatic_uploads: true,
			image_advtab: true,
			image_caption: true,
			//image_prepend_url:"//eroum.icubesystesm.co.kr/",
			relative_urls : false,
			remove_script_host : false,
			//document_base_url : '//eroum.icubesystesm.co.kr/',

			file_picker_types: 'image',
			file_picker_callback: function (cb, value, meta) {
				var input = document.createElement('input');
				input.setAttribute('type', 'file');
				input.setAttribute('accept', 'image/*');
				input.onchange = function () {
					var file = this.files[0];

					// server upload
					var xhr, formData;
                    xhr = new XMLHttpRequest();
                    xhr.withCredentials = false;
                    xhr.open('POST', '/comm/uploadEditor');

                    xhr.onload = function() {
						var json;
						if (xhr.status != 200) {
                        	console.log('HTTP Error: ' + xhr.status);
                        	return;
                      	}
                      	json = JSON.parse(xhr.responseText);
                      	if (!json || typeof json.url != 'string') {
                        	console.log('Invalid JSON: ' + xhr.responseText);
                        	return;
                      	}
						cb(json.url, {title:json.title});
                    }
                    formData = new FormData();
                    formData.append('upload', file, file.name);
                    xhr.send(formData);

					/* blob data 방식
					var file = this.files[0];
					var reader = new FileReader();
					reader.onload = function () {
						var id = 'blobid' + (new Date()).getTime();
						var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
						var base64 = reader.result.split(',')[1];
						var blobInfo = blobCache.create(id, file, base64);
						blobCache.add(blobInfo);
						cb(blobInfo.blobUri(), { title: file.name });
					};
					reader.readAsDataURL(file);
					*/
				};
				input.click();
			},

	};

	var baseConfig_noimg = {
			theme: 'silver',
			height: 300,
			language: 'ko_KR',
			toolbar_mode: 'sliding', //sliding, floating, wrap
			plugins: 'print preview paste importcss searchreplace autolink autosave directionality code visualblocks visualchars fullscreen link codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount textpattern noneditable charmap autoresize',
			menubar: 'file edit view insert format tools table',
			toolbar: 'undo redo | bold italic underline strikethrough | forecolor backcolor removeformat | alignleft aligncenter alignright alignjustify | outdent indent | link | code',

			autoresize_bottom_margin:30,
			max_width:870,
			min_height:300,
			max_height: 600,

			/*붙여넣기 옵션*/
			//paste_data_images: true,
			paste_enable_default_filters: false,
			convert_fonts_to_spans: true,
			paste_word_valid_elements: "b,strong,i,em,h1,h2,u,p,ol,ul,li,a[href],span,color,font-size,font-color,font-family,mark,table,tr,td",
		    paste_retain_style_properties: "all",
		    //추가 html 차단시 사용, 조절해서 사용할 것
		    paste_postprocess: function(plugin, args) {
		        args.node.innerHTML = cleanHTML(args.node.innerHTML);
		    },

			//paste_webkit_styles: "color font-size",

		    //클래스 없는 span 제거 방지 - 20201119, kkm
		    extended_valid_elements: 'span[*]',

			/*자동저장	*/
			autosave_ask_before_unload: true,
			autosave_interval: "10s",	// 자동저장 간격 s
			autosave_prefix: "{path}{query}-{id}-",
			//autosave_restore_when_empty: false, //편집기가 비어있을때 작성하던 글 복원 여부
			autosave_retention: "10m",	// 로컬스토리지 저장 기간 m


			/*에디터에 CSS적용
			 */
			//content_css: '/html/page/admin/assets/style/style.min.css',
			//importcss_append: true,

	};
