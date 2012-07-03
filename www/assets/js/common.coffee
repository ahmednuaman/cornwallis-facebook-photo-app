class Common
    jt = new $.jQTouch
        statusBar: 'black'
    
    ready = ->
        window.location.hash
        
        window.onhashchange = handleHashChange
    
    handleHashChange = ->
        hash = window.location.hash.replace '#', ''
        
        switch hash
            when 'takephoto' then stateTakePhoto()
            when 'pickexistingphoto' then statePickExistingPhoto()
    
    stateTakePhoto = ->
        try
            navigator.camera.getPicture handleTakePhotoSuccess, handleTakePhotoFail, 
                quality: 50,
                destinationType: Camera.DestinationType.FILE_URI
            
        catch error
            handleTakePhotoFail error
        
    
    handleTakePhotoSuccess = (imageURL) ->
        $( '#photoedit' ).find( '#photoeditimage' ).attr( 'src', imageURL )
        
        jt.goTo '#photoedit', 'flip'
    
    handleTakePhotoFail = (reason) ->
        alert reason
        
        jt.goBack '#start'
    
    statePickExistingPhoto = ->
        
    
    if !!window.device
        document.addEventListener 'deviceready', ready, false
        
    else
        $ ready
