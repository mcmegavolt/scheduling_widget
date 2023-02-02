# frozen_string_literal: true

module ApplicationHelper
  def current_class(controller)
    controller_name == controller ? 'active' : ''
  end

  def alert_message(content, color: 'secondary')
    content_tag(:div, content, class: "alert alert-#{color}")
  end
end
