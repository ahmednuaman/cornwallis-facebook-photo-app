class Common
    image = 'assets/image/test.jpg'
    jt = new $.jQTouch
        statusBar: 'black-translucent'
    
    ready = ->
        window.location.hash
        
        window.onhashchange = handleHashChange
    
    handleHashChange = ->
        hash = window.location.hash.replace '#', ''
        
        switch hash
            when 'takephoto' then stateTakePhoto()
            when 'pickexistingphoto' then statePickExistingPhoto()
            when 'photoedit' then statePickExistingPhoto()
    
    stateTakePhoto = ->
        getPhoto Camera.PictureSourceType.CAMERA
    
    statePickExistingPhoto = ->
        getPhoto Camera.PictureSourceType.PHOTOLIBRARY
    
    getPhoto = (source) ->
        try
            navigator.camera.getPicture handleTakePhotoSuccess, handleTakePhotoFail, 
                quality: 80,
                sourceType: source,
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
    
    if !!window.device
        document.addEventListener 'deviceready', ready, false
        
    else
        $ ready
