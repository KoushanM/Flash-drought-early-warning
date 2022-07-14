
 a=addfile("SIF_8days_US_0.5degree_hi2lores_Wrap_WITHTIME_46_week_GOD-HELP-ME_2007_2018.nc","r")

lattt=a&lat
lonnn=a&lon
SIF=a->SIF(:,closest_val(25.55,lattt):closest_val(49.45,lattt),closest_val(-120.55,lonnn):closest_val(-80.55,lonnn)) 
size=dimsizes(SIF)
ntime=size(0)
nlat=size(1)
nlon=size(2)
corr=new((/dimsizes(SIF&time),dimsizes(SIF&lat),dimsizes(SIF&lon)/),"float")
copy_VarCoords(SIF(0:ntime-1,:,:), corr)
corr@_FillValue=SIF@_FillValue
printVarSummary(corr)
aaa=0
bbb=0
ttt=0
yearr=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
do itime=0,ntime-1,1
if (ttt .eq.0) then 
corr(ttt,aaa,bbb)=SIF@_FillValue
else 
if (yearr .ge.  46) then
if (all((ismissing(SIF(0:ntime-1: 46,aaa,bbb)))) .or. all((ismissing(SIF(yearr-1:ntime-1: 46,aaa,bbb))))) then
corr(ttt,aaa,bbb)=SIF@_FillValue
else if (all(ismissing(SIF(0:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))) then
corr(ttt,aaa,bbb)=SIF@_FillValue
else if ((.not.all((ismissing(SIF(0:ntime-1: 46,aaa,bbb))))) .and. (.not.all((ismissing(SIF(yearr-1:ntime-1: 46,aaa,bbb)))))) then
if (stddev(SIF(0:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)) .eq. 0) then 
corr(ttt,aaa,bbb)=SIF@_FillValue
else 
V=(SIF(ttt,aaa,bbb)-SIF(ttt-1,aaa,bbb)-avg(SIF(0:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))/(stddev(SIF(0:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))
corr(ttt,aaa,bbb)=V
end if
end if
end if
end if
yearr=0

else if (yearr .lt.  46) then
if (all((ismissing(SIF(yearr:ntime-1:46,aaa,bbb)))) .or. all((ismissing(SIF(yearr-1:ntime-1: 46,aaa,bbb))))) then
corr(ttt,aaa,bbb)=SIF@_FillValue
else if (all(ismissing(SIF(yearr:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))) then
corr(ttt,aaa,bbb)=SIF@_FillValue
else if ((.not.all((ismissing(SIF(yearr:ntime-1: 46,aaa,bbb))))) .and. (.not.all((ismissing(SIF(yearr-1:ntime-1: 46,aaa,bbb)))))) then
if (stddev(SIF(yearr:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)) .eq. 0) then
corr(ttt,aaa,bbb)=SIF@_FillValue
else
V=(SIF(ttt,aaa,bbb)-SIF(ttt-1,aaa,bbb)-avg(SIF(yearr:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))/(stddev(SIF(yearr:ntime-1: 46,aaa,bbb)-SIF(yearr-1:ntime-1: 46,aaa,bbb)))
corr(ttt,aaa,bbb)=V
end if
end if
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

delete(V)
V=corr


;RCI------------------------------------------------------

RCI=new((/dimsizes(V&time),dimsizes(V&lat),dimsizes(V&lon)/),"float")
copy_VarCoords(V, RCI)
RCI@_FillValue=V@_FillValue
printVarSummary(RCI)

aaa=0
bbb=0
ttt=0
do ilat=0,nlat-1,1
print(aaa)
do ilon=0,nlon-1,1
do itime=0,ntime-1,1
if (ttt .eq. 0) then
rci=V@_FillValue
else if (ttt .eq. 1) then
if (all((ismissing(V(ttt,aaa,bbb)))))  then
rci=V@_FillValue
else if ((.not.all((ismissing(V(ttt,aaa,bbb)))))) then
if (V(ttt,aaa,bbb) .gt. 0.75) then
rci=0 + sqrt(V(ttt,aaa,bbb)-0.75)
else if (V(ttt,aaa,bbb) .lt. -0.75) then
rci=0- sqrt(abs(V(ttt,aaa,bbb))-0.75)
;print("sefre_K")
else
rci=0
end if
end if
end if
end if
else if(ttt .gt. 1) then
if (all((ismissing(V(ttt,aaa,bbb)))) .or. all((ismissing(V(ttt-1,aaa,bbb))))) then
rci=V@_FillValue
else if ((.not.all((ismissing(V(ttt,aaa,bbb))))) .and. (.not.all((ismissing(V(ttt-1,aaa,bbb)))))) then
if (V(ttt,aaa,bbb)/(V(ttt-1,aaa,bbb)+0.00001) .gt.0) then
if (V(ttt,aaa,bbb) .gt. 0.75) then
rci=RCI(ttt-1,aaa,bbb) + sqrt(V(ttt,aaa,bbb)-0.75)
else if (V(ttt,aaa,bbb) .lt. -0.75) then
rci=RCI(ttt-1,aaa,bbb)- sqrt(abs(V(ttt,aaa,bbb))-0.75)
else
rci=RCI(ttt-1,aaa,bbb)
end if
end if
else if (V(ttt,aaa,bbb)/(V(ttt-1,aaa,bbb)+0.00001) .lt. 0) then
rci=0
end if
end if
end if
end if
end if
end if
end if
RCI(ttt,aaa,bbb)=rci
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


tiimee=RCI&time
rci_2012=RCI(closest_val(15432,tiimee):closest_val(15576,tiimee),:,:)
rci_2017=RCI(closest_val(17259,tiimee):closest_val(17403,tiimee),:,:)





;plot ----------------------------------------------------------------------

wks = gsn_open_wks("png","RCI_sif_WITHTIME_2012_area_hi2lores_Wrap")
 nplot    = 20
  plot     = new(nplot,graphic)

 reshh                      = True
  reshh@gsnDraw              = False
  reshh@gsnFrame             = False

  reshh@cnLinesOn            = False
  reshh@cnLineLabelsOn       = False
  reshh@cnFillOn             = True

 rci_2012&lat@units = "degrees_north"
 rci_2012&lon@units = "degrees_east"

reshh@tmXBLabelFontHeightF = 0.0275
reshh@tmYLLabelFontHeightF = 0.0275

;reshh@cnFillPalette        = "hotcold_18lev"   ; choose color RCI
reshh@cnFillPalette        = "BlueWhiteOrangeRed"   ; choose color RCI
reshh@gsnAddCyclic = False
reshh@mpMinLatF    = min(rci_2012&lat) - 0.1
 reshh@mpMaxLatF    = max(rci_2012&lat) + 0.1
  reshh@mpMinLonF    = min(rci_2012&lon) - 0.1
  reshh@mpMaxLonF    = max(rci_2012&lon) + 0.1
  reshh@lbLabelBarOn         = False               ; turn off labelbar

reshh@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  reshh@cnLevels    = (/ -2.75, -2.25,-1.75,-1.25,-0.75,-0.25,0.25,0.75,1.25,1.75,2.25,2.75/)   ; set levels

   reshh@cnFillColors = (/ 2,13,29,45,59,74,120,168,174,190,209,227,240/)  ; set the colors to be used
 
reshh@lbLabelBarOn         = False               ; turn off labelbar

reshh@cnConstFEnableFill=True
reshh@mpOutlineBoundarySets       = "USStates" 
tiimee=RCI&time

reshh@tiMainString  = "April 2"
 reshh@tiMainFontHeightF = 0.035 
 plot_April_2  = gsn_csm_contour_map( wks,rci_2012(0,:,:), reshh)

reshh@tiMainString = "April 10"
 plot_April_10  = gsn_csm_contour_map( wks,rci_2012(1,:,:), reshh)

reshh@tiMainString = "April 18"
 plot_April_18  = gsn_csm_contour_map( wks,rci_2012(2,:,:), reshh)

reshh@tiMainString = "April 26"
 plot_April_26  = gsn_csm_contour_map( wks,rci_2012(3,:,:), reshh)

reshh@tiMainString = "May 4"
 plot_May_4  = gsn_csm_contour_map( wks,rci_2012(4,:,:), reshh)

reshh@tiMainString = "May 12"
 plot_May_12  = gsn_csm_contour_map( wks,rci_2012(5,:,:), reshh)

reshh@tiMainString = "May 20"
 plot_May_20  = gsn_csm_contour_map( wks,rci_2012(6,:,:), reshh)

reshh@tiMainString = "May 28"
 plot_May_28  = gsn_csm_contour_map( wks,rci_2012(7,:,:), reshh)


reshh@tiMainString = "June 5"
 plot_June_5  = gsn_csm_contour_map( wks,rci_2012(8,:,:), reshh)

reshh@tiMainString = "June 13"
 plot_June_13  = gsn_csm_contour_map( wks,rci_2012(9,:,:), reshh)

reshh@tiMainString = "June 21"
 plot_June_21  = gsn_csm_contour_map( wks,rci_2012(10,:,:), reshh)

reshh@tiMainString = "June 29"
 plot_June_29  = gsn_csm_contour_map( wks,rci_2012(11,:,:), reshh)

reshh@tiMainString = "July 7"
 plot_July_7  = gsn_csm_contour_map( wks,rci_2012(12,:,:), reshh)

reshh@tiMainString = "July 15"
 plot_July_15  = gsn_csm_contour_map( wks,rci_2012(13,:,:), reshh)

reshh@tiMainString = "July 23"
 plot_July_23  = gsn_csm_contour_map( wks,rci_2012(14,:,:), reshh)

reshh@tiMainString = "July 31"
 plot_July_31  = gsn_csm_contour_map( wks,rci_2012(15,:,:), reshh)


reshh@tiMainString = "August 8"
 plot_August_8  = gsn_csm_contour_map( wks,rci_2012(16,:,:), reshh)

reshh@tiMainString = "August 16"
 plot_August_16  = gsn_csm_contour_map( wks,rci_2012(17,:,:), reshh)

reshh@tiMainString = "August 24"
 plot_August_24  = gsn_csm_contour_map( wks,rci_2012(18,:,:), reshh)





 plot(0)= plot_April_2
 plot(1)= plot_April_10
 plot(2)= plot_April_18
 plot(3)= plot_April_26
 plot(4)= plot_May_4 
 plot(5)= plot_May_12
 plot(6)= plot_May_20
 plot(7)= plot_May_28
 plot(8)=plot_June_5
 plot(9)=plot_June_13
 plot(10)=plot_June_21
 plot(11)=plot_June_29

plot(12)=  plot_July_7 
 plot(13)=  plot_July_15
 plot(14)= plot_July_23
 plot(15)= plot_July_31
 plot(16)=plot_August_8
 plot(17)=plot_August_16

 plot(18)=plot_August_24



pres                         = True
  ;pres@gsnFrame                = False    ; Turn off so we can add titles

  pres@gsnPanelSave            = False     ; Don't resize plots back to original size after done

; pres@gsnPanelTop             = 0.95     ; Default is 1.0; may need to change to make room for titles

  pres@gsnPanelLabelBar        = True
  pres@pmLabelBarWidthF        = 0.8



pres@pmLabelBarOrthogonalPosF   =  -0.01
 pres@lbLabelFontHeightF = 0.0125

gsn_panel(wks,plot,(/5,4/),pres)

 frame(wks)  




delete(wks)
 delete(reshh)
 delete(plot)

delete(pres)



;plot _2017----------------------------------------------------------------------

wks = gsn_open_wks("eps","RCIsif_WITHTIME_2017_area_hi2lores_Wrap") 
nplot    = 20
  plot     = new(nplot,graphic)

 reshh                      = True
  reshh@gsnDraw              = False
  reshh@gsnFrame             = False

  reshh@cnLinesOn            = False
  reshh@cnLineLabelsOn       = False
  reshh@cnFillOn             = True

;reshh@gsnMaximize  = True
;reshh@cnFillOn     = True
;reshh@cnLinesOn    = False

 rci_2017&lat@units = "degrees_north"
 rci_2017&lon@units = "degrees_east"


reshh@tmXBLabelFontHeightF = 0.0275
reshh@tmYLLabelFontHeightF = 0.0275


reshh@cnFillPalette        = "hotcold_18lev"   ; choose color RCI
reshh@cnFillPalette        = "BlueWhiteOrangeRed"   ; choose color RCI
reshh@gsnAddCyclic = False
reshh@mpMinLatF    = min(rci_2017&lat) - 0.1
 reshh@mpMaxLatF    = max(rci_2017&lat) + 0.1
  reshh@mpMinLonF    = min(rci_2017&lon) - 0.1
  reshh@mpMaxLonF    = max(rci_2017&lon) + 0.1

  reshh@lbLabelBarOn         = False               ; turn off labelbar


reshh@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  reshh@cnLevels    = (/ -2.75, -2.25,-1.75,-1.25,-0.75,-0.25,0.25,0.75,1.25,1.75,2.25,2.75/)   ; set levels
 
   reshh@cnFillColors = (/ 2,13,29,45,59,74,120,168,174,190,209,227,240/)  ; set the colors to be used
    
  ;plot2018 = gsn_csm_contour_map(wks,RCI(6,:,:),reshh)


reshh@cnConstFEnableFill=True
reshh@mpOutlineBoundarySets       = "USStates" 
tiimee=RCI&time




reshh@tiMainString = "April 3"
 reshh@tiMainFontHeightF = 0.035 
 plot_April_2  = gsn_csm_contour_map( wks,rci_2017(0,:,:), reshh)

reshh@tiMainString = "April 11"
 plot_April_10  = gsn_csm_contour_map( wks,rci_2017(1,:,:), reshh)

reshh@tiMainString = "April 19"
 plot_April_18  = gsn_csm_contour_map( wks,rci_2017(2,:,:), reshh)

reshh@tiMainString = "April 27"
 plot_April_26  = gsn_csm_contour_map( wks,rci_2017(3,:,:), reshh)

reshh@tiMainString = "May 5"
 plot_May_4  = gsn_csm_contour_map( wks,rci_2017(4,:,:), reshh)

reshh@tiMainString = "May 13"
 plot_May_12  = gsn_csm_contour_map( wks,rci_2017(5,:,:), reshh)

reshh@tiMainString = "May 21"
 plot_May_20  = gsn_csm_contour_map( wks,rci_2017(6,:,:), reshh)

reshh@tiMainString = "May 29"
 plot_May_28  = gsn_csm_contour_map( wks,rci_2017(7,:,:), reshh)



reshh@tiMainString = "June 6"
 plot_June_5  = gsn_csm_contour_map( wks,rci_2017(8,:,:), reshh)

reshh@tiMainString = "June 14"
 plot_June_13  = gsn_csm_contour_map( wks,rci_2017(9,:,:), reshh)

reshh@tiMainString = "June 22"
 plot_June_21  = gsn_csm_contour_map( wks,rci_2017(10,:,:), reshh)

reshh@tiMainString = "June 30"
 plot_June_29  = gsn_csm_contour_map( wks,rci_2017(11,:,:), reshh)

reshh@tiMainString = "July 8"
 plot_July_7  = gsn_csm_contour_map( wks,rci_2017(12,:,:), reshh)

reshh@tiMainString = "July 16"
 plot_July_15  = gsn_csm_contour_map( wks,rci_2017(13,:,:), reshh)

reshh@tiMainString = "July 24"
 plot_July_23  = gsn_csm_contour_map( wks,rci_2017(14,:,:), reshh)

reshh@tiMainString = "August 1"
 plot_July_31  = gsn_csm_contour_map( wks,rci_2017(15,:,:), reshh)


reshh@tiMainString = "August 9"
 plot_August_8  = gsn_csm_contour_map( wks,rci_2017(16,:,:), reshh)

reshh@tiMainString = "August 17"
 plot_August_16  = gsn_csm_contour_map( wks,rci_2017(17,:,:), reshh)

reshh@tiMainString = "August 25"
 plot_August_24  = gsn_csm_contour_map( wks,rci_2017(18,:,:), reshh)





 plot(0)= plot_April_2
 plot(1)= plot_April_10
 plot(2)= plot_April_18
 plot(3)= plot_April_26
 plot(4)= plot_May_4 
 plot(5)= plot_May_12
 plot(6)= plot_May_20
 plot(7)= plot_May_28
 plot(8)=plot_June_5
 plot(9)=plot_June_13
 plot(10)=plot_June_21
 plot(11)=plot_June_29

plot(12)=  plot_July_7 
 plot(13)=  plot_July_15
 plot(14)= plot_July_23
 plot(16)= plot_July_31
 plot(17)=plot_August_8
 plot(18)=plot_August_16

 plot(19)=plot_August_24



pres                         = True
  ;pres@gsnFrame                = False    ; Turn off so we can add titles

  pres@gsnPanelSave            = False     ; Don't resize plots back to original size after done

; pres@gsnPanelTop             = 0.95     ; Default is 1.0; may need to change to make room for titles

  pres@gsnPanelLabelBar        = True
  pres@pmLabelBarWidthF        = 0.8

pres@pmLabelBarOrthogonalPosF   =  -0.01
 pres@lbLabelFontHeightF = 0.0125




gsn_panel(wks,plot,(/5,4/),pres)

 frame(wks)  




delete(wks)
 delete(reshh)
 delete(plot)

delete(pres)



PPP
