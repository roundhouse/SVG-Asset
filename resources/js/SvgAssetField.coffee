# $(document).ready ->
#     console.log 'whats up?'


Craft.SvgAssetField = Garnish.Base.extend(
    $this: null
    $parentInput: null
    $elements: null
    $data: null
    name: null
    modals: null
    svgCodeIconTpl: null

    init: (id) ->
        console.log 'hi'
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
            console.log that.modals
            that.modals[id].show()

        # On SVG Code link clicked
        @$elements.find('.element').each (i, e) ->
            $(e).addClass 'svgcodeelement'
            $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind 'mousedown mouseup', preventDefault

        # On Asset Select
        @$this.data('elementSelect').on 'selectElements', (e) ->
            $newElements = that.$elements.find('.element').slice(-e.elements.length)
            $newElements.each (i, e) ->
                `var id`
                $newEl = $(e).addClass('svgcodeelement')
                index = that.$elements.find('.element').index($newEl)
                id = $newEl.data('id')
                label = $newEl.data('label')
                $('<div data-id="' + id + '"><textarea name="' + that.$parentInput.attr('name') + '[svgCode]" readonly></textarea></div>').appendTo that.$data
                # $('<div data-id="' + id + '">' + '    <input type="hidden" name="' + that.$parentInput.attr('name') + '[focus-attr][' + index + '][data-focus-x]" value="0">' + ' </div>').appendTo that.$data
                $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind 'mousedown mouseup', preventDefault
                that.initializeModal id

        # On Asset Delete
        @$this.data('elementSelect').on 'removeElements', (e) ->
            `var id`
            id = 0
            that.$data.find('>div').each ->
                if e.target.$elements.filter('[data-id="' + $(this).data('id') + '"]').length < 1
                    id = $(this).data('id')
                    $(this).remove()
            that.destroyModal id


    initializeModal: (id) ->
        console.log id
        image = @$elements.find('.element[data-id=\'' + id + '\']').data('url')
        $modal = $('<div class="modal elementselectormodal" data-id="' + id + '">Hi :)</div>')

        myModal = new (Garnish.Modal)($modal,
            autoShow: false
            resizable: true)

        oldWidth = $modal.width()
        oldDisplay = 'none'
        timeout = null

        observer = new MutationObserver((mutations) ->
            mutations.forEach (mutation) ->
                if mutation.target == $modal[0] and mutation.attributeName == 'style'
                    if oldDisplay != $modal[0].style.display
                        oldDisplay = $modal[0].style.display
                    if oldWidth != $modal[0].style.width
                        if timeout == null
                            oldWidth = $modal[0].style.width
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

        @modals[id] = myModal

    destroyModal: (id) ->
        @modals[id].destroy()

)






