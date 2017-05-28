class RpgController < ApplicationController
  def index
      session[:gold] ||= 0
      session[:activities] ||= []

      @new_gold = session[:gold]
      @activities = session[:activities]
  end

  def create
      if params[:building] == 'farm'
          new_gold = Random.rand(10...20)
      elsif params[:building] == 'cave'
          new_gold = Random.rand(5...10)
      elsif params[:building] == 'casino'
          new_gold = Random.rand(-50...50)
      elsif params[:building] == 'house'
          new_gold = Random.rand(2...5)
    end

    time = Time.new

    if new_gold > 0
        session[:activities] << "Earned #{new_gold} golds from the #{params[:building]}! (#{time.strftime('%Y/%m/%d %l:%M %P')})"
    else
        session[:activities] << "Entered a #{params[:building]} and lost #{new_gold.abs} golds... Ouch. (#{time.strftime('%Y/%m/%d %l:%M %P')})"
        # .abs will show absolute value of a variable when tacked on
    end

    session[:gold] = session[:gold] + new_gold
    redirect_to "/"
  end
end
