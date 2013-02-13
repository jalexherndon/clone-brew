(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'dijit/form/Textarea'], function(declare, _WidgetBase, _TemplatedMixin, query, Textarea) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: 'brew-recipe-builder-notes-and-instructions',
      templateString: "      <div>        <div class=\"header\">Notes & Instructions</div>        <div class=\"${baseClass}-textarea\"></div>      </div>    ",
      _getValueAttr: function() {
        return {
          notes: this.notes_textarea.get('value')
        };
      },
      postCreate: function() {
        this.inherited(arguments);
        return this.notes_textarea = new Textarea({
          name: "notes",
          style: "min-height:100px;_height:100px;"
        }, query("." + this.baseClass + "-textarea", this.domNode)[0]);
      }
    });
  });

}).call(this);
