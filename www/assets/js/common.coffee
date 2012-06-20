ready = (event) ->
    console.log 'ready'
    
    $( '#capturephoto' ).click handleCapturePhotoClick
    $( '#authwithfb' ).click handleAuthWithFBClick
    $( '#sendtofb' ).click handleSendToFBClick

handleCapturePhotoClick = (event) ->
    event.preventDefault()
    
    console.log 'handleCapturePhotoClick', navigator.camera.DestinationType.DATA_URL
    
    navigator.camera.getPicture handleCapturePhotoSuccess, handleFail, 
        quality: 50
        destinationType: navigator.camera.DestinationType.DATA_URL

handleCapturePhotoSuccess = (image) ->
    console.log 'handleCapturePhotoSuccess', image
    
    $( '#thephoto' ).attr 'src', 'data:image/jpeg;base64,' + image;

handleAuthWithFBClick = (event) ->
    event.preventDefault()
    
    console.log 'handleAuthWithFBClick'

handleSendToFBClick = (event) ->
    event.preventDefault()
    
    console.log 'handleSendToFBClick'

handleFail = (message) ->
    alert message

document.addEventListener 'deviceready', ready, false