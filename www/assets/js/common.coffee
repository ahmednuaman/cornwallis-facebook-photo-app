class Common
    window.location.hash    = ''
    
    canvas = null
    image = 'assets/image/test.jpg'
    jt = new $.jQTouch
        statusBar: 'black-translucent'
    
    ready = ->
        canvas = document.getElementById( 'photoeditimage' ).getContext( '2d' )
        
        window.onhashchange = handleHashChange
    
    handleHashChange = ->
        hash = window.location.hash.replace '#', ''
        
        switch hash
            when 'takephoto' then stateTakePhoto()
            when 'pickexistingphoto' then statePickExistingPhoto()
            when 'photoedit' then statePhotoEdit()
        
    
    stateTakePhoto = ->
        try
            getPhoto Camera.PictureSourceType.CAMERA
            
        catch error
            handleTakePhotoFail error
        
    
    statePickExistingPhoto = ->
        try
            getPhoto Camera.PictureSourceType.PHOTOLIBRARY
            
        catch error
            handleTakePhotoFail error
        
    
    statePhotoEdit = ->
        console.log image
        
        # img = new Image()
        #         
        #         img.onload = ->
        #             console.log img
        #             canvas.drawImage img, 0, 0, canvas.width, canvas.height
        #         
        #         img.src = image
    
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
        
        jt.goTo '#photoedit', 'flip'
    
    handleTakePhotoFail = (reason) ->
        # alert reason
        #         
        #         jt.goBack '#start'
        jt.goTo '#photoedit', 'flip'
    
    if !!window.device
        document.addEventListener 'deviceready', ready, false
        
    else
        $ ready
    
