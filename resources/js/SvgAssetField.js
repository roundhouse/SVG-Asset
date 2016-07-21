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
    console.log('hi');
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
      console.log(that.modals);
      return that.modals[id].show();
    };
    this.$elements.find('.element').each(function(i, e) {
      $(e).addClass('svgcodeelement');
      return $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind('mousedown mouseup', preventDefault);
    });
    this.$this.data('elementSelect').on('selectElements', function(e) {
      var $newElements;
      $newElements = that.$elements.find('.element').slice(-e.elements.length);
      return $newElements.each(function(i, e) {
        var id;
        var $newEl, index, label;
        $newEl = $(e).addClass('svgcodeelement');
        index = that.$elements.find('.element').index($newEl);
        id = $newEl.data('id');
        label = $newEl.data('label');
        $('<div data-id="' + id + '"><textarea name="' + that.$parentInput.attr('name') + '[svgCode]" readonly></textarea></div>').appendTo(that.$data);
        $(that.svgCodeIconTpl).prependTo($(e)).bind('click', btnClick).bind('mousedown mouseup', preventDefault);
        return that.initializeModal(id);
      });
    });
    return this.$this.data('elementSelect').on('removeElements', function(e) {
      var id;
      id = 0;
      that.$data.find('>div').each(function() {
        if (e.target.$elements.filter('[data-id="' + $(this).data('id') + '"]').length < 1) {
          id = $(this).data('id');
          return $(this).remove();
        }
      });
      return that.destroyModal(id);
    });
  },
  initializeModal: function(id) {
    var $modal, image, myModal, observer, observerConfig, oldDisplay, oldWidth, timeout;
    console.log(id);
    image = this.$elements.find('.element[data-id=\'' + id + '\']').data('url');
    $modal = $('<div class="modal elementselectormodal" data-id="' + id + '">Hi :)</div>');
    myModal = new Garnish.Modal($modal, {
      autoShow: false,
      resizable: true
    });
    oldWidth = $modal.width();
    oldDisplay = 'none';
    timeout = null;
    observer = new MutationObserver(function(mutations) {
      return mutations.forEach(function(mutation) {
        if (mutation.target === $modal[0] && mutation.attributeName === 'style') {
          if (oldDisplay !== $modal[0].style.display) {
            oldDisplay = $modal[0].style.display;
          }
          if (oldWidth !== $modal[0].style.width) {
            if (timeout === null) {
              return oldWidth = $modal[0].style.width;
            }
          }
        }
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
    return this.modals[id] = myModal;
  },
  destroyModal: function(id) {
    return this.modals[id].destroy();
  }
});
