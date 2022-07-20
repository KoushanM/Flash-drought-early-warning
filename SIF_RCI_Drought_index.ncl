

;load the 8-day SIF data
aa=addfile("<netcdf.nc>","r")
lat_sif=aa->lat
lon_sif=aa->lon 

;You should use the RCI.ncl results 
a_rci=addfile("<netcdf.nc>","r")
RCI=a_rci->RCI
lat_rci=RCI&lat
lon_rci=RCI&lon

;load the drought short blend index data _ July
aaaa=addfile("<netcdf.nc>","r")

lat_usdm_july=aaaa->lat
lon_usdm_july=aaaa->lon 
USDM_Short_July=aaaa->USDM_Short_July
size=dimsizes(USDM_Short_July)
ntime=size(0)
nlat=size(1)
nlon=size(2)
day_usdm_july=USDM_Short_July&time
USDM_Short_July_AVE=new((/12/),"float")
copy_VarCoords(USDM_Short_July(0:ntime-1:4,0,0), USDM_Short_July_AVE)


;load the drought short blend index data _ August
abb=addfile("<netcdf.nc>","r")
lat_usdm_August=abb->lat
lon_usdm_August=abb->lon 
USDM_Short_August=abb->USDM_Short_August
size=dimsizes(USDM_Short_August)
ntime=size(0)
nlat=size(1)
nlon=size(2)
day_usdm_august=USDM_Short_August&time
USDM_Short_August_AVE=new((/12/),"float")
copy_VarCoords(USDM_Short_August(0:ntime-1:4,0,0), USDM_Short_August_AVE)

;The lat/lon is for the case study. You can change it 
example_rci_USDM=USDM_Short_July(:,closest_val(35.55,lat_usdm_july):closest_val(40.45,lat_usdm_july),closest_val(-100.55,lon_usdm_july):closest_val(-95.55,lon_usdm_july))
corr_norm_USDM=new((/12,dimsizes(example_rci_USDM&lat),dimsizes(example_rci_USDM&lon)/),"float")
copy_VarCoords(example_rci_USDM(0:ntime-1:4,:,:), corr_norm_USDM)




SIFo=aa->SIF
;corr_july=new((/dimsizes(SIFo&time)/46,dimsizes(SIFo&lat_sif),dimsizes(SIFo&lon_sif)/),"float")

corr_july_Siff=new((/dimsizes(SIFo&time)/46/),"float")
corr_july_Rcii=new((/dimsizes(RCI&time)/46/),"float")

size=dimsizes(SIFo)
;size=dimsizes(RCI)
ntime=size(0)
nlat=size(1)
nlon=size(2)
;copy_VarCoords(SIFo(0:ntime-1:46,:,:), corr_july)
copy_VarCoords(SIFo(0:ntime-1:46,0,0), corr_july_Siff)
copy_VarCoords(RCI(0:ntime-1:46,0,0), corr_july_Rcii)
Sif_month=dimsizes(corr_july_Siff)
july_count=Sif_month(0)
day_sif=SIFo&time
day_rci=RCI&time

bbb=0
ttt=0
;statistic

example_rci=RCI(:,closest_val(35.55,lat_rci):closest_val(40.45,lat_rci),closest_val(-100.55,lon_rci):closest_val(-95.55,lon_rci))
corr_norm_rci=new((/dimsizes(RCI&time)/46,dimsizes(example_rci&lat),dimsizes(example_rci&lon)/),"float")
copy_VarCoords(example_rci(0:ntime-1:46,:,:), corr_norm_rci)

example_SIFo=SIFo(:,closest_val(35.55,lat_sif):closest_val(40.45,lat_sif),closest_val(-100.55,lon_sif):closest_val(-95.55,lon_sif))
corr_norm_SIFo=new((/dimsizes(SIFo&time)/46,dimsizes(example_SIFo&lat),dimsizes(example_SIFo&lon)/),"float")
copy_VarCoords(example_SIFo(0:ntime-1:46,:,:), corr_norm_SIFo)



 do imonth=0,july_count-1

SIF_july_SIFF=SIFo(closest_val(day_sif(22)+bbb,day_sif):closest_val(day_sif(22)+bbb+60-3,day_sif),closest_val(35.55,lat_sif):closest_val(40.45,lat_sif),closest_val(-100.55,lon_sif):closest_val(-95.55,lon_sif))
SIF_july_rci=RCI(closest_val(day_rci(15)+bbb,day_rci):closest_val(day_rci(15)+bbb+60-3,day_rci),closest_val(35.55,lat_rci):closest_val(40.45,lat_rci),closest_val(-100.55,lon_rci):closest_val(-95.55,lon_rci))
SIF_july_RCII=RCI(closest_val(day_rci(15)+bbb,day_rci):closest_val(day_rci(15)+bbb+60-3,day_rci),closest_val(35.55,lat_rci):closest_val(40.45,lat_rci),closest_val(-100.55,lon_rci):closest_val(-95.55,lon_rci))
;SIF_july=where(SIFf_july.eq.0,SIFf_july@_FillValue,SIFf_july)
;copy_VarCoords(SIFf_july,SIF_july)
USDM_Short_July_spa=USDM_Short_July(closest_val(day_usdm_july(0)+bbb,day_usdm_july):closest_val(day_usdm_july(0)+bbb+30,day_usdm_july),closest_val(35.55,lat_usdm_july):closest_val(40.45,lat_usdm_july),closest_val(-100.55,lon_usdm_july):closest_val(-95.55,lon_usdm_july))
USDM_Short_August_spa=USDM_Short_August(closest_val(day_usdm_august(0)+bbb,day_usdm_august):closest_val(day_usdm_august(0)+bbb+30,day_usdm_august),closest_val(35.55,lat_usdm_August):closest_val(40.45,lat_usdm_August),closest_val(-100.55,lon_usdm_August):closest_val(-95.55,lon_usdm_August))


SIF_july_SpaAve_SIFF = dim_avg_n_Wrap(SIF_july_SIFF,(/1,2/))

SIF_july_SpaAve_RCII = dim_avg_n_Wrap(SIF_july_RCII,(/1,2/))
SIF_july_rci_SpaAve = dim_avg_n_Wrap(SIF_july_rci,(/1,2/))
;print( SIF_july_SpaAve)
;usdm====

USDM_Short_July_SpaAve = dim_avg_n_Wrap(USDM_Short_July_spa,(/1,2/))
print(USDM_Short_July_SpaAve)
USDM_Short_August_SpaAve = dim_avg_n_Wrap(USDM_Short_August_spa,(/1,2/))
print(USDM_Short_August_SpaAve)
;usdm=======
rci_max_usdm=max(SIF_july_rci_SpaAve)
rci_min_usdm=min(SIF_july_rci_SpaAve)

if (abs(rci_max_usdm) .gt. abs(rci_min_usdm)) then
if (rci_max_usdm .gt. 0) then
max_july=max(USDM_Short_July_SpaAve)
max_august=max(USDM_Short_August_SpaAve)
if (max_july .gt. max_august) then
USDM_Short_July_AVE(ttt)=max_july
corr_norm_USDM(ttt,:,:)=USDM_Short_July_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_July_SpaAve),:,:)
else
USDM_Short_July_AVE(ttt)=max_august
corr_norm_USDM(ttt,:,:)=USDM_Short_August_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_August_SpaAve),:,:)
end if
else
min_july=min(USDM_Short_July_SpaAve)
min_august=min(USDM_Short_August_SpaAve)
if (min_july .lt. min_august) then
USDM_Short_July_AVE(ttt)=min_july
corr_norm_USDM(ttt,:,:)=USDM_Short_July_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_July_SpaAve),:,:)
else
USDM_Short_July_AVE(ttt)=min_august
corr_norm_USDM(ttt,:,:)=USDM_Short_August_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_August_SpaAve),:,:)
end if
end if
else

if (rci_min_usdm .gt. 0) then
max_july=max(USDM_Short_July_SpaAve)
max_august=max(USDM_Short_August_SpaAve)
if (max_july .gt. max_august) then
USDM_Short_July_AVE(ttt)=max_july
corr_norm_USDM(ttt,:,:)=USDM_Short_July_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_July_SpaAve),:,:)

else
USDM_Short_July_AVE(ttt)=max_august
corr_norm_USDM(ttt,:,:)=USDM_Short_August_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_August_SpaAve),:,:)
end if
else
min_july=min(USDM_Short_July_SpaAve)
min_august=min(USDM_Short_August_SpaAve)

if (min_july .lt. min_august) then
USDM_Short_July_AVE(ttt)=min_july
corr_norm_USDM(ttt,:,:)=USDM_Short_July_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_July_SpaAve),:,:)
else
USDM_Short_July_AVE(ttt)=min_august
corr_norm_USDM(ttt,:,:)=USDM_Short_August_spa(closest_val(USDM_Short_July_AVE(ttt),USDM_Short_August_SpaAve),:,:)
end if
end if
end if






;sif===

corr_july_Siff(ttt)=max(SIF_july_SpaAve_SIFF)

;rci======
rci_max=max(SIF_july_SpaAve_RCII)
rci_min=min(SIF_july_SpaAve_RCII)
if (abs(rci_max) .gt. abs(rci_min)) then
corr_july_Rcii(ttt) = rci_max
else
corr_july_Rcii(ttt) = rci_min
end if
;==========

print("time=" +SIF_july_RCII&time)
print("max=" +corr_july_Rcii(ttt))
time_july_RCII=SIF_july_RCII&time
time_july_RCII!0= "time"
time_july_RCII@long_name = "days since 1970-001- 00:00:00"
time_july_RCII@units = "Year" 
;corr_july&time(ttt)=time_july(0)



;statistic_rci--------------------------------

corr_norm_SIFo(ttt,:,:)=SIF_july_SIFF(closest_val(corr_july_Siff(ttt),SIF_july_SpaAve_SIFF),:,:)
corr_norm_SIFo&time(ttt)=time_july_RCII(0)

corr_norm_rci(ttt,:,:)=SIF_july_RCII(closest_val(corr_july_Rcii(ttt),SIF_july_SpaAve_RCII),:,:)
corr_norm_rci&time(ttt)=time_july_RCII(0)


;confirm-------------------
;error bars
;dim_avg_n_Wrap(corr_norm,(/1,2/))
;dim_stddev_n_Wrap(corr_norm,(/1,2/))

bbb=bbb+365
ttt=ttt+1
;delete([/SIF_august,SIF_august_SpaAve,SIFf_august/])
delete([/SIF_july_RCII,SIF_july_SpaAve_RCII,SIF_july_SIFF,SIF_july_SpaAve_SIFF,time_july_RCII/])
end do



