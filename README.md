WAITFOR($IN[1])


&ACCESS RVP
&REL 25
&PARAM EDITMASK = *
&PARAM TEMPLATE = C:\KRC\Roboter\Template\vorgabe
&PARAM DISKPATH = KRC:\R1\Program
DEF kritsanan98( )
    GLOBAL INTERRUPT DECL 3 WHEN $STOPMESS==TRUE DO IR_STOPM ( )
    INTERRUPT ON 3 
    BAS (#INITMOV,0 )
SPTP XHOME WITH $VEL_AXIS[1] = SVEL_JOINT(100.0), $TOOL = STOOL2(FHOME), $BASE = SBASE(FHOME.BASE_NO), $IPO_MODE = SIPO_MODE(FHOME.IPO_FRAME), $LOAD = SLOAD(FHOME.TOOL_NO), $ACC_AXIS[1] = SACC_JOINT(PDEFAULT), $APO = SAPO_PTP(PDEFAULT), $GEAR_JERK[1] = SGEAR_JERK(PDEFAULT), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)
XP22[counter] = XP22

FOR counter = 1 TO 3 STEP 1
   ;ไปที่จุดแรก ก่อนจะพุ่งลงไป
SPTP XP2 WITH $VEL_AXIS[1] = SVEL_JOINT(70.0), $TOOL = STOOL2(FP2), $BASE = SBASE(FP2.BASE_NO), $IPO_MODE = SIPO_MODE(FP2.IPO_FRAME), $LOAD = SLOAD(FP2.TOOL_NO), $ACC_AXIS[1] = SACC_JOINT(PPDAT1), $APO = SAPO_PTP(PPDAT1), $GEAR_JERK[1] = SGEAR_JERK(PPDAT1), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)
   ;พุ่งลงไปก่อนจะหยิบ
SLIN XP1 WITH $VEL = SVEL_CP(0.5, , LCPDAT1), $TOOL = STOOL2(FP1), $BASE = SBASE(FP1.BASE_NO), $IPO_MODE = SIPO_MODE(FP1.IPO_FRAME), $LOAD = SLOAD(FP1.TOOL_NO), $ACC = SACC_CP(LCPDAT1), $ORI_TYPE = SORI_TYP(LCPDAT1), $APO = SAPO(LCPDAT1), $JERK = SJERK(LCPDAT1), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)

WAIT SEC 0.5
$OUT[1] = True
WAIT SEC 0.5

   ;พุ่งขึ้นหลังจากหยิบ
SLIN XP3 WITH $VEL = SVEL_CP(0.5, , LCPDAT2), $TOOL = STOOL2(FP3), $BASE = SBASE(FP3.BASE_NO), $IPO_MODE = SIPO_MODE(FP3.IPO_FRAME), $LOAD = SLOAD(FP3.TOOL_NO), $ACC = SACC_CP(LCPDAT2), $ORI_TYPE = SORI_TYP(LCPDAT2), $APO = SAPO(LCPDAT2), $JERK = SJERK(LCPDAT2), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)
   ;ไปตำแหน่งที่จะทำการวาง
SLIN XP9 WITH $VEL = SVEL_CP(0.5, , LCPDAT7), $TOOL = STOOL2(FP9), $BASE = SBASE(FP9.BASE_NO), $IPO_MODE = SIPO_MODE(FP9.IPO_FRAME), $LOAD = SLOAD(FP9.TOOL_NO), $ACC = SACC_CP(LCPDAT7), $ORI_TYPE = SORI_TYP(LCPDAT7), $APO = SAPO(LCPDAT7), $JERK = SJERK(LCPDAT7), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)
XPdata = XP20
XPdata[counter].z = XP20.z + (25*(counter))
LIN XPdata[counter]
XPdata[counter].z = XP20.z - (25*(counter))

WAIT SEC 0.5
$OUT[1] = False
WAIT SEC 0.5

   ;พุ่งขึ้นหลังจากวาง จบ!
SLIN XP10 WITH $VEL = SVEL_CP(0.5, , LCPDAT8), $TOOL = STOOL2(FP10), $BASE = SBASE(FP10.BASE_NO), $IPO_MODE = SIPO_MODE(FP10.IPO_FRAME), $LOAD = SLOAD(FP10.TOOL_NO), $ACC = SACC_CP(LCPDAT8), $ORI_TYPE = SORI_TYP(LCPDAT8), $APO = SAPO(LCPDAT8), $JERK = SJERK(LCPDAT8), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)
Endfor

SPTP XHOME WITH $VEL_AXIS[1] = SVEL_JOINT(100.0), $TOOL = STOOL2(FHOME), $BASE = SBASE(FHOME.BASE_NO), $IPO_MODE = SIPO_MODE(FHOME.IPO_FRAME), $LOAD = SLOAD(FHOME.TOOL_NO), $ACC_AXIS[1] = SACC_JOINT(PDEFAULT), $APO = SAPO_PTP(PDEFAULT), $GEAR_JERK[1] = SGEAR_JERK(PDEFAULT), $COLLMON_TOL_PRO[1] = USE_CM_PRO_VALUES(0)


END
