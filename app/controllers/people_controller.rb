class PeopleController < ApplicationController
  
  def edit
    @person = Person.find(params[:id])
  end
  
  
  def update
    @person = Person.find(params[:id])
    if Person.update(@person.id, params[:person])
      @person.save
    else
      flash[:warning] = @person.errors
    end
    
    redirect_to user_dashboard_path(@person.user.id)
  end
end
