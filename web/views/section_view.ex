defmodule Whitepages2.SectionView do
  use Whitepages2.Web, :view

  def render("index.json", %{sections: sections}) do
    %{data: render_many(sections, Whitepages2.SectionView, "section.json")}
  end

  def render("show.json", %{section: section}) do
    %{data: render_one(section, Whitepages2.SectionView, "section.json")}
  end

  def render("section.json", %{section: section}) do
    %{id: section.id,
      canvas_section_id: section.canvas_section_id,
      sis_id: section.sis_id,
      course_id: section.course_id,
      name: section.name}
  end
end
