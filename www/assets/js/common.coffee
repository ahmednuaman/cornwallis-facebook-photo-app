class Common
    image = 'assets/image/test.jpg'
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
                quality: 80,
                destinationType: Camera.DestinationType.FILE_URI
            
        catch error
            handleTakePhotoFail error
        
    
    handleTakePhotoSuccess = (imageURL) ->
        image = imageURL
        
        jt.goTo '#photoedit', 'slide'
    
    handleTakePhotoFail = (reason) ->
        # alert reason
        #         
        #         jt.goBack '#start'
        jt.goTo '#photoedit', 'slide'
    
    statePickExistingPhoto = ->
        
    
    if !!window.device
        document.addEventListener 'deviceready', ready, false
        
    else
        $ ready
