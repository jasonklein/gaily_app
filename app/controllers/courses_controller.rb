class CoursesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @course.build_booking    
  end

  def create

    @course = Course.new(params[:course])
    
    if !dates_cannot_overlap_for_same_classroom
      flash[:notice] = "Dates cannot overlap."
      render action: "new"
    else
      if @course.save
        redirect_to @course, notice: "#{@course.name} has been added."
      else
        render action: "new"
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def dates_cannot_overlap_for_same_classroom

    booking = params[:course][:booking_attributes]
    new_start_date = Date.new booking["start_date(1i)"].to_i, booking["start_date(2i)"].to_i, booking["start_date(3i)"].to_i
    new_end_date = Date.new booking["end_date(1i)"].to_i, booking["end_date(2i)"].to_i, booking["end_date(3i)"].to_i
    new_classroom_id = booking.classroom_id

    Booking.all.each do |booking|
      if new_classroom_id == booking.classroom_id
        if new_start_date == booking.start_date
          false
          break
        elsif (new_start_date > booking.start_date) && (new_start_date < booking.end_date)
          false
          break
        elsif (new_start_date < booking.start_date) && (new_end_date > booking.start_date)
          false
          break
         end
       else
        true
      end
    end
  end

end
