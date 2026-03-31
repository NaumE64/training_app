class Trainings::PdfsController < ApplicationController
  def show
    # byebug
    @workout = current_user.workouts
    .includes(workout_exercises: [:exercise, :exercise_sets])
    .find_by(id: params[:id])

    html = render_to_string(
      template: 'trainings/pdfs/show',
      layout: 'pdf',
      formats: [:html]
    )

    pdf = WickedPdf.new.pdf_from_string(html)

    send_data pdf,
      filename: "workout_#{@workout.id}.pdf",
      type: 'application/pdf',
      disposition: 'inline'
  end
end