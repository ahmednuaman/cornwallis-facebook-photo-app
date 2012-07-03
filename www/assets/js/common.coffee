class Common
    window.location.hash    = ''
    
    canvas = null
    image = 'assets/image/test.jpg'
    jt = new $.jQTouch
        statusBar: 'black-translucent'
    stage = null
    
    ready = ->
        canvas = document.getElementById 'editphotoimage'
        
        if window.devicePixelRatio > 1
            height = canvas.height
            width = canvas.width
            
            canvas.height = height * window.devicePixelRatio
            canvas.width = width * window.devicePixelRatio
            
            canvas.style.height = height + 'px'
            canvas.style.width = width + 'px'
        
        stage = new Stage canvas
        
        window.onhashchange = handleHashChange
    
    handleHashChange = ->
        hash = window.location.hash.replace '#', ''
        
        switch hash
            when 'takephoto' then stateTakePhoto()
            when 'pickexistingphoto' then statePickExistingPhoto()
            when 'editphoto' then stateEditPhoto()
        
    
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
        
    
    stateEditPhoto = ->
        img = new Image()
        
        img.onload = ->
            bitmap = new Bitmap img
            
            bitmap.scaleY = canvas.height / img.height
            bitmap.scaleX = bitmap.scaleY
            
            bitmap.x = canvas.width - ( img.width * bitmap.scaleX )
            
            stage.addChild bitmap
            
            stage.update()
        
        img.src = image
    
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
        
        goto 'editphoto'
    
    handleTakePhotoFail = (reason) ->
        # alert reason
        #         
        #         jt.goBack '#start'
        
        goto 'editphoto'
    
    goto = (state) ->
        window.location.href = '#' + state
    
    if !!window.device
        document.addEventListener 'deviceready', ready, false
        
    else
        $ ready
    
