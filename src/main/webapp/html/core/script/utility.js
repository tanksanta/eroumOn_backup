$(function() {
    //file upload sample
    var fileExt = function(file) {
        let ext = file.name.split('.').slice(-1)[0];

        if(ext === 'bmp' || ext === 'jpg' || ext === 'jpeg' || ext === 'gif' || ext === 'png' || ext === 'webp' || ext === 'svg') {
            return '<img src="' + window.URL.createObjectURL(file) + '">';
        } else if(ext === 'zip' || ext === 'rar' || ext === '7z' || ext === 'png' || ext === 'egg') {
            return '<i class="fa-solid fa-file-zipper"></i><span>' + file.name + '</span>';
        }else if(ext === 'mp4' || ext === 'wmv' || ext === 'avi') {
            return '<i class="fa-solid fa-file-video"></i><span>' + file.name + '</span>';
        } else if(ext === 'doc' || ext === 'docx') {
            return '<i class="fa-solid fa-file-word"></i><span>' + file.name + '</span>';
        } else if(ext === 'ppt' || ext === 'pptx') {
            return '<i class="fa-solid fa-file-powerpoint"></i><span>' + file.name + '</span>';
        } else if(ext === 'xls' || ext === 'xlsx') {
            return '<i class="fa-solid fa-file-excel"></i><span>' + file.name + '</span>';
        } else if(ext === 'pdf') {
            return '<i class="fa-solid fa-file-pdf"></i><span>' + file.name + '</span>';
        } else {
            return '<i class="fa-solid fa-file"></i><span>' + file.name + '</span>';
        }
    }

    $('.form-upload label').on('dragover dragenter dragleave drop', function(e) {
        e.preventDefault();
        e.stopPropagation();

        if(e.type === 'dragover' || e.type === 'dragenter') {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    })
    
    $('.form-upload label, .form-upload input').on('drop change', function(e) {
        let fileList = '';
        let fileItem = (e.originalEvent.dataTransfer === undefined) ? e.target.files : e.originalEvent.dataTransfer.files;

        if($(this).siblings('.form-upload-list').length === 0) {
            $(this).parent().append('<ul class="form-upload-list"></ul>');
        }
        
        fileList = $(this).siblings('.form-upload-list').empty();

        $.each(fileItem, function(i) {
            fileList.append('<li data-file-index="'+ i +'"><p>' + fileExt(this) + '</p><button class="button">삭제</button></li>');
        });

        $(this).closest('.form-upload').find('input[type="file"]')[0].files = fileItem;
    });
    
    $(document).on('click', '.form-upload-list li button', function() {
        let index  = parseInt($(this).closest('li').attr('data-file-index')),
            input  = $(this).closest('.form-upload').find('.form-upload-control'),
            data   = new DataTransfer();

            $(this).closest('li').remove();

            Array.from(input[0].files).forEach((file, fileIdx) => {
                if(index !== fileIdx) {
                    data.items.add(file);
                }
            });

            input[0].files = data.files;
    })
})