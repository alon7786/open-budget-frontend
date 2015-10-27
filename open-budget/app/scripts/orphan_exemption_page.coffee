define ['backbone', 'models'], (Backbone, models)->
  class OrphanExemptionView extends Backbone.View
          events:
            'click .exemption-expander': 'toggleExemptionDetails'

          initialize: ->
              @model.selectedExemption.on 'change:publication_id', =>
                  pid = @model.selectedExemption.get('publication_id')
                  @exemption = new models.Exemption(pageModel: models.pageModel, publicationId: pid)
                  @exemption.doFetch()
                  @exemption.on 'ready', => @render()

          render: ->
              data = @exemption.toJSON()
              @$el.html window.JST.exemption_details( data )
              if @model.selectedExemption.get('entity_id') != ""
                  @$el.css('display','none')
              else
                  @$el.css('display','inherit')
