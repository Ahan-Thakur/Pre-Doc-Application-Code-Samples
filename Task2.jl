
using CSV
using LinearAlgebra, Statistics, StatsBase
using DataFrames, RDatasets, DataFramesMeta, CategoricalArrays, Query
using GLM
using Random
using Plots
using LaTeXStrings
# Importing CSV
pwtdf = CSV.read("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/PennWorldTables.csv", DataFrame)

#pwtdf.avh = passmissing(replace).(pwtdf.avh, "," => "")
#pwtdf.avh = passmissing(parse).(Float64, pwtdf.avh)


# Q2: Calculating GDP per worker = Output/employees


gdpperworkerdf = @from i in pwtdf begin
    @select {i.countrycode, i.country, i.cgdpo, i.emp, i.avh}
    @collect DataFrame
end

#GDP per worker
@chain gdpperworkerdf begin
    @transform!(@byrow :gdpperworker = :cgdpo / :emp)
  
   end
 
 #GDP per hour
   @chain gdpperworkerdf begin
   @transform!(@byrow :gdpperhour = :cgdpo / (:avh * :emp))
   end

# Q3a Table of Descriptive Statistics for 2019, 2018, 2017
data2019df = @from i in pwtdf begin
    @where i.year in [2019]
    @select {i.countrycode, i.country, i.cgdpo, i.pop, i.emp, i.avh, i.hc, i.ctfp, i.labsh, i.cn}
    @collect DataFrame
end
@chain data2019df begin
    @transform!(@byrow :gdpperworker = :cgdpo / :emp)
end
@chain data2019df begin
    @transform!(@byrow :gdpperhour = :cgdpo / (:emp*:avh))
  end
CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/data2019.csv", data2019df)

data2018df = @from i in pwtdf begin
    @where i.year in [2018]
    @select {i.countrycode, i.country, i.cgdpo, i.pop, i.emp, i.avh, i.hc, i.ctfp, i.labsh, i.cn}
    @collect DataFrame
end
CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/data2018.csv", data2018df)

data2017df = @from i in pwtdf begin
    @where i.year in [2017]
    @select {i.countrycode, i.country, i.cgdpo, i.pop, i.emp, i.avh, i.hc, i.ctfp, i.labsh, i.cn}
    @collect DataFrame
end
CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/data2017.csv", data2018df)

#2019 Chosen
#Q3b Cleaning Data
#Replace 0 with missing in emp column to avoid inf in gdpperworker
data2019df[!, :emp] = recode(data2019df[!, :emp], 0=>missing) 
data2019cleandf = dropmissing(data2019df)
CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/data2019cleandf.csv", data2019cleandf)

#Q3c
#Provide descriptive statistics characterizing differences in income per worker and per hour worked
#for the year chosen to perform your analysis. You should include the richest and the poorest
#countries, the countries in the 95,90,75,50,25,10,5 percentiles and the log-variance of your measures
#both measures of income. Compute the ratio between the richest and the poorest countries,
#percentiles 90 and 10, percentiles 75 and 25. Tabulate your results accordingly.
#

#sort the dataframe by gdpperworker


#Poorest country
mingdpperworker= minimum(data2019cleandf[!, :gdpperworker]) 

#Richest country
maxgdpperworker = maximum(data2019cleandf[!, :gdpperworker]) 

#Create table of data for analysis, starting from poorest to richest

gdpperworker_5th = trunc(percentile(data2019cleandf.gdpperworker, 5))
gdpperworker_10th = trunc(percentile(data2019cleandf.gdpperworker, 10))
gdpperworker_25th = trunc(percentile(data2019cleandf.gdpperworker, 25))
gdpperworker_50th = trunc(percentile(data2019cleandf.gdpperworker, 50))
gdpperworker_75th = trunc(percentile(data2019cleandf.gdpperworker, 75))
gdpperworker_90th = trunc(percentile(data2019cleandf.gdpperworker, 90))
gdpperworker_95th = trunc(percentile(data2019cleandf.gdpperworker, 95))

analysis_stats_df = @from i in data2019cleandf begin
    @where i.gdpperworker == mingdpperworker
    @select {class = "Poorest", i.country, i.gdpperworker,i.gdpperhour}
    @collect DataFrame
end

#5th Percentile

df5th = @from i in data2019cleandf begin
    #@where trunc(i.gdpperworker) == gdpperworker_5th
    @where i.countrycode in ["ECU"]
    @select {class = "5th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df5th)

#10th Percentile

df10th = @from i in data2019cleandf begin
   #@where trunc(i.gdpperworker) == gdpperworker_10th
    @where i.countrycode in ["THA"]
    @select {class = "10th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df10th)

#25th Percentile

df25th = @from i in data2019cleandf begin
    @where trunc(i.gdpperworker) == gdpperworker_25th
    @select {class = "25th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df25th)


#50th Percentile

df50th = @from i in data2019cleandf begin
    @where trunc(i.gdpperworker) == gdpperworker_50th
    @select {class = "50th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df50th)


#75th Percentile

df75th = @from i in data2019cleandf begin
    @where trunc(i.gdpperworker) == gdpperworker_75th
    @select {class = "75th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df75th)

#90th Percentile

df90th = @from i in data2019cleandf begin
    @where i.countrycode in ["BEL"]
    #@where trunc(i.gdpperworker) == gdpperworker_90th
    @select {class = "90th Percentile", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, df90th)


gdpperworker_95th = percentile(data2019cleandf.gdpperworker, 95)

df95th = @from i in data2019cleandf begin
      @where i.countrycode in ["CHE"]
      #@where trunc(i.gdpperworker) == gdpperworker_95th 
      @select {class = "95th Percentile", i.country, i.gdpperworker, i.gdpperhour}
      @collect DataFrame
  end

  append!(analysis_stats_df, df95th)


richest_df = @from i in data2019cleandf begin
    @where i.gdpperworker == maxgdpperworker
    @select {class = "Richest", i.country, i.gdpperworker, i.gdpperhour}
    @collect DataFrame
end

append!(analysis_stats_df, richest_df)

CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/analysis_stats.csv",analysis_stats_df)

#Q3d
#Produce two sets of scatterplots, one using log of income per worker and the other log of income per
#hour worked. 
#Re-scale income per worker and per hour worked so that they are measured relative
#to the US. 
#Plot each of these variables in the x axis against emp/pop, avh, hc, labsh, and cn/emp. 
#Label the charts and the axis appropriately. 
#Label observations using the variable countrycode. 
#Add
#regression lines to the charts.
#Produce two sets of scatterplots, one using log of income per worker and the other log of income per
#hour worked. 

logvarofgdpperworker = var(log.(2.71828,data2019cleandf.gdpperworker))
logvarofgdpperhour = var(log.(2.71828,data2019cleandf.gdpperhour))


function ratioFunction(num1, num2)
    ratio12 = round(num1/num2, digits=6)
   return ratio12
end

ratio_rich_poor = ratioFunction(trunc(Int,maxgdpperworker), trunc(Int, mingdpperworker))

ratio_90_10 = ratioFunction(trunc(Int,minimum(df90th[!, :gdpperworker])), trunc(Int, minimum(df10th[!, :gdpperworker]) ))

ratio_75_25 = ratioFunction(trunc(Int,minimum(df75th[!, :gdpperworker])), trunc(Int, minimum(df25th[!, :gdpperworker]) ))


df_ratios = DataFrame(RatioType = ["ratio_rich_poor" , "ratio_90_10",  "ratio_75_25", "variancegdpperworker", "variancegdpperhour"], RatioVal = [ratio_rich_poor, ratio_90_10, ratio_75_25, logvarofgdpperworker,logvarofgdpperhour] )

CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Ratios_2019.csv",df_ratios)

#p1 = plot(log.(2.71828,data2019cleandf.gdpperworker), mode="markers", seriestype = [:scatter], smooth=true,legend = true, title="log GDP Per Worker ")
#p2 = plot(log.(2.71828,data2019cleandf.gdpperhour), mode="markers", seriestype = [:scatter], smooth=true,legend = true, title="log GDP Per Hour")

#png(p1, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/log_gdpperworker")
#png(p2, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/log_gdpperhour")

#p_combined = plot(p1, p2, layout = (1,2))

#png(p_combined, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/log_gdpperhourandworker")


#Re-scale income per worker and per hour worked so that they are measured relative
#to the US. 


US_data_2019 = @from i in data2019cleandf begin
  @where i.countrycode in ["USA"]
  @select {i.country, i.gdpperworker, i.gdpperhour}
  @collect DataFrame
end

USA_gdpperworker_2019 = minimum(US_data_2019[!, :gdpperworker])
USA_gdpperhour_2019 = minimum(US_data_2019[!, :gdpperhour])


US_relative_data_2019_df = @from i in data2019cleandf begin
  #@where i.countrycode in ["USA"]
  @select {i.country, i.countrycode,  i.emp, i.pop, i.avh, i.hc, i.labsh, i.cn, i.gdpperworker, i.gdpperhour, 
           #ratio_to_USA = ratioFunction(log(2.71828,i.gdpperworker),log(2.71828,USA_gdpperworker_2019)),
           relativetoUSAgdpperworker = (ratioFunction(log(2.71828,i.gdpperworker),log(2.71828,USA_gdpperworker_2019))), 
           relativetoUSAgdpperhour= (ratioFunction(log(2.71828,i.gdpperhour),log(2.71828,USA_gdpperhour_2019))),
           #log_relativetoUSAgdpperworker = log(2.71828,1000*(ratioFunction(trunc(Int,i.gdpperworker), trunc(Int, USA_gdpperworker_2019)))), 
           #log_relativetoUSAgdpperhour= log(2.71828,1000*(ratioFunction(trunc(Int,i.gdpperhour), trunc(Int, USA_gdpperhour_2019)))) ,
           emp_pop_ratio = i.emp/i.pop,
           cn_emp_ratio = i.cn/ i.emp,
           Oneminuslabsh = 1 - i.labsh,
           ctfp = i.ctfp
          }
  @collect DataFrame
end

sort!(US_relative_data_2019_df, [:relativetoUSAgdpperworker])

CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/US_relative_data_2019.csv",US_relative_data_2019_df)

#Plot each of these variables in the x axis against emp/pop, avh, hc, labsh, and cn/emp. 
#Label the charts and the axis appropriately.



x_worker = US_relative_data_2019_df.relativetoUSAgdpperworker
x_hour = US_relative_data_2019_df.relativetoUSAgdpperhour

y_emp_pop = US_relative_data_2019_df.emp_pop_ratio
y_avh = US_relative_data_2019_df.avh
y_hc = US_relative_data_2019_df.hc
y_labsh = US_relative_data_2019_df.labsh
y_cn_emp= US_relative_data_2019_df.cn_emp_ratio
y_countrycode = US_relative_data_2019_df.countrycode
y_1_labsh = US_relative_data_2019_df.Oneminuslabsh
y_ctfp = US_relative_data_2019_df.ctfp
y_hour = US_relative_data_2019_df.relativetoUSAgdpperhour


#c1 = US_relative_data_2019_df.countrycode

#labels = US_relative_data_2019_df.country

p_Worker_vs_Hour = plot(x_worker, [y_hour], title="INCOME LEVELS VERSUS LABOUR PRODUCTIVITY LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :red
         ,tickfontsize = 5
         #,ylim = (0.0, 1.0)
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_hour, text.(US_relative_data_2019_df.countrycode,:top,3) )



savefig(p_Worker_vs_Hour,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_vs_Hour.pdf")


png(p_Worker_vs_Hour, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_vs_Hour")



p_Worker_emp_pop = plot(x_worker, [y_emp_pop], title="FRACTION OF POPULATION IN EMPLOYMENT VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Fraction of population in employment in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :red
         ,tickfontsize = 5
         ,ylim = (0.0, 1.0)
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_emp_pop, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_emp_pop,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_emp_pop.pdf")


png(p_Worker_emp_pop, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_emp_pop")


p_Hour_emp_pop = plot(x_hour, [y_emp_pop], title="FRACTION OF POPULATION IN EMPLOYMENT VERSUS WORKER PRODUCTIVITY LEVELS"
         ,titlefont = font(6,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Fraction of population in employment in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,ylim = (0, 1.0)
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_emp_pop, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Hour_emp_pop,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_emp_pop.pdf")
        
png(p_Hour_emp_pop, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_emp_pop")

p_Worker_avh = plot(x_worker, [y_avh], title="AVERAGE ANNUAL HOURS WORKED VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Average annual hours worked in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_avh, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_avh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_avh.pdf")



png(p_Worker_avh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_avh")


p_Hour_avh = plot(x_hour, [y_avh], title="AVERAGE ANNUAL HOURS WORKED VERSUS WORKER PRODUCTIVITY LEVELS"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Average annual hours worked in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_avh, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Hour_avh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_avh.pdf")
        
png(p_Hour_avh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_avh")


p_Worker_hc = plot(x_worker, [y_hc], title="HUMAN CAPITAL INDEX VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Human Capital Index in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_hc, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_hc,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_hc.pdf")

png(p_Worker_hc, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_hc")


p_Hour_hc = plot(x_hour, [y_hc], title="HUMAN CAPITAL INDEX VERSUS WORKER PRODUCTIVITY LEVELS"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Human Capital Index in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_hc, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Hour_hc,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_hc.pdf")
        
png(p_Hour_hc, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_hc")


p_Worker_labsh = plot(x_worker, [y_labsh], title="SHARE OF LABOUR COMPENSATION VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(6,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Share of labour compensation in GDP at current national prices in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_labsh, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_labsh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_labsh.pdf")



png(p_Worker_labsh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_labsh")


p_Hour_labsh = plot(x_hour, [y_labsh], title="SHARE OF LABOUR COMPENSATION VERSUS WORKER PRODUCTIVITY LEVELS"
         #, label=y_countrycode
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(6,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Share of labour compensation in GDP at current national prices in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_labsh, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Hour_labsh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_labsh.pdf")
        
png(p_Hour_labsh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_labsh")


p_Worker_cn_emp = plot(x_worker, [y_cn_emp], title="CAPITAL PER WORKER VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Capital per worker in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_cn_emp, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_cn_emp,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_cn_emp.pdf")



png(p_Worker_cn_emp, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_cn_emp")


p_Hour_cn_emp = plot(x_hour, [y_cn_emp], title="CAPITAL PER WORKER VERSUS WORKER PRODUCTIVITY LEVELS"
         #, label=y_countrycode
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Capital per worker"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_cn_emp, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Hour_cn_emp,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_cn_emp.pdf")
        
png(p_Hour_cn_emp, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_cn_emp")

p_Worker_labsh = plot(x_worker, [y_1_labsh], title="SHARE OF CAPITAL COMPENSATION VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(6,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "Share of capital (1-labour) compensation in GDP at current national prices in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_1_labsh, text.(US_relative_data_2019_df.countrycode,:top,3) )


savefig(p_Worker_labsh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_1-labsh.pdf")



png(p_Worker_labsh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_1-labsh")


p_Hour_labsh = plot(x_hour, [y_1_labsh], title="SHARE OF CAPITAL COMPENSATION VERSUS WORKER PRODUCTIVITY LEVELS"
         #, label=y_countrycode
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(6,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend= false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "Share of capital (1-labour) compensation in GDP at current national prices in 2019"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :green
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_1_labsh, text.(US_relative_data_2019_df.countrycode,:top,3) )

savefig(p_Hour_labsh,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_oneminuslabsh.pdf")
        
png(p_Hour_labsh, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_oneminuslabsh")


p_Worker_ctfp = plot(x_worker, [y_ctfp], title="TFP VERSUS INCOME LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per worker), relative to USA in 2019"
         ,ylabel = "TFP"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_worker, y_ctfp, text.(US_relative_data_2019_df.countrycode,:top,3) )

savefig(p_Worker_ctfp,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_ctfp.pdf")
        
png(p_Worker_ctfp, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Worker_ctfp")


p_Hour_ctfp = plot(x_hour, [y_ctfp], title="TFP VERSUS WORKER PRODUCTIVITY LEVELS"
         #, label="emp/pop (in millions)"
         ,titlefont = font(8,"Computer Modern")
         ,guidefont = font(8,"Computer Modern")
         ,showaxis = true
         ,linewidth=1
         ,legend = false
         ,seriestype = [:scatter]
         ,xlabel = "log (PPP GDP per hour), relative to USA in 2019"
         ,ylabel = "TFP"
         ,smooth=true
         ,mode =  :markers
         ,markershape = :xcross
         ,markersize = 0.1
         ,markercolour = :blue
         ,tickfontsize = 5
         ,gridalpha = 0.01
         )
annotate!(x_hour, y_ctfp, text.(US_relative_data_2019_df.countrycode,:top,3) )

savefig(p_Hour_ctfp,"D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_ctfp.pdf")
        
png(p_Hour_ctfp, "D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/Graphs/GDP_RelativeUSA_Hour_ctfp")



@chain  data2019cleandf begin
    @transform!(@byrow :A1 = :ctfp)
   end
  
   #data2019cleandf[!, :A1] = recode(data2019cleandf[!, :A1], 0=>1)
  
   @chain  data2019cleandf begin
    @transform!(@byrow :k = (:cn/:emp))
  
   end
  
   @chain  data2019cleandf begin
    @transform!(@byrow :h = :hc )
    
  
   end
  
   @chain  data2019cleandf begin
    @transform!(@byrow :y = (:cgdpo/:emp))
  
   end
  
   @chain  data2019cleandf begin
    @transform!(@byrow :alpha = (1-:labsh) )
   end

   @chain  data2019cleandf begin
    @transform!(@byrow :Atfp = (:ctfp) )
   end
  
  
    #@chain  data2019cleandf begin
    #@transform!(@byrow :A = ( (:y)/ ((:k^:alpha)*(:h^(1-:alpha)))))
    
   #end
   
   @chain  data2019cleandf begin
    @transform!(@byrow :A = (:ctfp))
   end 
  
  
   @chain  data2019cleandf begin
    @transform!(@byrow :Ar = ( (:y) / (  (:ctfp)*(:k^:alpha)*(:h^(1-:alpha)))   ) )
   end 

  
   @chain  data2019cleandf begin
    @transform!(@byrow :Yhk = ((:k^:alpha)*(:h^(1-:alpha)) ))
   end 
  
  CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/PWT_2019_Success_Measures.csv",data2019cleandf)
  
  
   Success0A = (var((log.(2.71828,data2019cleandf.Ar)) + log.(2.71828,data2019cleandf.A)))/(var(log.(2.71828,data2019cleandf.y)))
  
   Success1A = ((var(log.(2.71828,data2019cleandf.A)))/(var(log.(2.71828,data2019cleandf.y))))
  
   Success1Ar = ((var(log.(2.71828,data2019cleandf.Ar))) / (var(log.(2.71828,data2019cleandf.y))))
   #Success1Ar2 = round(Success1Ar)
  
   gdpperworker_99th = percentile(data2019cleandf.gdpperworker, 99)  ##NOR
   gdpperworker_01st = percentile(data2019cleandf.gdpperworker, 01) ##PHL
  
   df90th = @from i in  data2019cleandf begin
    @where i.countrycode in ["BEL"]
    #@where trunc(i.gdpperworker) == gdpperworker_90th
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  df10th = @from i in  data2019cleandf begin
  @where i.countrycode in ["THA"]
  #@where trunc(i.gdpperworker) == gdpperworker_10th
  @select {i.Yhk, i.y}
  @collect DataFrame
  end
  
  Yhk_90 = df90th.Yhk
  Yhk_10 = df10th.Yhk
  y_90 =   df90th.y
  y_10 = df10th.y
  
  Success2_90_10 = (Yhk_90/Yhk_10) / (y_90/y_10)
  
  
  
  df99th = @from i in  data2019cleandf begin
    @where i.countrycode in ["NOR"]
    #@where trunc(i.gdpperworker) == gdpperworker_99th
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  df1st = @from i in  data2019cleandf begin
    @where i.countrycode in ["PHL"]
    #@where trunc(i.gdpperworker) == gdpperworker_01st
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  
  
  Yhk_99 = df99th.Yhk
  Yhk_1 = df1st.Yhk
  y_99 =   df99th.y
  y_1 = df1st.y
  
  Success2_99_1 = (Yhk_99/Yhk_1) / (y_99/y_1)
  
  df75th = @from i in  data2019cleandf begin
    @where trunc(i.gdpperworker) == gdpperworker_75th
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  df25th = @from i in  data2019cleandf begin
    @where trunc(i.gdpperworker) == gdpperworker_25th
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  Yhk_75 = df75th.Yhk
  Yhk_25 = df25th.Yhk
  y_75 =   df75th.y
  y_25 = df25th.y
  
  Success2_75_25 = (Yhk_75/Yhk_25) / (y_75/y_25)
  
  
  df95th = @from i in  data2019cleandf begin
   #@where trunc(i.gdpperworker) == gdpperworker_95th
   @where i.countrycode in ["CHE"]
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  df5th = @from i in  data2019cleandf begin
    #@where trunc(i.gdpperworker) == gdpperworker_5th
    @where i.countrycode in ["ECU"]
    @select {i.Yhk, i.y }
    @collect DataFrame
  end
  
  Yhk_95 = df95th.Yhk
  Yhk_5 = df5th.Yhk
  y_95 =   df95th.y
  y_5 = df5th.y
  
  Success2_95_5 = ((Yhk_95/Yhk_5)/(y_95/y_5))
  
  #round(num1/num2, digits=2)
  
  
  #----------------------------------------------------------------------
  #create output
  #----------------------------------------------------------------------
  
  success0_A = [Success0A]
  success1_A = [Success1A]
  success1_Ar = [Success1Ar]
  success2_90_10 = [Success2_90_10]
  success2_99_1 = [Success2_99_1]
  success2_75_25 = [Success2_75_25]
  success2_95_5 = [Success2_95_5]
  
  
   df_success_measures_2019 = DataFrame(Sucess0_A = success0_A
                                      ,Success1_A = success1_A
                                      ,Success1_Ar = success1_Ar
                                      ,Success2_99_1 = success2_99_1
                                      ,Success2_90_10 = success2_90_10
                                      ,Success2_75_25 = success2_75_25
                                      ,Success2_95_5 = success2_95_5
                                      )
  
                                      
  CSV.write("D:/Ahan/Ahan/Programming/Learning-Julia/MyProject.jl/src/GrowthDevAccountingTask2/Database/PWT_2019_Success_Measures2.csv",df_success_measures_2019)