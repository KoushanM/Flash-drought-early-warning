
iyear_start=
iyear_end=

;US domain
lat=fspan(24.25,49.75,52)
lat@units="degree_north"
lon=fspan(-125.25,-65.25,121)
lon@units="degree_east"
do iyear=iyear_start,iyear_end,1
year=sprinti("%4.0i",iyear)
print(year)
bbb=0
do imonth=1,46
smonth=sprinti("%0.2i",imonth)

; read the netcdf files
;For example: GOME_PK_dcSIF_005deg_8day_2009.nc

f1=addfile("GOME_PK_dcSIF_005deg_8day_"+(year)+".nc", "r")

lonn= f1->lon
SIF_112= short2flt(f1->SIF)
SIF_112 = SIF_112(:,::-1,:)
latt= SIF_112&lat
SIF_11 = SIF_112(bbb,closest_val(24.55,latt):closest_val(49.45,latt),closest_val(-125.05,lonn):closest_val(-65.05,lonn))



SIF_1=SIF_11

latsize=dimsizes(SIF_1&lat)
lonsize=dimsizes(SIF_1&lon)
SIF_time=conform_dims((/1,latsize(0),lonsize(0)/),SIF_1,(/1,2/))

delete(SIF_1)
SIF_1=SIF_time

;alocating time and specify the dimentions name
time=SIF_11@time
bbb=bbb+1
time!0= "time"
time@long_name = "year_8days"
time@units = "days since 1970-001- 00:00:00" 
lat!0="lat"
lon!0="lon"
SIF_1!0="time"
SIF_1!1="lat"
SIF_1!2="lon"
SIF_1&time=time
SIF_1&lat=SIF_11&lat
SIF_1&lon=SIF_11&lon

;convertion to new spatial resolution ---------------------------------------------------------------
opt = True
opt@critpc = 20
SIF  = area_hi2lores_Wrap (SIF_1&lon,SIF_1&lat, SIF_1 , True, 1,lon, lat, opt) 

latsize=dimsizes(SIF&lat)
lonsize=dimsizes(SIF&lon)

;create the netcdf file for each time step-----------------------------------------

print("creating netcdf")

fout=addfile("SIF_8days_US_0.5degree_hi2lores_Wrap_46_week_"+(year)+""+(smonth)+".nc","c")
fAtt               = True            ; assign file attributes
fAtt@title         = "SIF"  
fAtt@Conventions   = "None"   
fAtt@creation_date = systemfunc ("date")        
fileattdef( fout, fAtt )

print("predefine the coordinate variables") 
dimNames = (/"time","lat","lon"/)  
dimSizes = (/ -1,latsize(0),lonsize(0)/)
dimUnlim = (/True, False, False/)   
filedimdef(fout,dimNames,dimSizes,dimUnlim) 

print("predefine the the dimensionality of the variables")
filevardef(fout, "time" ,typeof(time),getvardims(time))
filevardef(fout, "lat"  ,typeof(lat),getvardims(lat))
filevardef(fout, "lon"  ,typeof(lon),getvardims(lon))
filevardef(fout, "SIF"  ,typeof(SIF),getvardims(SIF))

print("Copy attributes associated with each variable to the file")
filevarattdef(fout,"SIF",SIF)                           ; copy T attributes
filevarattdef(fout,"time" ,time)                    ; copy time attributes
filevarattdef(fout,"lat"  ,lat)                     ; copy lat attributes
filevarattdef(fout,"lon"  ,lon)                     ; copy lon attributes

print("output only the data values")
fout->time=(/time/)
fout->lat =(/lat/)
fout->lon =(/lon/)
fout->SIF =(/SIF/)
delete([/f1,SIF,SIF_1,SIF_112,fout,latt,SIF_11,lonn,SIF_time,time/])
print(smonth)
end do

print(year)
end do
