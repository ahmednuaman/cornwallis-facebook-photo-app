capturedImage = ''
fbAccessToken = ''

ready = (event) ->
    console.log 'ready'
    
    $( '#capturephoto' ).click handleCapturePhotoClick
    $( '#authwithfb' ).click handleAuthWithFBClick
    $( '#sendtofb' ).click handleSendToFBClick

handleCapturePhotoClick = (event) ->
    event.preventDefault()
    
    console.log 'handleCapturePhotoClick', navigator.camera.DestinationType.DATA_URL
    
    navigator.camera.getPicture handleCapturePhotoSuccess, handleFail, 
        quality: 50,
        destinationType: navigator.camera.DestinationType.FILE_URI
        # sourceType: navigator.camera.PictureSourceType.PHOTOLIBRARY

handleCapturePhotoSuccess = (image) ->
    console.log 'handleCapturePhotoSuccess', image
    
    capturedImage = image
    
    $( '#thephoto' ).attr 'src', image;

handleAuthWithFBClick = (event) ->
    event.preventDefault()
    
    console.log 'handleAuthWithFBClick'

handleSendToFBClick = (event) ->
    event.preventDefault()
    
    console.log 'handleSendToFBClick'
    
    opts = new FileUploadOptions()
    
    opts.fileKey = 'image.jpg'
    opts.fileName = capturedImage.substr capturedImage.lastIndexOf( '/' ) + 1
    opts.mimeType = 'image/jpeg'
    
    params =
        access_token: 'AAADBgNx22S4BACajl9v0FB9IZCXu6WxCQZBRjcX93YoDlZC6ZCZCxsupZBQgSHq6PzMxUEjwHyFhe6fdJ2ZBcE8Nx1rh3tFH83u6Y2D9pZBnWAZDZD',
        message: 'this is a test',
        source: '@image.jpg'
    
    console.log params
    
    opts.params = params
    
    ft = new FileTransfer()
    
    ft.upload capturedImage, 'https://graph.facebook.com/505256752040/photos', handleSendToFBSuccess, handleFail, opts

handleSendToFBSuccess = (event) ->
    console.log arguments

handleFail = (message) ->
    console.log arguments

document.addEventListener 'deviceready', ready, false