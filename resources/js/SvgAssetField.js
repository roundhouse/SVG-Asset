$(document).ready(function() {
  console.log('convert time');
  return $('.svg-convert').shapeSvgConvert({
    cleanUp: ['width', 'height', 'id', 'class', 'xmlns:xlink', 'xml:space', 'version']
  });
});

Craft.SvgAssetField = Garnish.Base.extend({
  $this: null,
  $parentInput: null,
  $elements: null,
  $data: null,
  name: null,
  modals: null,
  svgCodeIconTpl: null,
  init: function(id) {
    var btnClick, preventDefault, that;
    that = this;
    this.$this = $('#' + id);
    this.$parentInput = this.$this.closest('.input').find('>input[type=\'hidden\']');
    this.$elements = this.$this.find('.elements');
    this.$data = this.$this.find('.svg-code-modal');
    this.name = this.$data.data('name');
    this.modals = [];
    this.svgCodeIconTpl = '<a class="svgcode-btn icon" title="SVG Code">SVG Code</a>';
    preventDefault = function(event) {
      return event.stopPropagation();
    };
    btnClick = function(event) {
      var id;
      event.stopPropagation();
      id = $(this).closest('.element').data('id');
      return that.modals[id].show();
    };
    this.$elements.find('.element').each(function(i, e) {
      var extension, image;
      image = $(e).data('url');
      extension = image.substr(image.lastIndexOf('.') + 1);
      switch (extension) {
        case 'svg':
          $(e).addClass('svgcodeelement');
          id = $(e).data('id');
          that.initializeModal(id);
          return $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind('mousedown mouseup', preventDefault);
      }
    });
    this.$this.data('elementSelect').on('selectElements', function(e) {
      var $newElements;
      $newElements = that.$elements.find('.element').slice(-e.elements.length);
      return $newElements.each(function(i, e) {
        var $newEl, extension, image, label;
        image = $(e).data('url');
        extension = image.substr(image.lastIndexOf('.') + 1);
        switch (extension) {
          case 'svg':
            var id;
            $newEl = $(e).addClass('svgcodeelement');
            id = $newEl.data('id');
            label = $newEl.data('label');
            $('<div data-id="' + id + '"><textarea name="' + that.$parentInput.attr('name') + '[svgCode]" readonly></textarea></div>').appendTo(that.$data);
            $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind('mousedown mouseup', preventDefault);
            return that.initializeModal(id);
        }
      });
    });
    return this.$this.data('elementSelect').on('removeElements', function(e) {
      var id;
      id = 0;
      return that.$data.find('>div').each(function() {
        if (e.target.$elements.filter('[data-id="' + $(this).data('id') + '"]').length < 1) {
          id = $(this).data('id');
          return $(this).remove();
        }
      });
    });
  },
  initializeModal: function(id) {
    var $modal, image, myModal, observer, observerConfig, oldDisplay, oldWidth, svgCode, timeout;
    image = this.$elements.find('.element[data-id=\'' + id + '\']').data('url');
    svgCode = '';
    $modal = $('<div class="modal elementselectormodal" data-id="' + id + '">' + '    <div class="body">' + '        <div class="content">' + '            <div class="main">' + '                <div class="field"><div class="input"><textarea class="text nicetext fullwidth put-svg-here" rows="4" cols="50" style="min-height:250px;"></textarea></div></div>' + '                <div class="svg-code"><img src="' + image + '" class="svg-convert"></div>' + '            </div>' + '        </div>' + '    </div>' + '    <div class="footer">' + '        <div class="buttons left secondary-buttons">' + '            <div class="btn load-svg dashed">Reload SVG Code</div>' + '        </div>' + '        <div class="buttons right">' + '            <div class="btn submit">Ok</div>' + '        </div>' + '    </div>' + '</div>');
    myModal = new Garnish.Modal($modal, {
      autoShow: false,
      resizable: false
    });
    oldWidth = $modal.width();
    oldDisplay = 'none';
    timeout = null;
    observer = new MutationObserver(function(mutations) {
      return mutations.forEach(function(mutation) {
        return console.log(mutation);
      });
    });
    observerConfig = {
      attributes: true,
      childList: false,
      characterData: false,
      subtree: false,
      attributeOldValue: false,
      characterDataOldValue: false,
      attributeFilter: ['style']
    };
    observer.observe($modal[0], observerConfig);
    $modal.find('.submit').click(function() {
      return myModal.hide();
    });
    $modal.find('.load-svg').click(function() {
      return $('.svg-convert').shapeSvgConvert({
        cleanUp: ['width', 'height', 'id', 'class', 'xmlns:xlink', 'xml:space', 'version'],
        onComplete: function() {
          return $('.put-svg-here').val($('.svg-code').html());
        }
      });
    });
    return this.modals[id] = myModal;
  },
  destroyModal: function(id) {
    return this.modals[id].destroy();
  }
});
