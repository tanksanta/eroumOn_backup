<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script src="/html/core/script/JsCKEditorHelper.js"></script>

<style>
	.ck-editor__editable { height: 400px; }
    .ck-content { font-size: 12px; }
</style>

<script>
    var jsCKEditorHelper;
    $(function() {
        jsCKEditorHelper = new JsCKEditorHelper();
        jsCKEditorHelper.init('#cn');
    });
</script>