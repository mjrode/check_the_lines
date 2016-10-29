class NameFormatter

  def initialize(team_name)
    @team_name = team_name
  end

  def format_name
    remove_at
    format_direction
    format_state
    format_schools
    @team_name
  end

  def remove_at
    @team_name = @team_name.delete('@').strip
  end

  def format_state
    @team_name = @team_name + '.' if @team_name.include?('St')
  end

  def format_direction
    @team_name = @team_name.gsub('W ', 'W. ')
    @team_name = @team_name.gsub('S ', 'S. ')
    @team_name = @team_name.gsub('E ', 'E. ')
    @team_name = @team_name.gsub('N ', 'N. ')
  end

  def format_schools
    format_nc_state
    format_miami
    format_miami_ohio
    format_southern_miss
    format_central_michigan
    format_georgia_state
    format_texas_state
  end

  def format_nc_state
    @team_name = 'N.C State' if @team_name == "NC State"
  end

  def format_miami
    @team_name =  "Miami" if @team_name == 'Miami FL'
  end

  def format_miami_ohio
    @team_name = "Miami (Ohio)" if @team_name == 'Miami OH'
  end

  def format_southern_miss
    @team_name = "Southern Miss." if @team_name == "Southern Miss"
  end

  def format_central_michigan
    @team_name = "Central Michigan" if @team_name == "C Michigan"
  end

  def format_georgia_state
    @team_name = "Georgia State" if @team_name == "Georgia St."
  end

  def format_texas_state
    @team_name = "Texas State" if @team_name == "Texas St."
  end
end
