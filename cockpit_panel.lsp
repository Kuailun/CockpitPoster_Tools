(defun c:mPanel1( / originPoint width height)

  	(setq os (getvar "OSMODE"))                  ;; Save OSNAP mode
  	(setvar "OSMODE" 0)                          ;; Turn off OSNAP
	
	(setq panelRadius (getreal "\nEnter Radius"))
	(setq holeH (getreal "\nEnter Hole Horizontal"))
	(setq holeV (getreal "\nEnter Hole Vertical"))
	
	
	
	
	;缁樺埗榛勮壊澶栨
	(command-s "layer" "s" "Panel-1" "")
	(setq originPoint (getpoint "\nEnter a center point: "))
	(setq width (getdist originPoint "\nEnter the width: "))
	(setq height (getdist originPoint "\nEnter the height: "))
	(command-s "._rectangle" originPoint (list(+(car originPoint)width)(+(cadr originPoint)height)))
	
	;缁樺埗铻洪拤	
	(setq pt10 (polar originPoint 0 (+ 5 holeH)))
	(setq pt11 (polar pt10 (/ pi 2) (+ 5 holeV)))		
	(setq pt21 (polar pt11 (/ pi 2) (- height (*(+ 5 holeV)2))))
	(setq pt31 (polar pt11 0 (- width (*(+ 5 holeH)2))))
	(setq pt41 (polar pt21 0 (- width (*(+ 5 holeH)2))))
		
	(command-s "layer" "s" "Hole" "")
	(command-s "._circle" pt11 "3")
	(command-s "._circle" pt21 "3")
	(command-s "._circle" pt31 "3")
	(command-s "._circle" pt41 "3")
	
	(command-s "layer" "s" "Aid" "")
	(command-s "._circle" pt11 "4.5")
	(command-s "._circle" pt21 "4.5")
	(command-s "._circle" pt31 "4.5")
	(command-s "._circle" pt41 "4.5")
	
	;鍋忕Щ缁胯壊澶栨
	(command-s "layer" "s" "Panel-2" "")
	
	(setq tempRH (+ 9.5 holeH))
	(setq tempRV (+ 9.5 holeV))
	
	(setq pt0010 (polar originPoint 0 (+ tempRH 1)))

  	(setq pt0011 (polar pt0010 (/ pi 2) 1))										;Point 1	
	(setq pt0012 (polar pt0011 0 (-(/ width 2) (+ tempRH 1))))					;Point 1-1		
	(setq pt0021 (polar pt0011 0 (- width (+(* tempRH 2)2))))					;Point 2
	(setq pt0031 (polar pt0021 (/ pi 2) tempRV))								;Point 3
	(setq pt0041 (polar pt0031 0 tempRH))										;Point 4	
	(setq pt0042 (polar pt0041 (/ pi 2) (-(/ height 2) (+ tempRV 1))))			;Point 4-1	
	(setq pt0051 (polar pt0041 (/ pi 2) (- height (+(* tempRV 2)2))))			;Point 5
	(setq pt0061 (polar pt0051 pi tempRH))										;Point 6
	(setq pt0071 (polar pt0061 (/ pi 2) tempRV))								;Point 7
	(setq pt0072 (polar pt0071 pi (/ (- width (* tempRH 2)) 2)))				;Point 7-1
  	(setq pt0081 (polar pt0071 pi (- width 21)))						;Point 8
	(setq pt0091 (polar pt0081 (* (/ pi 2) -1) 9.5))					;Point 9
	(setq pt0101 (polar pt0091 pi 9.5))									;Point 10
	(setq pt0102 (polar pt0101 (* (/ pi 2) -1) (/ (- height 21) 2)))	;Point 10-1
  	(setq pt0111 (polar pt0101 (* (/ pi 2) -1) (- height 21)))			;Point 11
	(setq pt0121 (polar pt0111 0 9.5))									;Point 12
	
	(setq midpoint (polar (polar originPoint 0 (/ width 2)) (/ pi 2) (/ height 2)))
	
	;缁樺埗绾挎
	(command-s "line" pt0012 pt0021 "")
	(setq l1 (entlast))							;Line 1
	(command-s "pline" pt0021 pt0031 pt0041 "") 
	(setq l2 (entlast))							;Line 2
	(command-s "line" pt0041 pt0042 "")
	(setq l3 (entlast))							;Line 3
	(command-s "line" pt0042 pt0051 "")
	(setq l4 (entlast))							;Line 4
	(command-s "pline" pt0051 pt0061 pt0071 "") 
	(setq l5 (entlast))							;Line 5
	(command-s "line" pt0071 pt0072 "")
	(setq l6 (entlast))							;Line 6

	;缁樺埗鍦嗚
	(setvar "filletrad" 5.5)
	(command-s "_fillet" "p" l2)
	(command-s "_fillet" "p" l5)
	(setvar "filletrad" panelRadius)
	(command-s "_fillet" l1 l2)
	(command-s "_fillet" l2 l3)
	(command-s "_fillet" l4 l5)
	(command-s "_fillet" l5 l6)
	
	;闀滃儚
	(command-s "_mirror" l1 l2 l3 l4 l5 l6 "" pt0012 (polar pt0012 (/ pi 2) 1) "n")
	
	(setvar "OSMODE" 1447)                          ;; Turn on OSNAP
)



(defun c:mPanel2()

  	(setq os (getvar "OSMODE"))                  ;; Save OSNAP mode
  	(setvar "OSMODE" 0)                          ;; Turn off OSNAP
	
	(setq panelRadius (getreal "\nEnter Radius"))
	(setq holeV (getreal "\nEnter Hole Vertical"))
		
	;缁樺埗榛勮壊澶栨
	(command-s "layer" "s" "Panel-1" "")
	(setq originPoint (getpoint "\nEnter a center point: "))
	(setq width (getdist originPoint "\nEnter the width: "))
	(setq height (getdist originPoint "\nEnter the height: "))
	(command-s "._rectangle" originPoint (list(+(car originPoint)width)(+(cadr originPoint)height)))
	
	;缁樺埗铻洪拤	
	(setq pt10 (polar originPoint 0 5))
	(setq pt11 (polar pt10 (/ pi 2) (+ 12.5 holeV)))		
	(setq pt21 (polar pt11 (/ pi 2) (- height (*(+ 12.5 holeV)2))))
	(setq pt31 (polar pt11 0 (- width 10)))
	(setq pt41 (polar pt21 0 (- width 10)))
		
	(command-s "layer" "s" "Hole" "")
	(command-s "._circle" pt11 "3")
	(command-s "._circle" pt21 "3")
	(command-s "._circle" pt31 "3")
	(command-s "._circle" pt41 "3")
	
	(command-s "layer" "s" "Aid" "")
	(command-s "._circle" pt11 "4.5")
	(command-s "._circle" pt21 "4.5")
	(command-s "._circle" pt31 "4.5")
	(command-s "._circle" pt41 "4.5")
	
	;鍋忕Щ缁胯壊澶栨
	(command-s "layer" "s" "Panel-2" "")
		
	(setq pt0010 (polar originPoint 0 1))

  	(setq pt0011 (polar pt0010 (/ pi 2) 1))										;Point 1	
	(setq pt0012 (polar pt0011 0 (-(/ width 2) 1)))								;Point 1-1		
	(setq pt0021 (polar pt0011 0 (- width 2)))									;Point 2
	(setq pt0031 (polar pt0021 (/ pi 2) (+ 6 holeV)))							;Point 3
	(setq pt0032 (polar pt0031 pi 3))											;Point 3-1
	(setq pt0041 (polar pt0031 pi 9.5))											;Point 4	
	(setq pt0051 (polar pt0041 (/ pi 2) 11))									;Point 5
	(setq pt0052 (polar pt0051 0 6.5	))										;Point 5-1
	(setq pt0061 (polar pt0051 0 9.5	))										;Point 6	
	(setq pt0071 (polar pt0061 (/ pi 2) (- height (+ 36 (* 2 holeV)))))			;Point 7
	(setq pt0072 (polar pt0071 pi 3))											;Point 7-1
  	(setq pt0081 (polar pt0071 pi 9.5))											;Point 8
	(setq pt0091 (polar pt0081 (/ pi 2) 11))									;Point 9
	(setq pt0092 (polar pt0091 0 6.5))											;Point 9-2
	(setq pt0101 (polar pt0091 0 9.5))											;Point 10
  	(setq pt0111 (polar pt0101 (/ pi 2) (+ 6 holeV)))							;Point 11
	(setq pt0112 (polar pt0111 pi (-(/ width 2) 1)))							;Point 11-1
	
	;缁樺埗绾挎
	(command-s "pline" pt0012 pt0021 pt0031 pt0032 "")
	(setq l1 (entlast))							;Line 1
	(command-s "pline" pt0032 pt0041 pt0051 pt0052 "") 
	(setq l2 (entlast))							;Line 2
	(command-s "pline" pt0052 pt0061 pt0071 pt0072 "")
	(setq l3 (entlast))							;Line 3
	(command-s "pline" pt0072 pt0081 pt0091 pt0092 "")
	(setq l4 (entlast))							;Line 4
	(command-s "pline" pt0092 pt0101 pt0111 pt0112 "") 
	(setq l5 (entlast))							;Line 5

	;缁樺埗鍦嗚
	
	(setvar "filletrad" panelRadius)
	(command-s "_fillet" "p" l1)
	(command-s "_fillet" "p" l3)
	(command-s "_fillet" "p" l5)
	
	(setvar "filletrad" 5.5)
	(command-s "_fillet" "p" l2)
	(command-s "_fillet" "p" l2 l3)
	(command-s "_fillet" "p" l3 l4)
	(command-s "_fillet" "p" l4 l5)
	
	;闀滃儚
	(command-s "_mirror" l1 l2 l3 l4 l5 "" pt0012 (polar pt0012 (/ pi 2) 1) "n")
	
	(setvar "OSMODE" 1447)                          ;; Turn on OSNAP
  ;1-端点
  ;2-中点
  ;4-圆心
  ;8-节点
  ;16-象限点
  ;32-交点
  ;64-插入
  ;128-垂足
  ;256-切点
  ;512-最近点
  ;1024-几何中心
  ;2048-外观交点
  ;4196-
  
  
)

(defun c:mSave()
	(setq drawingName (getstring "\nEnter Name"))
	(setq drawingPath "E:\\A350-MIP-")
	(command "LAYER" "OFF" "*" "Y" "")
	
	(command "LAYER" "ON" "Panel-1" "")
	(setvar "cmdecho" 0)
	(setvar "filedia" 0)
	(command "SAVEAS" "2010" (strcat drawingPath drawingName "-1"))
	(setvar "filedia" 1)
	(setvar "cmdecho" 1)
	(command "LAYER" "OFF" "*" "Y" "")
	
	(command "LAYER" "ON" "Panel-2" "")
	(setvar "cmdecho" 0)
	(setvar "filedia" 0)
	(command "SAVEAS" "2013" (strcat drawingPath drawingName "-2"))
	(setvar "filedia" 1)
	(setvar "cmdecho" 1)
	(command "LAYER" "OFF" "*" "Y" "")
	
	(command "LAYER" "ON" "Aid" "")
	(setvar "cmdecho" 0)
	(setvar "filedia" 0)
	(command "SAVEAS" "2013" (strcat drawingPath drawingName "-3"))
	(setvar "filedia" 1)
	(setvar "cmdecho" 1)
	(command "LAYER" "OFF" "*" "Y" "")
	
	(command "LAYER" "ON" "Hole" "")
	(setvar "cmdecho" 0)
	(setvar "filedia" 0)
	(command "SAVEAS" "2013" (strcat drawingPath drawingName "-4"))
	(setvar "filedia" 1)
	(setvar "cmdecho" 1)
	(command "LAYER" "OFF" "*" "Y" "")
	
	(command "LAYER" "ON" "Position" "")
	(setvar "cmdecho" 0)
	(setvar "filedia" 0)
	(command "SAVEAS" "2013" (strcat drawingPath drawingName "-5"))
	(setvar "filedia" 1)
	(setvar "cmdecho" 1)
	
	;(command "LAYER" "ON" "*" "Y" "")
	(princ)
)