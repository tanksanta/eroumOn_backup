
class JsCKEditorHelper{
    init(cssSelector){
        ClassicEditor.create( 
            document.querySelector( cssSelector )
            , {
                extraPlugins: [JsCKEditorUploadAdapterPlugin],
                language: "ko"
            }
        ).then(editor => {
            window.editor = editor;
        }).catch( error => {
            console.error( error );
        });
    }

    getData(){
        if (window.editor == undefined) return null;
        
        return window.editor.getData();
    }

    setData(str){
        window.editor.setData(str);
    }
}

function JsCKEditorUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        return new JsCKEditorUploadAdapter(loader)
    }
}


class JsCKEditorUploadAdapter {
    constructor(loader) {
        this.loader = loader;
    }

    upload() {
        return this.loader.file.then( file => new Promise(((resolve, reject) => {
            this._initRequest();
            this._initListeners( resolve, reject, file );
            this._sendRequest( file );
        })))
    }

    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();
        xhr.open('POST', '/comm/uploadEditor', true);
        xhr.responseType = 'json';
    }

    _initListeners(resolve, reject, file) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = '파일을 업로드 할 수 없습니다.'

        xhr.addEventListener('error', () => {reject(genericErrorText)})
        xhr.addEventListener('abort', () => reject())
        xhr.addEventListener('load', () => {
            const response = xhr.response
            if(!response || response.error) {
                return reject( response && response.error ? response.error.message : genericErrorText );
            }

            resolve({
                default: response.url //업로드된 파일 주소
            })
        })
    }

    _sendRequest(file) {
        const data = new FormData()
        data.append('upload',file)
        this.xhr.send(data)
    }
}


