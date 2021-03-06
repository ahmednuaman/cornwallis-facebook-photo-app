class Common
    window.location.hash = ''
    
    canvas = null
    image = 'assets/image/test.jpg'
    imageX = 0
    stage = null
    text = { }
    textColour = '#ffffff'
    textFont = 'bold ' + ( window.devicePixelRatio * 4 ) + '0px Arial'
    textOutline = '#000000'
    
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
            when 'confirmphoto' then stateConfirmPhoto()
        
    
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
        
        stage.clear()
        stage.update()
        
        text = { }
        
        img.onload = ->
            bitmap = new Bitmap img
            
            bitmap.scaleY = canvas.height / img.height
            bitmap.scaleX = bitmap.scaleY
            
            bitmap.x = imageX = canvas.width - ( img.width * bitmap.scaleX )
            
            stage.addChild bitmap
            
            stage.update()
        
        img.src = image
        
        $( '#editphoto' ).find( 'select' ).unbind( 'change' ).change( addTextToPhoto ).each( ->
            $( this ).val( $( this ).find( 'option:first' ) )
        )
    
    addTextToPhoto = (event) ->
        element = $ this
        id = element.attr 'id'
        base = text[ id ]
        outline = text[ id + 'outline' ]
        
        if !!base && !!outline
            base.text = sortOutText element.val()
            outline.text = sortOutText element.val()
            
        else
            text[ id ] = base = new Text sortOutText( element.val() ), textFont, textColour
            text[ id + 'outline' ] = outline = new Text sortOutText( element.val() ), textFont, textOutline
            
            outline.outline = true
            
            base.maxWidth = outline.maxWidth = canvas.width
            base.textAlign = outline.textAlign = 'center'
            
            base.x = outline.x = imageX * -1
            base.y = outline.y = if id.indexOf( 'top' ) == -1 then canvas.height - 20 * window.devicePixelRatio else 50 * window.devicePixelRatio
            
            stage.addChild base
            stage.addChild outline
            
        
        stage.update()
    
    stateConfirmPhoto = ->
        $( '#confirmphotoimage' ).attr( 'src', stage.toDataURL( null, 'image/jpeg' ) )
    
    sortOutText = (text) ->
        text.toUpperCase().replace( /_/g, ' ' ).replace( /\|/g, "\n" )
    
    getPhoto = (source) ->
        try
            navigator.camera.getPicture handleTakePhotoSuccess, handleTakePhotoFail, 
                allowEdit: true,
                quality: 50,
                sourceType: source,
                destinationType: Camera.DestinationType.FILE_URI,
                targetWidth: canvas.width,
                targetHeight: canvas.height
            
        catch error
            handleTakePhotoFail error
        
    
    handleTakePhotoSuccess = (imageURI) ->
        image = imageURI
        
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
    
