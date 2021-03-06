require 'gnuplot'
require_relative 'mnk_cubic_parabola'
require_relative 'sum_approximation_module'

class PlotCPWithExtremes
  include SumApproximation

  attr_accessor :x, :y
  attr_reader :ob, :gn

  def initialize(obn, gene_id)
    @ob = obn
    @gn = gene_id
    @x = []
    @y = []
  end

  def plotting_equation
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|

        plot.title  'Cubic parabola with extreme points'
        plot.ylabel "#{gn}"
        plot.xlabel 'Calibration ID'

        @x = ob.x.collect { |v| v.to_f }
        @y = x.collect do |v|
          ob.coefficient_a * v**3 + ob.coefficient_b * v**2 + ob.coefficient_c * v + ob.coefficient_d
        end

        plot.data = [
                    Gnuplot::DataSet.new([x, ob.y]) do |ds|
                    ds.with = 'points'
                    ds.title = 'Data'
                    ds.linewidth = 2
                    end,

                    Gnuplot::DataSet.new([x, y]) do |ds|
                    ds.with = 'linespoints'
                    ds.title = 'Approximation data'
                    end,

                    mistake_written_in_title]
      end
    end
  end
end
