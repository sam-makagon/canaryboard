module IndicatorsHelper
  def status_button(indicator)
    color =
      case indicator.current_state.status.name
      when "green"
        "btn-success"
      when "yellow"
        "btn-warning"
      when "red"
        "btn-danger"
      when "blue"
        "btn-info"
      end

    options = {
      class: ["indicator", "btn", color].compact.join(" "),
      data: {
        title: "#{indicator.current_state.created_at.strftime("%H:%M, %b %-d, %Y")}",
        content: indicator.current_state.message || "No message"
      }
    }

    link_to "&nbsp;".html_safe, indicator_path(indicator), options
  end

  def format_date(date)
    if date != nil
      date.strftime("%b %-d, %Y %H:%M")
    end
  end

  def history_row(event)
    color =
      case event.status.name
      when "green"
        "success"
      when "yellow"
        "warning"
      when "red"
        "error"
      else
        ""
      end

    content_tag :tr,
      content_tag(:td, content_tag(:i, event.started_at) ) +
      content_tag(:td, content_tag(:i, event.stopped_at) ) +
      content_tag(:td, event.message || "No message"),
      class: color
  end
end
