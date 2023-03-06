class WakeboardSetChibsAndDibs < ActiveRecord::Migration[7.0]
  def change
    remove_columns(:wakeboard_sets, :rider_limit, :current_rider_count, type: :integer)
    # add dib count - dibs have limit of 4 people
    add_column(:wakeboard_sets, :dib_count, :integer, default: 0)
    add_column(:wakeboard_sets, :dib_limit, :integer, default: 4)
    
    # add chib count + limit default - chibs limited to 3 people
    add_column(:wakeboard_sets, :chib_count, :integer, default: 0)
    add_column(:wakeboard_sets, :chib_limit, :integer, default: 3)

    # add driver count + limit default - max of 2 drivers
    add_column(:wakeboard_sets, :driver_count, :integer, default: 0)
    add_column(:wakeboard_sets, :driver_limit, :integer, default: 2)
  end
end
