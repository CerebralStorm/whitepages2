defmodule Whitepages2.EnrollmentView do
  use Whitepages2.Web, :view

  def render("index.json", %{enrollments: enrollments}) do
    %{data: render_many(enrollments, Whitepages2.EnrollmentView, "enrollment.json")}
  end

  def render("show.json", %{enrollment: enrollment}) do
    %{data: render_one(enrollment, Whitepages2.EnrollmentView, "enrollment.json")}
  end

  def render("enrollment.json", %{enrollment: enrollment}) do
    %{id: enrollment.id,
      canvas_enrollment_id: enrollment.canvas_enrollment_id,
      section_id: enrollment.section_id,
      course_id: enrollment.course_id,
      role: enrollment.role,
      enrollment_state: enrollment.enrollment_state}
  end
end
