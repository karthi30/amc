class AmcController < ApplicationController
  def index
  	@all_scheme_names = Amc.all.pluck("scheme_name").uniq
  end

  def checkSchemeValue
    scheme_value = Amc.where(:scheme_name => params[:scheme_name], :on_date => params[:on_date].to_date.strftime('%d-%b-%Y'))
    if scheme_value.present?
      puts scheme_value.to_json
      units = params[:invested].to_f / scheme_value.first.net_asset_value.to_f
      today = Amc.where(:scheme_name => params[:scheme_name]).last.net_asset_value.to_f * units.to_f
      puts Amc.where(:scheme_name => params[:scheme_name]).last.net_asset_value.to_f
      render json: {units: units, today: today}
    else
      render json: {units: 0, today: 0}
    end
  end

end
