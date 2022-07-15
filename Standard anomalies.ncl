;load monthly precipitation data
a=addfile("<NetCDF File.nc>","r")

lat=a->lat
lon=a->lon 

 precip=a->precip(0:239,closest_val(24.55,lat):closest_val(49.45,lat),closest_val(-120.05,lon):closest_val(-80.05,lon)) 
  precip_Ave=dim_avg_n_Wrap( precip, (/1,2/))

 precipi=precip
;Method one
 precipi_monthly_climatology=clmMonTLL( precipi)
 precipi_monthly_anomalies=calcMonAnomTLL( precipi, precipi_monthly_climatology)
  precipi_anomal= precipi_monthly_anomalies(:,:,:)
  precipi_anomall=dim_avg_n_Wrap( precipi_anomal, (/1,2/))


;Method Two_ the results are same as method 1 _ Method 2 is used in the paper 
;Stan Anomally------------------------------------------------------------

size=dimsizes(precipi)
ntime=size(0)
nlat=size(1)
nlon=size(2)
stann=new((/dimsizes(  precipi&time),dimsizes(  precipi&lat),dimsizes(  precipi&lon)/),"float")
copy_VarCoords(  precipi(0:ntime-1,:,:), stann)
stann@_FillValue=stann@_FillValue
printVarSummary(stann)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
;print(bbb)
do itime=0,ntime-1,1
;print(ttt)
if (yearr .ge. 12) then
if (all((ismissing(  precipi(0:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(  precipi(0:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(  precipi(0:ntime-1:12,aaa,bbb)) .eq. 0) then 
stann(ttt,aaa,bbb)=stann@_FillValue
else 
V=doubletofloat((  precipi(ttt,aaa,bbb)-avg(  precipi(0:ntime-1:12,aaa,bbb)))/(stddev(  precipi(0:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
yearr=0
else if (yearr .lt. 12) then
if (all((ismissing(  precipi(yearr:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(  precipi(yearr:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(  precipi(yearr:ntime-1:12,aaa,bbb)) .eq. 0) then
stann(ttt,aaa,bbb)=stann@_FillValue
else
V=doubletofloat((  precipi(ttt,aaa,bbb)-avg(  precipi(yearr:ntime-1:12,aaa,bbb)))/(stddev(  precipi(yearr:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
end if
end if
ttt=ttt+1
yearr=yearr+1
end do 
ttt=0
yearr=0
bbb=bbb+1
end do
bbb=0
aaa=aaa+1
end do



  precipi_Stan_anomal=stann
copy_VarCoords( stann,   precipi_Stan_anomal)
;------------------------------------------------------



;Monthly

   precipi_Stan_anomal_jan=   precipi_Stan_anomal(0:239:12,:,:)
   precipi_Stan_anomal_feb=   precipi_Stan_anomal(1:239:12,:,:)
   precipi_Stan_anomal_march=   precipi_Stan_anomal(2:239:12,:,:)
   precipi_Stan_anomal_april=   precipi_Stan_anomal(3:239:12,:,:)
   precipi_Stan_anomal_may=   precipi_Stan_anomal(4:239:12,:,:)
   precipi_Stan_anomal_june=   precipi_Stan_anomal(5:239:12,:,:)
   precipi_Stan_anomal_july=   precipi_Stan_anomal(6:239:12,:,:)
   precipi_Stan_anomal_august=   precipi_Stan_anomal(7:239:12,:,:)
   precipi_Stan_anomal_sep=   precipi_Stan_anomal(8:239:12,:,:)
   precipi_Stan_anomal_oct=   precipi_Stan_anomal(9:239:12,:,:)
   precipi_Stan_anomal_nov=   precipi_Stan_anomal(10:239:12,:,:)
   precipi_Stan_anomal_dec=   precipi_Stan_anomal(11:239:12,:,:)

   precipi_Stan_anomal_jan_2012=   precipi_Stan_anomal_jan(12,:,:)
  precipi_Stan_anomal_jan_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_jan_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_feb_2012=  precipi_Stan_anomal_feb(12,:,:)
  precipi_Stan_anomal_feb_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_feb_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_march_2012=  precipi_Stan_anomal_march(12,:,:)
  precipi_Stan_anomal_march_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_march_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_april_2012=  precipi_Stan_anomal_april(12,:,:)
  precipi_Stan_anomal_april_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_april_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_may_2012=  precipi_Stan_anomal_may(12,:,:)
  precipi_Stan_anomal_may_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_may_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_june_2012=  precipi_Stan_anomal_june(12,:,:)
  precipi_Stan_anomal_june_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_june_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_july_2012=  precipi_Stan_anomal_july(12,:,:)
  precipi_Stan_anomal_july_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_july_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_august_2012=  precipi_Stan_anomal_august(12,:,:)
  precipi_Stan_anomal_august_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_august_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_sep_2012=  precipi_Stan_anomal_sep(12,:,:)
  precipi_Stan_anomal_sep_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_sep_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_oct_2012=  precipi_Stan_anomal_oct(12,:,:)
  precipi_Stan_anomal_oct_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_oct_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_nov_2012=  precipi_Stan_anomal_nov(12,:,:)
  precipi_Stan_anomal_nov_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_nov_2012&lon@units = "degrees_east"
  precipi_Stan_anomal_dec_2012=  precipi_Stan_anomal_dec(12,:,:)
  precipi_Stan_anomal_dec_2012&lat@units = "degrees_north"
   precipi_Stan_anomal_dec_2012&lon@units = "degrees_east"

printVarSummary(  precipi_Stan_anomal_dec_2012)
delete([/a,V,yearr,size,nlat,nlon,ntime,lat,lon,stann/])


;========================================================================================
;Load Monthly ET data
a=addfile("<NetCDF File.nc>","r")

lat=a->lat
lon=a->lon 

et=a->ET(:,closest_val(25.55,lat):closest_val(49.45,lat),closest_val(-120.55,lon):closest_val(-80.55,lon))  
  

 eti=et
 eti_monthly_climatology=clmMonTLL( eti)
 eti_monthly_anomalies=calcMonAnomTLL( eti, eti_monthly_climatology)
  eti_anomal= eti_monthly_anomalies
  eti_anomall=dim_avg_n_Wrap( eti_anomal, (/1,2/))
eti_monthly__std=stdMonTLL(eti)
 eti_stdAve=dim_avg_n_Wrap(eti_monthly__std, (/1,2/))



;Stan Anomally------------------------------------------------------------

size=dimsizes( eti)
ntime=size(0)
nlat=size(1)
nlon=size(2)
stann=new((/dimsizes(eti&time),dimsizes(eti&lat),dimsizes(eti&lon)/),"float")
copy_VarCoords(eti(0:ntime-1,:,:), stann)
stann@_FillValue=stann@_FillValue
printVarSummary(stann)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
;print(bbb)
do itime=0,ntime-1,1
;print(ttt)
if (yearr .ge. 12) then
if (all((ismissing(eti(0:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(eti(0:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(eti(0:ntime-1:12,aaa,bbb)) .eq. 0) then 
stann(ttt,aaa,bbb)=stann@_FillValue
else 
V=doubletofloat((eti(ttt,aaa,bbb)-avg(eti(0:ntime-1:12,aaa,bbb)))/(stddev(eti(0:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
yearr=0
else if (yearr .lt. 12) then
if (all((ismissing(eti(yearr:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(eti(yearr:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(eti(yearr:ntime-1:12,aaa,bbb)) .eq. 0) then
stann(ttt,aaa,bbb)=stann@_FillValue
else
V=doubletofloat((eti(ttt,aaa,bbb)-avg(eti(yearr:ntime-1:12,aaa,bbb)))/(stddev(eti(yearr:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
end if
end if
ttt=ttt+1
yearr=yearr+1
end do 
ttt=0
yearr=0
bbb=bbb+1
end do
bbb=0
aaa=aaa+1
end do

eti_Stan_anomal=stann*(1)
copy_VarCoords( stann, eti_Stan_anomal)
;------------------------------------------------------
;Monthly

 eti_Stan_anomal_jan= eti_Stan_anomal(0:227:12,:,:)
 eti_Stan_anomal_feb= eti_Stan_anomal(1:227:12,:,:)
 eti_Stan_anomal_march= eti_Stan_anomal(2:227:12,:,:)
 eti_Stan_anomal_april= eti_Stan_anomal(3:227:12,:,:)
 eti_Stan_anomal_may= eti_Stan_anomal(4:227:12,:,:)
 eti_Stan_anomal_june= eti_Stan_anomal(5:227:12,:,:)
 eti_Stan_anomal_july= eti_Stan_anomal(6:227:12,:,:)
 eti_Stan_anomal_august= eti_Stan_anomal(7:227:12,:,:)
 eti_Stan_anomal_sep= eti_Stan_anomal(8:227:12,:,:)
 eti_Stan_anomal_oct= eti_Stan_anomal(9:227:12,:,:)
 eti_Stan_anomal_nov= eti_Stan_anomal(10:227:12,:,:)
 eti_Stan_anomal_dec= eti_Stan_anomal(11:227:12,:,:)

 eti_Stan_anomal_jan_2012= eti_Stan_anomal_jan(11,:,:)
eti_Stan_anomal_jan_2012&lat@units = "degrees_north"
 eti_Stan_anomal_jan_2012&lon@units = "degrees_east"
eti_Stan_anomal_feb_2012=eti_Stan_anomal_feb(11,:,:)
eti_Stan_anomal_feb_2012&lat@units = "degrees_north"
 eti_Stan_anomal_feb_2012&lon@units = "degrees_east"
eti_Stan_anomal_march_2012=eti_Stan_anomal_march(11,:,:)
eti_Stan_anomal_march_2012&lat@units = "degrees_north"
 eti_Stan_anomal_march_2012&lon@units = "degrees_east"
eti_Stan_anomal_april_2012=eti_Stan_anomal_april(11,:,:)
eti_Stan_anomal_april_2012&lat@units = "degrees_north"
eti_Stan_anomal_april_2012&lon@units = "degrees_east"
eti_Stan_anomal_may_2012=eti_Stan_anomal_may(11,:,:)
eti_Stan_anomal_may_2012&lat@units = "degrees_north"
eti_Stan_anomal_may_2012&lon@units = "degrees_east"
eti_Stan_anomal_june_2012=eti_Stan_anomal_june(11,:,:)
eti_Stan_anomal_june_2012&lat@units = "degrees_north"
eti_Stan_anomal_june_2012&lon@units = "degrees_east"
eti_Stan_anomal_july_2012=eti_Stan_anomal_july(11,:,:)
eti_Stan_anomal_july_2012&lat@units = "degrees_north"
eti_Stan_anomal_july_2012&lon@units = "degrees_east"
eti_Stan_anomal_august_2012=eti_Stan_anomal_august(11,:,:)
eti_Stan_anomal_august_2012&lat@units = "degrees_north"
eti_Stan_anomal_august_2012&lon@units = "degrees_east"
eti_Stan_anomal_sep_2012=eti_Stan_anomal_sep(11,:,:)
eti_Stan_anomal_sep_2012&lat@units = "degrees_north"
eti_Stan_anomal_sep_2012&lon@units = "degrees_east"
eti_Stan_anomal_oct_2012=eti_Stan_anomal_oct(11,:,:)
eti_Stan_anomal_oct_2012&lat@units = "degrees_north"
eti_Stan_anomal_oct_2012&lon@units = "degrees_east"
eti_Stan_anomal_nov_2012=eti_Stan_anomal_nov(11,:,:)
eti_Stan_anomal_nov_2012&lat@units = "degrees_north"
eti_Stan_anomal_nov_2012&lon@units = "degrees_east"
eti_Stan_anomal_dec_2012=eti_Stan_anomal_dec(11,:,:)
eti_Stan_anomal_dec_2012&lat@units = "degrees_north"
eti_Stan_anomal_dec_2012&lon@units = "degrees_east"

printVarSummary(eti_Stan_anomal_dec_2012)

delete([/a,V,yearr,size,nlat,nlon,ntime,lat,lon,stann/])

;=========================================================================================

;Load SIF temp data
a=addfile("<NetCDF File.nc>","r")

lat=a->lat
lon=a->lon 
siff=a->SIF




 
SIF=siff(:,closest_val(25.55,lat):closest_val(49.45,lat),closest_val(-120.05,lon):closest_val(-80.05,lon))  
SIF_Ave=dim_avg_n_Wrap( SIF, (/1,2/))

 SIFi=SIF
 SIFi_monthly_climatology=clmMonTLL( SIFi)
 SIFi_monthly_anomalies=calcMonAnomTLL( SIFi, SIFi_monthly_climatology)
  SIFi_anomal= SIFi_monthly_anomalies
  SIFi_anomall=dim_avg_n_Wrap( SIFi_anomal, (/1,2/))
  SIFi_anomall=dim_avg_n_Wrap( SIFi_anomal, (/1,2/))



;Stan Anomally------------------------------------------------------------

size=dimsizes(SIFi)
ntime=size(0)
nlat=size(1)
nlon=size(2)
stann=new((/dimsizes(SIFi&time),dimsizes(SIFi&lat),dimsizes(SIFi&lon)/),"float")
copy_VarCoords(SIFi(0:ntime-1,:,:), stann)
stann@_FillValue=stann@_FillValue
printVarSummary(stann)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
;print(bbb)
do itime=0,ntime-1,1
;print(ttt)
if (yearr .ge. 12) then
if (all((ismissing(SIFi(0:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(SIFi(0:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(SIFi(0:ntime-1:12,aaa,bbb)) .eq. 0) then 
stann(ttt,aaa,bbb)=stann@_FillValue
else 
V=doubletofloat((SIFi(ttt,aaa,bbb)-avg(SIFi(0:ntime-1:12,aaa,bbb)))/(stddev(SIFi(0:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
yearr=0
else if (yearr .lt. 12) then
if (all((ismissing(SIFi(yearr:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(SIFi(yearr:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(SIFi(yearr:ntime-1:12,aaa,bbb)) .eq. 0) then
stann(ttt,aaa,bbb)=stann@_FillValue
else
V=doubletofloat((SIFi(ttt,aaa,bbb)-avg(SIFi(yearr:ntime-1:12,aaa,bbb)))/(stddev(SIFi(yearr:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
end if
end if
ttt=ttt+1
yearr=yearr+1
end do 
ttt=0
yearr=0
bbb=bbb+1
end do
bbb=0
aaa=aaa+1
end do

SIFi_Stan_anomal=stann*(1)
copy_VarCoords( stann, SIFi_Stan_anomal)
;------------------------------------------------------


;Monthly

 SIFi_Stan_anomal_jan= SIFi_Stan_anomal(0:143:12,:,:)
 SIFi_Stan_anomal_feb= SIFi_Stan_anomal(1:143:12,:,:)
 SIFi_Stan_anomal_march= SIFi_Stan_anomal(2:143:12,:,:)
 SIFi_Stan_anomal_april= SIFi_Stan_anomal(3:143:12,:,:)
 SIFi_Stan_anomal_may= SIFi_Stan_anomal(4:143:12,:,:)
 SIFi_Stan_anomal_june= SIFi_Stan_anomal(5:143:12,:,:)
 SIFi_Stan_anomal_july= SIFi_Stan_anomal(6:143:12,:,:)
 SIFi_Stan_anomal_august= SIFi_Stan_anomal(7:143:12,:,:)
 SIFi_Stan_anomal_sep= SIFi_Stan_anomal(8:143:12,:,:)
 SIFi_Stan_anomal_oct= SIFi_Stan_anomal(9:143:12,:,:)
 SIFi_Stan_anomal_nov= SIFi_Stan_anomal(10:143:12,:,:)
 SIFi_Stan_anomal_dec= SIFi_Stan_anomal(11:143:12,:,:)

 SIFi_Stan_anomal_jan_2012= SIFi_Stan_anomal_jan(5,:,:)
SIFi_Stan_anomal_jan_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_jan_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_feb_2012=SIFi_Stan_anomal_feb(5,:,:)
SIFi_Stan_anomal_feb_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_feb_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_march_2012=SIFi_Stan_anomal_march(5,:,:)
SIFi_Stan_anomal_march_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_march_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_april_2012=SIFi_Stan_anomal_april(5,:,:)
SIFi_Stan_anomal_april_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_april_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_may_2012=SIFi_Stan_anomal_may(5,:,:)
SIFi_Stan_anomal_may_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_may_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_june_2012=SIFi_Stan_anomal_june(5,:,:)
SIFi_Stan_anomal_june_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_june_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_july_2012=SIFi_Stan_anomal_july(5,:,:)
SIFi_Stan_anomal_july_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_july_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_august_2012=SIFi_Stan_anomal_august(5,:,:)
SIFi_Stan_anomal_august_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_august_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_sep_2012=SIFi_Stan_anomal_sep(5,:,:)
SIFi_Stan_anomal_sep_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_sep_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_oct_2012=SIFi_Stan_anomal_oct(5,:,:)
SIFi_Stan_anomal_oct_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_oct_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_nov_2012=SIFi_Stan_anomal_nov(5,:,:)
SIFi_Stan_anomal_nov_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_nov_2012&lon@units = "degrees_east"
SIFi_Stan_anomal_dec_2012=SIFi_Stan_anomal_dec(5,:,:)
SIFi_Stan_anomal_dec_2012&lat@units = "degrees_north"
 SIFi_Stan_anomal_dec_2012&lon@units = "degrees_east"

printVarSummary(SIFi_Stan_anomal_dec_2012)

delete([/a,V,yearr,size,nlat,nlon,ntime,lat,lon,stann/])

;=======================================================================================

;Load Monthly GPP data
a=addfile("<NetCDF File.nc>","r")

lat=a->lat
lon=a->lon 
gpp=a->Gpp
;gpp_d=gpp/80
;gpp_mm=gpp_d*30
;copy_VarCoords( gpp, gpp_mm)
;gpp_m=where(gpp_mm.eq.0,gpp_mm@_FillValue,gpp_mm)
;copy_VarCoords(gpp_mm,gpp_m)


;printVarSummary(gpp_m)



GPP=gpp(:,closest_val(25.55,lat):closest_val(49.45,lat),closest_val(-120.05,lon):closest_val(-80.05,lon))

  GPP_Ave=dim_avg_n_Wrap( GPP, (/1,2/))

 GPPi=GPP(0:227,:,:)
 GPPi_monthly_climatology=clmMonTLL( GPPi)
 GPPi_monthly_anomalies=calcMonAnomTLL( GPPi, GPPi_monthly_climatology)
  GPPi_anomal= GPPi_monthly_anomalies
GPP_STD_Clim=stdMonTLL(GPPi)

  GPPi_anomall=dim_avg_n_Wrap( GPPi_anomal, (/1,2/))



;Stan Anomally------------------------------------------------------------

size=dimsizes( GPPi)
ntime=size(0)
nlat=size(1)
nlon=size(2)
stann=new((/dimsizes(GPPi&time),dimsizes(GPPi&lat),dimsizes(GPPi&lon)/),"float")
copy_VarCoords(GPPi(0:ntime-1,:,:), stann)
stann@_FillValue=stann@_FillValue
printVarSummary(stann)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
;print(bbb)
do itime=0,ntime-1,1
;print(ttt)
if (yearr .ge. 12) then
if (all((ismissing(GPPi(0:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(GPPi(0:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(GPPi(0:ntime-1:12,aaa,bbb)) .eq. 0) then 
stann(ttt,aaa,bbb)=stann@_FillValue
else 
V=doubletofloat((GPPi(ttt,aaa,bbb)-avg(GPPi(0:ntime-1:12,aaa,bbb)))/(stddev(GPPi(0:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
yearr=0
else if (yearr .lt. 12) then
if (all((ismissing(GPPi(yearr:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(GPPi(yearr:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(GPPi(yearr:ntime-1:12,aaa,bbb)) .eq. 0) then
stann(ttt,aaa,bbb)=stann@_FillValue
else
V=doubletofloat((GPPi(ttt,aaa,bbb)-avg(GPPi(yearr:ntime-1:12,aaa,bbb)))/(stddev(GPPi(yearr:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
end if
end if
ttt=ttt+1
yearr=yearr+1
end do 
ttt=0
yearr=0
bbb=bbb+1
end do
bbb=0
aaa=aaa+1
end do

GPPi_Stan_anomal=stann*(1)
copy_VarCoords( stann, GPPi_Stan_anomal)
;------------------------------------------------------


;Monthly

 GPPi_Stan_anomal_jan= GPPi_Stan_anomal(0:227:12,:,:)
 GPPi_Stan_anomal_feb= GPPi_Stan_anomal(1:227:12,:,:)
 GPPi_Stan_anomal_march= GPPi_Stan_anomal(2:227:12,:,:)
 GPPi_Stan_anomal_april= GPPi_Stan_anomal(3:227:12,:,:)
 GPPi_Stan_anomal_may= GPPi_Stan_anomal(4:227:12,:,:)
 GPPi_Stan_anomal_june= GPPi_Stan_anomal(5:227:12,:,:)
 GPPi_Stan_anomal_july= GPPi_Stan_anomal(6:227:12,:,:)
 GPPi_Stan_anomal_august= GPPi_Stan_anomal(7:227:12,:,:)
 GPPi_Stan_anomal_sep= GPPi_Stan_anomal(8:227:12,:,:)
 GPPi_Stan_anomal_oct= GPPi_Stan_anomal(9:227:12,:,:)
 GPPi_Stan_anomal_nov= GPPi_Stan_anomal(10:227:12,:,:)
 GPPi_Stan_anomal_dec= GPPi_Stan_anomal(11:227:12,:,:)

 GPPi_Stan_anomal_jan_2012= GPPi_Stan_anomal_jan(11,:,:)
GPPi_Stan_anomal_jan_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_jan_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_feb_2012=GPPi_Stan_anomal_feb(11,:,:)
GPPi_Stan_anomal_feb_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_feb_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_march_2012=GPPi_Stan_anomal_march(11,:,:)
GPPi_Stan_anomal_march_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_march_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_april_2012=GPPi_Stan_anomal_april(11,:,:)
GPPi_Stan_anomal_april_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_april_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_may_2012=GPPi_Stan_anomal_may(11,:,:)
GPPi_Stan_anomal_may_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_may_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_june_2012=GPPi_Stan_anomal_june(11,:,:)
GPPi_Stan_anomal_june_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_june_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_july_2012=GPPi_Stan_anomal_july(11,:,:)
GPPi_Stan_anomal_july_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_july_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_august_2012=GPPi_Stan_anomal_august(11,:,:)
GPPi_Stan_anomal_august_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_august_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_sep_2012=GPPi_Stan_anomal_sep(11,:,:)
GPPi_Stan_anomal_sep_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_sep_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_oct_2012=GPPi_Stan_anomal_oct(11,:,:)
GPPi_Stan_anomal_oct_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_oct_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_nov_2012=GPPi_Stan_anomal_nov(11,:,:)
GPPi_Stan_anomal_nov_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_nov_2012&lon@units = "degrees_east"
GPPi_Stan_anomal_dec_2012=GPPi_Stan_anomal_dec(11,:,:)
GPPi_Stan_anomal_dec_2012&lat@units = "degrees_north"
 GPPi_Stan_anomal_dec_2012&lon@units = "degrees_east"

printVarSummary(GPPi_Stan_anomal_dec_2012)


delete([/a,V,yearr,size,nlat,nlon,ntime,lat,lon,stann/])


;========================================================================================
;Load Monthly temp data
a=addfile("<NetCDF File.nc>","r")
lat=a->lat
lon=a->lon 
Tavee=a->Tave


 
Tave=Tavee(0:227,closest_val(24.55,lat):closest_val(49.45,lat),closest_val(-120.05,lon):closest_val(-80.05,lon))
  Tave_Ave=dim_avg_n_Wrap( Tave, (/1,2/))

 Tavei=Tave(:,:,:)
 Tavei_monthly_climatology=clmMonTLL( Tavei)
 Tavei_monthly_anomalies=calcMonAnomTLL( Tavei, Tavei_monthly_climatology)
  Tavei_anomal= Tavei_monthly_anomalies
  Tavei_anomall=dim_avg_n_Wrap( Tavei_anomal, (/1,2/))
Tavei_monthly__std=stdMonTLL(Tavei)
 Tavei_stdAve=dim_avg_n_Wrap(Tavei_monthly__std, (/1,2/))




;Stan Anomally------------------------------------------------------------

size=dimsizes( Tavei)
ntime=size(0)
nlat=size(1)
nlon=size(2)
stann=new((/dimsizes(Tavei&time),dimsizes(Tavei&lat),dimsizes(Tavei&lon)/),"float")
copy_VarCoords(Tavei(0:ntime-1,:,:), stann)
stann@_FillValue=stann@_FillValue
printVarSummary(stann)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
;print(bbb)
do itime=0,ntime-1,1
;print(ttt)
if (yearr .ge. 12) then
if (all((ismissing(Tavei(0:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(Tavei(0:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(Tavei(0:ntime-1:12,aaa,bbb)) .eq. 0) then 
stann(ttt,aaa,bbb)=stann@_FillValue
else 
V=doubletofloat((Tavei(ttt,aaa,bbb)-avg(Tavei(0:ntime-1:12,aaa,bbb)))/(stddev(Tavei(0:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
yearr=0
else if (yearr .lt. 12) then
if (all((ismissing(Tavei(yearr:ntime-1:12,aaa,bbb))))) then
stann(ttt,aaa,bbb)=stann@_FillValue
;print("missing value")
else if ((.not.all((ismissing(Tavei(yearr:ntime-1:12,aaa,bbb)))))) then
;else
if (stddev(Tavei(yearr:ntime-1:12,aaa,bbb)) .eq. 0) then
stann(ttt,aaa,bbb)=stann@_FillValue
else
V=doubletofloat((Tavei(ttt,aaa,bbb)-avg(Tavei(yearr:ntime-1:12,aaa,bbb)))/(stddev(Tavei(yearr:ntime-1:12,aaa,bbb))))
stann(ttt,aaa,bbb)=V
end if
end if
end if
end if
end if
ttt=ttt+1
yearr=yearr+1
end do 
ttt=0
yearr=0
bbb=bbb+1
end do
bbb=0
aaa=aaa+1
end do

Tavei_Stan_anomal=stann*(1)
copy_VarCoords( stann, Tavei_Stan_anomal)
;------------------------------------------------------

;Monthly

 Tavei_Stan_anomal_jan= Tavei_Stan_anomal(0:227:12,:,:)
 Tavei_Stan_anomal_feb= Tavei_Stan_anomal(1:227:12,:,:)
 Tavei_Stan_anomal_march= Tavei_Stan_anomal(2:227:12,:,:)
 Tavei_Stan_anomal_april= Tavei_Stan_anomal(3:227:12,:,:)
 Tavei_Stan_anomal_may= Tavei_Stan_anomal(4:227:12,:,:)
 Tavei_Stan_anomal_june= Tavei_Stan_anomal(5:227:12,:,:)
 Tavei_Stan_anomal_july= Tavei_Stan_anomal(6:227:12,:,:)
 Tavei_Stan_anomal_august= Tavei_Stan_anomal(7:227:12,:,:)
 Tavei_Stan_anomal_sep= Tavei_Stan_anomal(8:227:12,:,:)
 Tavei_Stan_anomal_oct= Tavei_Stan_anomal(9:227:12,:,:)
 Tavei_Stan_anomal_nov= Tavei_Stan_anomal(10:227:12,:,:)
 Tavei_Stan_anomal_dec= Tavei_Stan_anomal(11:227:12,:,:)

 Tavei_Stan_anomal_jan_2012= Tavei_Stan_anomal_jan(12,:,:)
Tavei_Stan_anomal_jan_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_jan_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_feb_2012=Tavei_Stan_anomal_feb(12,:,:)
Tavei_Stan_anomal_feb_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_feb_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_march_2012=Tavei_Stan_anomal_march(12,:,:)
Tavei_Stan_anomal_march_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_march_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_april_2012=Tavei_Stan_anomal_april(12,:,:)
Tavei_Stan_anomal_april_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_april_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_may_2012=Tavei_Stan_anomal_may(12,:,:)
Tavei_Stan_anomal_may_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_may_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_june_2012=Tavei_Stan_anomal_june(12,:,:)
Tavei_Stan_anomal_june_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_june_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_july_2012=Tavei_Stan_anomal_july(12,:,:)
Tavei_Stan_anomal_july_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_july_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_august_2012=Tavei_Stan_anomal_august(12,:,:)
Tavei_Stan_anomal_august_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_august_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_sep_2012=Tavei_Stan_anomal_sep(12,:,:)
Tavei_Stan_anomal_sep_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_sep_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_oct_2012=Tavei_Stan_anomal_oct(12,:,:)
Tavei_Stan_anomal_oct_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_oct_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_nov_2012=Tavei_Stan_anomal_nov(12,:,:)
Tavei_Stan_anomal_nov_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_nov_2012&lon@units = "degrees_east"
Tavei_Stan_anomal_dec_2012=Tavei_Stan_anomal_dec(12,:,:)
Tavei_Stan_anomal_dec_2012&lat@units = "degrees_north"
 Tavei_Stan_anomal_dec_2012&lon@units = "degrees_east"