$(document).ready ->
    console.log 'convert time'
    $('.svg-convert').shapeSvgConvert(
        cleanUp: ['width','height','id','class','xmlns:xlink','xml:space','version']
    )


Craft.SvgAssetField = Garnish.Base.extend(
    $this: null
    $parentInput: null
    $elements: null
    $data: null
    name: null
    modals: null
    svgCodeIconTpl: null

    init: (id) ->
        that = this
        @$this = $('#' + id)
        @$parentInput = @$this.closest('.input').find('>input[type=\'hidden\']')
        @$elements = @$this.find('.elements')
        @$data = @$this.find('.svg-code-modal')
        @name = @$data.data('name')
        @modals = []
        @svgCodeIconTpl = '<a class="svgcode-btn icon" title="SVG Code">SVG Code</a>'
        # @svgCodeIconTpl = '<a class="svgcode-btn icon" title="SVG Code"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="64px" height="64px" viewBox="0 0 64 64" style="enable-background:new 0 0 64 64;" xml:space="preserve"><path style="fill-rule:evenodd;clip-rule:evenodd;fill:#48A0DC;" d="M32,28c-1.104,0-2,0.896-2,1.999V40c0,1.104,0.896,2,2,2s2-0.896,2-2V29.999C34,28.896,33.104,28,32,28z M32,26c1.104,0,2-0.896,2-2c0-1.105-0.896-1.999-2-1.999S30,22.895,30,24C30,25.104,30.896,26,32,26z"/></svg></a>'
        preventDefault = (event) ->
            event.stopPropagation()

        btnClick = (event) ->
            `var id`
            event.stopPropagation()
            id = $(this).closest('.element').data('id')
            that.modals[id].show()

        # Adding Links to element
        @$elements.find('.element').each (i, e) ->
            image = $(e).data('url')
            extension = image.substr(image.lastIndexOf('.') + 1)
            switch extension
                when 'svg'
                    $(e).addClass 'svgcodeelement'
                    id = $(e).data('id')
                    that.initializeModal id
                    $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind 'mousedown mouseup', preventDefault
                else

        # On Asset Select
        @$this.data('elementSelect').on 'selectElements', (e) ->
            $newElements = that.$elements.find('.element').slice(-e.elements.length)
            $newElements.each (i, e) ->
                image = $(e).data('url')
                extension = image.substr(image.lastIndexOf('.') + 1)
                switch extension
                    when 'svg'
                        `var id`
                        $newEl = $(e).addClass('svgcodeelement')
                        id = $newEl.data('id')
                        label = $newEl.data('label')
                        $('<div data-id="' + id + '"><textarea name="' + that.$parentInput.attr('name') + '[svgCode]" readonly></textarea></div>').appendTo that.$data
                        # $('<div data-id="' + id + '">' + '    <input type="hidden" name="' + that.$parentInput.attr('name') + '[focus-attr][' + index + '][data-focus-x]" value="0">' + ' </div>').appendTo that.$data
                        $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind 'mousedown mouseup', preventDefault
                        that.initializeModal id
                    else

        # On Asset Delete
        @$this.data('elementSelect').on 'removeElements', (e) ->
            `var id`
            id = 0
            that.$data.find('>div').each ->
                if e.target.$elements.filter('[data-id="' + $(this).data('id') + '"]').length < 1
                    id = $(this).data('id')
                    $(this).remove()
            # that.updateInputs()
            # that.destroyModal id


    # updateInputs: () ->
    #     @$data.find('>div').each (i) ->
    #         $(this).find('input[type="hidden"]').each ->
    #             $(this).attr 'name', $(this).attr('name').replace(/\[focus\-attr]\[[0-9]]/i, '[focus-attr][' + i + ']')


    initializeModal: (id) ->
        image = @$elements.find('.element[data-id=\'' + id + '\']').data('url')
        svgCode = ''

        # $.get image, (data) ->
        #     svg = $(data).find('svg')
        #     svg = svg.removeAttr('xmlns:a')
        
        # $modal = $('<div class="modal elementselectormodal" data-id="' + id + '"><img src="'+image+'" class="svg-convert"></div>')
        $modal = $(
            '<div class="modal elementselectormodal" data-id="' + id + '">' +
            '    <div class="body">' +
            '        <div class="content">' +
            '            <div class="main">' +
            '                <div class="field"><div class="input"><textarea class="text nicetext fullwidth put-svg-here" rows="4" cols="50" style="min-height:250px;"></textarea></div></div>' +
            '                <div class="svg-code"><img src="'+image+'" class="svg-convert"></div>' +
            '            </div>' +
            '        </div>' +
            '    </div>' +
            '    <div class="footer">' +
            '        <div class="buttons left secondary-buttons">' +
            '            <div class="btn load-svg dashed">Reload SVG Code</div>' +
            '        </div>' +
            '        <div class="buttons right">' +
            '            <div class="btn submit">Ok</div>' +
            '        </div>' +
            '    </div>' +
            '</div>'
        )

        myModal = new (Garnish.Modal)($modal,
            autoShow: false
            resizable: false)

        oldWidth = $modal.width()
        oldDisplay = 'none'
        timeout = null

        observer = new MutationObserver((mutations) ->
            mutations.forEach (mutation) ->
                console.log mutation
                # if mutation.target == $modal[0] and mutation.attributeName == 'style'
                #     if oldDisplay != $modal[0].style.display
                #         oldDisplay = $modal[0].style.display
                #     if oldWidth != $modal[0].style.width
                #         if timeout == null
                #             oldWidth = $modal[0].style.width
        )


        observerConfig = 
            attributes: true
            childList: false
            characterData: false
            subtree: false
            attributeOldValue: false
            characterDataOldValue: false
            attributeFilter: [ 'style' ]
        observer.observe $modal[0], observerConfig


        $modal.find('.submit').click ->
            myModal.hide()

        $modal.find('.load-svg').click ->
            $('.svg-convert').shapeSvgConvert(
                cleanUp: ['width','height','id','class','xmlns:xlink','xml:space','version']
                onComplete: ->
                    $('.put-svg-here').val($('.svg-code').html())
            )

        @modals[id] = myModal

    

    destroyModal: (id) ->
        @modals[id].destroy()

)






