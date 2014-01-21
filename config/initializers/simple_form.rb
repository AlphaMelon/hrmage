# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
    config.wrappers(:default, class: 'row',hint_class: :field, error_class: :errors) do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly

      ## Inputs
      b.wrapper tag: :div, class: 'large-12 small-12 columns' do |c|
        c.wrapper tag: :div, class: 'row' do |d|
            d.use :label_input
            d.use :error, wrap_with: { tag: :small, class: :error }
        end
      end
    end


    config.wrappers :custom, class: 'row', hint_class: :field_with_hint, form_class: :custom, label_class: 'control-label left inline', error_class: :errors do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly

      ## Inputs
      b.wrapper tag: :div, class: 'large-12 small-12 columns' do |c|
        c.wrapper tag: :div, class: 'row' do |d|
          d.wrapper tag: :div, class: 'large-3 small-3 columns' do |e|
            e.use :label, class: 'left inline'
          end
          d.wrapper tag: :div, class: 'large-9 small-9 columns' do |e|
            e.use :input
          end
        end
        c.wrapper tag: :div, class: 'row' do |d|
          d.wrapper tag: :div, class: 'large-12 small-12 columns' do |e|
            e.use :hint,  wrap_with: { tag: :span, class: :hint }
            e.use :error, wrap_with: { tag: :small, class: :error }
          end
        end
      end

    end

    config.default_wrapper = :default

    config.button_class = 'button'
    config.boolean_style = :inline
    config.error_notification_tag = :div
    config.error_notification_class = 'alert-box alert'
    config.label_class = 'control-label left inline'
    config.generate_additional_classes_for = [:wrapper, :label, :input]
end